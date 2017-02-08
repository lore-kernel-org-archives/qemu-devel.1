Received: from eggs.gnu.org ([2001:4830:134:3::10]:58049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cbV9g-0000dV-8B
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cbV9c-0005AJ-7J
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:31:40 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:17949)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cbV9c-0005A8-22
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:31:36 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Wed, 8 Feb 2017 16:31:03 +0000
Message-ID: <1486571463-16183-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/8] MIPS Boston board support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: paul.burton@imgtec.com, aurelien@aurel32.net, alistair23@gmail.com

This series introduces support for the MIPS Boston development board. It begins
by introducing support for moving MIPS Coherence Manager GCRs which Boston
software typically does to avoid conflicting with its flash memory region. An
API is then added to retrieve the emulated MIPS GIC timer frequency, which is
used to report system clock frequency to software via "platform registers"
which the Boston board provides. An issue with the MIPS GIC that current Boston
Linux kernels encounter is fixed, and an API introduced to allow the board to
determine whether the MIPS CPS hardware is supported.

The last 3 patches are more extensive, providing support for the FIT image
format used with Boston, the Xilinx PCIe controller which Boston boards include
3 of, and finally the Boston board support itself.

This can be tested with either U-Boot or Linux if desired. U-Boot support is
available in the following patchset:

  https://www.mail-archive.com/u-boot@lists.denx.de/msg221003.html

Linux kernel support can be found as part of the generic kernel patchset:

  https://www.linux-mips.org/archives/linux-mips/2016-08/msg00456.html

Hopefully this will be merged for v4.9, but it can also be found in a
downstream kernel from Imagination Technologies in the "eng" branch of:

  git://git.linux-mips.org/pub/scm/linux-mti.git

Linux may be built with:

  $ make 64r6el_defconfig
  $ make

The arch/mips/boot/vmlinux.gz.itb image may then be provided to QEMU's -kernel
argument, for example:

  $ qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -serial stdio

v3:
Yongbok Kim:
  loader-fit
    fixed potential memory leaks.
  xlinix-pcie
    added descriptions for macros. (Alistair)
    removed returning on !level. (Alistair)
    updated IRQ connection with GPIO logic (Alistair)
    moved xilinx_pcie_init() to boston.c (Alistair)
    replaced stw_le_p() with pci_set_word()
  boston
    isolated boston machine support for mips64el.
    updated for recent Chardev changes.
  and other cosmetic changes.

v1, v2:
Paul Burton (8):
  hw/mips_cmgcr: allow GCR base to be moved
  hw/mips_gictimer: provide API for retrieving frequency
  hw/mips_gic: Update pin state on mask changes
  target-mips: Provide function to test if a CPU supports an ISA
  dtc: Update requirement to v1.4.2
  loader: Support Flattened Image Trees (FIT images)
  hw: xilinx-pcie: Add support for Xilinx AXI PCIe Controller
  hw/mips: MIPS Boston board support

 configure                            |   8 +-
 default-configs/mips64el-softmmu.mak |   2 +
 dtc                                  |   2 +-
 hw/core/Makefile.objs                |   1 +
 hw/core/loader-fit.c                 | 325 ++++++++++++++++++++
 hw/core/loader.c                     |   7 +-
 hw/intc/mips_gic.c                   |  56 ++--
 hw/mips/Makefile.objs                |   1 +
 hw/mips/boston.c                     | 575 +++++++++++++++++++++++++++++++++++
 hw/misc/mips_cmgcr.c                 |  17 ++
 hw/pci-host/Makefile.objs            |   1 +
 hw/pci-host/xilinx-pcie.c            | 328 ++++++++++++++++++++
 hw/timer/mips_gictimer.c             |   5 +
 include/hw/loader-fit.h              |  41 +++
 include/hw/loader.h                  |   6 +
 include/hw/misc/mips_cmgcr.h         |   3 +
 include/hw/pci-host/xilinx-pcie.h    |  68 +++++
 include/hw/timer/mips_gictimer.h     |   1 +
 target/mips/cpu.h                    |   1 +
 target/mips/translate.c              |  10 +
 20 files changed, 1422 insertions(+), 36 deletions(-)
 create mode 100644 hw/core/loader-fit.c
 create mode 100644 hw/mips/boston.c
 create mode 100644 hw/pci-host/xilinx-pcie.c
 create mode 100644 include/hw/loader-fit.h
 create mode 100644 include/hw/pci-host/xilinx-pcie.h

-- 
2.7.4
