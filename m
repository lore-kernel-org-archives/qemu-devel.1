Received: from eggs.gnu.org ([2001:4830:134:3::10]:55503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0R-000761-KU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0Q-0005e3-Jz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1h0Q-0005dp-Bw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:18 +0200
Message-Id: <20171009225623.29232-38-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 37/42] tpm: lookup the the TPM interface
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
---
 hw/tpm/tpm_int.h     | 19 -------------------
 include/sysemu/tpm.h | 52 ++++++++++++++++++++++++++++++++++++++--------=
------
 hw/i386/acpi-build.c |  2 +-
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 90e97b9170..86fadc16d3 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -15,25 +15,6 @@
 #include "qemu/osdep.h"
 #include "qom/object.h"
=20
-#define TYPE_TPM_IF "tpm-if"
-#define TPM_IF_CLASS(klass) \
-    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
-#define TPM_IF_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
-#define TPM_IF(obj) \
-    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
-
-typedef struct TPMIf {
-    Object parent_obj;
-} TPMIf;
-
-typedef struct TPMIfClass {
-    InterfaceClass parent_class;
-
-    enum TpmModel model;
-    void (*request_completed)(TPMIf *obj);
-} TPMIfClass;
-
 #define TPM_STANDARD_CMDLINE_OPTS               \
     { \
         .name =3D "type", \
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 62b073beeb..dbd2b0cc7a 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,32 +12,56 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H
=20
-#include "qemu/option.h"
+#include "qom/object.h"
+#include "qapi-types.h"
=20
-int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
-int tpm_init(void);
-void tpm_cleanup(void);
-
-typedef enum  TPMVersion {
+typedef enum TPMVersion {
     TPM_VERSION_UNSPEC =3D 0,
     TPM_VERSION_1_2 =3D 1,
     TPM_VERSION_2_0 =3D 2,
 } TPMVersion;
=20
-TPMVersion tpm_tis_get_tpm_version(Object *obj);
+#define TYPE_TPM_IF "tpm-if"
+#define TPM_IF_CLASS(klass)                                 \
+    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
+#define TPM_IF_GET_CLASS(obj)                           \
+    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
+#define TPM_IF(obj)                             \
+    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
+
+typedef struct TPMIf {
+    Object parent_obj;
+} TPMIf;
+
+typedef struct TPMIfClass {
+    InterfaceClass parent_class;
+
+    enum TpmModel model;
+    void (*request_completed)(TPMIf *obj);
+} TPMIfClass;
+
+int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
+int tpm_init(void);
+void tpm_cleanup(void);
=20
 #define TYPE_TPM_TIS                "tpm-tis"
=20
-static inline TPMVersion tpm_get_version(void)
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
index 2af37a9129..40371b6f75 100644
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
2.14.1.146.gd35faa819
