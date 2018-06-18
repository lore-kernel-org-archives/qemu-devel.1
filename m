Received: from eggs.gnu.org ([2001:4830:134:3::10]:41668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUv6f-00028f-Ui
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUv6a-0000r2-5W
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:26:09 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Jun 2018 16:25:34 +0200
Message-Id: <20180618142536.23995-11-david@redhat.com>
In-Reply-To: <20180618142536.23995-1-david@redhat.com>
References: <20180618142536.23995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/12] nvdimm: convert nvdimm_mr into a
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

This way we can easily check if the region has already been inititalized
without having to rely on the size of an uninitialized region being 0.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/nvdimm.c         | 9 +++++----
 include/hw/mem/nvdimm.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 7260c9c6b1..db7d8c3050 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -43,7 +43,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
     Error *local_err = NULL;
     uint64_t value;
 
-    if (memory_region_size(&nvdimm->nvdimm_mr)) {
+    if (nvdimm->nvdimm_mr) {
         error_setg(&local_err, "cannot change property value");
         goto out;
     }
@@ -75,7 +75,7 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
 
-    return &nvdimm->nvdimm_mr;
+    return nvdimm->nvdimm_mr;
 }
 
 static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
@@ -102,9 +102,10 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
         return;
     }
 
-    memory_region_init_alias(&nvdimm->nvdimm_mr, OBJECT(dimm),
+    nvdimm->nvdimm_mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
                              "nvdimm-memory", mr, 0, pmem_size);
-    nvdimm->nvdimm_mr.align = align;
+    nvdimm->nvdimm_mr->align = align;
 }
 
 /*
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 9340631cfc..c5c9b3c7f8 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -74,7 +74,7 @@ struct NVDIMMDevice {
      * it's the PMEM region in NVDIMM device, which is presented to
      * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supported.
      */
-    MemoryRegion nvdimm_mr;
+    MemoryRegion *nvdimm_mr;
 
     /*
      * The 'on' value results in the unarmed flag set in ACPI NFIT,
-- 
2.17.1
