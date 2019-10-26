Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF6BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF69920663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/aedIQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQaY-0006KD-3O
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQQe-0002eH-JY
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQQd-00087i-7L
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQQd-00087R-31
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8A0zZyI5mOTDSkC5unD31tlwYoyzVjIrE1Z1/ZiyoRc=;
 b=Q/aedIQm1lqQVD5+CBBpv/FLL1wRX5u0GvdZcWtVYe4BbQjXHdV9N5Jhl8bez6wieSSyi7
 RmskFO1HHCup+8M/2em0RU+o9FXt+gNOrlmo+9Hlzz9paUwpFmGHbjl/33EPviekc38wgv
 GBEU/XKIQvKj/nHtsAJ9eLC83vQ367c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-_6dW5Q9nMMG2wCbMLACq5w-1; Sat, 26 Oct 2019 14:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDEED5E6;
 Sat, 26 Oct 2019 18:04:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CE2C60F8A;
 Sat, 26 Oct 2019 18:04:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/20] hw/pci-host/piix: Define and use the PIIX IRQ Route
 Control Registers
Date: Sat, 26 Oct 2019 20:01:38 +0200
Message-Id: <20191026180143.7369-16-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _6dW5Q9nMMG2wCbMLACq5w-1
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
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
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

The IRQ Route Control registers definitions belong to the PIIX
chipset. We were only defining the 'A' register. Define the other
B, C and D registers, and use them.

Acked-by: Paul Durrant <paul@xen.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/xen/xen-hvm.c         | 5 +++--
 hw/mips/gt64xxx_pci.c         | 4 ++--
 hw/pci-host/piix.c            | 9 ++++-----
 include/hw/southbridge/piix.h | 6 ++++++
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 95f23a263c..82ece6b9e7 100644
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
@@ -156,8 +157,8 @@ void xen_piix_pci_write_config_client(uint32_t address,=
 uint32_t val, int len)
             v =3D 0;
         }
         v &=3D 0xf;
-        if (((address + i) >=3D 0x60) && ((address + i) <=3D 0x63)) {
-            xen_set_pci_link_route(xen_domid, address + i - 0x60, v);
+        if (((address + i) >=3D PIIX_PIRQCA) && ((address + i) <=3D PIIX_P=
IRQCD)) {
+            xen_set_pci_link_route(xen_domid, address + i - PIIX_PIRQCA, v=
);
         }
     }
 }
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index c277398c0d..5cab9c1ee1 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1013,12 +1013,12 @@ static void gt64120_pci_set_irq(void *opaque, int i=
rq_num, int level)
=20
     /* now we change the pic irq level according to the piix irq mappings =
*/
     /* XXX: optimize */
-    pic_irq =3D piix4_dev->config[0x60 + irq_num];
+    pic_irq =3D piix4_dev->config[PIIX_PIRQCA + irq_num];
     if (pic_irq < 16) {
         /* The pic level is the logical OR of all the PCI irqs mapped to i=
t. */
         pic_level =3D 0;
         for (i =3D 0; i < 4; i++) {
-            if (pic_irq =3D=3D piix4_dev->config[0x60 + i]) {
+            if (pic_irq =3D=3D piix4_dev->config[PIIX_PIRQCA + i]) {
                 pic_level |=3D pci_irq_levels[i];
             }
         }
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 6548d9a4b5..390fb9ceba 100644
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
@@ -468,7 +467,7 @@ static void piix3_set_irq_level_internal(PIIX3State *pi=
ix3, int pirq, int level)
     int pic_irq;
     uint64_t mask;
=20
-    pic_irq =3D piix3->dev.config[PIIX_PIRQC + pirq];
+    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
     if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
         return;
     }
@@ -482,7 +481,7 @@ static void piix3_set_irq_level(PIIX3State *piix3, int =
pirq, int level)
 {
     int pic_irq;
=20
-    pic_irq =3D piix3->dev.config[PIIX_PIRQC + pirq];
+    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
     if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
         return;
     }
@@ -501,7 +500,7 @@ static void piix3_set_irq(void *opaque, int pirq, int l=
evel)
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
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index e49d4a6bbe..094508b928 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t s=
mb_io_base,
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
  * Reset Control Register: PCI-accessible ISA-Compatible Register at addre=
ss
  * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:7000)=
.
--=20
2.21.0


