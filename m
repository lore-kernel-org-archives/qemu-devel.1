Received: from eggs.gnu.org ([2001:4830:134:3::10]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H84-0002IW-FD
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H83-0004kY-BX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H83-0004jm-2n
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:47:03 -0300
Message-Id: <20170420184705.25018-14-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] hostmem: use
 host_memory_backend_mr_inited() where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Use the new interface to boost readability.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1489151370-15453-3-git-send-email-peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c |  6 +++---
 backends/hostmem.c      | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 42efb2f28a..fc4ef46d11 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -51,7 +51,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 #ifndef CONFIG_LINUX
     error_setg(errp, "-mem-path not supported on this host");
 #else
-    if (!memory_region_size(&backend->mr)) {
+    if (!host_memory_backend_mr_inited(backend)) {
         gchar *path;
         backend->force_prealloc = mem_prealloc;
         path = object_get_canonical_path(OBJECT(backend));
@@ -76,7 +76,7 @@ static void set_mem_path(Object *o, const char *str, Error **errp)
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
-    if (memory_region_size(&backend->mr)) {
+    if (host_memory_backend_mr_inited(backend)) {
         error_setg(errp, "cannot change property value");
         return;
     }
@@ -96,7 +96,7 @@ static void file_memory_backend_set_share(Object *o, bool value, Error **errp)
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
-    if (memory_region_size(&backend->mr)) {
+    if (host_memory_backend_mr_inited(backend)) {
         error_setg(errp, "cannot change property value");
         return;
     }
diff --git a/backends/hostmem.c b/backends/hostmem.c
index d8faab4bed..4606b73849 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -45,7 +45,7 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
     Error *local_err = NULL;
     uint64_t value;
 
-    if (memory_region_size(&backend->mr)) {
+    if (host_memory_backend_mr_inited(backend)) {
         error_setg(&local_err, "cannot change property value");
         goto out;
     }
@@ -146,7 +146,7 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
-    if (!memory_region_size(&backend->mr)) {
+    if (!host_memory_backend_mr_inited(backend)) {
         backend->merge = value;
         return;
     }
@@ -172,7 +172,7 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
-    if (!memory_region_size(&backend->mr)) {
+    if (!host_memory_backend_mr_inited(backend)) {
         backend->dump = value;
         return;
     }
@@ -208,7 +208,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         }
     }
 
-    if (!memory_region_size(&backend->mr)) {
+    if (!host_memory_backend_mr_inited(backend)) {
         backend->prealloc = value;
         return;
     }
@@ -249,7 +249,7 @@ bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
 MemoryRegion *
 host_memory_backend_get_memory(HostMemoryBackend *backend, Error **errp)
 {
-    return memory_region_size(&backend->mr) ? &backend->mr : NULL;
+    return host_memory_backend_mr_inited(backend) ? &backend->mr : NULL;
 }
 
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mapped)
-- 
2.11.0.259.g40922b1
