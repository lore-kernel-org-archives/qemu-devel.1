Received: from eggs.gnu.org ([2001:4830:134:3::10]:49601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlh-0002bl-5A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlc-0000XZ-RQ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRdlc-0000Wd-Kc
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:08 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127135107euoutp02ffe370c8134f9759dc5fc0461961b33a~q-21uOOKj2313823138euoutp02W
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:51:07 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 16:50:30 +0300
Message-Id: <20181127135030.1671-5-i.maximets@samsung.com>
In-Reply-To: <20181127135030.1671-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135106eucas1p119ab7de9758f13ea52adc0f4829ab9cb@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] memfd: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

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
