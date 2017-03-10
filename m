Received: from eggs.gnu.org ([2001:4830:134:3::10]:55475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmBw7-0005Mg-3j
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmBw3-0006Rb-VZ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:13:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cmBw3-0006R0-Pe
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:13:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF9A264A5B
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 04:13:47 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 10 Mar 2017 12:13:33 +0800
Message-Id: <1489119213-977-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] hostmem: fix reference to uninit mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

Trying to get memory region size of an uninitialized memory region is
probably not a good idea. Let's just do the alloc no matter what.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-file.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 42efb2f..a61d1bd 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -39,6 +39,7 @@ static void
 file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
+    gchar *path;
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -51,16 +52,12 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 #ifndef CONFIG_LINUX
     error_setg(errp, "-mem-path not supported on this host");
 #else
-    if (!memory_region_size(&backend->mr)) {
-        gchar *path;
-        backend->force_prealloc = mem_prealloc;
-        path = object_get_canonical_path(OBJECT(backend));
-        memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-                                 path,
-                                 backend->size, fb->share,
-                                 fb->mem_path, errp);
-        g_free(path);
-    }
+    backend->force_prealloc = mem_prealloc;
+    path = object_get_canonical_path(OBJECT(backend));
+    memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
+                                     path, backend->size, fb->share,
+                                     fb->mem_path, errp);
+    g_free(path);
 #endif
 }
 
-- 
2.7.4
