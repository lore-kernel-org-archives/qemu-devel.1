Received: from eggs.gnu.org ([2001:4830:134:3::10]:56336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeGvZ-00052N-D0
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeGvT-0002Oo-Tg
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:01:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eeGvT-0002N9-LD
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:00:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C8475536E
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 09:00:58 +0000 (UTC)
References: <20180116142316.30486-1-pbonzini@redhat.com>
	<CAK1Eb9niRFD-QK4LMnevaonkrFyWcQidcmYqq2-hf1-4vVSWjg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff1120c3-3613-459f-c6f0-c65ca2269b7e@redhat.com>
Date: Wed, 24 Jan 2018 10:00:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9niRFD-QK4LMnevaonkrFyWcQidcmYqq2-hf1-4vVSWjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24/01/2018 04:58, Fam Zheng wrote:
> On Tue, Jan 16, 2018 at 10:23 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> There are cases in which a queued coroutine must be restarted from
>> non-coroutine context (with qemu_co_enter_next).  In this cases,
>> qemu_co_enter_next also needs to be thread-safe, but it cannot use a
>> CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
>> right now is rolling its own list of Coroutines) and will happen in
>> Fam's NVMe driver as well.
>>
>> This series extracts the idea of a polymorphic lockable object
>> from my "scoped lock guard" proposal, and applies it to CoQueue.
>> The implementation of QemuLockable is similar to C11 _Generic, but
>> redone using the preprocessor and GCC builtins for compatibility.
>>
>> In general, while a bit on the esoteric side, the functionality used
>> to emulate _Generic is fairly old in GCC, and the builtins are already
>> used by include/qemu/atomic.h; the series was tested with Fedora 27 (boot
>> Damn Small Linux via http) and CentOS 6 (compiled only).
>>
>> Paolo
>>
>> v1->v2: fix typos and copyright year
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> Should I include this series in my pull request for the NVMe driver?

Yes, please.  This is within block layer area, since CoQueue and
block/curl.c are still the only users.

Paolo
