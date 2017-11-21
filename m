Received: from eggs.gnu.org ([2001:4830:134:3::10]:43315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7yI-0000MS-T4
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7yI-0008Jd-2K
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:48:14 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH7yH-0008JD-TC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:48:13 -0500
Received: by mail-oi0-x241.google.com with SMTP id a75so8436624oib.1
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 04:48:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f5cc649a-8b33-fc0c-4a9c-559a33cda86b@redhat.com>
References: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
	<f5cc649a-8b33-fc0c-4a9c-559a33cda86b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 12:47:52 +0000
Message-ID: <CAFEAcA8u5J+bEjp+Rq+n9W4WoJOXzTtHxKhVvUHp92isquE99g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 0/2] Fix TCG atomic writes to
 nondirty pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Richard Henderson <rth@twiddle.net>, Stuart Monteith <stuart.monteith@linaro.org>

On 20 November 2017 at 20:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 20/11/2017 19:08, Peter Maydell wrote:
>> To do a write to memory that is marked as notdirty, we need
>> to invalidate any TBs we have cached for that memory, and
>> update the cpu physical memory dirty flags for VGA and migration.
>> The slowpath code in notdirty_mem_write() does all this correctly,
>> but the new atomic handling code in atomic_mmu_lookup() doesn't
>> do anything at all, it just clears the dirty bit in the TLB.
>>
>> The effect of this bug is that if the first write to a notdirty
>> page for which we have cached TBs is by a guest atomic access,
>> we fail to invalidate the TBs and subsequently will execute
>> incorrect code. This can be seen by trying to run 'javac' on AArch64.
>>
>> The first patch here refactors notdirty_mem_write() to pull out
>> the "correctly handle dirty bit updates" parts of the code into
>> two new functions memory_notdirty_write_prepare() and
>> memory_notdirty_write_complete(). The second patch then uses
>> those functions to fix the atomic helpers.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks; applied to master for rc2.

-- PMM
