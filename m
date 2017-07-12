Received: from eggs.gnu.org ([2001:4830:134:3::10]:39423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dV6kX-00044m-J7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dV6kU-0000Gb-NG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:47:33 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Wed, 12 Jul 2017 10:08:14 +0800
Message-ID: <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, james.morse@arm.com, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com
Cc: gengdongjiu@huawei.com

In the armv8 platform, the mainly hardware error source are ARMv8
SEA/SEI/GSIV. For the ARMv8 SEA/SEI, the KVM or host kernel will signal SIGBUS
or use other interface to notify user space, such as Qemu. After Qemu gets
the notification, it will record the CPER and inject the SEA/SEI to KVM. this
series of patches will generate APEI table when guest OS boot up, and dynamically
record CPER for the guest OS about the generic hardware errors, currently the
userspace only handle the memory section hardware errors

how to test:
1. In the guest OS, use this command to dump the APEI table: 
	"iasl -p ./HEST -d /sys/firmware/acpi/tables/HEST"
2. And find the address for the generic error status block
   according to the notification type
3. then find the CPER record through the generic error status block.

For example(notification type is SEA):

(1) root@genericarmv8:~# iasl -p ./HEST -d /sys/firmware/acpi/tables/HEST
(2) root@genericarmv8:~# cat HEST.dsl
	/*
	 * Intel ACPI Component Architecture
	 * AML/ASL+ Disassembler version 20170303 (64-bit version)
	 * Copyright (c) 2000 - 2017 Intel Corporation
	 *
	 * Disassembly of /sys/firmware/acpi/tables/HEST, Mon Dec 12 07:19:43 2016
	 *
	 * ACPI Data Table [HEST]
	 *
	 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
	 */
    ..................................................................................
    [228h 0552   2]                Subtable Type : 0009 [Generic Hardware Error Source]
	[22Ah 0554   2]                    Source Id : 0008
	[22Ch 0556   2]            Related Source Id : FFFF
	[22Eh 0558   1]                     Reserved : 00
	[22Fh 0559   1]                      Enabled : 01
	[230h 0560   4]       Records To Preallocate : 00000001
	[234h 0564   4]      Max Sections Per Record : 00000001
	[238h 0568   4]          Max Raw Data Length : 00001000

	[23Ch 0572  12]         Error Status Address : [Generic Address Structure]
	[23Ch 0572   1]                     Space ID : 00 [SystemMemory]
	[23Dh 0573   1]                    Bit Width : 40
	[23Eh 0574   1]                   Bit Offset : 00
	[23Fh 0575   1]         Encoded Access Width : 04 [QWord Access:64]
	[240h 0576   8]                      Address : 00000000785D0040

	[248h 0584  28]                       Notify : [Hardware Error Notification Structure]
	[248h 0584   1]                  Notify Type : 08 [SEA]
	[249h 0585   1]                Notify Length : 1C
	[24Ah 0586   2]   Configuration Write Enable : 0000
	[24Ch 0588   4]                 PollInterval : 00000000
	[250h 0592   4]                       Vector : 00000000
	[254h 0596   4]      Polling Threshold Value : 00000000
	[258h 0600   4]     Polling Threshold Window : 00000000
	[25Ch 0604   4]        Error Threshold Value : 00000000
	[260h 0608   4]       Error Threshold Window : 00000000

	[264h 0612   4]    Error Status Block Length : 00001000
    .....................................................................................
(3) according to above table, the address that contains the physical address of a block
    of memory that holds the error status data for SEA notification error source is 0x00000000785D0040
(4) the address for SEA notification error source is 0x785d8058
	(qemu) xp /2x 0x00000000785D0040
	00000000785d0040: 0x785d8058 0x00000000
(5) check the content of generic error status block and generic error data entry
    (qemu) xp /100x 0x785d8058
    00000000785d8058: 0x00000001 0x00000000 0x00000000 0x00000098
    00000000785d8068: 0x00000001 0xa5bc1114 0x4ede6f64 0x833e63b8
	00000000785d8078: 0xb1837ced 0x00000000 0x00000000 0x00000050
	00000000785d8088: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d8098: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d80a8: 0x00000000 0x00000000 0x00000000 0x00004002
	00000000785d80b8: 0x00000000 0x00000000 0x00000000 0x00001111
	00000000785d80c8: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d80d8: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d80e8: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d80f8: 0x00000000 0x00000003 0x00000000 0x00000000
	00000000785d8108: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d8118: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d8128: 0x00000000 0x00000000 0x00000000 0x00000000
	00000000785d8138: 0x00000000 0x00000000 0x00000000 0x00000000

Dongjiu Geng (3):
  ACPI: Add new ACPI structures and macros
  ACPI: Add APEI GHES Table Generation support
  ACPI: build and enable APEI GHES in the Makefile and configuration

 default-configs/arm-softmmu.mak |   1 +
 hw/acpi/Makefile.objs           |   1 +
 hw/acpi/aml-build.c             |   2 +
 hw/acpi/hest_ghes.c             | 219 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c        |   6 ++
 include/hw/acpi/acpi-defs.h     | 194 +++++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h     |   1 +
 include/hw/acpi/hest_ghes.h     |  47 +++++++++
 include/qemu/uuid.h             |  11 ++
 9 files changed, 482 insertions(+)
 create mode 100644 hw/acpi/hest_ghes.c
 create mode 100644 include/hw/acpi/hest_ghes.h

-- 
2.10.1
