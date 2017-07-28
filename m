Received: from eggs.gnu.org ([2001:4830:134:3::10]:46895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dbDc0-0006B4-Tj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dbDbv-0006lQ-Qn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:20:00 -0400
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com
	([104.47.38.47]:54880
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dbDbv-0006kj-Ij
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:19:55 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 28 Jul 2017 15:16:27 -0700
Message-ID: <8bb495720f167d9cab3089779cbb2d0cc4b3acc3.1501280035.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1501280035.git.alistair.francis@xilinx.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/5] hw/i386: Improve some of the warning
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
V3:
 - Improve the messages

 hw/i386/acpi-build.c | 15 ++++++++++-----
 hw/i386/pc.c         |  7 +++----
 hw/i386/pc_q35.c     |  8 +++++---
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade183..7130c7409d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2766,17 +2766,22 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
index 22e16031b0..a67440f2a1 100644
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
@@ -2085,9 +2085,8 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
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
index 169a214d50..435eb2c458 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -101,9 +101,11 @@ static void pc_q35_init(MachineState *machine)
         lowmem = pcms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
             lowmem & ((1ULL << 30) - 1)) {
-            warn_report("Large machine and max_ram_below_4g(%"PRIu64
-                        ") not a multiple of 1G; possible bad performance.",
-                        pcms->max_ram_below_4g);
+            warn_report("Large machine as the ram size (0x%" PRIx64 ") is more"
+                        " then twice the size of the internal limit"
+                        " (0x%" PRIx64 ") and max-ram-below-4g (%"PRIu64")"
+                        " note a multiple of 1G; possible bad performance.",
+                        machine->ram_size, lowmem, pcms->max_ram_below_4g);
         }
     }
 
-- 
2.11.0
