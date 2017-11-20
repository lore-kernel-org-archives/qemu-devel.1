Received: from eggs.gnu.org ([2001:4830:134:3::10]:43378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGnNE-0004Fl-A0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGnND-0004Py-D4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:48:36 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:46020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGnND-0004PQ-6w
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:48:35 -0500
Received: by mail-wm0-x233.google.com with SMTP id 9so19289028wme.4
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:48:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1aaf0a6f-c38b-d80d-b09a-1a54545c7660@twiddle.net>
References: <1511184421-23535-1-git-send-email-peter.maydell@linaro.org>
	<1511184421-23535-3-git-send-email-peter.maydell@linaro.org>
	<1aaf0a6f-c38b-d80d-b09a-1a54545c7660@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 14:47:58 +0000
Message-ID: <CAFEAcA-RXwYtL7yjNjxdHmuBfHe61-mYNX6ytDJ4bETLyA3DHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/2] accel/tcg: Handle atomic
 accesses to notdirty memory correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

On 20 November 2017 at 14:27, Richard Henderson <rth@twiddle.net> wrote:
> On 11/20/2017 02:27 PM, Peter Maydell wrote:
>> -    return (void *)((uintptr_t)addr + tlbe->addend);
>> +    hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
>> +
>> +    memory_notdirty_write_prepare(ndi, ENV_GET_CPU(env), addr,
>> +                                  qemu_ram_addr_from_host_nofail(hostaddr),
>> +                                  1 << s_bits);
>
> These calls should be conditional on TLB_NOTDIRTY being set.
> We certainly don't need to do anything like taking a lock otherwise.

We only take the lock if the dirty flag is set for the
physical memory, which it won't be if TLB_NOTDIRTY wasn't set...

> Perhaps an extra bool in NDI, like
>
>   ndi->active = false;
>   if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
>       ndi->active = true;
>       memory_notdirty_write_prepare(ndi, ...);
>   }
>
> and
>
> #define ATOMIC_MMU_CLEANUP \
> do { \
>   if (unlikely(ndi->active)) { \
>      memory_notdirty_write_complete(ndi); \
>   } \
> } while (0)

...but yes, we could skip the whole thing if the TLB entry
isn't marked notdirty.

(Having NDI be "mostly opaque apart from this one thing" is a
little ugly, though.)

thanks
-- PMM
