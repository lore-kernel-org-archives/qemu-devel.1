Received: from eggs.gnu.org ([209.51.188.92]:59288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24QV-0004eu-Ap
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24QR-0003bG-40
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:55 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:20 +0100
Message-Id: <20190308013222.12524-17-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/18] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

The Edk2Crypto object is used to hold configuration values specific
to EDK2.

The edk2_add_host_crypto_policy() function loads crypto policies
from the host, and register them as fw_cfg named file items.
So far only the 'https' policy is supported.

An usercase example is the 'HTTPS Boof' feature of OVMF [*].

Usage example:

  $ qemu-system-x86_64 \
      -object edk2_crypto,id=3Dhttps,\
              ciphers=3D/etc/crypto-policies/back-ends/openssl.config,\
              cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin

(On Fedora these files are provided by the ca-certificates and
crypto-policies packages).

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                             |   8 ++
 hw/Makefile.objs                        |   1 +
 hw/firmware/Makefile.objs               |   1 +
 hw/firmware/uefi_edk2_crypto_policies.c | 166 ++++++++++++++++++++++++
 include/hw/firmware/uefi_edk2.h         |  28 ++++
 5 files changed, 204 insertions(+)
 create mode 100644 hw/firmware/Makefile.objs
 create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
 create mode 100644 include/hw/firmware/uefi_edk2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 306fc2aefa..3696b63249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2205,6 +2205,14 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
=20
+EDK2 Firmware
+M: Laszlo Ersek <lersek@redhat.com>
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+S: Maintained
+F: docs/interop/firmware.json
+F: hw/firmware/uefi_edk2_crypto_policies.c
+F: include/hw/firmware/uefi_edk2.h
+
 Usermode Emulation
 ------------------
 Overall
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e2fcd6aafc..da4fb91285 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -8,6 +8,7 @@ devices-dirs-$(CONFIG_SOFTMMU) +=3D char/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D cpu/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D display/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D dma/
+devices-dirs-$(CONFIG_SOFTMMU) +=3D firmware/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D gpio/
 devices-dirs-$(CONFIG_HYPERV) +=3D hyperv/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D i2c/
diff --git a/hw/firmware/Makefile.objs b/hw/firmware/Makefile.objs
new file mode 100644
index 0000000000..ea1f6d44df
--- /dev/null
+++ b/hw/firmware/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y +=3D uefi_edk2_crypto_policies.o
diff --git a/hw/firmware/uefi_edk2_crypto_policies.c b/hw/firmware/uefi_e=
dk2_crypto_policies.c
new file mode 100644
index 0000000000..660c7f3655
--- /dev/null
+++ b/hw/firmware/uefi_edk2_crypto_policies.c
@@ -0,0 +1,166 @@
+/*
+ * UEFI EDK2 Support
+ *
+ * Copyright (c) 2019 Red Hat Inc.
+ *
+ * Author:
+ *  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "hw/firmware/uefi_edk2.h"
+
+
+#define TYPE_EDK2_CRYPTO "edk2_crypto"
+
+#define EDK2_CRYPTO_CLASS(klass) \
+     OBJECT_CLASS_CHECK(Edk2CryptoClass, (klass), \
+                        TYPE_EDK2_CRYPTO)
+#define EDK2_CRYPTO_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(Edk2CryptoClass, (obj), \
+                      TYPE_EDK2_CRYPTO)
+#define EDK2_CRYPTO(obj) \
+     INTERFACE_CHECK(Edk2Crypto, (obj), \
+                     TYPE_EDK2_CRYPTO)
+
+typedef struct Edk2Crypto {
+    Object parent_obj;
+
+    /*
+     * Path to the acceptable ciphersuites and the preferred order from
+     * the host-side crypto policy.
+     */
+    char *ciphers_path;
+
+    /* Path to the trusted CA certificates configured on the host side. =
*/
+    char *cacerts_path;
+} Edk2Crypto;
+
+typedef struct Edk2CryptoClass {
+    ObjectClass parent_class;
+} Edk2CryptoClass;
+
+
+static void edk2_crypto_prop_set_ciphers(Object *obj, const char *value,
+                                         Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    g_free(s->ciphers_path);
+    s->ciphers_path =3D g_strdup(value);
+}
+
+static char *edk2_crypto_prop_get_ciphers(Object *obj,
+                                          Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    return g_strdup(s->ciphers_path);
+}
+
+static void edk2_crypto_prop_set_cacerts(Object *obj, const char *value,
+                                         Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    g_free(s->cacerts_path);
+    s->cacerts_path =3D g_strdup(value);
+}
+
+static char *edk2_crypto_prop_get_cacerts(Object *obj,
+                                          Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    return g_strdup(s->cacerts_path);
+}
+
+static void edk2_crypto_finalize(Object *obj)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    g_free(s->ciphers_path);
+    g_free(s->cacerts_path);
+}
+
+static void edk2_crypto_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "ciphers",
+                                  edk2_crypto_prop_get_ciphers,
+                                  edk2_crypto_prop_set_ciphers,
+                                  NULL);
+    object_class_property_add_str(oc, "cacerts",
+                                  edk2_crypto_prop_get_cacerts,
+                                  edk2_crypto_prop_set_cacerts,
+                                  NULL);
+}
+
+static const TypeInfo edk2_crypto_info =3D {
+    .parent =3D TYPE_OBJECT,
+    .name =3D TYPE_EDK2_CRYPTO,
+    .instance_size =3D sizeof(Edk2Crypto),
+    .instance_finalize =3D edk2_crypto_finalize,
+    .class_size =3D sizeof(Edk2CryptoClass),
+    .class_init =3D edk2_crypto_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void edk2_crypto_register_types(void)
+{
+    type_register_static(&edk2_crypto_info);
+}
+
+type_init(edk2_crypto_register_types);
+
+static Edk2Crypto *edk2_crypto_by_id(const char *edk_crypto_id, Error **=
errp)
+{
+    Object *obj;
+    Object *container;
+
+    container =3D object_get_objects_root();
+    obj =3D object_resolve_path_component(container,
+                                        edk_crypto_id);
+    if (!obj) {
+        error_setg(errp, "Cannot find EDK2 crypto object ID %s",
+                   edk_crypto_id);
+        return NULL;
+    }
+
+    if (!object_dynamic_cast(obj, TYPE_EDK2_CRYPTO)) {
+        error_setg(errp, "Object '%s' is not a EDK2 crypto subclass",
+                   edk_crypto_id);
+        return NULL;
+    }
+
+    return EDK2_CRYPTO(obj);
+}
+
+void edk2_add_host_crypto_policy(FWCfgState *fw_cfg)
+{
+    Edk2Crypto *s;
+
+    s =3D edk2_crypto_by_id("https", NULL);
+    if (!s) {
+        return;
+    }
+
+    if (s->ciphers_path) {
+        /* TODO g_free the returned pointer */
+        fw_cfg_add_file_from_host(fw_cfg, "etc/edk2/https/ciphers",
+                                  s->ciphers_path, NULL);
+    }
+
+    if (s->cacerts_path) {
+        /* TODO g_free the returned pointer */
+        fw_cfg_add_file_from_host(fw_cfg, "etc/edk2/https/cacerts",
+                                  s->cacerts_path, NULL);
+    }
+}
diff --git a/include/hw/firmware/uefi_edk2.h b/include/hw/firmware/uefi_e=
dk2.h
new file mode 100644
index 0000000000..e0b2fb160a
--- /dev/null
+++ b/include/hw/firmware/uefi_edk2.h
@@ -0,0 +1,28 @@
+/*
+ * UEFI EDK2 Support
+ *
+ * Copyright (c) 2019 Red Hat Inc.
+ *
+ * Author:
+ *  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_FIRMWARE_UEFI_EDK2_H
+#define HW_FIRMWARE_UEFI_EDK2_H
+
+#include "hw/nvram/fw_cfg.h"
+
+/**
+ * edk2_add_host_crypto_policy:
+ * @s: fw_cfg device being modified
+ *
+ * Add a new named file containing the host crypto policy.
+ *
+ * Currently only the 'https' policy is supported.
+ */
+void edk2_add_host_crypto_policy(FWCfgState *s);
+
+#endif /* HW_FIRMWARE_UEFI_EDK2_H */
--=20
2.20.1
