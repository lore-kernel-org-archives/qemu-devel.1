Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34040C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0333207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U13dcBQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0333207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9u2W-0005S0-4Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j9tjg-0005Pv-Uk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j9tje-0007Zy-BV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:52:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j9tje-0007ZV-7T
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583427153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbPItgInqIgq6iyTU6lnIVSzytizlIijG5Rj4N/mq5s=;
 b=U13dcBQsiWKyCy3X7OE2sUi8ExhS02AYEkh0azYuTCcppNdnMruEnJQYG41ZT9YVxe4yMu
 q8A5WUwrsJN0qD/u1oVhTwXb3hu1l6ojSPKGwO1a4LoZU6/NLfLEGGFNGZOttoxE6G9HDE
 7TO/ySIBYv9kc2DQ5ljihMNcdJS+GtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-mwYItfwkOOKAY-XhgmFe5Q-1; Thu, 05 Mar 2020 11:52:32 -0500
X-MC-Unique: mwYItfwkOOKAY-XhgmFe5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF05DB21;
 Thu,  5 Mar 2020 16:52:31 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D694C271BA;
 Thu,  5 Mar 2020 16:52:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v5 05/10] tpm: Add the SysBus TPM TIS device
Date: Thu,  5 Mar 2020 17:51:44 +0100
Message-Id: <20200305165149.618-6-eric.auger@redhat.com>
In-Reply-To: <20200305165149.618-1-eric.auger@redhat.com>
References: <20200305165149.618-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce the tpm-tis-device which is a sysbus device
and is bound to be used on ARM.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/sysemu/tpm.h    |   1 +
 hw/tpm/tpm_tis_sysbus.c | 159 ++++++++++++++++++++++++++++++++++++++++
 hw/tpm/Kconfig          |   5 ++
 hw/tpm/Makefile.objs    |   1 +
 4 files changed, 166 insertions(+)
 create mode 100644 hw/tpm/tpm_tis_sysbus.c

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 1691b92c28..f37851b1aa 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -44,6 +44,7 @@ typedef struct TPMIfClass {
 } TPMIfClass;
=20
 #define TYPE_TPM_TIS_ISA            "tpm-tis"
+#define TYPE_TPM_TIS_SYSBUS         "tpm-tis-device"
 #define TYPE_TPM_CRB                "tpm-crb"
 #define TYPE_TPM_SPAPR              "tpm-spapr"
=20
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
new file mode 100644
index 0000000000..18c02aed67
--- /dev/null
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -0,0 +1,159 @@
+/*
+ * tpm_tis_sysbus.c - QEMU's TPM TIS SYSBUS Device
+ *
+ * Copyright (C) 2006,2010-2013 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger <stefanb@us.ibm.com>
+ *  David Safford <safford@us.ibm.com>
+ *
+ * Xen 4 support: Andrease Niederl <andreas.niederl@iaik.tugraz.at>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ * Implementation of the TIS interface according to specs found at
+ * http://www.trustedcomputinggroup.org. This implementation currently
+ * supports version 1.3, 21 March 2013
+ * In the developers menu choose the PC Client section then find the TIS
+ * specification.
+ *
+ * TPM TIS for TPM 2 implementation following TCG PC Client Platform
+ * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "tpm_util.h"
+#include "hw/sysbus.h"
+#include "tpm_tis.h"
+
+typedef struct TPMStateSysBus {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    TPMState state; /* not a QOM object */
+} TPMStateSysBus;
+
+#define TPM_TIS_SYSBUS(obj) OBJECT_CHECK(TPMStateSysBus, (obj), TYPE_TPM_T=
IS_SYSBUS)
+
+static int tpm_tis_pre_save_sysbus(void *opaque)
+{
+    TPMStateSysBus *sbdev =3D opaque;
+
+    return tpm_tis_pre_save(&sbdev->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_sysbus =3D {
+    .name =3D "tpm-tis",
+    .version_id =3D 0,
+    .pre_save  =3D tpm_tis_pre_save_sysbus,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BUFFER(state.buffer, TPMStateSysBus),
+        VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
+        VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
+        VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
+        VMSTATE_UINT8(state.next_locty, TPMStateSysBus),
+
+        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateSysBus, TPM_TIS_NUM_LOCALI=
TIES,
+                             0, vmstate_locty, TPMLocality),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void tpm_tis_sysbus_request_completed(TPMIf *ti, int ret)
+{
+    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(ti);
+    TPMState *s =3D &sbdev->state;
+
+    tpm_tis_request_completed(s, ret);
+}
+
+static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
+{
+    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(ti);
+    TPMState *s =3D &sbdev->state;
+
+    return tpm_tis_get_tpm_version(s);
+}
+
+static void tpm_tis_sysbus_reset(DeviceState *dev)
+{
+    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(dev);
+    TPMState *s =3D &sbdev->state;
+
+    return tpm_tis_reset(s);
+}
+
+static Property tpm_tis_sysbus_properties[] =3D {
+    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
+    DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tpm_tis_sysbus_initfn(Object *obj)
+{
+    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
+    TPMState *s =3D &sbdev->state;
+
+    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
+                          s, "tpm-tis-mmio",
+                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT=
);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
+{
+    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(dev);
+    TPMState *s =3D &sbdev->state;
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+
+    if (!s->be_driver) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+}
+
+static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
+
+    device_class_set_props(dc, tpm_tis_sysbus_properties);
+    dc->vmsd  =3D &vmstate_tpm_tis_sysbus;
+    tc->model =3D TPM_MODEL_TPM_TIS;
+    dc->realize =3D tpm_tis_sysbus_realizefn;
+    dc->user_creatable =3D true;
+    dc->reset =3D tpm_tis_sysbus_reset;
+    tc->request_completed =3D tpm_tis_sysbus_request_completed;
+    tc->get_version =3D tpm_tis_sysbus_get_tpm_version;
+}
+
+static const TypeInfo tpm_tis_sysbus_info =3D {
+    .name =3D TYPE_TPM_TIS_SYSBUS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(TPMStateSysBus),
+    .instance_init =3D tpm_tis_sysbus_initfn,
+    .class_init  =3D tpm_tis_sysbus_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { }
+    }
+};
+
+static void tpm_tis_sysbus_register(void)
+{
+    type_register_static(&tpm_tis_sysbus_info);
+}
+
+type_init(tpm_tis_sysbus_register)
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 686f8206bb..4794e7fe28 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -7,6 +7,11 @@ config TPM_TIS_ISA
     depends on TPM && ISA_BUS
     select TPM_TIS
=20
+config TPM_TIS_SYSBUS
+    bool
+    depends on TPM
+    select TPM_TIS
+
 config TPM_TIS
     bool
     depends on TPM
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 3ef2036cca..f1ec4beb95 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,6 +1,7 @@
 common-obj-$(CONFIG_TPM) +=3D tpm_util.o
 obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS_ISA) +=3D tpm_tis_isa.o
+common-obj-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm_tis_sysbus.o
 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis_common.o
 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
--=20
2.20.1


