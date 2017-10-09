Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyd-0005T6-U6
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyd-0004qe-43
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyc-0004qN-Tk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:46 +0200
Message-Id: <20171009225623.29232-6-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/42] tpm: replace tpm_get_backend_driver() to
 drop be_drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use tpm_driver_find_by_type() instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tpm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tpm.c b/tpm.c
index 04de8da5fd..ad2ed6a0da 100644
--- a/tpm.c
+++ b/tpm.c
@@ -31,13 +31,6 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] =3D true;
 }
=20
-static const TPMDriverOps *tpm_get_backend_driver(const char *type)
-{
-    int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
-
-    return i >=3D 0 ? be_drivers[i] : NULL;
-}
-
 #ifdef CONFIG_TPM
=20
 void tpm_register_driver(const TPMDriverOps *tdo)
@@ -110,6 +103,7 @@ static int configure_tpm(QemuOpts *opts)
     const TPMDriverOps *be;
     TPMBackend *drv;
     Error *local_err =3D NULL;
+    int i;
=20
     if (!QLIST_EMPTY(&tpm_backends)) {
         error_report("Only one TPM is allowed.");
@@ -129,7 +123,8 @@ static int configure_tpm(QemuOpts *opts)
         return 1;
     }
=20
-    be =3D tpm_get_backend_driver(value);
+    i =3D qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
+    be =3D i >=3D 0 ? tpm_driver_find_by_type(i) : NULL;
     if (be =3D=3D NULL) {
         error_report(QERR_INVALID_PARAMETER_VALUE,
                      "type", "a TPM backend type");
--=20
2.14.1.146.gd35faa819
