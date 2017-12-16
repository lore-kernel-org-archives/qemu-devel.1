Received: from eggs.gnu.org ([2001:4830:134:3::10]:45994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTq-00068V-Ax
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTm-0000BP-E4
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55532
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTm-0000B6-98
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfL8Z074862
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:29 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evx0cxtdj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:29 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:29 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:36 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-20-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 19/32] tpm: add TPM interface to lookup TPM
 version
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

Do not hardcode TPM device model to lookup version, use an interface
instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c     | 5 +++--
 include/sysemu/tpm.h | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fd1511b..4d13335 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -990,9 +990,9 @@ static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb=
)
 /*
  * Get the TPMVersion of the backend device being used
  */
-TPMVersion tpm_tis_get_tpm_version(Object *obj)
+static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
 {
-    TPMState *s =3D TPM(obj);
+    TPMState *s =3D TPM(ti);
=20
     if (tpm_backend_had_startup_error(s->be_driver)) {
         return TPM_VERSION_UNSPEC;
@@ -1102,6 +1102,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
     tc->model =3D TPM_MODEL_TPM_TIS;
+    tc->get_version =3D tpm_tis_get_tpm_version;
     tc->request_completed =3D tpm_tis_request_completed;
 }
=20
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 2fe0f1e..650b4b8 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -42,6 +42,7 @@ typedef struct TPMIfClass {
=20
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj);
+    enum TPMVersion (*get_version)(TPMIf *obj);
 } TPMIfClass;
=20
 #define TYPE_TPM_TIS                "tpm-tis"
@@ -54,15 +55,13 @@ static inline TPMIf *tpm_find(void)
     return TPM_IF(obj);
 }
=20
-TPMVersion tpm_tis_get_tpm_version(Object *obj);
-
 static inline TPMVersion tpm_get_version(TPMIf *ti)
 {
     if (!ti) {
         return TPM_VERSION_UNSPEC;
     }
=20
-    return tpm_tis_get_tpm_version(OBJECT(ti));
+    return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
=20
 #endif /* QEMU_TPM_H */
--=20
2.5.5
