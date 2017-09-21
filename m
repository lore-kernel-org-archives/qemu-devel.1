Received: from eggs.gnu.org ([2001:4830:134:3::10]:45858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dvBA4-0004f1-H9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dvB9z-000221-Jy
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:40 -0400
Received: from mail-by2nam01on0065.outbound.protection.outlook.com
	([104.47.34.65]:35520
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dvB9z-00021f-82
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:35 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 21 Sep 2017 16:41:48 -0700
Message-ID: <cover.1506037164.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 0/2]  Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com

There are numorous QEMU machines that only have a single or a handful of
valid CPU options. To simplyfy the management of specificying which CPU
is/isn't valid let's create a property that can be set in the machine
init. We can then check to see if the user supplied CPU is in that list
or not.

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
qemu-system-aarch64: Invalid CPU: cortex-a9-arm-cpu
The valid options are: cortex-m3-arm-cpu, cortex-m4-arm-cpu

RFC v2:
 - Rebase on Igor's work
 - Use more QEMUisms inside the code
 - List the supported machines in a NULL terminated array

Alistair Francis (2):
  machine: Add a valid_cpu_types property
  netduino2: Specify the valid CPUs

 hw/arm/netduino2.c  | 10 +++++++++-
 hw/core/machine.c   | 35 +++++++++++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.11.0
