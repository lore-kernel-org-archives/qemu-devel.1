Received: from eggs.gnu.org ([2001:4830:134:3::10]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvR5Y-0004au-Pr
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 13:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvR5V-0007FH-JZ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 13:50:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvR5V-0007F0-DQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 13:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9B527A7E6
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 17:50:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 19:50:19 +0200
Message-Id: <20180830175019.16939-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hostmem: no need to check for
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
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

memfd_backend_memory_alloc/file_backend_memory_alloc both needlessly
are are calling host_memory_backend_mr_inited() which creates an
illusion that alloc could be called multiple times but it isn't, it's
called once from UserCreatable complete().

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c  | 2 +-
 backends/hostmem-memfd.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 2476dcb435..5cd5fa75a7 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -54,7 +54,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, E=
rror **errp)
 #ifndef CONFIG_LINUX
     error_setg(errp, "-mem-path not supported on this host");
 #else
-    if (!host_memory_backend_mr_inited(backend)) {
+    {
         gchar *path;
         backend->force_prealloc =3D mem_prealloc;
         path =3D object_get_canonical_path(OBJECT(backend));
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index abd52364db..7184918112 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -44,10 +44,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
         return;
     }
=20
-    if (host_memory_backend_mr_inited(backend)) {
-        return;
-    }
-
     backend->force_prealloc =3D mem_prealloc;
     fd =3D qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                            m->hugetlb, m->hugetlbsize, m->seal ?
--=20
2.19.0.rc0.48.gb9dfa238d5
