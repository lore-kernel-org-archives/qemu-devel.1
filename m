Received: from eggs.gnu.org ([209.51.188.92]:35806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UPr-0005Ve-Qb
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UPr-0002ZK-33
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Mar 2019 12:07:10 +0100
Message-Id: <20190306110711.309-10-laurent@vivier.eu>
In-Reply-To: <20190306110711.309-1-laurent@vivier.eu>
References: <20190306110711.309-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/10] hostmem-file: simplify ifdef-s in
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-s390x@nongnu.org, Corey Minyard <minyard@acm.org>, Pierre Morel <pmorel@linux.ibm.com>, Wei Yang <richardw.yang@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

cleanup file_backend_memory_alloc() by using one CONFIG_POSIX ifdef
instead of several ones within the function to make it simpler to follow.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190213123858.24620-1-imammedo@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190214031004.32522-2-stefanha@redhat.com>
[lv: s/hostmem/hostmem-file/]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 backends/hostmem-file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ba601ce94088..ce5478804804 100644
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
2.20.1
