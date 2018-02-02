Received: from eggs.gnu.org ([2001:4830:134:3::10]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPW9-0005uE-EQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPV5-0000Fo-EO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:47:49 -0500
Received: from mail-by2nam01on0072.outbound.protection.outlook.com
	([104.47.34.72]:13488
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ehPV4-0000E5-Vx
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:46:43 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 1 Feb 2018 16:42:03 -0800
Message-ID: <cover.1517532021.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/6]  Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org, peter.maydell@linaro.org


There are numorous QEMU machines that only have a single or a handful of
valid CPU options. To simplyfy the management of specificying which CPU
is/isn't valid let's create a property that can be set in the machine
init. We can then check to see if the user supplied CPU is in that list
or not.

I have added the valid_cpu_types for some ARM machines only at the
moment.

Here is what specifying the CPUs looks like now:

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -no=
graphic -cpu "cortex-m3" -S
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) info cpus
* CPU #0: thread_id=3D24175
(qemu) q

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -no=
graphic -cpu "cortex-m4" -S
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) q

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -no=
graphic -cpu "cortex-m5" -S
qemu-system-aarch64: unable to find CPU model 'cortex-m5'

$ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -no=
graphic -cpu "cortex-a9" -S
qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
The valid models are: cortex-m3, cortex-m4

V5:
 - Use cpu_model instead of cpu_type
V4:
 - Rebase
 - Remove spaces
V3:
 - Make the varialbes static
V2:
 - Rebase
 - Reorder patches
 - Add a Raspberry Pi 2 CPU fix
V1:
 - Small fixes to prepare a series instead of RFC
 - Add commit messages for the commits
 - Expand the machine support to ARM machines
RFC v2:
 - Rebase on Igor's work
 - Use more QEMUisms inside the code
 - List the supported machines in a NULL terminated array



Alistair Francis (6):
  machine: Convert the valid cpu types to use cpu_model
  netduino2: Specify the valid CPUs
  bcm2836: Use the Cortex-A7 instead of Cortex-A15
  raspi: Specify the valid CPUs
  xlnx-zcu102: Specify the valid CPUs
  xilinx_zynq: Specify the valid CPUs

 hw/arm/bcm2836.c     |  2 +-
 hw/arm/netduino2.c   | 10 +++++++++-
 hw/arm/raspi.c       |  7 +++++++
 hw/arm/xilinx_zynq.c |  6 ++++++
 hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
 hw/core/machine.c    | 11 +++++------
 6 files changed, 45 insertions(+), 8 deletions(-)

--=20
2.14.1
