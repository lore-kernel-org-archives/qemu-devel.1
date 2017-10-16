Received: from eggs.gnu.org ([2001:4830:134:3::10]:44339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e41Cw-00076N-FN
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e41Ct-0003vN-FQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:18896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1e41Ct-0003uO-6u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:07 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon, 16 Oct 2017 16:56:22 +0800
Message-Id: <1508144183-30844-2-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] hostmem-file: Add "nopin" option for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com

Since qemu does not need pin nvdimm memory during the VFIO
hotplug, the new option can be used to avoid pin whole nvdimm
memory. The default value is still "nopin=off" as previous.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 backends/hostmem-file.c | 23 +++++++++++++++++++++++
 hw/vfio/common.c        | 12 +++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index e44c319..e402077 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -33,6 +33,7 @@ struct HostMemoryBackendFile {
 
     bool share;
     bool discard_data;
+    bool nopin;
     char *mem_path;
 };
 
@@ -128,6 +129,25 @@ static void file_backend_unparent(Object *obj)
     }
 }
 
+static bool file_memory_backend_get_nopin(Object *o, Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    return fb->nopin;
+}
+
+static void file_memory_backend_set_nopin(Object *o, bool value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    if (memory_region_size(&backend->mr)) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+    fb->nopin = value;
+}
+
 static void
 file_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -142,6 +162,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "discard-data",
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data,
         &error_abort);
+    object_class_property_add_bool(oc, "nopin",
+        file_memory_backend_get_nopin, file_memory_backend_set_nopin,
+        &error_abort);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path,
         &error_abort);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..f36ff24 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -408,7 +408,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
     void *vaddr;
     int ret;
     VFIOHostDMAWindow *hostwin;
-    bool hostwin_found;
+    bool hostwin_found, nopin;
+    Object *obj = section->mr->owner;
 
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_add_skip(
@@ -424,6 +425,15 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
+    if (obj && object_dynamic_cast(obj, "memory-backend-file")) {
+        nopin = object_property_get_bool(obj, "nopin", NULL);
+        if (nopin) {
+            error_report("warning: If VFIO DMA still map to NVDIMM memory, "
+                         "the VM will crash");
+            return;
+        }
+    }
+
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
     llend = int128_make64(section->offset_within_address_space);
     llend = int128_add(llend, section->size);
-- 
1.9.1
