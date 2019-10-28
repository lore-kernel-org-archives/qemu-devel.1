Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2164CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96EA20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whfsz/oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96EA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9Tu-0004Di-D3
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iP80L-0002eK-QO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iP80K-00080c-JP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iP80K-0007zB-Bw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFumcyoqfTm2frQnxsT/waaWD2sDmObom9MoH51AV2A=;
 b=Whfsz/oaFbd7Ijy4W4LYqDT6Pqaf0zNNP5otDveKTTuV+5O1b6kuSE7nw3eNVgzmT04cvW
 6Q3tyFGXJxg1Pmms2YDRKIF/P0sNBf15EtVWCt5iS1mIOZ2P00hIohRe2qwIUgHA7CjbT9
 znKQl1EsPz4G9/xGfIjstFYYqOBPHvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-ZZrVdd1COxqSotmg7v9C4Q-1; Mon, 28 Oct 2019 12:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 635158017CC;
 Mon, 28 Oct 2019 16:36:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-87.brq.redhat.com [10.40.204.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B1591C941;
 Mon, 28 Oct 2019 16:36:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] hw/pci-host/piix: Move RCR_IOPORT register definition
Date: Mon, 28 Oct 2019 17:34:41 +0100
Message-Id: <20191028163447.18541-15-philmd@redhat.com>
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZZrVdd1COxqSotmg7v9C4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The RCR_IOPORT register belongs to the PIIX chipset.
Move the definition to "piix.h", and prepend the PIIX prefix.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c          | 2 +-
 hw/isa/piix4.c                | 2 +-
 hw/pci-host/piix.c            | 7 ++++---
 include/hw/i386/pc.h          | 6 ------
 include/hw/southbridge/piix.h | 6 ++++++
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b1b050d8e2..266d9b534b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -209,7 +209,7 @@ static void acpi_get_pm_info(MachineState *machine, Acp=
iPmInfo *pm)
=20
     /* The above need not be conditional on machine type because the reset=
 port
      * happens to be the same on PIIX (pc) and ICH9 (q35). */
-    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D RCR_IOPORT);
+    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D PIIX_RCR_IOPORT);
=20
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL)=
;
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index f3e21ea76d..86678e6829 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -166,7 +166,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
                           "reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
-                                        RCR_IOPORT, &s->rcr_mem, 1);
+                                        PIIX_RCR_IOPORT, &s->rcr_mem, 1);
=20
     /* initialize i8259 pic */
     i8259_out_irq =3D qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 3292703de7..6548d9a4b5 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/southbridge/piix.h"
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
@@ -87,7 +88,7 @@ typedef struct PIIX3State {
     /* Reset Control Register contents */
     uint8_t rcr;
=20
-    /* IO memory region for Reset Control Register (RCR_IOPORT) */
+    /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
     MemoryRegion rcr_mem;
 } PIIX3State;
=20
@@ -695,8 +696,8 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
=20
     memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
                           "piix3-reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(dev), RCR_IOP=
ORT,
-                                        &d->rcr_mem, 1);
+    memory_region_add_subregion_overlap(pci_address_space_io(dev),
+                                        PIIX_RCR_IOPORT, &d->rcr_mem, 1);
=20
     qemu_register_reset(piix3_reset, d);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2fd40ceebe..d6ff95e047 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -240,12 +240,6 @@ typedef struct PCII440FXState PCII440FXState;
=20
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
=20
-/*
- * Reset Control Register: PCI-accessible ISA-Compatible Register at addre=
ss
- * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000)=
.
- */
-#define RCR_IOPORT 0xcf9
-
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state, int *piix_devfn,
                     ISABus **isa_bus, qemu_irq *pic,
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index add352456b..e49d4a6bbe 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t s=
mb_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
                       int smm_enabled, DeviceState **piix4_pm);
=20
+/*
+ * Reset Control Register: PCI-accessible ISA-Compatible Register at addre=
ss
+ * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000)=
.
+ */
+#define PIIX_RCR_IOPORT 0xcf9
+
 extern PCIDevice *piix4_dev;
=20
 DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
--=20
2.21.0


