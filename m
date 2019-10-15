Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CDC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F6A20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F6A20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQ1U-0000vb-9u
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPkC-0004jw-Ct
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPkA-00074L-JT
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPkA-00073L-1Q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BBA61DA2;
 Tue, 15 Oct 2019 16:32:16 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0250A19C58;
 Tue, 15 Oct 2019 16:31:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/32] hw/pci-host/piix: Extract piix3_create()
Date: Tue, 15 Oct 2019 18:26:58 +0200
Message-Id: <20191015162705.28087-26-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 15 Oct 2019 16:32:16 +0000 (UTC)
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

Extract the PIIX3 creation code from the i440fx_init() function.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/piix.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 2f4cbcbfe9..3292703de7 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -331,6 +331,36 @@ static void i440fx_realize(PCIDevice *dev, Error **e=
rrp)
     }
 }
=20
+static PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus)
+{
+    PIIX3State *piix3;
+    PCIDevice *pci_dev;
+
+    /*
+     * Xen supports additional interrupt routes from the PCI devices to
+     * the IOAPIC: the four pins of each PCI device on the bus are also
+     * connected to the IOAPIC directly.
+     * These additional routes can be discovered through ACPI.
+     */
+    if (xen_enabled()) {
+        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
+                                                  TYPE_PIIX3_XEN_DEVICE)=
;
+        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
+        pci_bus_irqs(pci_bus, xen_piix3_set_irq, xen_pci_slot_get_pirq,
+                     piix3, XEN_PIIX_NUM_PIRQS);
+    } else {
+        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
+                                                  TYPE_PIIX3_DEVICE);
+        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
+        pci_bus_irqs(pci_bus, piix3_set_irq, pci_slot_get_pirq,
+                     piix3, PIIX_NUM_PIRQS);
+        pci_bus_set_route_irq_fn(pci_bus, piix3_route_intx_pin_to_irq);
+    }
+    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+
+    return piix3;
+}
+
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state,
                     int *piix3_devfn,
@@ -400,27 +430,8 @@ PCIBus *i440fx_init(const char *host_type, const cha=
r *pci_type,
                  PAM_EXPAN_SIZE);
     }
=20
-    /* Xen supports additional interrupt routes from the PCI devices to
-     * the IOAPIC: the four pins of each PCI device on the bus are also
-     * connected to the IOAPIC directly.
-     * These additional routes can be discovered through ACPI. */
-    if (xen_enabled()) {
-        PCIDevice *pci_dev =3D pci_create_simple_multifunction(b,
-                             -1, true, TYPE_PIIX3_XEN_DEVICE);
-        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
-                piix3, XEN_PIIX_NUM_PIRQS);
-    } else {
-        PCIDevice *pci_dev =3D pci_create_simple_multifunction(b,
-                             -1, true, TYPE_PIIX3_DEVICE);
-        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
-                PIIX_NUM_PIRQS);
-        pci_bus_set_route_irq_fn(b, piix3_route_intx_pin_to_irq);
-    }
+    piix3 =3D piix3_create(b, isa_bus);
     piix3->pic =3D pic;
-    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
-
     *piix3_devfn =3D piix3->dev.devfn;
=20
     ram_size =3D ram_size / 8 / 1024 / 1024;
--=20
2.21.0


