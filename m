Received: from eggs.gnu.org ([2001:4830:134:3::10]:54484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyk-0005XP-47
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyh-0004s9-03
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyg-0004rp-Ps
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:50 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:47 +0200
Message-Id: <20171009225623.29232-7-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/42] tpm: remove tpm_register_driver()
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

No more users of be_drivers[], drop that too.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 1 -
 hw/tpm/tpm_emulator.c        | 1 -
 hw/tpm/tpm_passthrough.c     | 1 -
 tpm.c                        | 8 --------
 4 files changed, 11 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index c6e5637f68..adb6a68076 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -216,6 +216,5 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
 TPMBackend *qemu_find_tpm(const char *id);
=20
 void tpm_register_model(enum TpmModel model);
-void tpm_register_driver(const TPMDriverOps *tdo);
=20
 #endif
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 5ddd7238d2..9e24a5f30e 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -581,7 +581,6 @@ static const TypeInfo tpm_emulator_info =3D {
 static void tpm_emulator_register(void)
 {
     type_register_static(&tpm_emulator_info);
-    tpm_register_driver(&tpm_emulator_driver);
 }
=20
 type_init(tpm_emulator_register)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index e6ace28b04..f04eab3e63 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -418,7 +418,6 @@ static const TypeInfo tpm_passthrough_info =3D {
 static void tpm_passthrough_register(void)
 {
     type_register_static(&tpm_passthrough_info);
-    tpm_register_driver(&tpm_passthrough_driver);
 }
=20
 type_init(tpm_passthrough_register)
diff --git a/tpm.c b/tpm.c
index ad2ed6a0da..75a589b837 100644
--- a/tpm.c
+++ b/tpm.c
@@ -23,7 +23,6 @@
 static QLIST_HEAD(, TPMBackend) tpm_backends =3D
     QLIST_HEAD_INITIALIZER(tpm_backends);
=20
-static TPMDriverOps const *be_drivers[TPM_TYPE__MAX];
 static bool tpm_models[TPM_MODEL__MAX];
=20
 void tpm_register_model(enum TpmModel model)
@@ -33,13 +32,6 @@ void tpm_register_model(enum TpmModel model)
=20
 #ifdef CONFIG_TPM
=20
-void tpm_register_driver(const TPMDriverOps *tdo)
-{
-    assert(!be_drivers[tdo->type]);
-
-    be_drivers[tdo->type] =3D tdo;
-}
-
 static const TPMDriverOps *
 tpm_driver_find_by_type(enum TpmType type)
 {
--=20
2.14.1.146.gd35faa819
