Received: from eggs.gnu.org ([2001:4830:134:3::10]:54121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUs-0000Tc-TJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUk-0007Ou-VS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUk-0007NO-Iu
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:22 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:58 +0200
Message-Id: <20170901125611.29295-35-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/47] tpm: Clean up driver registration & lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@us.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

We have a strict separation between enum TpmType and be_drivers[]:

* TpmType may have any number of members.  It just happens to have one.

* tpm_register_driver() uses the first empty slot in be_drivers[].

  If you register more than tpm_models[] has space,
  tpm_register_driver() fails.  Its caller silently ignores the
  failure.

  If you register more than one with a given TpmType,
  tpm_display_backend_drivers() will shows all of them, but
  tpm_driver_find_by_type() and tpm_get_backend_driver() will find
  only the one one that registered first.

Since we only ever register one driver, and be_drivers[] has space for
just that one, this contraption even works.

Turn be_drivers[] into a straight map from enum TpmType to driver.
Much simpler, and has a decent chance to actually work should we ever
acquire additional drivers.

While there, use qapi_enum_parse() in tpm_get_backend_driver().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-8-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, superfluous initializer dropped, commit message rewritten]
Cc: Stefan Berger <stefanb@us.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-4-git-send-email-armbru@redhat.com>
---
 include/sysemu/tpm_backend.h |  2 +-
 tpm.c                        | 45 +++++++++++++-------------------------=
------
 2 files changed, 14 insertions(+), 33 deletions(-)

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
index 9a7c7114d3..6f39ec9192 100644
--- a/tpm.c
+++ b/tpm.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qerror.h"
+#include "qapi/util.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
@@ -25,11 +26,8 @@ static QLIST_HEAD(, TPMBackend) tpm_backends =3D
=20
=20
 #define TPM_MAX_MODELS      1
-#define TPM_MAX_DRIVERS     1
=20
-static TPMDriverOps const *be_drivers[TPM_MAX_DRIVERS] =3D {
-    NULL,
-};
+static TPMDriverOps const *be_drivers[TPM_TYPE__MAX];
=20
 static enum TpmModel tpm_models[TPM_MAX_MODELS] =3D {
     TPM_MODEL__MAX,
@@ -63,31 +61,18 @@ static bool tpm_model_is_registered(enum TpmModel mod=
el)
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type)
 {
-    int i;
+    int i =3D qapi_enum_parse(TpmType_lookup, type, -1, NULL);
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
@@ -100,9 +85,12 @@ static void tpm_display_backend_drivers(void)
=20
     fprintf(stderr, "Supported TPM types (choose only one):\n");
=20
-    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
+    for (i =3D 0; i < TPM_TYPE__MAX; i++) {
+        if (be_drivers[i] =3D=3D NULL) {
+            continue;
+        }
         fprintf(stderr, "%12s   %s\n",
-                TpmType_lookup[be_drivers[i]->type], be_drivers[i]->desc=
());
+                TpmType_lookup[i], be_drivers[i]->desc());
     }
     fprintf(stderr, "\n");
 }
@@ -239,14 +227,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const =
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
2.13.5
