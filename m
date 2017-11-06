Received: from eggs.gnu.org ([2001:4830:134:3::10]:40363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmL6-00087Q-5m
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmL5-0005rN-CA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmL5-0005qA-5h
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:24 +0100
Message-Id: <20171106183925.16747-28-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 27/28] tpm-tis: use DEFINE_PROP_TPMBE
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index dccc56ab09..a00779f3aa 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -86,7 +86,6 @@ typedef struct TPMState {
=20
     TPMBackendCmd cmd;
=20
-    char *backend;
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
 } TPMState;
@@ -1049,7 +1048,7 @@ static const VMStateDescription vmstate_tpm_tis =3D=
 {
=20
 static Property tpm_tis_properties[] =3D {
     DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
-    DEFINE_PROP_STRING("tpmdev", TPMState, backend),
+    DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1062,17 +1061,10 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
         return;
     }
=20
-    s->be_driver =3D qemu_find_tpm_be(s->backend);
     if (!s->be_driver) {
-        error_setg(errp, "backend driver with id %s could not be found",
-                   s->backend);
+        error_setg(errp, "'tpmdev' property is required");
         return;
     }
-
-    if (tpm_backend_init(s->be_driver, TPM_IF(s), errp)) {
-        return;
-    }
-
     if (s->irq_num > 15) {
         error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
                    s->irq_num);
--=20
2.15.0.rc0.40.gaefcc5f6f
