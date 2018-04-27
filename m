Received: from eggs.gnu.org ([2001:4830:134:3::10]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fCBJX-0004Z6-FC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fCBJU-0007n1-Qc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:53:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:32371)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fCBJU-0007mH-Ge
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:53:56 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Fri, 27 Apr 2018 15:53:13 -0600
Message-Id: <20180427215314.23168-2-ross.zwisler@linux.intel.com>
In-Reply-To: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [PATCH 2/3] nvdimm,
 acpi: add NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>

Add support for the NFIT Platform Capabilities Structure, newly added in
ACPI 6.2 Errata A.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 hw/acpi/nvdimm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 59d6e4254c..859b390e07 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -169,6 +169,21 @@ struct NvdimmNfitControlRegion {
 } QEMU_PACKED;
 typedef struct NvdimmNfitControlRegion NvdimmNfitControlRegion;
 
+/*
+ * NVDIMM Platform Capabilities Structure
+ *
+ * Defined in section 5.2.25.9 of ACPI 6.2 Errata A, September 2017
+ */
+struct NvdimmNfitPlatformCaps {
+    uint16_t type;
+    uint16_t length;
+    uint8_t highest_cap;
+    uint8_t reserved[3];
+    uint32_t capabilities;
+    uint8_t reserved2[4];
+} QEMU_PACKED;
+typedef struct NvdimmNfitPlatformCaps NvdimmNfitPlatformCaps;
+
 /*
  * Module serial number is a unique number for each device. We use the
  * slot id of NVDIMM device to generate this number so that each device
@@ -351,6 +366,21 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
                                          JEDEC Annex L Release 3. */);
 }
 
+/*
+ * ACPI 6.2 Errata A: 5.2.25.9 NVDIMM Platform Capabilities Structure
+ */
+static void
+nvdimm_build_structure_caps(GArray *structures)
+{
+    NvdimmNfitPlatformCaps *nfit_caps;
+
+    nfit_caps = acpi_data_push(structures, sizeof(*nfit_caps));
+
+    nfit_caps->type = cpu_to_le16(7 /* NVDIMM Platform Capabilities */);
+    nfit_caps->length = cpu_to_le16(sizeof(*nfit_caps));
+    nfit_caps->highest_cap = 1;
+    nfit_caps->capabilities = cpu_to_le32(2 /* memory controller */);
+}
 static GArray *nvdimm_build_device_structure(void)
 {
     GSList *device_list = nvdimm_get_device_list();
@@ -373,6 +403,8 @@ static GArray *nvdimm_build_device_structure(void)
     }
     g_slist_free(device_list);
 
+    nvdimm_build_structure_caps(structures);
+
     return structures;
 }
 
-- 
2.14.3
