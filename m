Received: from eggs.gnu.org ([209.51.188.92]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gm8lb-00023q-8u
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 21:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gm8lX-0000Cl-BD
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 21:59:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:14705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gm8lJ-0008IL-Kb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 21:59:47 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Wed, 23 Jan 2019 10:59:53 +0800
Message-Id: <5db91f1f6d25bcb040208e1228e4035c7bae79ce.1548136274.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1548136274.git.yi.z.zhang@linux.intel.com>
References: <cover.1548136274.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V10 3/4] hostmem: add more information in error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

When there are multiple memory backends in use, including the object type
name and the property name in the error message can help users to locate
the error.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/hostmem-file.c | 6 ++++--
 backends/hostmem.c      | 8 +++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index e640749..0dd7a90 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -82,7 +82,8 @@ static void set_mem_path(Object *o, const char *str, Error **errp)
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property value");
+        error_setg(errp, "cannot change property 'mem-path' of %s",
+                   object_get_typename(o));
         return;
     }
     g_free(fb->mem_path);
@@ -120,7 +121,8 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     uint64_t val;
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(&local_err, "cannot change property value");
+        error_setg(&local_err, "cannot change property '%s' of %s",
+                   name, object_get_typename(o));
         goto out;
     }
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1a89342..e2bcf9f 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -47,7 +47,8 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
     uint64_t value;
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(&local_err, "cannot change property value");
+        error_setg(&local_err, "cannot change property %s of %s ",
+                   name, object_get_typename(obj));
         goto out;
     }
 
@@ -56,8 +57,9 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
         goto out;
     }
     if (!value) {
-        error_setg(&local_err, "Property '%s.%s' doesn't take value '%"
-                   PRIu64 "'", object_get_typename(obj), name, value);
+        error_setg(&local_err,
+                   "property '%s' of %s doesn't take value '%" PRIu64 "'",
+                   name, object_get_typename(obj), value);
         goto out;
     }
     backend->size = value;
-- 
2.7.4
