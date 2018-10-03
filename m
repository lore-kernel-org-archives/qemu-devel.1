Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7ilM-0003ik-DM
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7ilJ-0003t6-9T
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:08:32 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed,  3 Oct 2018 22:07:34 +0700
Message-Id: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 00/12] arm: Add first models of Xilinx
 Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This patch series adds initial support for Xilinx's Versal SoC.
Xilinx is introducing Versal, an adaptive compute acceleration platform
(ACAP), built on 7nm FinFET process technology. Versal ACAPs combine Scalar
Processing Engines, Adaptable Hardware Engines, and Intelligent Engines with
leading-edge memory and interfacing technologies to deliver powerful
heterogeneous acceleration for any application. The Versal AI Core series has
five devices, offering 128 to 400 AI Engines. The series includes dual-core Arm
Cortex-A72 application processors, dual-core Arm Cortex-R5 real-time
processors, 256KB of on-chip memory with ECC, more than 1,900 DSP engines
optimized for high-precision floating point with low latency.

More info can be found here:
https://www.xilinx.com/news/press/2018/xilinx-unveils-versal-the-first-in-a-new-category-of-platforms-delivering-rapid-innovation-with-software-programmability-and-scalable-ai-inference.html


In QEMU we'd like to have a virtual developer board with the Versal SoC
and a selected set of peripherals under the control of QEMU.
We'd like to gradually extend this board as QEMU gains more support
for Versal hardware components. QEMU will generate a device-tree
describing only the components it supports and includes in the virtual
dev board.

Before adding Versal support, this series starts with a few fixes to the
GEM that I ran into when running recent kernels on the Versal and ZynqMP
models.

I also noticed a problem with HVC insns not being enabled when using
QEMU's PSCI implementation on CPU's with EL2 and EL3 enabled. This causes
problems for Linux/KVM guests, also fixed in this series.

Best regards,
Edgar

Edgar E. Iglesias (12):
  net: cadence_gem: Disable TSU feature bit
  net: cadence_gem: Announce availability of priority queues
  net: cadence_gem: Use uint32_t for 32bit descriptor words
  net: cadence_gem: Add macro with max number of descriptor words
  net: cadence_gem: Add support for extended descriptors
  net: cadence_gem: Add support for selecting the DMA MemoryRegion
  net: cadence_gem: Implement support for 64bit descriptor addresses
  net: cadence_gem: Announce 64bit addressing support
  target-arm: powerctl: Enable HVC when starting CPUs to EL2
  target/arm: Add the Cortex-A72
  hw/arm: versal: Add a model of Xilinx Versal SoC
  hw/arm: versal: Add a virtual Xilinx Versal board

 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/Makefile.objs                |   1 +
 hw/arm/xlnx-versal-virt.c           | 494 ++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c                | 339 +++++++++++++++++++++++++
 hw/net/cadence_gem.c                | 196 ++++++++++----
 include/hw/arm/xlnx-versal.h        | 122 +++++++++
 include/hw/net/cadence_gem.h        |   7 +-
 target/arm/arm-powerctl.c           |  11 +
 target/arm/cpu64.c                  |  59 +++++
 9 files changed, 1175 insertions(+), 55 deletions(-)
 create mode 100644 hw/arm/xlnx-versal-virt.c
 create mode 100644 hw/arm/xlnx-versal.c
 create mode 100644 include/hw/arm/xlnx-versal.h

-- 
2.7.4
