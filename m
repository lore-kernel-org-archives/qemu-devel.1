Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C478C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477F6214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtI+jiEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477F6214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33463 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j18wO-0005zW-Dr
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j18us-00045t-PO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j18ur-0007MB-H8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:15:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j18ur-0007Lp-Dh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581340557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DravC8YXTkGc7LI6oW602bIznZkWbfHP2rsChoxtCaY=;
 b=BtI+jiEojTl0dTY6ovxbiIMBZb1NQzct5yX/80uYuGSqCM3V7usO2TRtXr3uDJlddd01hJ
 bmrTqx+RGAOsVOr/wAbKZuQLoS5M9PbP4s2nrA+6Ws2LOoQRXSGsPHBRCVihUWQAwyWN/h
 5oU4EhRSPKKaEa/GYnH+2QR+5zzJYDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-3RqJDGWEN_aFKsPGiGkIoA-1; Mon, 10 Feb 2020 08:15:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1446E13E4;
 Mon, 10 Feb 2020 13:15:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB48B26DF6;
 Mon, 10 Feb 2020 13:15:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [RFC 1/2] tpm: Let the TPM TIS device be usable on ARM
Date: Mon, 10 Feb 2020 14:15:22 +0100
Message-Id: <20200210131523.27540-2-eric.auger@redhat.com>
In-Reply-To: <20200210131523.27540-1-eric.auger@redhat.com>
References: <20200210131523.27540-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3RqJDGWEN_aFKsPGiGkIoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Implement support for TPM on aarch64 by using the
TPM TIS MMIO frontend. Instead of being an ISA device,
the TPM TIS device becomes a sysbus device on ARM. It is
bound to be dynamically instantiated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

I am aware such kind of #ifde'fy is frown upon but this is just
for starting the discussion
---
 hw/tpm/Kconfig   |  2 +-
 hw/tpm/tpm_tis.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 9e67d990e8..326c89e6df 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -4,7 +4,7 @@ config TPMDEV
=20
 config TPM_TIS
     bool
-    depends on TPM && ISA_BUS
+    depends on TPM
     select TPMDEV
=20
 config TPM_CRB
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 31facb896d..cfc840942f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -30,6 +30,7 @@
=20
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_ids.h"
+#include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
@@ -65,7 +66,11 @@ typedef struct TPMLocality {
 } TPMLocality;
=20
 typedef struct TPMState {
+#ifdef CONFIG_ISA_BUS
     ISADevice busdev;
+#else
+    SysBusDevice busdev;
+#endif
     MemoryRegion mmio;
=20
     unsigned char buffer[TPM_TIS_BUFFER_MAX];
@@ -967,6 +972,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Error *=
*errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+#ifdef CONFIG_ISA_BUS
     if (s->irq_num > 15) {
         error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
                    s->irq_num);
@@ -982,6 +988,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Error *=
*errp)
         tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
                      TPM_PPI_ADDR_BASE, OBJECT(s));
     }
+#endif
 }
=20
 static void tpm_tis_initfn(Object *obj)
@@ -991,6 +998,10 @@ static void tpm_tis_initfn(Object *obj)
     memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
                           TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT=
);
+#ifndef CONFIG_ISA_BUS
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+#endif
 }
=20
 static void tpm_tis_class_init(ObjectClass *klass, void *data)
@@ -1002,6 +1013,7 @@ static void tpm_tis_class_init(ObjectClass *klass, vo=
id *data)
     device_class_set_props(dc, tpm_tis_properties);
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
+    dc->user_creatable =3D true;
     tc->model =3D TPM_MODEL_TPM_TIS;
     tc->get_version =3D tpm_tis_get_tpm_version;
     tc->request_completed =3D tpm_tis_request_completed;
@@ -1009,7 +1021,11 @@ static void tpm_tis_class_init(ObjectClass *klass, v=
oid *data)
=20
 static const TypeInfo tpm_tis_info =3D {
     .name =3D TYPE_TPM_TIS,
+#ifdef CONFIG_ISA_BUS
     .parent =3D TYPE_ISA_DEVICE,
+#else
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+#endif
     .instance_size =3D sizeof(TPMState),
     .instance_init =3D tpm_tis_initfn,
     .class_init  =3D tpm_tis_class_init,
--=20
2.20.1


