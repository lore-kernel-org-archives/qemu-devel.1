Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A93C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 05:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA00F20881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 05:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fxy8AIYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA00F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTgP1-0004ns-0n
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 01:36:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTgIM-00080J-Gj
	for qemu-devel@nongnu.org; Thu, 23 May 2019 01:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTgII-0005hN-NL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 01:29:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTgIF-0005em-EA; Thu, 23 May 2019 01:29:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458dNL3ZWLz9s6w; Thu, 23 May 2019 15:29:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558589362;
	bh=gs+yX4Rpc3mi9205nXqZ5YZPkPALH1nmnc7QtQ5Y84A=;
	h=From:To:Cc:Subject:Date:From;
	b=fxy8AIYOGyegWUqWWNpsPQ3AOOh1inQeTIlpQLQRXe0iAFYAfMhQOiFTgljOILKr/
	IFp2619X0l04Gy9kIFREYk/ORU1TiJMz0xj3LIzfM0tNOnTr/cN2u3Jtdeb8EPQfza
	4pVY32c/oEX4+us5pwW3IzZHLmcpuWXFVqpybwpU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org
Date: Thu, 23 May 2019 15:29:11 +1000
Message-Id: <20190523052918.1129-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 1/8] spapr: Clean up device node name
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org,
	mdroth@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
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
---
 hw/ppc/spapr_pci.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 97961b0128..b2db46ef1d 100644
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
-    gchar *nodename;
+    const gchar *basename;
+    char *nodename;
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


