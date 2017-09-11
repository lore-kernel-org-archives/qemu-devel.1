Received: from eggs.gnu.org ([2001:4830:134:3::10]:39870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUot-000610-EG
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUop-00022D-Fu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:35 -0400
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com
	([104.47.33.75]:52954
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1drUop-00021S-9d
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:31 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 11 Sep 2017 12:52:43 -0700
Message-ID: <1d6ef2ccd9667878ed5820fcf17eef35957ea5d8.1505158760.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505158760.git.alistair.francis@xilinx.com>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/8] hw/i386: Improve some of the warning
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
V4:
 - Fixup pc_q35.c message
V3:
 - Improve the messages

 hw/i386/acpi-build.c | 15 ++++++++++-----
 hw/i386/pc.c         |  7 +++----
 hw/i386/pc_q35.c     |  8 +++++---
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4d19d91e1b..9776812588 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2750,17 +2750,22 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                      ACPI_BUILD_ALIGN_SIZE);
         if (tables_blob->len > legacy_table_size) {
             /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
-            warn_report("migration may not work.");
+            warn_report("ACPI table size %u exceeds %d bytes,"
+                        " migration may not work",
+                        tables_blob->len, legacy_table_size);
+            error_printf("Try removing CPUs, NUMA nodes, memory slots"
+                         " or PCI bridges.");
         }
         g_array_set_size(tables_blob, legacy_table_size);
     } else {
         /* Make sure we have a buffer in case we need to resize the tables. */
         if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
             /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-            warn_report("ACPI tables are larger than 64k.");
-            warn_report("migration may not work.");
-            warn_report("please remove CPUs, NUMA nodes, "
-                        "memory slots or PCI bridges.");
+            warn_report("ACPI table size %u exceeds %d bytes,"
+                        " migration may not work",
+                        tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
+            error_printf("Try removing CPUs, NUMA nodes, memory slots"
+                         " or PCI bridges.");
         }
         acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 21081041d5..c882f8c2ea 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -384,7 +384,7 @@ ISADevice *pc_find_fdc0(void)
         warn_report("multiple floppy disk controllers with "
                     "iobase=0x3f0 have been found");
         error_printf("the one being picked for CMOS setup might not reflect "
-                     "your intent\n");
+                     "your intent");
     }
 
     return state.floppy;
@@ -2098,9 +2098,8 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
     }
 
     if (value < (1ULL << 20)) {
-        warn_report("small max_ram_below_4g(%"PRIu64
-                    ") less than 1M.  BIOS may not work..",
-                    value);
+        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
+                    "BIOS may not work with less than 1MiB", value);
     }
 
     pcms->max_ram_below_4g = value;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c1cba584d1..7947efb680 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -101,9 +101,11 @@ static void pc_q35_init(MachineState *machine)
         lowmem = pcms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
             lowmem & ((1ULL << 30) - 1)) {
-            warn_report("Large machine and max_ram_below_4g(%"PRIu64
-                        ") not a multiple of 1G; possible bad performance.",
-                        pcms->max_ram_below_4g);
+            warn_report("There is possibly poor performance as the ram size "
+                        " (0x%" PRIx64 ") is more then twice the size of"
+                        " max-ram-below-4g (%"PRIu64") and"
+                        " max-ram-below-4g is not a multiple of 1G.",
+                        machine->ram_size, pcms->max_ram_below_4g);
         }
     }
 
-- 
2.11.0
