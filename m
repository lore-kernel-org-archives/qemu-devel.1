Received: from eggs.gnu.org ([209.51.188.92]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Q0-0003Gc-V7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Pz-0006aT-1M
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:10:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gu7Px-0006Uu-7Q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:10:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Feb 2019 11:10:03 +0800
Message-Id: <20190214031004.32522-2-stefanha@redhat.com>
In-Reply-To: <20190214031004.32522-1-stefanha@redhat.com>
References: <20190214031004.32522-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

cleanup file_backend_memory_alloc() by using one CONFIG_POSIX ifdef
instead of several ones within the function to make it simpler to follow.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190213123858.24620-1-imammedo@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
     HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(backend);
-#ifdef CONFIG_POSIX
     gchar *name;
-#endif
=20
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -54,9 +56,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, E=
rror **errp)
         error_setg(errp, "mem-path property not set");
         return;
     }
-#ifndef CONFIG_POSIX
-    error_setg(errp, "-mem-path not supported on this host");
-#else
     backend->force_prealloc =3D mem_prealloc;
     name =3D host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
--=20
2.20.1
