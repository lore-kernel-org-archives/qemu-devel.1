Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CA9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B201D20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201D20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPwR-0003i5-El
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPkc-0004xx-MN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPkb-0007Ig-Aq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPkb-0007I7-1q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 139E73090FF4;
 Tue, 15 Oct 2019 16:32:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CBAB451D;
 Tue, 15 Oct 2019 16:32:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/32] hw/pci-host/piix: Define and use the PIIX IRQ Route
 Control Registers
Date: Tue, 15 Oct 2019 18:27:00 +0200
Message-Id: <20191015162705.28087-28-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 15 Oct 2019 16:32:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The IRQ Route Control registers definitions belong to the PIIX
chipset. We were only defining the 'A' register. Define the other
B, C and D registers, and use them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/xen/xen-hvm.c         | 5 +++--
 hw/mips/gt64xxx_pci.c         | 4 ++--
 hw/pci-host/piix.c            | 9 ++++-----
 include/hw/southbridge/piix.h | 6 ++++++
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 6b5e5bb7f5..4ce2fb9c89 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
+#include "hw/southbridge/piix.h"
 #include "hw/irq.h"
 #include "hw/hw.h"
 #include "hw/i386/apic-msidef.h"
@@ -156,8 +157,8 @@ void xen_piix_pci_write_config_client(uint32_t addres=
s, uint32_t val, int len)
             v =3D 0;
         }
         v &=3D 0xf;
-        if (((address + i) >=3D 0x60) && ((address + i) <=3D 0x63)) {
-            xen_set_pci_link_route(xen_domid, address + i - 0x60, v);
+        if (((address + i) >=3D PIIX_PIRQCA) && ((address + i) <=3D PIIX=
_PIRQCD)) {
+            xen_set_pci_link_route(xen_domid, address + i - PIIX_PIRQCA,=
 v);
         }
     }
 }
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index c277398c0d..5cab9c1ee1 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1013,12 +1013,12 @@ static void gt64120_pci_set_irq(void *opaque, int=
 irq_num, int level)
=20
     /* now we change the pic irq level according to the piix irq mapping=
s */
     /* XXX: optimize */
-    pic_irq =3D piix4_dev->config[0x60 + irq_num];
+    pic_irq =3D piix4_dev->config[PIIX_PIRQCA + irq_num];
     if (pic_irq < 16) {
         /* The pic level is the logical OR of all the PCI irqs mapped to=
 it. */
         pic_level =3D 0;
         for (i =3D 0; i < 4; i++) {
-            if (pic_irq =3D=3D piix4_dev->config[0x60 + i]) {
+            if (pic_irq =3D=3D piix4_dev->config[PIIX_PIRQCA + i]) {
                 pic_level |=3D pci_irq_levels[i];
             }
         }
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 3770575c1a..a450fc726e 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -61,7 +61,6 @@ typedef struct I440FXState {
 #define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
 #define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
 #define XEN_PIIX_NUM_PIRQS      128ULL
-#define PIIX_PIRQC              0x60
=20
 typedef struct PIIX3State {
     PCIDevice dev;
@@ -468,7 +467,7 @@ static void piix3_set_irq_level_internal(PIIX3State *=
piix3, int pirq, int level)
     int pic_irq;
     uint64_t mask;
=20
-    pic_irq =3D piix3->dev.config[PIIX_PIRQC + pirq];
+    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
     if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
         return;
     }
@@ -482,7 +481,7 @@ static void piix3_set_irq_level(PIIX3State *piix3, in=
t pirq, int level)
 {
     int pic_irq;
=20
-    pic_irq =3D piix3->dev.config[PIIX_PIRQC + pirq];
+    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
     if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
         return;
     }
@@ -501,7 +500,7 @@ static void piix3_set_irq(void *opaque, int pirq, int=
 level)
 static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
 {
     PIIX3State *piix3 =3D opaque;
-    int irq =3D piix3->dev.config[PIIX_PIRQC + pin];
+    int irq =3D piix3->dev.config[PIIX_PIRQCA + pin];
     PCIINTxRoute route;
=20
     if (irq < PIIX_NUM_PIC_IRQS) {
@@ -530,7 +529,7 @@ static void piix3_write_config(PCIDevice *dev,
                                uint32_t address, uint32_t val, int len)
 {
     pci_default_write_config(dev, address, val, len);
-    if (ranges_overlap(address, len, PIIX_PIRQC, 4)) {
+    if (ranges_overlap(address, len, PIIX_PIRQCA, 4)) {
         PIIX3State *piix3 =3D PIIX3_PCI_DEVICE(dev);
         int pic_irq;
=20
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.=
h
index 79ebe0089b..9c92c37a4d 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t=
 smb_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
                       int smm_enabled, DeviceState **piix4_pm);
=20
+/* PIRQRC[A:D]: PIRQx Route Control Registers */
+#define PIIX_PIRQCA 0x60
+#define PIIX_PIRQCB 0x61
+#define PIIX_PIRQCC 0x62
+#define PIIX_PIRQCD 0x63
+
 /*
  * Reset Control Register: PCI-accessible ISA-Compatible Register at add=
ress
  * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:700=
0).
--=20
2.21.0


