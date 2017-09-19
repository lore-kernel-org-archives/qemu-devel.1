Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzC-000500-Tm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOz8-0004Kq-88
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOz7-0004K3-Vy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:41 -0300
Message-Id: <20170919201850.14772-4-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/12] hostmem-file: Add "discard-data" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The new option can be used to indicate that the file contents can
be destroyed and don't need to be flushed to disk when QEMU exits
or when the memory backend object is removed.

Internally, it will trigger a madvise(MADV_REMOVE) call when the
memory backend is removed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170824192315.5897-4-ehabkost@redhat.com>
[ehabkost: fixup: improved documentation]
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Tested-by: Zack Cornelius <zack.cornelius@kove.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c | 29 +++++++++++++++++++++++++++++
 qemu-options.hx         |  8 +++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index fc4ef46d11..e44c319915 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -32,6 +32,7 @@ struct HostMemoryBackendFile {
     HostMemoryBackend parent_obj;
 
     bool share;
+    bool discard_data;
     char *mem_path;
 };
 
@@ -103,16 +104,44 @@ static void file_memory_backend_set_share(Object *o, bool value, Error **errp)
     fb->share = value;
 }
 
+static bool file_memory_backend_get_discard_data(Object *o, Error **errp)
+{
+    return MEMORY_BACKEND_FILE(o)->discard_data;
+}
+
+static void file_memory_backend_set_discard_data(Object *o, bool value,
+                                               Error **errp)
+{
+    MEMORY_BACKEND_FILE(o)->discard_data = value;
+}
+
+static void file_backend_unparent(Object *obj)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
+
+    if (host_memory_backend_mr_inited(backend) && fb->discard_data) {
+        void *ptr = memory_region_get_ram_ptr(&backend->mr);
+        uint64_t sz = memory_region_size(&backend->mr);
+
+        qemu_madvise(ptr, sz, QEMU_MADV_REMOVE);
+    }
+}
+
 static void
 file_backend_class_init(ObjectClass *oc, void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
 
     bc->alloc = file_backend_memory_alloc;
+    oc->unparent = file_backend_unparent;
 
     object_class_property_add_bool(oc, "share",
         file_memory_backend_get_share, file_memory_backend_set_share,
         &error_abort);
+    object_class_property_add_bool(oc, "discard-data",
+        file_memory_backend_get_discard_data, file_memory_backend_set_discard_data,
+        &error_abort);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path,
         &error_abort);
diff --git a/qemu-options.hx b/qemu-options.hx
index 600614f6e5..77859a248c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4182,7 +4182,7 @@ property must be set.  These objects are placed in the
 
 @table @option
 
-@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off}
+@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off}
 
 Creates a memory file backend object, which can be used to back
 the guest RAM with huge pages. The @option{id} parameter is a
@@ -4194,6 +4194,12 @@ the path to either a shared memory or huge page filesystem mount.
 The @option{share} boolean option determines whether the memory
 region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
+Setting the @option{discard-data} boolean option to @var{on}
+indicates that file contents can be destroyed when QEMU exits,
+to avoid unnecessarily flushing data to the backing file.  Note
+that @option{discard-data} is only an optimization, and QEMU
+might not discard file contents if it aborts unexpectedly or is
+terminated using SIGKILL.
 
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
-- 
2.13.5
