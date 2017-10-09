Received: from eggs.gnu.org ([2001:4830:134:3::10]:54413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyZ-0005Pr-Km
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyY-0004ov-9o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyY-0004oS-4N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:45 +0200
Message-Id: <20171009225623.29232-5-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/42] tpm: lookup tpm backend class in
 tpm_driver_find_by_type()
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

One step towards removing TPMDriverOps and driver registration.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tpm.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tpm.c b/tpm.c
index bc7d7470a8..04de8da5fd 100644
--- a/tpm.c
+++ b/tpm.c
@@ -47,6 +47,24 @@ void tpm_register_driver(const TPMDriverOps *tdo)
     be_drivers[tdo->type] =3D tdo;
 }
=20
+static const TPMDriverOps *
+tpm_driver_find_by_type(enum TpmType type)
+{
+    ObjectClass *oc;
+    TPMBackendClass *bc;
+    char *typename =3D g_strdup_printf("tpm-%s", TpmType_str(type));
+
+    oc =3D object_class_by_name(typename);
+    g_free(typename);
+
+    if (!object_class_dynamic_cast(oc, TYPE_TPM_BACKEND)) {
+        return NULL;
+    }
+
+    bc =3D TPM_BACKEND_CLASS(oc);
+    return bc->ops;
+}
+
 /*
  * Walk the list of available TPM backend drivers and display them on th=
e
  * screen.
@@ -58,11 +76,11 @@ static void tpm_display_backend_drivers(void)
     fprintf(stderr, "Supported TPM types (choose only one):\n");
=20
     for (i =3D 0; i < TPM_TYPE__MAX; i++) {
-        if (be_drivers[i] =3D=3D NULL) {
+        const TPMDriverOps *ops =3D tpm_driver_find_by_type(i);
+        if (!ops) {
             continue;
         }
-        fprintf(stderr, "%12s   %s\n",
-                TpmType_str(i), be_drivers[i]->desc);
+        fprintf(stderr, "%12s   %s\n", TpmType_str(i), ops->desc);
     }
     fprintf(stderr, "\n");
 }
@@ -196,11 +214,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const =
char *optarg)
=20
 #endif /* CONFIG_TPM */
=20
-static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
-{
-    return be_drivers[type];
-}
-
 /*
  * Walk the list of active TPM backends and collect information about th=
em
  * following the schema description in qapi-schema.json.
--=20
2.14.1.146.gd35faa819
