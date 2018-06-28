Received: from eggs.gnu.org ([2001:4830:134:3::10]:38134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAk-0007Ki-Qv
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAj-0000hH-Qz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:42 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:55465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAj-0000fC-Jn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:41 -0400
Received: by mail-wm0-x22f.google.com with SMTP id v16-v6so11055508wmv.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:37 +0200
Message-Id: <1530216310-52873-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/60] nvdimm: make get_memory_region() perform
 checks and initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We might get a call to get_memory_region() before the device has been
realized. We should return a consistent value, as the return value
will e.g. later on be used in the pre_plug handler.

To avoid duplicating too much code, factor the initialization and checks
out into a helper function.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180619134141.29478-12-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/nvdimm.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index afd3912..021d1c3 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -78,20 +78,22 @@ static void nvdimm_finalize(Object *obj)
     g_free(nvdimm->nvdimm_mr);
 }
 
-static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
+static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
 {
-    NVDIMMDevice *nvdimm = NVDIMM(dimm);
+    PCDIMMDevice *dimm = PC_DIMM(nvdimm);
+    uint64_t align, pmem_size, size;
+    MemoryRegion *mr;
 
-    return nvdimm->nvdimm_mr;
-}
+    g_assert(!nvdimm->nvdimm_mr);
 
-static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
-{
-    MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem);
-    NVDIMMDevice *nvdimm = NVDIMM(dimm);
-    uint64_t align, pmem_size, size = memory_region_size(mr);
+    if (!dimm->hostmem) {
+        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
+        return;
+    }
 
+    mr = host_memory_backend_get_memory(dimm->hostmem);
     align = memory_region_get_alignment(mr);
+    size = memory_region_size(mr);
 
     pmem_size = size - nvdimm->label_size;
     nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
@@ -115,6 +117,30 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
     nvdimm->nvdimm_mr->align = align;
 }
 
+static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(dimm);
+    Error *local_err = NULL;
+
+    if (!nvdimm->nvdimm_mr) {
+        nvdimm_prepare_memory_region(nvdimm, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return NULL;
+        }
+    }
+    return nvdimm->nvdimm_mr;
+}
+
+static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(dimm);
+
+    if (!nvdimm->nvdimm_mr) {
+        nvdimm_prepare_memory_region(nvdimm, errp);
+    }
+}
+
 /*
  * the caller should check the input parameters before calling
  * label read/write functions.
-- 
1.8.3.1
