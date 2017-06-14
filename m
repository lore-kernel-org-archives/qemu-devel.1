Received: from eggs.gnu.org ([2001:4830:134:3::10]:34477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEw4-0001Hk-VI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEw3-0005r8-Mk
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLEw3-0005qZ-DU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D08580C08
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:30:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 17:30:00 -0300
Message-Id: <20170614203000.19984-6-ehabkost@redhat.com>
In-Reply-To: <20170614203000.19984-1-ehabkost@redhat.com>
References: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] hostmem-file: Add "persistent" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The new option can be used to indicate that the memory block contents
can be safely discarded and don't need to be flushed to the filesystem
when the memory backend is destroyed (including when QEMU exits).

Internally, it will trigger a madvise(MADV_REMOVE) or
fallocate(FALLOC_FL_PUNCH_HOLE) call when the memory backend is
destroyed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c | 35 ++++++++++++++++++++++++++++++++++-
 qemu-options.hx         |  9 ++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index d078775b4b..e6cb232349 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -32,6 +32,7 @@ struct HostMemoryBackendFile {
     HostMemoryBackend parent_obj;
 
     bool share;
+    bool persistent;
     char *mem_path;
 };
 
@@ -57,7 +58,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->share, true,
+                                 backend->size, fb->share, fb->persistent,
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -103,6 +104,26 @@ static void file_memory_backend_set_share(Object *o, bool value, Error **errp)
     fb->share = value;
 }
 
+static bool file_memory_backend_get_persistent(Object *o, Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    return fb->persistent;
+}
+
+static void file_memory_backend_set_persistent(Object *o, bool value,
+                                               Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+    fb->persistent = value;
+}
+
 static void
 file_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -110,14 +131,25 @@ file_backend_class_init(ObjectClass *oc, void *data)
 
     bc->alloc = file_backend_memory_alloc;
 
+
     object_class_property_add_bool(oc, "share",
         file_memory_backend_get_share, file_memory_backend_set_share,
         &error_abort);
+    object_class_property_add_bool(oc, "persistent",
+        file_memory_backend_get_persistent, file_memory_backend_set_persistent,
+        &error_abort);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path,
         &error_abort);
 }
 
+static void file_backend_instance_init(Object *o)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    fb->persistent = true;
+}
+
 static void file_backend_instance_finalize(Object *o)
 {
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
@@ -129,6 +161,7 @@ static const TypeInfo file_backend_info = {
     .name = TYPE_MEMORY_BACKEND_FILE,
     .parent = TYPE_MEMORY_BACKEND,
     .class_init = file_backend_class_init,
+    .instance_init = file_backend_instance_init,
     .instance_finalize = file_backend_instance_finalize,
     .instance_size = sizeof(HostMemoryBackendFile),
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index 30c4f9850f..7fb4feec9b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3961,7 +3961,7 @@ property must be set.  These objects are placed in the
 
 @table @option
 
-@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off}
+@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},persistent=@var{on|off}
 
 Creates a memory file backend object, which can be used to back
 the guest RAM with huge pages. The @option{id} parameter is a
@@ -3973,6 +3973,13 @@ the path to either a shared memory or huge page filesystem mount.
 The @option{share} boolean option determines whether the memory
 region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
+Setting the @option{persistent} boolean option to @var{off}
+indicates that memory contents can be safely discarded and not
+flushed to disk when the backend object is destroyed or QEMU
+exits.  @option{persistent} is @var{on} by default.  It is valid
+to set @option{persistent} to @var{off} if @option{share} is
+@var{on}. It is redundant to set @option{persistent} to @var{off}
+if @option{share} is @var{off}.
 
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
-- 
2.11.0.259.g40922b1
