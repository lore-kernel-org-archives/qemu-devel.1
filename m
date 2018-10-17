Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCtto-0006QN-Lm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCttm-0005jF-DJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:40 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gCttm-0005So-1k
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:38 -0400
Received: by mail-pl1-x644.google.com with SMTP id 1-v6so13324195plv.7
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 15:02:21 -0700 (PDT)
Date: Wed, 17 Oct 2018 14:54:17 -0700
Message-Id: <20181017215422.3973-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] First RISC-V Patch Set for the 3.1 Soft Freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org

The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)

are available in the Git repository at:

  git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf0

for you to fetch changes up to 7c28f4da20e5585dce7d575691dac5392b7c6f78:

  RISC-V: Don't add NULL bootargs to device-tree (2018-10-17 13:02:30 -0700)

----------------------------------------------------------------
First RISC-V Patch Set for the 3.1 Soft Freeze

This pull request contains a handful of patches that have been floating
around various trees for a while but haven't made it upstream.  These
patches all appear quite safe.  They're all somewhat independent from
each other:

* One refactors our IRQ management function to allow multiple interrupts
  to be raised an once.  This patch has no functional difference.
* Cleaning up the op_helper/cpu_helper split.  This patch has no
  functional difference.
* Updates to various constants to keep them in sync with the latest ISA
  specification and to remove some non-standard bits that snuck in.
* A fix for a memory leak in the PLIC driver.
* A fix to our device tree handling to avoid provinging a NULL string.

I've given this my standard test: building the port, booting a Fedora
root filesytem on the latest Linux tag, and then shutting down that
image.  Essentially I'm just following the QEMU RISC-V wiki page's
instructions.  Everything looks fine here.

We have a lot more outstanding patches so I'll definately be submitting
another PR for the soft freeze.

----------------------------------------------------------------
Michael Clark (5):
      RISC-V: Allow setting and clearing multiple irqs
      RISC-V: Move non-ops from op_helper to cpu_helper
      RISC-V: Update CSR and interrupt definitions
      RISC-V: Add missing free for plic_hart_config
      RISC-V: Don't add NULL bootargs to device-tree

 hw/riscv/sifive_clint.c                 |   8 +-
 hw/riscv/sifive_plic.c                  |   4 +-
 hw/riscv/sifive_u.c                     |   4 +-
 hw/riscv/spike.c                        |   6 +-
 hw/riscv/virt.c                         |   6 +-
 target/riscv/Makefile.objs              |   2 +-
 target/riscv/cpu.c                      |   6 +-
 target/riscv/cpu.h                      |  22 +-
 target/riscv/cpu_bits.h                 | 683 +++++++++++++++++---------------
 target/riscv/{helper.c => cpu_helper.c} |  35 +-
 target/riscv/op_helper.c                |  34 +-
 11 files changed, 438 insertions(+), 372 deletions(-)
 rename target/riscv/{helper.c => cpu_helper.c} (95%)
