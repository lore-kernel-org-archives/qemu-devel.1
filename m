Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dzTUw-0000CK-TR
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dzTUt-0006IR-Cr
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:08:58 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com
	([104.47.33.83]:43697
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dzTUt-0006Hc-51
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:08:55 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 3 Oct 2017 13:05:06 -0700
Message-ID: <cover.1507059418.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/5]  Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

There are numorous QEMU machines that only have a single or a handful of
valid CPU options. To simplyfy the management of specificying which CPU
is/isn't valid let's create a property that can be set in the machine
init. We can then check to see if the user supplied CPU is in that list
or not.

I have added the valid_cpu_types for some ARM machines only at the
moment.

Here is what specifying the CPUs looks like now:

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) info cpus
* CPU #0: thread_id=24175
(qemu) q

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) q

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
qemu-system-aarch64: unable to find CPU model 'cortex-m5'

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu

V1:
 - Small fixes to prepare a series instead of RFC
 - Add commit messages for the commits
 - Expand the machine support to ARM machines
RFC v2:
 - Rebase on Igor's work
 - Use more QEMUisms inside the code
 - List the supported machines in a NULL terminated array


Alistair Francis (5):
  machine: Add a valid_cpu_types property
  netduino2: Specify the valid CPUs
  xlnx-zcu102: Specify the valid CPUs
  xilinx_zynq: : Specify the valid CPUs
  raspi: : Specify the valid CPUs

 hw/arm/netduino2.c           |  9 ++++++++-
 hw/arm/raspi.c               |  6 ++++++
 hw/arm/xilinx_zynq.c         |  5 +++++
 hw/arm/xlnx-zcu102.c         | 10 ++++++++++
 hw/arm/xlnx-zynqmp.c         | 16 +++++++++-------
 hw/core/machine.c            | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  1 +
 include/hw/boards.h          |  1 +
 8 files changed, 75 insertions(+), 8 deletions(-)

-- 
2.11.0
