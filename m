Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A57CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0FB20867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3K20mIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0FB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQdq-0002vC-1s
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQQj-0002l8-3r
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQQf-000890-Vy
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQQf-00088U-D2
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2dLm2Xz1fiqAxTYOSPP2mDkuhzEl+Dho4NsPEDSoi8=;
 b=e3K20mIpScMZpQQgImxzUR3u+/qIdt0q/HDNDd+5HrurKWTvo6+TB/PAkMEZsQxWN8NlHR
 vhbM3Z7GULSKomOObq4Q7+BGCW92jbwu7+PL17bQycwESl3dESXIsO16v75jyfab1by3os
 Wmg34FK4xGYQN9EIi/tvA5pmS0VFzqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-qWviySrFN8a-Vf41-bibzQ-1; Sat, 26 Oct 2019 14:04:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60CB0800D41;
 Sat, 26 Oct 2019 18:04:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AB6B60F82;
 Sat, 26 Oct 2019 18:04:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/20] hw/pci-host/piix: Move RCR_IOPORT register definition
Date: Sat, 26 Oct 2019 20:01:37 +0200
Message-Id: <20191026180143.7369-15-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qWviySrFN8a-Vf41-bibzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
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
v2: prepend PIIX prefix (Aleksandar)
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


