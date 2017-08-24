Received: from eggs.gnu.org ([2001:4830:134:3::10]:51057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkxix-0006WL-Ux
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkxiw-0001dk-VU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkxiw-0001d8-NM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:23:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 24 Aug 2017 16:23:15 -0300
Message-Id: <20170824192315.5897-4-ehabkost@redhat.com>
In-Reply-To: <20170824192315.5897-1-ehabkost@redhat.com>
References: <20170824192315.5897-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] hostmem-file: Add "discard-data" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The new option can be used to indicate that the file contents can
be destroyed and don't need to be flushed to disk when QEMU exits
or when the memory backend object is removed.

Internally, it will trigger a madvise(MADV_REMOVE) call when the
memory backend is removed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Replaced 'persistent=no' with 'discard-data=yes', to make it clear
  that the flag will destroy data on the backing file.
* Call madvise() directly from unparent() method instead of
  relying on low-level memory backend code to call it.
  v1 relied on getting the memory region reference count back to
  0, which doesn't happen when QEMU is exiting because there's no
  machine cleanup code to ensure that.
---
 backends/hostmem-file.c | 29 +++++++++++++++++++++++++++++
 qemu-options.hx         |  5 ++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index fc4ef46..e44c319 100644
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
index 9f6e2ad..ad985e4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4160,7 +4160,7 @@ property must be set.  These objects are placed in the
 
 @table @option
 
-@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off}
+@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off}
 
 Creates a memory file backend object, which can be used to back
 the guest RAM with huge pages. The @option{id} parameter is a
@@ -4172,6 +4172,9 @@ the path to either a shared memory or huge page filesystem mount.
 The @option{share} boolean option determines whether the memory
 region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
+Setting the @option{discard-data} boolean option to @var{on}
+indicates that file contents can be destroyed when QEMU exits,
+to avoid unnecessarily flushing data to the backing file.
 
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
-- 
2.9.4
