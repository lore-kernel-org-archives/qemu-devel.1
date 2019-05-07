Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EAC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FA9206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m3/sihIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA9206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtdC-00078Q-O2
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:31:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVq-0000sN-Rr
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVn-0002jj-6t
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:36 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVl-0002eZ-8g; Tue, 07 May 2019 02:23:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL32fl6z9sNl; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210203;
	bh=iXRbtKnEi4KD2zFvx3pS7UHijBpaA9oyb90cQ+3y1pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3/sihIBbaqHFWeWZ+MugZfGraomuInVe9zfcctpWQwU9yqZQAc0yT675pef+XOiJ
	NOlwmgh8mf5gJPLCL+jKZakPeKAieUS+RuChPRI0vhWhfPDULocclrslQJKz7CqPJ8
	xOTTm9DCjywM2kZnPGuGZdIs3FqZNiH/ulR7QGBI=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Tue,  7 May 2019 16:23:15 +1000
Message-Id: <20190507062316.20916-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507062316.20916-1-david@gibson.dropbear.id.au>
References: <20190507062316.20916-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v3 4/5] pci: Make is_bridge a bool
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The is_bridge field in PCIDevice acts as a bool, but is declared as an in=
t.
Declare it as a bool for clarity, and change everything that writes it to
use true/false instead of 0/1 to match.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-bridge/dec.c                | 4 ++--
 hw/pci-bridge/i82801b11.c          | 2 +-
 hw/pci-bridge/pci_bridge_dev.c     | 2 +-
 hw/pci-bridge/pcie_pci_bridge.c    | 2 +-
 hw/pci-bridge/pcie_root_port.c     | 2 +-
 hw/pci-bridge/simba.c              | 2 +-
 hw/pci-bridge/xio3130_downstream.c | 2 +-
 hw/pci-bridge/xio3130_upstream.c   | 2 +-
 include/hw/pci/pci.h               | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 8484bfd434..ca40253730 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -68,7 +68,7 @@ static void dec_21154_pci_bridge_class_init(ObjectClass=
 *klass, void *data)
     k->vendor_id =3D PCI_VENDOR_ID_DEC;
     k->device_id =3D PCI_DEVICE_ID_DEC_21154;
     k->config_write =3D pci_bridge_write_config;
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     dc->desc =3D "DEC 21154 PCI-PCI bridge";
     dc->reset =3D pci_bridge_reset;
     dc->vmsd =3D &vmstate_pci_device;
@@ -129,7 +129,7 @@ static void dec_21154_pci_host_class_init(ObjectClass=
 *klass, void *data)
     k->device_id =3D PCI_DEVICE_ID_DEC_21154;
     k->revision =3D 0x02;
     k->class_id =3D PCI_CLASS_BRIDGE_PCI;
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     /*
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 10e590e5c6..6d8b0f54a7 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -90,7 +90,7 @@ static void i82801b11_bridge_class_init(ObjectClass *kl=
ass, void *data)
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     k->vendor_id =3D PCI_VENDOR_ID_INTEL;
     k->device_id =3D PCI_DEVICE_ID_INTEL_82801BA_11;
     k->revision =3D ICH9_D2P_A2_REVISION;
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
index ff6b8323da..c56ed1f52f 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -253,7 +253,7 @@ static void pci_bridge_dev_class_init(ObjectClass *kl=
ass, void *data)
     k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
     k->device_id =3D PCI_DEVICE_ID_REDHAT_BRIDGE;
     k->class_id =3D PCI_CLASS_BRIDGE_PCI;
-    k->is_bridge =3D 1,
+    k->is_bridge =3D true;
     dc->desc =3D "Standard PCI Bridge";
     dc->reset =3D qdev_pci_bridge_dev_reset;
     dc->props =3D pci_bridge_dev_properties;
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bri=
dge.c
index d491b40d04..9a4fba413a 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -143,7 +143,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *k=
lass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
=20
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
     k->device_id =3D PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
     k->realize =3D pcie_pci_bridge_realize;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
index e94d918b6d..be3f4d5e03 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -162,7 +162,7 @@ static void rp_class_init(ObjectClass *klass, void *d=
ata)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     k->config_write =3D rp_write_config;
     k->realize =3D rp_realize;
     k->exit =3D rp_exit;
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index dea4c8c5e7..7cf0d6e047 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -76,7 +76,7 @@ static void simba_pci_bridge_class_init(ObjectClass *kl=
ass, void *data)
     k->device_id =3D PCI_DEVICE_ID_SUN_SIMBA;
     k->revision =3D 0x11;
     k->config_write =3D pci_bridge_write_config;
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset =3D pci_bridge_reset;
     dc->vmsd =3D &vmstate_pci_device;
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
index 467bbabe4c..ab2a51e15d 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -152,7 +152,7 @@ static void xio3130_downstream_class_init(ObjectClass=
 *klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     k->config_write =3D xio3130_downstream_write_config;
     k->realize =3D xio3130_downstream_realize;
     k->exit =3D xio3130_downstream_exitfn;
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_ups=
tream.c
index b524908cf1..1d41a49ab0 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -126,7 +126,7 @@ static void xio3130_upstream_class_init(ObjectClass *=
klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
-    k->is_bridge =3D 1;
+    k->is_bridge =3D true;
     k->config_write =3D xio3130_upstream_write_config;
     k->realize =3D xio3130_upstream_realize;
     k->exit =3D xio3130_upstream_exitfn;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index da20c915ef..d082707dfa 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -234,7 +234,7 @@ typedef struct PCIDeviceClass {
      * This doesn't mean pci host switch.
      * When card bus bridge is supported, this would be enhanced.
      */
-    int is_bridge;
+    bool is_bridge;
=20
     /* rom bar */
     const char *romfile;
--=20
2.21.0


