Received: from eggs.gnu.org ([2001:4830:134:3::10]:46094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTz-0006I2-Vb
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTw-0000Hk-1D
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56172
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTv-0000HW-SD
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdUqE110110
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:39 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evwa8qt3y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:39 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:38 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:43 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-27-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 26/32] tpm-tis: use DEFINE_PROP_TPMBE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index db101b6..97cd7f5 100644
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
@@ -1053,7 +1052,7 @@ static const VMStateDescription vmstate_tpm_tis =3D=
 {
=20
 static Property tpm_tis_properties[] =3D {
     DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
-    DEFINE_PROP_STRING("tpmdev", TPMState, backend),
+    DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1066,17 +1065,10 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
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
2.5.5
