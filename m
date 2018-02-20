Received: from eggs.gnu.org ([2001:4830:134:3::10]:53884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGY-0008CA-9R
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGU-0001f7-IE
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:46 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 18:03:06 +0000
Message-Id: <20180220180325.29818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/19] Add Cortex-M33 and mps2-an505 board model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset enables the Cortex-M33 v8M CPU type and adds a board model
for it: the AN505 FPGA image for the MPS2+ devboard. The AN505 uses and
extends the "IoT Kit", which is a reference subsystem that includes the
CPU and some devices, and is intended to be extended further to build
a complete device. Both the IoT Kit and the FPGA use devices documented
in the ARM CoreLink SIE-200 System IP for Embedded TRM.

Useful documents (these are also linked in comments in the relevant
source files):

Board TRM:
 http://infocenter.arm.com/help/topic/com.arm.doc.100112_0200_06_en/versatile_express_cortex_m_prototyping_systems_v2m_mps2_and_v2m_mps2plus_technical_reference_100112_0200_06_en.pdf
Application Note AN505 (documenting the FPGA image):
 http://infocenter.arm.com/help/topic/com.arm.doc.dai0505b/index.html
ARMv8M IoT Kit FVP User Guide (ARM ECM0601256):
 http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
ARM CoreLink SIE-200 System IP for Embedded TRM (DDI 0571G):
https://developer.arm.com/products/architecture/m-profile/docs/ddi0571/g

The most complicated thing here is the various kinds of security
controller in the system, so here's a summary of them which will
hopefully make the patchset easier to navigate:

 * Secure Attribution Unit (SAU) -- this is part of the CPU. Rather like
   the MPU, it provides registers that the guest can use to specify the
   security attributes for memory regions. The QEMU implementation is
   already in master. If the SAU says 'no' then a SecureFault exception
   is taken.
 * Implementation Defined Attribution Unit (IDAU) -- an implementation
   defined mechanism for an SoC to specify security attributes for memory.
   In Cortex-M33 hardware, the CPU puts the address of each memory access
   out on a special set of signal lines, and the SoC then has to respond
   with its attribute information for that address. Typically this is set
   up to be simple combinatorial logic; for this board, for instance the
   IDAU reports the inverse of address bit 28 as the NS attribute, creating
   a series of 256MB regions NS/S/NS/S... over the whole address space.
   If the IDAU attributes are more restrictive than the SAU then the IDAU
   overrides the SAU settings. Again, transgressions get a SecureFault.
   In QEMU we define a QOM interface for the IDAU which can then be
   implemented by the SoC or board class. In this series patch 4 has
   the interface definition and the CPU use of it; patch 18 has the
   SoC implementation of its end.
 * The Peripheral Protection Controller (PPC) is part of the interconnect
   fabric outside the CPU. It sits in front of non-TrustZone aware devices
   and can configurably block attempts to access them from the wrong
   security state or privilege mode. Blocked transactions can be configured
   to either cause a bus error, or to be RAZ/WI. The PPC has no register
   interface of its own, but is configured by setting signal lines into it.
   It's one of the devices in the SIE-200 TRM.
 * The Memory Protection Controller (MPC) is similar in purpose to the PPC
   but specifically for sitting in front of RAM. It allows more granular
   configuration of protection so that one RAM can be split between Secure
   and Nonsecure. The IoTKit and FPGA should have MPCs, but I have not
   implemented them in this patchset (it seemed big enough as it is :-))
   It's also documented in the SIE-200 TRM.
 * The Master Security Controller (MSC) sits in front of the transaction
   master interface of a non-trustzone-aware device that can initiate
   memory transactions (DMA controllers, for instance). It allows
   transactions made by the device to be configurably blocked, so that a
   DMA controller can be given to the non-secure world but prevented from
   making accesses to secure-only memory. Like the PPC, it has no register
   interface and is configured using signal lines. It's documented in the
   SIE-200 TRM. I haven't implemented the MSC in this patchset.
 * The IoT Kit security controller is an ad-hoc collection of registers
   that let the guest configure various bits of the IoT Kit subsystem.
   It includes registers that control both the 2 PPCs in the IoT Kit and
   the 5 PPCs in the FPGA, and also registers to control the MSCs. The
   QEMU implementation is in patches 15-17 (and used in subsequent patches).

Patch series structure:

Patches 1..3 make the Arm -kernel loading code honour the CPU's
AddressSpace -- this is necessary for this board because most of the
devices and RAM don't live in address_space_system(). They've already
been on-list and reviewed; included here to make the series
self-contained.

Patches 4 and 5 are the CPU end of the IDAU.

Patches 6 and 7 allow the board/SoC code to specify the reset value of
the secure Vector Table Offset Register. This is configurable for
Cortex-M33 hardware, and on this board it's not zero.

Patch 8 adds the CPU definition for the Cortex-M33, since we now have
all the component parts. At this point the only major missing feature
in our v8M emulation is the stack-limit checking; there may of course
still be lurking bugs.

Patches 9 and 10 are trivial bugfixes/adjustments.

Patch 11 adds a qdev_init_gpio_in_named_with_opaque() function that's
identical to the existing qdev_init_gpio_in_named() but allows an
arbitrary opaque pointer to be passed to the irq handler function
rather than it having to be the DeviceState pointer.  This gets used
in the IoTKit device object later.

Patch 12 implements a TYPE_SPLIT_IRQ device that is a QoMified
equivalent of our qemu_irq_split() function. It's more flexible
because you can specify how many output lines it has, and it fits
better in a QoM-style device too. (The diffstat in this cover letter
seems to have decided this is a copy of or-irq with changes, but
the patch itself does not represent it in that silly way.)

Patch 13 implements the FPGAIO device which is a trivial bit
of miscellaneous registers in the AN505 FPGA image.

Patch 14 is the Peripheral Protection Controller model.

Patches 15-17 implement the IoT Kit security controller; I split it
into 3 pieces because it's quite a lot of code in one patch
otherwise. Some of the devices in the IoT Kit are just
unimplemented-device stubs for now.

Patch 18 implements the IoT Kit object, which is pretty similar to an
SoC container object.

Finally, patch 19 provides the new board model. Most of the devices
are left as unimplemented-device stubs, but all the stubs are
correctly wired into the right PPCs.

Incidentally, for the new devices in this patchset I've adopted the
convention of having the header file include a "QEMU interface"
comment that summarizes and documents all the GPIO lines, IRQs, sysbus
memory regions and QOM properties that code that instantiates the
device needs to know. It's a bit ad-hoc but it seems like it's worth
documenting somehow...

Some of the patches contain a variant on the sysbus_init_child()
helper function I proposed the other day. Since that seems to have run
into discussion about how best to do it I've just put some file-local
functions to decrease the verbosity of the code for the moment, to
avoid a dependency there.

You can find a git branch with this series at
 https://git.linaro.org/people/peter.maydell/qemu-arm.git v8m

I'm afraid I don't know of any publicly available test images for the
board at the moment.

thanks
-- PMM

Peter Maydell (19):
  loader: Add new load_ramdisk_as()
  hw/arm/boot: Honour CPU's address space for image loads
  hw/arm/armv7m: Honour CPU's address space for image loads
  target/arm: Define an IDAU interface
  armv7m: Forward idau property to CPU object
  target/arm: Define init-svtor property for the reset secure VTOR value
  armv7m: Forward init-svtor property to CPU object
  target/arm: Add Cortex-M33
  hw/misc/unimp: Move struct to header file
  include/hw/or-irq.h: Add missing include guard
  qdev: Add new qdev_init_gpio_in_named_with_opaque()
  hw/core/split-irq: Device that splits IRQ lines
  hw/misc/mps2-fpgaio: FPGA control block for MPS2 AN505
  hw/misc/tz-ppc: Model TrustZone peripheral protection controller
  hw/misc/iotkit-secctl: Arm IoT Kit security controller initial skeleton
  hw/misc/iotkit-secctl: Add handling for PPCs
  hw/misc/iotkit-secctl: Add remaining simple registers
  hw/arm/iotkit: Model Arm IOT Kit
  mps2-an505: New board model: MPS2 with AN505 Cortex-M33 FPGA image

 hw/arm/Makefile.objs                      |   2 +
 hw/core/Makefile.objs                     |   1 +
 hw/misc/Makefile.objs                     |   4 +
 include/hw/arm/armv7m.h                   |   5 +
 include/hw/arm/iotkit.h                   | 109 +++++
 include/hw/{or-irq.h => core/split-irq.h} |  32 +-
 include/hw/irq.h                          |   4 +-
 include/hw/loader.h                       |  12 +-
 include/hw/misc/iotkit-secctl.h           | 103 +++++
 include/hw/misc/mps2-fpgaio.h             |  43 ++
 include/hw/misc/tz-ppc.h                  | 101 +++++
 include/hw/misc/unimp.h                   |  10 +
 include/hw/or-irq.h                       |   5 +
 include/hw/qdev-core.h                    |  30 +-
 target/arm/cpu.h                          |   6 +
 target/arm/idau.h                         |  61 +++
 hw/arm/armv7m.c                           |  30 +-
 hw/arm/boot.c                             | 119 +++--
 hw/arm/iotkit.c                           | 598 +++++++++++++++++++++++++
 hw/arm/mps2-tz.c                          | 504 +++++++++++++++++++++
 hw/core/loader.c                          |   8 +-
 hw/core/qdev.c                            |   8 +-
 hw/core/split-irq.c                       |  89 ++++
 hw/misc/iotkit-secctl.c                   | 706 ++++++++++++++++++++++++++++++
 hw/misc/mps2-fpgaio.c                     | 176 ++++++++
 hw/misc/tz-ppc.c                          | 302 +++++++++++++
 hw/misc/unimp.c                           |  10 -
 target/arm/cpu.c                          |  64 ++-
 target/arm/helper.c                       |  28 +-
 default-configs/arm-softmmu.mak           |   5 +
 hw/misc/trace-events                      |  24 +
 31 files changed, 3119 insertions(+), 80 deletions(-)
 create mode 100644 include/hw/arm/iotkit.h
 copy include/hw/{or-irq.h => core/split-irq.h} (63%)
 create mode 100644 include/hw/misc/iotkit-secctl.h
 create mode 100644 include/hw/misc/mps2-fpgaio.h
 create mode 100644 include/hw/misc/tz-ppc.h
 create mode 100644 target/arm/idau.h
 create mode 100644 hw/arm/iotkit.c
 create mode 100644 hw/arm/mps2-tz.c
 create mode 100644 hw/core/split-irq.c
 create mode 100644 hw/misc/iotkit-secctl.c
 create mode 100644 hw/misc/mps2-fpgaio.c
 create mode 100644 hw/misc/tz-ppc.c

-- 
2.16.1
