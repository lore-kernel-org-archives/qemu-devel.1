Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265AC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7A920675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7A920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwTg-0006VE-Fv
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdw4z-0004HU-KP
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdw4r-0007SO-JB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hdw4d-00076e-9U; Thu, 20 Jun 2019 08:21:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E382A44BCD;
 Thu, 20 Jun 2019 12:21:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-106.brq.redhat.com [10.40.204.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 644FB5D9C6;
 Thu, 20 Jun 2019 12:21:42 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>
Date: Thu, 20 Jun 2019 14:21:30 +0200
Message-Id: <20190620122132.10075-2-philmd@redhat.com>
In-Reply-To: <20190620122132.10075-1-philmd@redhat.com>
References: <20190620122132.10075-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 20 Jun 2019 12:21:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 1/3] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Edk2Crypto object is used to hold configuration values specific
to EDK2.

The edk2_add_host_crypto_policy() function loads crypto policies
from the host, and register them as fw_cfg named file items.
So far only the 'https' policy is supported.

A usercase example is the 'HTTPS Boof' feature of OVMF [*].

Usage example:

- via the command line:

  $ qemu-system-x86_64 \
      --object edk2_crypto,id=3Dhttps,\
              ciphers=3D/etc/crypto-policies/back-ends/openssl.config,\
              cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin

- via QMP:

  {
    "execute": "object-add",
    "arguments": {
      "qom-type": "edk2_crypto",
      "id": "https",
      "props": {
        "ciphers": "/etc/crypto-policies/back-ends/openssl.config",
        "cacerts": "/etc/pki/ca-trust/extracted/edk2/cacerts.bin"
      }
    }
  }

(On Fedora these files are provided by the ca-certificates and
crypto-policies packages).

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3:
- inverted the if() logic
- '-object' -> '--object' in commit description (Eric)
- reworded the 'TODO: g_free' comment
v4:
- do not return pointer to alloc'd data (Markus)
- INTERFACE_CHECK -> OBJECT_CLASS_CHECK (Markus)
- path -> filename (Laszlo)
- dropped the 'TODO: g_free' comment (Markus)
v5:
- only allow 1 singleton using the UserCreatableClass::complete
  callback (Markus, Laszlo)
- object own fw_cfg 'file' content, no need for
  fw_cfg_add_file_from_host() (Laszlo)
- g_file_get_contents() called when object is instantiated
  and report error, the machine 'done' notifier do not have
  to manage errors (do not fail).
- add QMP example
-
- do not add docs/interop/firmware.json to MAINTAINERS
---
 MAINTAINERS                             |   2 +
 hw/Makefile.objs                        |   1 +
 hw/firmware/Makefile.objs               |   1 +
 hw/firmware/uefi_edk2_crypto_policies.c | 209 ++++++++++++++++++++++++
 include/hw/firmware/uefi_edk2.h         |  30 ++++
 5 files changed, 243 insertions(+)
 create mode 100644 hw/firmware/Makefile.objs
 create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
 create mode 100644 include/hw/firmware/uefi_edk2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d32c5c2313..28de489134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2262,6 +2262,8 @@ EDK2 Firmware
 M: Laszlo Ersek <lersek@redhat.com>
 M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
 S: Supported
+F: hw/firmware/uefi_edk2_crypto_policies.c
+F: include/hw/firmware/uefi_edk2.h
 F: pc-bios/descriptors/??-edk2-*.json
 F: pc-bios/edk2-*
 F: roms/Makefile.edk2
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d770926ba9..c13b6ee0dd 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -8,6 +8,7 @@ devices-dirs-$(CONFIG_SOFTMMU) +=3D char/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D cpu/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D display/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D dma/
+devices-dirs-$(CONFIG_SOFTMMU) +=3D firmware/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D gpio/
 devices-dirs-$(CONFIG_HYPERV) +=3D hyperv/
 devices-dirs-$(CONFIG_I2C) +=3D i2c/
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
index 0000000000..a0164272ea
--- /dev/null
+++ b/hw/firmware/uefi_edk2_crypto_policies.c
@@ -0,0 +1,209 @@
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
+     OBJECT_CHECK(Edk2Crypto, (obj), \
+                  TYPE_EDK2_CRYPTO)
+
+typedef struct FWCfgHostContent {
+    /*
+     * Path to the acceptable ciphersuites and the preferred order from
+     * the host-side crypto policy.
+     */
+    char *filename;
+    /*
+     * Add a new NAMED fw_cfg item as a raw "blob" of the given size. Th=
e data
+     * referenced by the starting pointer is only linked, NOT copied, in=
to the
+     * data structure of the fw_cfg device.
+     */
+    char *contents;
+
+    size_t contents_length;
+} FWCfgHostContent;
+
+typedef struct Edk2Crypto {
+    Object parent_obj;
+
+    /*
+     * Path to the acceptable ciphersuites and the preferred order from
+     * the host-side crypto policy.
+     */
+    FWCfgHostContent ciphers;
+    /* Path to the trusted CA certificates configured on the host side. =
*/
+    FWCfgHostContent cacerts;
+} Edk2Crypto;
+
+typedef struct Edk2CryptoClass {
+    ObjectClass parent_class;
+} Edk2CryptoClass;
+
+static Edk2Crypto *edk2_crypto_by_policy_id(const char *policy_id, Error=
 **errp)
+{
+    Object *obj;
+
+    obj =3D object_resolve_path_component(object_get_objects_root(), pol=
icy_id);
+    if (!obj) {
+        error_setg(errp, "Cannot find EDK2 crypto policy ID %s", policy_=
id);
+        return NULL;
+    }
+
+    if (!object_dynamic_cast(obj, TYPE_EDK2_CRYPTO)) {
+        error_setg(errp, "Object '%s' is not a EDK2 crypto subclass",
+                         policy_id);
+        return NULL;
+    }
+
+    return EDK2_CRYPTO(obj);
+}
+
+static void edk2_crypto_prop_set_ciphers(Object *obj, const char *value,
+                                         Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    g_free(s->ciphers.filename);
+    s->ciphers.filename =3D g_strdup(value);
+}
+
+static char *edk2_crypto_prop_get_ciphers(Object *obj,
+                                          Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    return g_strdup(s->ciphers.filename);
+}
+
+static void edk2_crypto_prop_set_cacerts(Object *obj, const char *value,
+                                         Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    g_free(s->cacerts.filename);
+    s->cacerts.filename =3D g_strdup(value);
+}
+
+static char *edk2_crypto_prop_get_cacerts(Object *obj,
+                                          Error **errp G_GNUC_UNUSED)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    return g_strdup(s->cacerts.filename);
+}
+
+static void edk2_crypto_complete(UserCreatable *uc, Error **errp)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(uc);
+    Error *local_err =3D NULL;
+    GError *gerr =3D NULL;
+
+    if (s->ciphers.filename) {
+        if (!g_file_get_contents(s->ciphers.filename, &s->ciphers.conten=
ts,
+                                 &s->ciphers.contents_length, &gerr)) {
+            goto report_error;
+        }
+    }
+    if (s->cacerts.filename) {
+        if (!g_file_get_contents(s->cacerts.filename, &s->cacerts.conten=
ts,
+                                 &s->cacerts.contents_length, &gerr)) {
+            goto report_error;
+        }
+    }
+    return;
+
+ report_error:
+    error_setg(&local_err, "%s", gerr->message);
+    g_error_free(gerr);
+    error_propagate_prepend(errp, local_err, "EDK2 crypto policy: ");
+}
+
+static void edk2_crypto_finalize(Object *obj)
+{
+    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
+
+    g_free(s->ciphers.filename);
+    g_free(s->ciphers.contents);
+    g_free(s->cacerts.filename);
+    g_free(s->cacerts.contents);
+}
+
+static void edk2_crypto_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
+
+    ucc->complete =3D edk2_crypto_complete;
+
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
+static void edk2_add_host_crypto_policy_https(FWCfgState *fw_cfg)
+{
+    Edk2Crypto *s;
+
+    s =3D edk2_crypto_by_policy_id("https", NULL);
+    if (!s) {
+        return;
+    }
+    if (s->ciphers.contents_length) {
+        fw_cfg_add_file(fw_cfg, "etc/edk2/https/ciphers",
+                        s->ciphers.contents, s->ciphers.contents_length)=
;
+    }
+    if (s->cacerts.contents_length) {
+        fw_cfg_add_file(fw_cfg, "etc/edk2/https/cacerts",
+                        s->cacerts.contents, s->cacerts.contents_length)=
;
+    }
+}
+
+void edk2_add_host_crypto_policy(FWCfgState *fw_cfg)
+{
+    edk2_add_host_crypto_policy_https(fw_cfg);
+}
diff --git a/include/hw/firmware/uefi_edk2.h b/include/hw/firmware/uefi_e=
dk2.h
new file mode 100644
index 0000000000..f8f81c5cb2
--- /dev/null
+++ b/include/hw/firmware/uefi_edk2.h
@@ -0,0 +1,30 @@
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
+ * @fw_cfg: fw_cfg device being modified
+ *
+ * Add a new named file containing the host crypto policy.
+ *
+ * This method is called by the machine_done() Notifier of
+ * some implementations of MachineState, currently the X86
+ * PCMachineState and the ARM VirtMachineState.
+ */
+void edk2_add_host_crypto_policy(FWCfgState *fw_cfg);
+
+#endif /* HW_FIRMWARE_UEFI_EDK2_H */
--=20
2.20.1


