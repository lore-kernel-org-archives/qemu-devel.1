Received: from eggs.gnu.org ([2001:4830:134:3::10]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0H-0004g8-5z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0A-0006AP-7G
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:53 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com
	([104.47.32.43]:6381
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dUu09-00068Z-SX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:50 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Jul 2017 05:07:26 -0700
Message-ID: <b80b284089ce9d4664a5014b65266c0e25e40072.1499774331.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499774331.git.alistair.francis@xilinx.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/8] hw/i386: Improve some of the warning
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
---

 hw/i386/acpi-build.c | 7 ++++---
 hw/i386/pc.c         | 9 ++++-----
 hw/i386/pc_q35.c     | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade183..f9efb6be41 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2766,7 +2766,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                      ACPI_BUILD_ALIGN_SIZE);
         if (tables_blob->len > legacy_table_size) {
             /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
-            warn_report("migration may not work.");
+            warn_report("ACPI tables are larger than legacy_table_size");
+            warn_report("migration may not work");
         }
         g_array_set_size(tables_blob, legacy_table_size);
     } else {
@@ -2774,9 +2775,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
             /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
             warn_report("ACPI tables are larger than 64k.");
-            warn_report("migration may not work.");
+            warn_report("migration may not work");
             warn_report("please remove CPUs, NUMA nodes, "
-                        "memory slots or PCI bridges.");
+                        "memory slots or PCI bridges");
         }
         acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 465e91cc5b..084ca796c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -383,8 +383,8 @@ ISADevice *pc_find_fdc0(void)
     if (state.multiple) {
         warn_report("multiple floppy disk controllers with "
                     "iobase=0x3f0 have been found");
-        error_printf("the one being picked for CMOS setup might not reflect "
-                     "your intent\n");
+        warn_report("the one being picked for CMOS setup might not reflect "
+                    "your intent");
     }
 
     return state.floppy;
@@ -2087,9 +2087,8 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
     }
 
     if (value < (1ULL << 20)) {
-        warn_report("small max_ram_below_4g(%"PRIu64
-                    ") less than 1M.  BIOS may not work..",
-                    value);
+        warn_report("max_ram_below_4g (%" PRIu64 ") is less than 1M; "
+                    "BIOS may not work.", value);
     }
 
     pcms->max_ram_below_4g = value;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1653a47f0a..682c576cf1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -101,8 +101,8 @@ static void pc_q35_init(MachineState *machine)
         lowmem = pcms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
             lowmem & ((1ULL << 30) - 1)) {
-            warn_report("Large machine and max_ram_below_4g(%"PRIu64
-                        ") not a multiple of 1G; possible bad performance.",
+            warn_report("Large machine and max_ram_below_4g (%"PRIu64") not a "
+                        "multiple of 1G; possible bad performance.",
                         pcms->max_ram_below_4g);
         }
     }
-- 
2.11.0
