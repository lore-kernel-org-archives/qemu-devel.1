Received: from eggs.gnu.org ([2001:4830:134:3::10]:47397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2bVR-0001Fg-Dm
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2bVQ-00031J-Dz
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:46:09 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2bVQ-00030M-7y
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:46:08 -0400
Received: by mail-wr0-x22f.google.com with SMTP id z52so47700157wrc.2
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 03:46:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f1102288-a192-0ee2-3a35-08045926af59@twiddle.net>
References: <CAFEAcA_3fm+-6QaH0eb46wF7OS1qFnCEcEBa-q6UnGZD5HemPA@mail.gmail.com>
	<f1102288-a192-0ee2-3a35-08045926af59@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 11:45:46 +0100
Message-ID: <CAFEAcA9zZswBqHOfgoeia5xoSu51Ntd4QrQK3KmM7ygZg7GaCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] How expensive is an extra QEMU TLB MMU index ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 18:59, Richard Henderson <rth@twiddle.net> wrote:
> On 04/21/2017 10:23 AM, Peter Maydell wrote:
>> So, just how expensive is having an extra MMU mode which isn't
>> actually used? Is it bad enough to be worth the reduced
>> maintainability?

> Once you get above 7 indicies, we will start to reduce the size of the TLB
> for various hosts.  See CPU_TLB_BITS in include/exec/cpu-defs.h.

That should be "above 8", right?

#define CPU_TLB_BITS                                             \
    MIN(8,                                                       \
        TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
        (NB_MMU_MODES <= 1 ? 0 :                                 \
         NB_MMU_MODES <= 2 ? 1 :                                 \
         NB_MMU_MODES <= 4 ? 2 :                                 \
         NB_MMU_MODES <= 8 ? 3 : 4))

Given that the worst case TCG_TARGET_TLB_DISPLACEMENT_BITS
is 16 (ARM, PPC, MIPS) and CPU_TLB_ENTRY_BITS 5, it's
only the NB_MMU_MODES 9 or more that reduces CPU_TLB_BITS
below 8.

So I have one more "free" mmu index for ARM, after which
it starts to cost us on ARM/PPC/MIPS hosts.

Unfortunately for v8M we're going to want "HFNMIENA, Secure"
as another index, which would be over 8. I'll have a play with
an approach where we have a wider set of index values within
target/arm code which we translate to/from MMU indexes when
we interact with the core TLB code.

thanks
-- PMM
