Received: from eggs.gnu.org ([2001:4830:134:3::10]:51685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dihqu-0004K4-Ky
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dihqo-0000Cx-5E
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:02:20 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 18 Aug 2017 22:23:41 +0800
Message-ID: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 0/6] Add RAS virtualization support for
 armv8 SEA and SEI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, gengdongjiu@huawei.com, zhengqiang10@huawei.com

In the armv8 platform, the mainly processor hardware error notification
type are synchronous external abort(SEA) and SError Interrupt (SEI), For
the ARMv8 SEA/SEI, KVM or host kernel will deliver SIGBUS or use other
interface to notify user space. After user space gets the notification,
it will record the CPER to simulate GHES for guest OS and inject the a
exception(SEA/SEI) to KVM. 

This series patch has two parts, one part handles synchronous external
abort(SEA) exception and SError Interrupt (SEI) exception; another part
is generating APEI table when guest OS boot up, and dynamically record
CPER for the guest OS about the generic hardware errors. Currently the
userspace only handles the memory section hardware errors. Before Qemu
record the CPER, it needs to check the ACK value written by the guest
OS to avoid read-write race condition. In the simulated APEI/GHESV2/CPER
table, the max number of error soure is 11, which is classified by
notification type, now only enable the SEA/SEI notification type error
source to avoid OS boot warning.


About the whole solution we ever discuessed it in here before:
https://patchwork.kernel.org/patch/9633105/

Below is the APEI/GHESV2/CPER table layout, the max number of error soure is 11:

       etc/acpi/tables                               etc/hardware_errors
    ====================                    ==========================================
+ +--------------------------+            +------------------+
| | HEST                     |            |    address       |              +--------------+
| +--------------------------+            |    registers     |              | Error Status |
| | GHES0                    |            | +----------------+              | Data Block 0 |
| +--------------------------+ +--------->| |status_address0 |------------->| +------------+
| | .................        | |          | +----------------+              | |  CPER      |
| | error_status_address-----+-+ +------->| |status_address1 |----------+   | |  CPER      |
| | .................        |   |        | +----------------+          |   | |  ....      |
| | read_ack_register--------+-+ |        |  .............   |          |   | |  CPER      |
| | read_ack_preserve        | | |        +------------------+          |   | +------------+
| | read_ack_write           | | | +----->| |status_address10|--------+ |   | Error Status |
+ +--------------------------+ | | |      | +----------------+        | |   | Data Block 1 |
| | GHES1                    | +-+-+----->| | ack_value0     |        | +-->| +------------+
+ +--------------------------+   | |      | +----------------+        |     | |  CPER      |
| | .................        |   | | +--->| | ack_value1     |        |     | |  CPER      |
| | error_status_address-----+---+ | |    | +----------------+        |     | |  ....      |
| | .................        |     | |    | |  ............. |        |     | |  CPER      |
| | read_ack_register--------+-----+-+    | +----------------+        |     +-+------------+
| | read_ack_preserve        |     |   +->| | ack_value10    |        |     | |..........  |
| | read_ack_write           |     |   |  | +----------------+        |     | +------------+
+ +--------------------------|     |   |                              |     | Error Status |
| | ...............          |     |   |                              |     | Data Block 10|
+ +--------------------------+     |   |                              +---->| +------------+
| | GHES10                   |     |   |                                    | |  CPER      |
+ +--------------------------+     |   |                                    | |  CPER      |
| | .................        |     |   |                                    | |  ....      |
| | error_status_address-----+-----+   |                                    | |  CPER      |
| | .................        |         |                                    +-+------------+
| | read_ack_register--------+---------+
| | read_ack_preserve        |
| | read_ack_write           |
+ +--------------------------+


----------------------------------------------------------------------------------------------
How to test guest OS do SEA/SEI recovery:

1. In the guest OS, trigger a SEA or SEI.
2. Then you will see below error log that printed by the memory failure
3. Memory failure will do the recovery for the error.

Such as the below shown kernel log:
[   21.101216] Synchronous External Abort: synchronous external abort (0x96000010) at 0xffffff8008064018
[   21.104969] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 8
[   21.106918] {1}[Hardware Error]: event severity: recoverable
[   21.109027] {1}[Hardware Error]:  Error 0, type: recoverable
[   21.110362] {1}[Hardware Error]:   section_type: memory error
[   21.111705] {1}[Hardware Error]:   physical_address: 0x000000007a200000
[   21.113255] {1}[Hardware Error]:   error_type: 3, multi-bit ECC
[   21.118528] Internal error: : 96000010 [#1] SMP
[   21.119587] Modules linked in:
[   21.120307] CPU: 0 PID: 509 Comm: devmem Not tainted 4.12.0-rc4ajb-00990-g954379b-dirty #67
[   21.122307] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[   21.123915] task: ffffffc03da32900 task.stack: ffffffc03dbbc000
[   21.125302] PC is at __do_user_fault+0x58/0x110
[   21.126370] LR is at __do_user_fault+0x54/0x110
[   21.127433] pc : [<ffffff8008097528>] lr : [<ffffff8008097524>] pstate: 80000145
[   21.129164] sp : ffffffc03dbbfd20
[   21.129940] x29: ffffffc03dbbfd20 x28: ffffffc03da32900
[   21.131204] x27: 0000000000000000 x26: 0000007f7edc5001
[   21.132439] x25: ffffff8008648438 x24: ffffffc03dbbfec0
[   21.133689] x23: 0000000000030001 x22: 0000007f7edc5001
[   21.134934] x21: 0000000000000007 x20: 0000000092000021
[   21.136195] x19: ffffffc03da32900 x18: 0000007fdd4c18f0
[   21.137439] x17: 0000007f7ecb9ebc x16: 0000000000412058

------------------------------------------------------------------------------------------------
how to test guest OS APTI/GHES:
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
     * AML/ASL+ Disassembler version 20170728 (64-bit version)
     * Copyright (c) 2000 - 2017 Intel Corporation
     *
     * Disassembly of /sys/firmware/acpi/tables/HEST, Mon Sep  5 07:59:17 2016
     *
     * ACPI Data Table [HEST]
     *
     * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
     */

    ..................................................................................
    [308h 0776   2]                Subtable Type : 000A [Generic Hardware Error Source V2]
    [30Ah 0778   2]                    Source Id : 0008
    [30Ch 0780   2]            Related Source Id : FFFF
    [30Eh 0782   1]                     Reserved : 00
    [30Fh 0783   1]                      Enabled : 01
    [310h 0784   4]       Records To Preallocate : 00000001
    [314h 0788   4]      Max Sections Per Record : 00000001
    [318h 0792   4]          Max Raw Data Length : 00001000

    [31Ch 0796  12]         Error Status Address : [Generic Address Structure]
    [31Ch 0796   1]                     Space ID : 00 [SystemMemory]
    [31Dh 0797   1]                    Bit Width : 40
    [31Eh 0798   1]                   Bit Offset : 00
    [31Fh 0799   1]         Encoded Access Width : 04 [QWord Access:64]
    [320h 0800   8]                      Address : 00000000785D0040

    [328h 0808  28]                       Notify : [Hardware Error Notification Structure]
    [328h 0808   1]                  Notify Type : 08 [SEA]
    [329h 0809   1]                Notify Length : 1C
    [32Ah 0810   2]   Configuration Write Enable : 0000
    [32Ch 0812   4]                 PollInterval : 00000000
    [330h 0816   4]                       Vector : 00000000
    [334h 0820   4]      Polling Threshold Value : 00000000
    [338h 0824   4]     Polling Threshold Window : 00000000
    [33Ch 0828   4]        Error Threshold Value : 00000000
    [340h 0832   4]       Error Threshold Window : 00000000

    [344h 0836   4]    Error Status Block Length : 00001000
    [348h 0840  12]            Read Ack Register : [Generic Address Structure]
    [348h 0840   1]                     Space ID : 00 [SystemMemory]
    [349h 0841   1]                    Bit Width : 40
    [34Ah 0842   1]                   Bit Offset : 00
    [34Bh 0843   1]         Encoded Access Width : 04 [QWord Access:64]
    [34Ch 0844   8]                      Address : 00000000785D0098

    [354h 0852   8]            Read Ack Preserve : 00000000FFFFFFFE
    [35Ch 0860   8]               Read Ack Write : 0000000000000001

    [364h 0868   2]                Subtable Type : 000A [Generic Hardware Error Source V2]
    [366h 0870   2]                    Source Id : 0009
    [368h 0872   2]            Related Source Id : FFFF
    [36Ah 0874   1]                     Reserved : 00
    [36Bh 0875   1]                      Enabled : 01
    [36Ch 0876   4]       Records To Preallocate : 00000001
    [370h 0880   4]      Max Sections Per Record : 00000001
    [374h 0884   4]          Max Raw Data Length : 00001000

    [378h 0888  12]         Error Status Address : [Generic Address Structure]
    [378h 0888   1]                     Space ID : 00 [SystemMemory]
    [379h 0889   1]                    Bit Width : 40
    [37Ah 0890   1]                   Bit Offset : 00
    [37Bh 0891   1]         Encoded Access Width : 04 [QWord Access:64]
    [37Ch 0892   8]                      Address : 00000000785D0048

    [384h 0900  28]                       Notify : [Hardware Error Notification Structure]
    [384h 0900   1]                  Notify Type : 09 [SEI]
    [385h 0901   1]                Notify Length : 1C
    [386h 0902   2]   Configuration Write Enable : 0000
    [388h 0904   4]                 PollInterval : 00000000
    [38Ch 0908   4]                       Vector : 00000000
    [390h 0912   4]      Polling Threshold Value : 00000000
    [394h 0916   4]     Polling Threshold Window : 00000000
    [398h 0920   4]        Error Threshold Value : 00000000
    [39Ch 0924   4]       Error Threshold Window : 00000000

    [3A0h 0928   4]    Error Status Block Length : 00001000
    [3A4h 0932  12]            Read Ack Register : [Generic Address Structure]
    [3A4h 0932   1]                     Space ID : 00 [SystemMemory]
    [3A5h 0933   1]                    Bit Width : 40
    [3A6h 0934   1]                   Bit Offset : 00
    [3A7h 0935   1]         Encoded Access Width : 04 [QWord Access:64]
    [3A8h 0936   8]                      Address : 00000000785D00A0

    [3B0h 0944   8]            Read Ack Preserve : 00000000FFFFFFFE
    [3B8h 0952   8]               Read Ack Write : 0000000000000001
    .....................................................................................
(3) according to above table, the address that contains the physical address of a block
    of memory that holds the error status data for SEA notification error source is 0x00000000785D0040
(4) the address for SEA notification error source is 0x785d8108
    (qemu) xp /1 0x00000000785D0040
    00000000785d0040: 0x785d80b0

(5) check the content of generic error status block and generic error data entry
    (qemu) xp /100x 0x785d80b0
    00000000785d80b0: 0x00000001 0x00000000 0x00000000 0x00000098
    00000000785d80c0: 0x00000000 0xa5bc1114 0x4ede6f64 0x833e63b8
    00000000785d80d0: 0xb1837ced 0x00000000 0x00000300 0x00000050
    00000000785d80e0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d80f0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8100: 0x00000000 0x00000000 0x00000000 0x00004002
    00000000785d8110: 0x00000000 0x00000000 0x00000000 0x00001111
    00000000785d8120: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8130: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8140: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8150: 0x00000000 0x00000003 0x00000000 0x00000000
    00000000785d8160: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8170: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8180: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8190: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d81a0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d81b0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d81c0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d81d0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d81e0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d81f0: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8200: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8210: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8220: 0x00000000 0x00000000 0x00000000 0x00000000
    00000000785d8230: 0x00000000 0x00000000 0x00000000 0x00000000
(6) check the OSPM's ACK value(for example SEA)
    /* Before OSPM acknowledges the error, check the ACK value */
    (qemu) xp /1 0x00000000785D0098
    00000000785d00f0: 0x00000000

    /* After OSPM acknowledges the error, check the ACK value */
    (qemu) xp /1 0x00000000785D0098
    00000000785d00f0: 0x00000001

Dongjiu Geng (6):
  ACPI: add APEI/HEST/CPER structures and macros
  ACPI: Add APEI GHES Table Generation support
  ACPI: build and enable APEI GHES in the Makefile and configuration
  target-arm: kvm64: detect guest RAS EXTENSION feature
  target-arm: kvm64: handle SIGBUS signal for synchronous External Abort
  target-arm: kvm64: Handle SError interrupt from the guest OS

 default-configs/arm-softmmu.mak |   1 +
 hw/acpi/Makefile.objs           |   1 +
 hw/acpi/aml-build.c             |   2 +
 hw/acpi/hest_ghes.c             | 345 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c        |   6 +
 include/hw/acpi/acpi-defs.h     | 193 ++++++++++++++++++++++
 include/hw/acpi/aml-build.h     |   1 +
 include/hw/acpi/hest_ghes.h     |  47 ++++++
 include/sysemu/kvm.h            |   2 +-
 linux-headers/asm-arm64/kvm.h   |   5 +
 linux-headers/linux/kvm.h       |   2 +
 target/arm/cpu.h                |   3 +
 target/arm/internals.h          |  14 ++
 target/arm/kvm.c                |  34 ++++
 target/arm/kvm64.c              | 186 ++++++++++++++++++++++
 target/arm/kvm_arm.h            |   1 +
 16 files changed, 842 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/hest_ghes.c
 create mode 100644 include/hw/acpi/hest_ghes.h

-- 
1.8.3.1
