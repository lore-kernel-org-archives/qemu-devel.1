Received: from eggs.gnu.org ([2001:4830:134:3::10]:39927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKR-0007SA-Op
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKP-00056o-44
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKO-00055E-UO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:15 +0100
Message-Id: <20171106183925.16747-19-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/28] tpm: lookup the the TPM interface
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
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This will allow to introduce new devices implementing TPM.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm.h | 25 +++++++++++++++----------
 hw/i386/acpi-build.c |  2 +-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 7b407caf25..2fe0f1e120 100644
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
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 73519ab3ac..cdb4aa9835 100644
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
--=20
2.15.0.rc0.40.gaefcc5f6f
