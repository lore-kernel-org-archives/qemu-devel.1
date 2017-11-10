Received: from eggs.gnu.org ([2001:4830:134:3::10]:55236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HP-0001p6-3x
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HM-000174-HC
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:22 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 11 Nov 2017 03:19:42 +0800
Message-ID: <1510341591-22817-4-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 03/12] docs: APEI GHES generation
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Add APEI/GHES description document

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 docs/specs/acpi_hest_ghes.txt | 98 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 docs/specs/acpi_hest_ghes.txt

diff --git a/docs/specs/acpi_hest_ghes.txt b/docs/specs/acpi_hest_ghes.txt
new file mode 100644
index 0000000..816d7b9
--- /dev/null
+++ b/docs/specs/acpi_hest_ghes.txt
@@ -0,0 +1,98 @@
+Generating APEI tables and record CPER
+=============================
+
+Copyright (C) 2017 HuaWei Corporation.
+
+Design Details:
+-------------------
+
+       etc/acpi/tables                               etc/hardware_errors
+    ====================                    ==========================================
++ +--------------------------+            +------------------+
+| | HEST                     |            |    address       |              +--------------+
+| +--------------------------+            |    registers     |              | Error Status |
+| | GHES1                    |            | +----------------+              | Data Block 1 |
+| +--------------------------+ +--------->| |status_address1 |------------->| +------------+
+| | .................        | |          | +----------------+              | |  CPER      |
+| | error_status_address-----+-+ +------->| |status_address2 |----------+   | |  CPER      |
+| | .................        |   |        | +----------------+          |   | |  ....      |
+| | read_ack_register--------+-+ |        |  .............   |          |   | |  CPER      |
+| | read_ack_preserve        | | |        +------------------+          |   | +------------+
+| | read_ack_write           | | | +----->| |status_addressN |--------+ |   | Error Status |
++ +--------------------------+ | | |      | +----------------+        | |   | Data Block 2 |
+| | GHES2                    | +-+-+----->| | ack_value1     |        | +-->| +------------+
++ +--------------------------+   | |      | +----------------+        |     | |  CPER      |
+| | .................        |   | | +--->| | ack_value2     |        |     | |  CPER      |
+| | error_status_address-----+---+ | |    | +----------------+        |     | |  ....      |
+| | .................        |     | |    | |  ............. |        |     | |  CPER      |
+| | read_ack_register--------+-----+-+    | +----------------+        |     +-+------------+
+| | read_ack_preserve        |     |   +->| | ack_valueN     |        |     | |..........  |
+| | read_ack_write           |     |   |  | +----------------+        |     | +------------+
++ +--------------------------|     |   |                              |     | Error Status |
+| | ...............          |     |   |                              |     | Data Block N |
++ +--------------------------+     |   |                              +---->| +------------+
+| | GHESN                    |     |   |                                    | |  CPER      |
++ +--------------------------+     |   |                                    | |  CPER      |
+| | .................        |     |   |                                    | |  ....      |
+| | error_status_address-----+-----+   |                                    | |  CPER      |
+| | .................        |         |                                    +-+------------+
+| | read_ack_register--------+---------+
+| | read_ack_preserve        |
+| | read_ack_write           |
++ +--------------------------+
+
+(1) QEMU generates the ACPI HEST table. This table goes in the current
+    "etc/acpi/tables" fw_cfg blob. Each error source has different
+    notification type.
+
+(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
+    also need to populate this blob. The "etc/hardwre_errors" fw_cfg blob contains
+    one address registers table and one Error Status Data Block table, all
+    of which are pre-allocated.
+
+(3) The address registers table contains N Error Status Address entries
+    and N Read Ack Address entries, the size for each entry is 8-byte. The
+    Error Status Data Block table contains N Error Status Data Block entry,
+    the size for each entry is 0x1000(4096) bytes. The total size for
+    "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes
+
+(4) QEMU generates the ACPI linker/loader script for the firmware
+
+(4a) The HEST table is part of "etc/acpi/tables", which the firmware
+    already allocates memory for it and downloads, because QEMU already
+    generates an ALLOCATE linker/loader command for it.
+
+(4b) QEMU creates another ALLOCATE command for the "etc/hardware_errors"
+    blob. The firmware allocates memory for this blob,
+    and downloads it.
+
+(5) QEMU generates, N ADD_POINTER commands, which patch address in the
+    "Error Status Address" fields of the HEST table with a pointer to the
+    corresponding address registers in the downloaded "etc/hardware_errors" blob.
+
+(6) QEMU generates N ADD_POINTER commands for the firmware, pointing the
+    address registers (located in guest memory, in the downloaded
+    "etc/hardware_errors" blob) to the respective Error Status Data Blocks.
+
+(7) QEMU Defines a third, write-only fw_cfg blob, called "etc/hardware_errors_addr".
+    Through that blob, the firmware can send back the guest-side allocation addresses
+    to QEMU. The "etc/hardware_errors_addr" blob contains a 8-byte entry. QEMU generates
+    a single WRITE_POINTER commands for the firmware, the firmware will write the start
+    address of Error Status Data Block0 back to fw_cfg file "etc/hardware_errors_addr".
+    Then Qemu will know the start address of Error Status Data Block0. For error source K
+    (0 <= K < 2), its address offset is K * 0x1000, because each of Error Status Data Block
+    has fixed size which is 0x1000. Using this way, QEMU will know the address of each
+    Error Status Data Block.
+
+(8) When QEMU gets SIGBUS from the kernel, QEMU format the CPER right into guest
+    memory, and then inject whatever interrupt (or assert whatever GPIO line) which is
+    necessary for notifying the guest.
+
+(9) This notification (in virtual hardware) can either be handled by the
+    guest kernel stand-alone, or else the guest kernel can invoke an ACPI
+    event handler method with it. The ACPI event handler method could
+    invoke the specific guest kernel driver for error handling via a
+    Notify() operation.
+
+For the above design, it would leave the firmware alone after OS boot and firmware no need
+to care about HEST, GHES, CPER.
-- 
1.8.3.1
