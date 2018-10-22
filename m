Received: from eggs.gnu.org ([2001:4830:134:3::10]:39702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf73-0001ZU-JZ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf70-0005cW-Qw
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:7889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6y-0004iw-DL
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:34 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:55 +0200
Message-Id: <20181022183656.4902-26-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 25/26] hw: acpi: reduced: Add NFIT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

If the platform is NVDIMM enabled, we add the NFIT table to the ACPI
build.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
---
 hw/acpi/reduced.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 9d0c5ba01e..fac19a978a 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -204,6 +204,11 @@ static void acpi_reduced_build(MachineState *ms, AcpiBuildTables *tables,
                                              tables->linker, &mcfg);
     }
 
+    if (conf->acpi_nvdimm_state.is_enabled) {
+        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
+                          &conf->acpi_nvdimm_state, ms->ram_slots);
+    }
+
     /* RSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
@@ -339,8 +344,7 @@ static Aml *ged_event_aml(GedEvent *event)
         return aml_call0("\\_SB.MHPC." MEMORY_SLOT_SCAN_METHOD);
     case GED_PCI_HOTPLUG:
     case GED_NVDIMM_HOTPLUG:
-        /* Not supported for now */
-        return NULL;
+        return aml_notify(aml_name("\\_SB.NVDR"), aml_int(0x80));
     default:
         break;
     }
-- 
2.17.2
