Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A6CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C0320867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esoYuUUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C0320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQeT-0003Qj-6O
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQQM-00026p-F8
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQQK-0007zN-Sx
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQQK-0007yy-PD
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/Dx+PbxKqebN9kqK3yoqBeSkpzxICQMpRExQnwgy+Q=;
 b=esoYuUUuzl4aS6rhaNwso9hAqAtgmvEW0OUYglGImXZsG7jqORua197YVvHd20GEsyJD0S
 6pwz/qFd1odNTeamZUXyakcPK322ufDrksnffkkKSH/eILhAHQd7+AWzHG10TeGOXsvgX0
 FKcdFVeOWoBeV5FhJKV5864lotA5Itk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Tkh2DuxaOcK2hmL4G70YLw-1; Sat, 26 Oct 2019 14:04:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAEAB5E6;
 Sat, 26 Oct 2019 18:04:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E3DF60C80;
 Sat, 26 Oct 2019 18:04:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/20] hw/pci-host/piix: Extract piix3_create()
Date: Sat, 26 Oct 2019 20:01:36 +0200
Message-Id: <20191026180143.7369-14-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Tkh2DuxaOcK2hmL4G70YLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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

Extract the PIIX3 creation code from the i440fx_init() function.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/piix.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 2f4cbcbfe9..3292703de7 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -331,6 +331,36 @@ static void i440fx_realize(PCIDevice *dev, Error **err=
p)
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
+                                                  TYPE_PIIX3_XEN_DEVICE);
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
@@ -400,27 +430,8 @@ PCIBus *i440fx_init(const char *host_type, const char =
*pci_type,
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


