Received: from eggs.gnu.org ([2001:4830:134:3::10]:35492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReUF-00046f-24
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU7-00022w-Q7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gReU7-0001xU-FL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id y185so1732799wmd.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:37:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:37 +0100
Message-Id: <1543329397-48407-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/15] hostmem: no need to check for
 host_memory_backend_mr_inited() in alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

memfd_backend_memory_alloc/file_backend_memory_alloc both needlessly
are are calling host_memory_backend_mr_inited() which creates an
illusion that alloc could be called multiple times but it isn't, it's
called once from UserCreatable complete().

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem-file.c  | 24 ++++++++++++------------
 backends/hostmem-memfd.c |  4 ----
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 639c8d4..7cd3a2b 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -42,6 +42,9 @@ static void
 file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(backend);
+#ifdef CONFIG_LINUX
+    gchar *path;
+#endif
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -54,18 +57,15 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 #ifndef CONFIG_POSIX
     error_setg(errp, "-mem-path not supported on this host");
 #else
-    if (!host_memory_backend_mr_inited(backend)) {
-        gchar *path;
-        backend->force_prealloc = mem_prealloc;
-        path = object_get_canonical_path(OBJECT(backend));
-        memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-                                 path,
-                                 backend->size, fb->align,
-                                 (backend->share ? RAM_SHARED : 0) |
-                                 (fb->is_pmem ? RAM_PMEM : 0),
-                                 fb->mem_path, errp);
-        g_free(path);
-    }
+    backend->force_prealloc = mem_prealloc;
+    path = object_get_canonical_path(OBJECT(backend));
+    memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
+                                     path,
+                                     backend->size, fb->align,
+                                     (backend->share ? RAM_SHARED : 0) |
+                                     (fb->is_pmem ? RAM_PMEM : 0),
+                                     fb->mem_path, errp);
+    g_free(path);
 #endif
 }
 
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 1c3579e..2eb9c82 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -44,10 +44,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return;
     }
 
-    if (host_memory_backend_mr_inited(backend)) {
-        return;
-    }
-
     backend->force_prealloc = mem_prealloc;
     fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                            m->hugetlb, m->hugetlbsize, m->seal ?
-- 
1.8.3.1
