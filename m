Received: from eggs.gnu.org ([2001:4830:134:3::10]:53712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Ez-000469-VM
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Ez-0003mU-4N
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Ey-0003mH-R9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77AD1C058EBD
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:23:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:08 +0200
Message-Id: <20170822132255.23945-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/54] tpm: simplify driver registration &
 lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Make be_drivers[n] match order of TpmType enum.

Use qapi_enum_parse() in tpm_get_backend_driver.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h |  2 +-
 tpm.c                        | 42 ++++++++++++--------------------------=
----
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index b58f52d39f..1d21c6b19b 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -227,6 +227,6 @@ TPMBackend *qemu_find_tpm(const char *id);
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
 int tpm_register_model(enum TpmModel model);
-int tpm_register_driver(const TPMDriverOps *tdo);
+void tpm_register_driver(const TPMDriverOps *tdo);
=20
 #endif
diff --git a/tpm.c b/tpm.c
index c3b731b3f2..f175661bfe 100644
--- a/tpm.c
+++ b/tpm.c
@@ -26,9 +26,8 @@ static QLIST_HEAD(, TPMBackend) tpm_backends =3D
=20
=20
 #define TPM_MAX_MODELS      1
-#define TPM_MAX_DRIVERS     1
=20
-static TPMDriverOps const *be_drivers[TPM_MAX_DRIVERS] =3D {
+static TPMDriverOps const *be_drivers[TPM_TYPE__MAX] =3D {
     NULL,
 };
=20
@@ -64,31 +63,18 @@ static bool tpm_model_is_registered(enum TpmModel mod=
el)
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type)
 {
-    int i;
+    int i =3D qapi_enum_parse(TpmType_lookup, type, TPM_TYPE__MAX, -1, N=
ULL);
=20
-    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
-        if (!strcmp(TpmType_lookup[be_drivers[i]->type], type)) {
-            return be_drivers[i];
-        }
-    }
-
-    return NULL;
+    return i >=3D 0 ? be_drivers[i] : NULL;
 }
=20
 #ifdef CONFIG_TPM
=20
-int tpm_register_driver(const TPMDriverOps *tdo)
+void tpm_register_driver(const TPMDriverOps *tdo)
 {
-    int i;
+    assert(!be_drivers[tdo->type]);
=20
-    for (i =3D 0; i < TPM_MAX_DRIVERS; i++) {
-        if (!be_drivers[i]) {
-            be_drivers[i] =3D tdo;
-            return 0;
-        }
-    }
-    error_report("Could not register TPM driver");
-    return 1;
+    be_drivers[tdo->type] =3D tdo;
 }
=20
 /*
@@ -101,9 +87,12 @@ static void tpm_display_backend_drivers(void)
=20
     fprintf(stderr, "Supported TPM types (choose only one):\n");
=20
-    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
+    for (i =3D 0; i < TPM_TYPE__MAX; i++) {
+        if (be_drivers[i] =3D=3D NULL) {
+            continue;
+        }
         fprintf(stderr, "%12s   %s\n",
-                qapi_enum_lookup(TpmType_lookup, be_drivers[i]->type),
+                qapi_enum_lookup(TpmType_lookup, i),
                 be_drivers[i]->desc());
     }
     fprintf(stderr, "\n");
@@ -241,14 +230,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const =
char *optarg)
=20
 static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
 {
-    int i;
-
-    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
-        if (be_drivers[i]->type =3D=3D type) {
-            return be_drivers[i];
-        }
-    }
-    return NULL;
+    return be_drivers[type];
 }
=20
 static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
--=20
2.14.1.146.gd35faa819
