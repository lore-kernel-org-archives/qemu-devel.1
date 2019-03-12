Received: from eggs.gnu.org ([209.51.188.92]:35682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vsb-0008QU-2e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vlv-0007Ut-KY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3Vlt-0007Ti-Jj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 21:59:30 -0300
Message-Id: <20190312005930.9043-8-ehabkost@redhat.com>
In-Reply-To: <20190312005930.9043-1-ehabkost@redhat.com>
References: <20190312005930.9043-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] memfd: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Ilya Maximets <i.maximets@samsung.com>

From: Ilya Maximets <i.maximets@samsung.com>

This gives more information about the failure.
Additionally 'ENOSYS' returned for a non-Linux platforms instead of
'errno', which is not initilaized in this case.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190311135850.6537-5-i.maximets@samsung.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
