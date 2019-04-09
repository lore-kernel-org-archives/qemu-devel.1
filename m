Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D7CC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 07:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D58120857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 07:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W36LiaHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D58120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDkux-0007jT-8U
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 03:11:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDksA-0005gU-Is
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDks9-0005AY-JG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33043 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDks9-00056A-4k; Tue, 09 Apr 2019 03:08:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44ddg74ZtVz9sRV; Tue,  9 Apr 2019 17:08:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554793715;
	bh=ODgRAHHJFpRl+9TKFtUBGOPcpEX4KOZLMDCB3XwB+Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W36LiaHewIPy+BsLnQ6y/MfV0bPX2m6yjo0UU88aRqxG09yHP+YRYOAl+okuH2UKj
	vKFCu1+cALc8an2wB5atFvTm7AC81itjABxVtMEUlmBM4J2UrXENGjm0DUIlsEydkQ
	iv7/aOlcmgCiN6s0btCqK1KuO2VuqkuC84P//HfI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  9 Apr 2019 17:08:30 +1000
Message-Id: <20190409070830.22430-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409070830.22430-1-david@gibson.dropbear.id.au>
References: <20190409070830.22430-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 2/2] spapr_pci: Fix extended config space
 accesses
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, mst@redhat.com, clg@redhat.com, qemu-devel@nongnu.org,
	groug@kaod.org, alex.williamson@redhat.com, spopovyc@redhat.com,
	qemu-ppc@nongnu.org, marcel@redhat.com,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409070830.GDMMZEQFb7fDBSk5G5bB0qQ50R7n4CZdSX6URd8sgNE@z>

From: Greg Kurz <groug@kaod.org>

The PAPR PHB acts as a legacy PCI bus but it allows PCIe extended
config space accesses anyway (for pseries-2.9 and newer machine
types).

Introduce a specific PCI bus subtype to inform the common PCI code
about that.

Fixes: c2077e2ca0da7
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155414130834.574858.16502276132110219890.stgit@bahia.lan>
[dwg: Apply fix so we don't rename the default pci bus, breaking everythi=
ng]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b63ed9d8da..f0b6b23afc 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1638,6 +1638,28 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
     memory_region_del_subregion(get_system_memory(), &sphb->mem32window)=
;
 }
=20
+static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
+{
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
+
+    return sphb->pcie_ecs;
+}
+
+static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data=
)
+{
+    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
+
+    pbc->allows_extended_config_space =3D spapr_phb_allows_extended_conf=
ig_space;
+}
+
+#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+
+static const TypeInfo spapr_phb_root_bus_info =3D {
+    .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
+    .parent =3D TYPE_PCI_BUS,
+    .class_init =3D spapr_phb_root_bus_class_init,
+};
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
@@ -1739,10 +1761,11 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
=20
-    bus =3D pci_register_root_bus(dev, NULL,
+    bus =3D pci_register_root_bus(dev, "pci.0",
                                 pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
                                 &sphb->memspace, &sphb->iospace,
-                                PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_=
BUS);
+                                PCI_DEVFN(0, 0), PCI_NUM_PINS,
+                                TYPE_SPAPR_PHB_ROOT_BUS);
     phb->bus =3D bus;
     qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
=20
@@ -2325,6 +2348,7 @@ void spapr_pci_rtas_init(void)
 static void spapr_pci_register_types(void)
 {
     type_register_static(&spapr_phb_info);
+    type_register_static(&spapr_phb_root_bus_info);
 }
=20
 type_init(spapr_pci_register_types)
--=20
2.20.1


