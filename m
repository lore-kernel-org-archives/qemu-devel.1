Received: from eggs.gnu.org ([2001:4830:134:3::10]:36284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QK-NQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAL-0007Q0-4u
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007OA-Os
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI2Hoe047138
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpvu3rt3n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:40 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-7-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 06/21] tpm: remove tpm_register_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

No more users of be_drivers[], drop that too.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c        | 1 -
 hw/tpm/tpm_passthrough.c     | 1 -
 include/sysemu/tpm_backend.h | 1 -
 tpm.c                        | 8 --------
 4 files changed, 11 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 95e1e04..187a69e 100644
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
index e6ace28..f04eab3 100644
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
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index c6e5637..adb6a68 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -216,6 +216,5 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
 TPMBackend *qemu_find_tpm(const char *id);
=20
 void tpm_register_model(enum TpmModel model);
-void tpm_register_driver(const TPMDriverOps *tdo);
=20
 #endif
diff --git a/tpm.c b/tpm.c
index ad2ed6a..75a589b 100644
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
2.5.5
