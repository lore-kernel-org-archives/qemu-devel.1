Received: from eggs.gnu.org ([2001:4830:134:3::10]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTo-00066d-Iw
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTk-0000AK-Lo
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTk-00009S-E4
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:28 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdeIv052963
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:27 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2evxpte5kh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:27 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:26 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:35 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-19-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 18/32] tpm: lookup the the TPM interface
 instead of TIS device
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

This will allow to introduce new devices implementing TPM.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/i386/acpi-build.c |  2 +-
 include/sysemu/tpm.h | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 73519ab..cdb4aa9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -208,7 +208,7 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
     }
=20
     info->has_hpet =3D hpet_find();
-    info->tpm_version =3D tpm_get_version();
+    info->tpm_version =3D tpm_get_version(tpm_find());
     info->pvpanic_port =3D pvpanic_port();
     info->applesmc_io_base =3D applesmc_port();
 }
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 7b407ca..2fe0f1e 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -19,7 +19,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const cha=
r *optarg);
 int tpm_init(void);
 void tpm_cleanup(void);
=20
-typedef enum  TPMVersion {
+typedef enum TPMVersion {
     TPM_VERSION_UNSPEC =3D 0,
     TPM_VERSION_1_2 =3D 1,
     TPM_VERSION_2_0 =3D 2,
@@ -44,20 +44,25 @@ typedef struct TPMIfClass {
     void (*request_completed)(TPMIf *obj);
 } TPMIfClass;
=20
-TPMVersion tpm_tis_get_tpm_version(Object *obj);
-
 #define TYPE_TPM_TIS                "tpm-tis"
=20
-static inline TPMVersion tpm_get_version(void)
+/* returns NULL unless there is exactly one TPM device */
+static inline TPMIf *tpm_find(void)
 {
-#ifdef CONFIG_TPM
-    Object *obj =3D object_resolve_path_type("", TYPE_TPM_TIS, NULL);
+    Object *obj =3D object_resolve_path_type("", TYPE_TPM_IF, NULL);
+
+    return TPM_IF(obj);
+}
=20
-    if (obj) {
-        return tpm_tis_get_tpm_version(obj);
+TPMVersion tpm_tis_get_tpm_version(Object *obj);
+
+static inline TPMVersion tpm_get_version(TPMIf *ti)
+{
+    if (!ti) {
+        return TPM_VERSION_UNSPEC;
     }
-#endif
-    return TPM_VERSION_UNSPEC;
+
+    return tpm_tis_get_tpm_version(OBJECT(ti));
 }
=20
 #endif /* QEMU_TPM_H */
--=20
2.5.5
