Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1S-0006iM-K2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1M-0001jT-HW
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1M-0001i8-9n
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:12 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:46 +0200
Message-Id: <20170901153758.8628-36-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 35/47] tpm: Clean up model registration &
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
Cc: Stefan Berger <stefanb@us.ibm.com>

We have a strict separation between enum TpmModel and tpm_models[]:

* TpmModel may have any number of members.  It just happens to have one.

* tpm_register_model() uses the first empty slot in tpm_models[].

  If you register more than tpm_models[] has space,
  tpn_register_model() fails.  Its caller silently ignores the
  failure.

  Register the same TpmModel more than once has no effect other than
  wasting tpm_models[] slots: tpm_model_is_registered() is happy with
  the first one it finds.

Since we only ever register one model, and tpm_models[] has space for
just that one, this contraption even works.

Turn tpm_models[] into a straight map from enum TpmType to bool.  Much
simpler.

Cc: Stefan Berger <stefanb@us.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-5-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[Commit message typo fixed]
---
 include/sysemu/tpm_backend.h |  2 +-
 tpm.c                        | 37 +++++--------------------------------
 2 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 1d21c6b19b..b0a9731aee 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -226,7 +226,7 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)=
;
 TPMBackend *qemu_find_tpm(const char *id);
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
-int tpm_register_model(enum TpmModel model);
+void tpm_register_model(enum TpmModel model);
 void tpm_register_driver(const TPMDriverOps *tdo);
=20
 #endif
diff --git a/tpm.c b/tpm.c
index 6f39ec9192..7635fc779b 100644
--- a/tpm.c
+++ b/tpm.c
@@ -24,39 +24,12 @@
 static QLIST_HEAD(, TPMBackend) tpm_backends =3D
     QLIST_HEAD_INITIALIZER(tpm_backends);
=20
-
-#define TPM_MAX_MODELS      1
-
 static TPMDriverOps const *be_drivers[TPM_TYPE__MAX];
+static bool tpm_models[TPM_MODEL__MAX];
=20
-static enum TpmModel tpm_models[TPM_MAX_MODELS] =3D {
-    TPM_MODEL__MAX,
-};
-
-int tpm_register_model(enum TpmModel model)
+void tpm_register_model(enum TpmModel model)
 {
-    int i;
-
-    for (i =3D 0; i < TPM_MAX_MODELS; i++) {
-        if (tpm_models[i] =3D=3D TPM_MODEL__MAX) {
-            tpm_models[i] =3D model;
-            return 0;
-        }
-    }
-    error_report("Could not register TPM model");
-    return 1;
-}
-
-static bool tpm_model_is_registered(enum TpmModel model)
-{
-    int i;
-
-    for (i =3D 0; i < TPM_MAX_MODELS; i++) {
-        if (tpm_models[i] =3D=3D model) {
-            return true;
-        }
-    }
-    return false;
+    tpm_models[model] =3D true;
 }
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type)
@@ -270,7 +243,7 @@ TPMInfoList *qmp_query_tpm(Error **errp)
     TPMInfoList *info, *head =3D NULL, *cur_item =3D NULL;
=20
     QLIST_FOREACH(drv, &tpm_backends, list) {
-        if (!tpm_model_is_registered(drv->fe_model)) {
+        if (!tpm_models[drv->fe_model]) {
             continue;
         }
         info =3D g_new0(TPMInfoList, 1);
@@ -317,7 +290,7 @@ TpmModelList *qmp_query_tpm_models(Error **errp)
     TpmModelList *head =3D NULL, *prev =3D NULL, *cur_item;
=20
     for (i =3D 0; i < TPM_MODEL__MAX; i++) {
-        if (!tpm_model_is_registered(i)) {
+        if (!tpm_models[i]) {
             continue;
         }
         cur_item =3D g_new0(TpmModelList, 1);
--=20
2.13.5
