Received: from eggs.gnu.org ([2001:4830:134:3::10]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv4F-0003fo-4G
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv49-0002S9-28
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 17:00:07 +0100
Message-Id: <20180710160013.26559-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] accel/tcg: Support execution from MMIO and
 small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

This series adds support to TCG for executing from MMIO regions
and small MMU regions. The basic principle is that if get_page_addr_code()
finds that the region is not backed by a full page of RAM then it
returns -1, and tb_gen_code() then generates a non-cached TB
containing a single instruction. Execution from these regions
thus performs the instruction fetch every time, ensuring that we
get the read-from-MMIO and check-small-MMU-region permissions
checks right.

This means that the code path for "generate bus fault for failing
to load an instruction" no longer goes through get_page_addr_code(),
but instead via each target's translate code and its calls to
the cpu_ld*_code() or similar functions. Patch 1 makes sure we
can distinguish insn fetches from data loads when generating the
bus fault exceptions. (Aside: I have assumed that all cpu_ld*_code()
loads should trigger iside faults rather than dside. Hopefully this
is true...)

Patches 2 and 3 make trivial fixes to various callers of
get_page_addr_code(); patch 4 does the work of generating our
single-insn TBs. Patch 5 can then remove all the code that
(mis)handles MMIO regions from get_page_addr_code(). Finally
patch 6 drops the target/arm workarounds for not having support
for executing from small MPU regions.

Note for the Xilinx folks: this patchset makes the mmio-exec
testcase for running from the SPI flash pass. Cedric: you might
like to test the aspeed image you had that relies on execution
from an MMIO region too.

The diffstat is pretty satisfying for a patchset that adds
a feature, but it actually undersells it: this code renders the
hw/misc/mmio_interface.c and the mmio_ptr related code in memory.c
and the xilinx-spips device all obsolete, so there are another
couple of hundred lines of code to be deleted there. I opted not
to include that in this patchset, for ease of review.

NB: I tested this with icount, but there are potentially
some weird things that could happen with interactions between
icount's io-recompile and execution from an MMIO device
that returns different instructions each time it's read.

thanks
-- PMM


Peter Maydell (6):
  accel/tcg: Pass read access type through to io_readx()
  accel/tcg: Handle get_page_addr_code() returning -1 in hashtable
    lookups
  accel/tcg: Handle get_page_addr_code() returning -1 in
    tb_check_watchpoint()
  accel/tcg: tb_gen_code(): Create single-insn TB for execution from
    non-RAM
  accel/tcg: Return -1 for execution from MMIO regions in
    get_page_addr_code()
  target/arm: Allow execution from small regions

 accel/tcg/softmmu_template.h |  11 ++--
 include/qom/cpu.h            |   6 +++
 accel/tcg/cpu-exec.c         |   3 ++
 accel/tcg/cputlb.c           | 100 +++++------------------------------
 accel/tcg/translate-all.c    |  23 +++++++-
 memory.c                     |   3 +-
 target/arm/helper.c          |  23 --------
 7 files changed, 52 insertions(+), 117 deletions(-)

-- 
2.17.1
