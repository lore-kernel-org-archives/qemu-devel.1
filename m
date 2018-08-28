Received: from eggs.gnu.org ([2001:4830:134:3::10]:48069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fug4u-00041m-Nf
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fug4q-0000xr-Lo
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:38:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fug4q-0000vs-G1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:38:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7325401EF0F
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 15:38:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 17:38:40 +0200
Message-Id: <20180828153840.22519-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hostmem-memfd: honour share=on/off property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The share=3Don/off property is used to modified mmap() MAP_SHARED
setting. Make it on by default for convenience and compatibility
reasons.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-memfd.c | 4 +++-
 qemu-options.hx          | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 1e20fe0ba8..abd52364db 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -59,7 +59,8 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, =
Error **errp)
=20
     name =3D object_get_canonical_path(OBJECT(backend));
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
-                                   name, backend->size, true, fd, errp);
+                                   name, backend->size,
+                                   backend->share, fd, errp);
     g_free(name);
 }
=20
@@ -131,6 +132,7 @@ memfd_backend_instance_init(Object *obj)
=20
     /* default to sealed file */
     m->seal =3D true;
+    MEMORY_BACKEND(m)->share =3D true;
 }
=20
 static void
diff --git a/qemu-options.hx b/qemu-options.hx
index f14e423b7c..25c02d72b8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4029,7 +4029,7 @@ Memory backend objects offer more control than the =
@option{-m} option that is
 traditionally used to define guest RAM. Please refer to
 @option{memory-backend-file} for a description of the options.
=20
-@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},du=
mp=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-nodes=3D=
@var{host-nodes},policy=3D@var{default|preferred|bind|interleave},seal=3D=
@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{size}
+@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},du=
mp=3D@var{on|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=3D@va=
r{size},host-nodes=3D@var{host-nodes},policy=3D@var{default|preferred|bin=
d|interleave},seal=3D@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@v=
ar{size}
=20
 Creates an anonymous memory file backend object, which allows QEMU to
 share the memory with an external process (e.g. when using
@@ -4051,6 +4051,8 @@ with the @option{seal} option (requires at least Li=
nux 4.16).
 Please refer to @option{memory-backend-file} for a description of the
 other options.
=20
+The @option{share} boolean option is @var{on} by default with memfd.
+
 @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
=20
 Creates a random number generator backend which obtains entropy from
--=20
2.19.0.rc0.48.gb9dfa238d5
