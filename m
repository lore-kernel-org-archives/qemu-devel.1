Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUW-0006WJ-Ay
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUU-0007mN-Tq
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:50362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eglUU-0007QP-I2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:26 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 31 Jan 2018 14:02:29 +0800
Message-Id: <20180131060229.9294-7-haozhong.zhang@intel.com>
In-Reply-To: <20180131060229.9294-1-haozhong.zhang@intel.com>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 6/6] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

This option controls whether QEMU mmap(2) the memory backend file with
MAP_SYNC flag, which can fully guarantee the guest write persistence
to the backend, if MAP_SYNC flag is supported by the host kernel
(Linux kernel 4.15 and later) and the backend is a file supporting
DAX (e.g., file on ext4/xfs file system mounted with '-o dax').

It can take one of following values:
 - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
        'share=off', QEMU will abort
 - off: never pass MAP_SYNC to mmap(2)
 - auto (default): if MAP_SYNC is supported and 'share=on', work as if
        'sync=on'; otherwise, work as if 'sync=off'

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 docs/nvdimm.txt         | 20 +++++++++++++++++++-
 qemu-options.hx         | 22 +++++++++++++++++++++-
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index df06b547a6..ade80d76f1 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -15,6 +15,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
+#include "qapi-visit.h"
 
 /* hostmem-file.c */
 /**
@@ -35,6 +36,7 @@ struct HostMemoryBackendFile {
     bool discard_data;
     char *mem_path;
     uint64_t align;
+    OnOffAuto sync;
 };
 
 static void
@@ -60,7 +62,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
                                  backend->size, fb->align,
-                                 fb->share ? QEMU_RAM_SHARE : 0,
+                                 (fb->share ? QEMU_RAM_SHARE : 0) |
+                                 qemu_ram_sync_flags(fb->sync),
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -154,6 +157,39 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     error_propagate(errp, local_err);
 }
 
+static void file_memory_backend_get_sync(
+    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
+    OnOffAuto value = fb->sync;
+
+    visit_type_OnOffAuto(v, name, &value, errp);
+}
+
+static void file_memory_backend_set_sync(
+    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
+    Error *local_err = NULL;
+    OnOffAuto value;
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(&local_err, "cannot change property '%s' of %s '%s'",
+                   name, object_get_typename(obj), backend->id);
+        goto out;
+    }
+
+    visit_type_OnOffAuto(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    fb->sync = value;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -188,6 +224,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL, &error_abort);
+    object_class_property_add(oc, "sync", "OnOffAuto",
+        file_memory_backend_get_sync, file_memory_backend_set_sync,
+        NULL, NULL, &error_abort);
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index e903d8bb09..5e9cee5f5e 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -142,11 +142,29 @@ backend of vNVDIMM:
 Guest Data Persistence
 ----------------------
 
+vNVDIMM is designed and implemented to guarantee the guest data
+persistence on the backends even on the host crash and power
+failures. However, there are still some requirements and limitations
+as explained below.
+
 Though QEMU supports multiple types of vNVDIMM backends on Linux,
-currently the only one that can guarantee the guest write persistence
+if MAP_SYNC is not supported by the host kernel and the backends,
+the only backend that can guarantee the guest write persistence
 is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
 which all guest access do not involve any host-side kernel cache.
 
+mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
+systems, QEMU can mmap(2) the backend with MAP_SYNC, which can
+guarantee the guest write persistence to vNVDIMM. Besides the host
+kernel support, enabling MAP_SYNC in QEMU also requires:
+
+ - the backend is a file supporting DAX, e.g., a file on an ext4 or
+   xfs file system mounted with '-o dax',
+
+ - 'sync' option of memory-backend-file is not 'off', and
+
+ - 'share' option of memory-backend-file is 'on'.
+
 When using other types of backends, it's suggested to set 'unarmed'
 option of '-device nvdimm' to 'on', which sets the unarmed flag of the
 guest NVDIMM region mapping structure.  This unarmed flag indicates
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ce427da78..4e8ec5ed97 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3957,7 +3957,7 @@ property must be set.  These objects are placed in the
 
 @table @option
 
-@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align}
+@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align},sync=@var{on|off|auto}
 
 Creates a memory file backend object, which can be used to back
 the guest RAM with huge pages.
@@ -4017,6 +4017,26 @@ requires an alignment different than the default one used by QEMU, eg
 the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
 such cases, users can specify the required alignment via this option.
 
+The @option{sync} option specifies whether QEMU mmap(2) @option{mem-path}
+with MAP_SYNC flag, which can guarantee the guest write persistence to
+@option{mem-path} even on the host crash and power failures. MAP_SYNC
+requires supports from both the host kernel (since Linux kernel 4.15)
+and @option{mem-path} (only files supporting DAX). It can take one of
+following values:
+
+@table @option
+@item @var{on}
+try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
+@option{share}=@var{off}, QEMU will abort
+
+@item @var{off}
+never pass MAP_SYNC to mmap(2)
+
+@item @var{auto} (default)
+if MAP_SYNC is supported and @option{share}=@var{on}, work as if
+@option{sync}=@var{on}; otherwise, work as if @option{sync}=@var{off}
+@end table
+
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
 Creates a memory backend object, which can be used to back the guest RAM.
-- 
2.14.1
