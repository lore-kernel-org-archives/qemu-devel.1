Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E1C28CC2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0D026050
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l0fvJd+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0D026050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWDnz-0007lm-Jl
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 01:40:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDm0-0006Xu-TB
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDlz-00048u-Db
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:44 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWDly-00045I-Nd; Thu, 30 May 2019 01:38:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DxFk6Y8gz9s00; Thu, 30 May 2019 15:38:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559194714;
	bh=w/YEBfbeW/wU9g+yVcIls2ll9TuKhF9juZrK/MSyc1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0fvJd+r98167XZaygMvF5ctUsfrwVp3mKerReBuopZW8Pe4ushX9xPPZ9PZ/8C3q
	2FcxqHbaZjF03odRISSrgBNUFJtPfMT6pnO+Wt+VAvp0FKhfaRvnweMJqu2yy563d1
	woIDhOzHo45el3olc4fjEPCAR1E+bDtLBD02xYsY=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Thu, 30 May 2019 15:38:24 +1000
Message-Id: <20190530053831.22115-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530053831.22115-1-david@gibson.dropbear.id.au>
References: <20190530053831.22115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v2 1/8] spapr: Clean up device node name
 generation for PCI devices
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
Cc: mdroth@linux.ibm.com, mst@redhat.com, groug@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_populate_pci_child_dt() adds a 'name' property to the device tree
node for PCI devices.  This is never necessary for a flattened device tre=
e,
it is implicit in the name added when the node is constructed.  In fact
anything we do add to a 'name' property will be overwritten with somethin=
g
derived from the structural name in the guest firmware (but in fact it is
exactly the same bytes).

So, remove that.  In addition, pci_get_node_name() is very simple, so fol=
d
it into its (also simple) sole caller spapr_create_pci_child_dt().

While we're there rename pci_find_device_name() to the shorter and more
accurate dt_name_from_class().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 97961b0128..3f86cf8620 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1173,8 +1173,8 @@ static const PCIClass pci_classes[] =3D {
     { "data-processing-controller", spc_subclass },
 };
=20
-static const char *pci_find_device_name(uint8_t class, uint8_t subclass,
-                                        uint8_t iface)
+static const char *dt_name_from_class(uint8_t class, uint8_t subclass,
+                                      uint8_t iface)
 {
     const PCIClass *pclass;
     const PCISubClass *psubclass;
@@ -1216,23 +1216,6 @@ static const char *pci_find_device_name(uint8_t cl=
ass, uint8_t subclass,
     return name;
 }
=20
-static gchar *pci_get_node_name(PCIDevice *dev)
-{
-    int slot =3D PCI_SLOT(dev->devfn);
-    int func =3D PCI_FUNC(dev->devfn);
-    uint32_t ccode =3D pci_default_read_config(dev, PCI_CLASS_PROG, 3);
-    const char *name;
-
-    name =3D pci_find_device_name((ccode >> 16) & 0xff, (ccode >> 8) & 0=
xff,
-                                ccode & 0xff);
-
-    if (func !=3D 0) {
-        return g_strdup_printf("%s@%x,%x", name, slot, func);
-    } else {
-        return g_strdup_printf("%s@%x", name, slot);
-    }
-}
-
 static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
                                             PCIDevice *pdev);
=20
@@ -1300,11 +1283,6 @@ static void spapr_populate_pci_child_dt(PCIDevice =
*dev, void *fdt, int offset,
         _FDT(fdt_setprop(fdt, offset, "udf-supported", NULL, 0));
     }
=20
-    _FDT(fdt_setprop_string(fdt, offset, "name",
-                            pci_find_device_name((ccode >> 16) & 0xff,
-                                                 (ccode >> 8) & 0xff,
-                                                 ccode & 0xff)));
-
     buf =3D spapr_phb_get_loc_code(sphb, dev);
     _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
     g_free(buf);
@@ -1348,10 +1326,23 @@ static int spapr_create_pci_child_dt(SpaprPhbStat=
e *phb, PCIDevice *dev,
                                      void *fdt, int node_offset)
 {
     int offset;
+    const gchar *basename;
     gchar *nodename;
+    int slot =3D PCI_SLOT(dev->devfn);
+    int func =3D PCI_FUNC(dev->devfn);
+    uint32_t ccode =3D pci_default_read_config(dev, PCI_CLASS_PROG, 3);
+
+    basename =3D dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) &=
 0xff,
+                                  ccode & 0xff);
+
+    if (func !=3D 0) {
+        nodename =3D g_strdup_printf("%s@%x,%x", basename, slot, func);
+    } else {
+        nodename =3D g_strdup_printf("%s@%x", basename, slot);
+    }
=20
-    nodename =3D pci_get_node_name(dev);
     _FDT(offset =3D fdt_add_subnode(fdt, node_offset, nodename));
+
     g_free(nodename);
=20
     spapr_populate_pci_child_dt(dev, fdt, offset, phb);
--=20
2.21.0


