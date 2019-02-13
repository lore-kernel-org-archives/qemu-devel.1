Received: from eggs.gnu.org ([209.51.188.92]:40713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gttok-0007Aw-7j
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gttoj-0006V9-DB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:39:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gttoj-0006Uf-84
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:39:09 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Feb 2019 07:38:58 -0500
Message-Id: <20190213123858.24620-1-imammedo@redhat.com>
In-Reply-To: <20190213071401.11544-1-stefanha@redhat.com>
References: <20190213071401.11544-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Zhang Yi <yi.z.zhang@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>

cleanup file_backend_memory_alloc() by using one CONFIG_POSIX ifdef
instead of several ones within the function to make it simpler to follow.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
---
Cc: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
CC: Wei Yang <richardw.yang@linux.intel.com>
---
 backends/hostmem-file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ba601ce940..ce54788048 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -41,10 +41,12 @@ struct HostMemoryBackendFile {
 static void
 file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
+#ifndef CONFIG_POSIX
+    error_setg(errp, "backend '%s' not supported on this host",
+               object_get_typename(OBJECT(backend)));
+#else
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
-#ifdef CONFIG_POSIX
     gchar *name;
-#endif
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -54,9 +56,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         error_setg(errp, "mem-path property not set");
         return;
     }
-#ifndef CONFIG_POSIX
-    error_setg(errp, "-mem-path not supported on this host");
-#else
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-- 
2.18.1
