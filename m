Received: from eggs.gnu.org ([2001:4830:134:3::10]:49797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyL5b-00059q-Vn
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 12:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyL5a-0001Yr-QH
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 12:25:51 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cyL5a-0001YA-KA
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 12:25:50 -0400
Received: by mail-wm0-x234.google.com with SMTP id o81so91857614wmb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 09:25:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170412150221.12199.46501.malone@gac.canonical.com>
References: <20170412105411.12710.65118.malonedeb@gac.canonical.com>
	<20170412150221.12199.46501.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Apr 2017 17:25:27 +0100
Message-ID: <CAFEAcA_MkSJ7AyBzWyDKcjHN7gdh=toMB44Hz4Ynjn7k6AKRyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1682093] Re: aarch64-softmmu "bad ram
 pointer" crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1682093 <1682093@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 April 2017 at 16:02, Harry Wagstaff <1682093@bugs.launchpad.net> wrote:
> I've done some investigation and it appears that this bug is caused by
> the following:
>
> 1. The flash memory of the virt platform is initialised as a
> cfi.pflash01. It has a memory region with romd_mode = true and
> rom_device = true
>
> 2. Some code stored in the flash memory is executed. This causes the
> memory to be loaded into the TLB.
>
> 3. The code is overwritten. This causes the romd_mode of the flash
> memory to be reset. It also causes the code to be evicted from the TLB.
>
> 4. An attempt is made to execute the code again (cpu_exec(), cpu-exec.c:677)
> 4a. Eventually, QEMU attempts to refill the TLB (softmmu_template.h:127)
> 4b. We try to fill in the tlb entry (tlb_set_page_with_attrs, cputlb.c:602)
> 4b. The flash memory no longer appears to be a ram or romd (cputlb.c:632)
> 4c. QEMU decides that the flash memory is an IO device (cputlb.c:634)
> 4d. QEMU aborts while trying to fill in the rest of the TLB entry (qemu_ram_addr_from_host_nofail)

Yeah, this is a known bug -- but fixing it would just mean that
we would print the slightly more helpful message about the
guest attempting to execute from something that isn't RAM
or ROM before exiting.

See for instance this thread from January.
https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg00674.html

> I have built a MWE (which I have attached) which produces this behaviour
> in git head. I'm not exactly sure what a fix for this should look like:
> AFAIK it's not technically valid to write into flash, but I'm not sure
> that QEMU crashing should be considered correct behaviour.

You should fix your guest so that it doesn't try to execute
from flash without putting the flash back into the mode you
can execute from...

Writing to the flash device is permitted -- it's how
you program it (you write command bytes to it, and
read back responses and status and so on).

thanks
-- PMM
