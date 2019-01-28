Received: from eggs.gnu.org ([209.51.188.92]:42179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCp4-00047U-OJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCp4-0004Sz-1a
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCp3-0004SG-SK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:57 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 28 Jan 2019 17:43:51 -0200
Message-Id: <20190128194351.14679-3-ehabkost@redhat.com>
In-Reply-To: <20190128194351.14679-1-ehabkost@redhat.com>
References: <20190128194351.14679-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] hostmem: add more information in error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

When there are multiple memory backends in use, including the object type
and property name in the error message can help users to locate the error.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Message-Id: <97d9193875747d8378c05b9e3b3cb39c1b7d2b4e.1546399191.git.yi.z.zhang@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: reword commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c | 6 ++++--
 backends/hostmem.c      | 8 +++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 7a34e25c43..ba601ce940 100644
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
index 0c8ef17653..87b19d2111 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -57,7 +57,8 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
     uint64_t value;
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(&local_err, "cannot change property value");
+        error_setg(&local_err, "cannot change property %s of %s ",
+                   name, object_get_typename(obj));
         goto out;
     }
 
@@ -66,8 +67,9 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
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
2.18.0.rc1.1.g3f1ff2140
