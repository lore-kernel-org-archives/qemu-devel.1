Received: from eggs.gnu.org ([209.51.188.92]:51308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSi-00008X-Lx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSh-0000WU-RN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1h3LSh-0000W0-Kl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190311135926euoutp020c61c692d9e4f6d53c79afd4d910e3df~K7DyYG0eb2092420924euoutp02f
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:59:26 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 11 Mar 2019 16:58:50 +0300
Message-Id: <20190311135850.6537-5-i.maximets@samsung.com>
In-Reply-To: <20190311135850.6537-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20190311135850.6537-1-i.maximets@samsung.com>
	<CGME20190311135925eucas1p21442eda0f28a7e6ae1f9a238ca0a4f0d@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/4] memfd: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

This gives more information about the failure.
Additionally 'ENOSYS' returned for a non-Linux platforms instead of
'errno', which is not initilaized in this case.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/memfd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/memfd.c b/util/memfd.c
index 393d23da96..00334e5b21 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -71,14 +71,18 @@ int qemu_memfd_create(const char *name, size_t size, =
bool hugetlb,
     }
     mfd =3D memfd_create(name, flags);
     if (mfd < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to create memfd with flags 0x%x", flags=
);
         goto err;
     }
=20
     if (ftruncate(mfd, size) =3D=3D -1) {
+        error_setg_errno(errp, errno, "failed to resize memfd to %zu", s=
ize);
         goto err;
     }
=20
     if (seals && fcntl(mfd, F_ADD_SEALS, seals) =3D=3D -1) {
+        error_setg_errno(errp, errno, "failed to add seals 0x%x", seals)=
;
         goto err;
     }
=20
@@ -88,8 +92,9 @@ err:
     if (mfd >=3D 0) {
         close(mfd);
     }
+#else
+    error_setg_errno(errp, ENOSYS, "failed to create memfd");
 #endif
-    error_setg_errno(errp, errno, "failed to create memfd");
     return -1;
 }
=20
--=20
2.17.1
