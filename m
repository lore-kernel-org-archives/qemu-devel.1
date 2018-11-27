Received: from eggs.gnu.org ([2001:4830:134:3::10]:51259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbGu-0003Kn-1s
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbGq-0004q9-ON
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:16 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRbGq-0004pg-IY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:12 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127111110euoutp025215ec040b3a975f7e3d97afebd33f25~q9rL9Civp2967029670euoutp02P
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 11:11:10 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 14:10:47 +0300
Message-Id: <20181127111050.18453-2-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127111050.18453-1-i.maximets@samsung.com>
	<CGME20181127111109eucas1p2b1eae35e38e46c3f76c86a350ed41926@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] hostmem-memfd: enable seals only if
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

If seals are not supported, memfd_create() will fail.
Furthermore, there is no way to disable it in this case because
'.seal' property is not registered.

This issue leads to vhost-user-test failures on RHEL 7.2:

  qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=3D2M,: \
                      failed to create memfd: Invalid argument

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---
 backends/hostmem-memfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index b6836b28e5..ee39bdbde6 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -129,8 +129,8 @@ memfd_backend_instance_init(Object *obj)
 {
     HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
=20
-    /* default to sealed file */
-    m->seal =3D true;
+    /* default to sealed file if supported */
+    m->seal =3D qemu_memfd_check(MFD_ALLOW_SEALING);
 }
=20
 static void
--=20
2.17.1
