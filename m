Received: from eggs.gnu.org ([2001:4830:134:3::10]:47584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhcHB-0006HJ-H3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhcH8-0000Uu-Fb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:57:29 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:49722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhcH8-0000UL-7N
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:57:26 -0400
Received: from player759.ha.ovh.net (unknown [10.109.160.217])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2BA7A190734
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 16:57:24 +0200 (CEST)
References: <20180710160013.26559-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ce2458db-7b97-1672-48cf-b88c24d93157@kaod.org>
Date: Mon, 23 Jul 2018 16:57:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] accel/tcg: Support execution from MMIO
 and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 07/10/2018 06:00 PM, Peter Maydell wrote:
> This series adds support to TCG for executing from MMIO regions
> and small MMU regions. The basic principle is that if get_page_addr_code()
> finds that the region is not backed by a full page of RAM then it
> returns -1, and tb_gen_code() then generates a non-cached TB
> containing a single instruction. Execution from these regions
> thus performs the instruction fetch every time, ensuring that we
> get the read-from-MMIO and check-small-MMU-region permissions
> checks right.
> 
> This means that the code path for "generate bus fault for failing
> to load an instruction" no longer goes through get_page_addr_code(),
> but instead via each target's translate code and its calls to
> the cpu_ld*_code() or similar functions. Patch 1 makes sure we
> can distinguish insn fetches from data loads when generating the
> bus fault exceptions. (Aside: I have assumed that all cpu_ld*_code()
> loads should trigger iside faults rather than dside. Hopefully this
> is true...)
> 
> Patches 2 and 3 make trivial fixes to various callers of
> get_page_addr_code(); patch 4 does the work of generating our
> single-insn TBs. Patch 5 can then remove all the code that
> (mis)handles MMIO regions from get_page_addr_code(). Finally
> patch 6 drops the target/arm workarounds for not having support
> for executing from small MPU regions.
> 
> Note for the Xilinx folks: this patchset makes the mmio-exec
> testcase for running from the SPI flash pass. Cedric: you might
> like to test the aspeed image you had that relies on execution
> from an MMIO region too.

I have added a memory region alias at 0x0 on the memory region where
the first flash device is mapped and all aspeed machines, palmetto, 
romulus, witherspoon booted fine. 

More or less 4MB of data access is generated and the slowdown is hardly 
noticeable, around one second on a laptop.

I wonder if I should add a bool option to the machine to activate
or not the feature ?

Thanks,

C. 

> The diffstat is pretty satisfying for a patchset that adds
> a feature, but it actually undersells it: this code renders the
> hw/misc/mmio_interface.c and the mmio_ptr related code in memory.c
> and the xilinx-spips device all obsolete, so there are another
> couple of hundred lines of code to be deleted there. I opted not
> to include that in this patchset, for ease of review.
> 
> NB: I tested this with icount, but there are potentially
> some weird things that could happen with interactions between
> icount's io-recompile and execution from an MMIO device
> that returns different instructions each time it's read.
> 
> thanks
> -- PMM
> 
> 
> Peter Maydell (6):
>   accel/tcg: Pass read access type through to io_readx()
>   accel/tcg: Handle get_page_addr_code() returning -1 in hashtable
>     lookups
>   accel/tcg: Handle get_page_addr_code() returning -1 in
>     tb_check_watchpoint()
>   accel/tcg: tb_gen_code(): Create single-insn TB for execution from
>     non-RAM
>   accel/tcg: Return -1 for execution from MMIO regions in
>     get_page_addr_code()
>   target/arm: Allow execution from small regions
> 
>  accel/tcg/softmmu_template.h |  11 ++--
>  include/qom/cpu.h            |   6 +++
>  accel/tcg/cpu-exec.c         |   3 ++
>  accel/tcg/cputlb.c           | 100 +++++------------------------------
>  accel/tcg/translate-all.c    |  23 +++++++-
>  memory.c                     |   3 +-
>  target/arm/helper.c          |  23 --------
>  7 files changed, 52 insertions(+), 117 deletions(-)
> 
