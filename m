Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C9C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 05:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D8921019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 05:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ip2G9e4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D8921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTgQC-0005OK-9R
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 01:37:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTgIK-00080I-QL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 01:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTgII-0005hk-U8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 01:29:36 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47945 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTgIH-0005eu-3G; Thu, 23 May 2019 01:29:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458dNL5hBBz9s3l; Thu, 23 May 2019 15:29:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558589362;
	bh=6fqGLI8ZRatU3Q/dmXpXtP9f7RvLplVbARfRl18Pp9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ip2G9e4ocpSWn57EaavBZnU1sHRK5yhhmpPhbPwLSVbOM+TlJ/pMBwHIegCR1K++m
	0Ad0oNeJzJk2JkLOTHEI2Y+sP9fULcJLWg4OuVrxaFaCOdlOdyyQhv50xKjMXzbJPt
	+RsvaQPONbtyAgyrt8WvOnYcEJDJYnzdEezuO85c=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org
Date: Thu, 23 May 2019 15:29:12 +1000
Message-Id: <20190523052918.1129-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523052918.1129-1-david@gibson.dropbear.id.au>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 2/8] spapr: Clean up device tree construction
 for PCI devices
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

spapr_create_pci_child_dt() is a trivial wrapper around
spapr_populate_pci_child_dt(), but is the latter's only caller.  So fold
them together into spapr_dt_pci_device(), which closer matches our modern
naming convention.

While there, make a number of cleanups to the function itself.  This is
mostly using more temporary locals to avoid awkwardly long lines, and in
some cases avoiding double reads of PCI config space variables.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 119 +++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b2db46ef1d..4075b433fd 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1219,57 +1219,75 @@ static const char *dt_name_from_class(uint8_t cla=
ss, uint8_t subclass,
 static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
                                             PCIDevice *pdev);
=20
-static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int o=
ffset,
-                                       SpaprPhbState *sphb)
+/* create OF node for pci device and required OF DT properties */
+static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
+                               void *fdt, int parent_offset)
 {
+    int offset;
+    const gchar *basename;
+    char *nodename;
+    int slot =3D PCI_SLOT(dev->devfn);
+    int func =3D PCI_FUNC(dev->devfn);
     ResourceProps rp;
-    bool is_bridge =3D false;
-    int pci_status;
-    char *buf =3D NULL;
     uint32_t drc_index =3D spapr_phb_get_pci_drc_index(sphb, dev);
+    uint32_t header_type =3D pci_default_read_config(dev, PCI_HEADER_TYP=
E, 1);
+    bool is_bridge =3D (header_type =3D=3D PCI_HEADER_TYPE_BRIDGE);
+    uint32_t vendor_id =3D pci_default_read_config(dev, PCI_VENDOR_ID, 2=
);
+    uint32_t device_id =3D pci_default_read_config(dev, PCI_DEVICE_ID, 2=
);
+    uint32_t revision_id =3D pci_default_read_config(dev, PCI_REVISION_I=
D, 1);
     uint32_t ccode =3D pci_default_read_config(dev, PCI_CLASS_PROG, 3);
-    uint32_t max_msi, max_msix;
+    uint32_t irq_pin =3D pci_default_read_config(dev, PCI_INTERRUPT_PIN,=
 1);
+    uint32_t subsystem_id =3D pci_default_read_config(dev, PCI_SUBSYSTEM=
_ID, 2);
+    uint32_t subsystem_vendor_id =3D
+        pci_default_read_config(dev, PCI_SUBSYSTEM_VENDOR_ID, 2);
+    uint32_t cache_line_size =3D
+        pci_default_read_config(dev, PCI_CACHE_LINE_SIZE, 1);
+    uint32_t pci_status =3D pci_default_read_config(dev, PCI_STATUS, 2);
+    gchar *loc_code;
+   =20
+    basename =3D dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) &=
 0xff,
+                                  ccode & 0xff);
=20
-    if (pci_default_read_config(dev, PCI_HEADER_TYPE, 1) =3D=3D
-        PCI_HEADER_TYPE_BRIDGE) {
-        is_bridge =3D true;
+    if (func !=3D 0) {
+        nodename =3D g_strdup_printf("%s@%x,%x", basename, slot, func);
+    } else {
+        nodename =3D g_strdup_printf("%s@%x", basename, slot);
     }
=20
+    _FDT(offset =3D fdt_add_subnode(fdt, parent_offset, nodename));
+
+    g_free(nodename);
+
     /* in accordance with PAPR+ v2.7 13.6.3, Table 181 */
-    _FDT(fdt_setprop_cell(fdt, offset, "vendor-id",
-                          pci_default_read_config(dev, PCI_VENDOR_ID, 2)=
));
-    _FDT(fdt_setprop_cell(fdt, offset, "device-id",
-                          pci_default_read_config(dev, PCI_DEVICE_ID, 2)=
));
-    _FDT(fdt_setprop_cell(fdt, offset, "revision-id",
-                          pci_default_read_config(dev, PCI_REVISION_ID, =
1)));
+    _FDT(fdt_setprop_cell(fdt, offset, "vendor-id", vendor_id));
+    _FDT(fdt_setprop_cell(fdt, offset, "device-id", device_id));
+    _FDT(fdt_setprop_cell(fdt, offset, "revision-id", revision_id));
+
     _FDT(fdt_setprop_cell(fdt, offset, "class-code", ccode));
-    if (pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)) {
-        _FDT(fdt_setprop_cell(fdt, offset, "interrupts",
-                 pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)));
+    if (irq_pin) {
+        _FDT(fdt_setprop_cell(fdt, offset, "interrupts", irq_pin));
     }
=20
     if (!is_bridge) {
-        _FDT(fdt_setprop_cell(fdt, offset, "min-grant",
-            pci_default_read_config(dev, PCI_MIN_GNT, 1)));
-        _FDT(fdt_setprop_cell(fdt, offset, "max-latency",
-            pci_default_read_config(dev, PCI_MAX_LAT, 1)));
+        uint32_t min_grant =3D pci_default_read_config(dev, PCI_MIN_GNT,=
 1);
+        uint32_t max_latency =3D pci_default_read_config(dev, PCI_MAX_LA=
T, 1);
+        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
+        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latency));
     }
=20
-    if (pci_default_read_config(dev, PCI_SUBSYSTEM_ID, 2)) {
-        _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id",
-                 pci_default_read_config(dev, PCI_SUBSYSTEM_ID, 2)));
+    if (subsystem_id) {
+        _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id", subsystem_id)=
);
     }
=20
-    if (pci_default_read_config(dev, PCI_SUBSYSTEM_VENDOR_ID, 2)) {
+    if (subsystem_vendor_id) {
         _FDT(fdt_setprop_cell(fdt, offset, "subsystem-vendor-id",
-                 pci_default_read_config(dev, PCI_SUBSYSTEM_VENDOR_ID, 2=
)));
+                              subsystem_vendor_id));
     }
=20
-    _FDT(fdt_setprop_cell(fdt, offset, "cache-line-size",
-        pci_default_read_config(dev, PCI_CACHE_LINE_SIZE, 1)));
+    _FDT(fdt_setprop_cell(fdt, offset, "cache-line-size", cache_line_siz=
e));
+
=20
     /* the following fdt cells are masked off the pci status register */
-    pci_status =3D pci_default_read_config(dev, PCI_STATUS, 2);
     _FDT(fdt_setprop_cell(fdt, offset, "devsel-speed",
                           PCI_STATUS_DEVSEL_MASK & pci_status));
=20
@@ -1283,9 +1301,9 @@ static void spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
         _FDT(fdt_setprop(fdt, offset, "udf-supported", NULL, 0));
     }
=20
-    buf =3D spapr_phb_get_loc_code(sphb, dev);
-    _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
-    g_free(buf);
+    loc_code =3D spapr_phb_get_loc_code(sphb, dev);
+    _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", loc_code));
+    g_free(loc_code);
=20
     if (drc_index) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index=
));
@@ -1297,13 +1315,13 @@ static void spapr_populate_pci_child_dt(PCIDevice=
 *dev, void *fdt, int offset,
                           RESOURCE_CELLS_SIZE));
=20
     if (msi_present(dev)) {
-        max_msi =3D msi_nr_vectors_allocated(dev);
+        uint32_t max_msi =3D msi_nr_vectors_allocated(dev);
         if (max_msi) {
             _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
         }
     }
     if (msix_present(dev)) {
-        max_msix =3D dev->msix_entries_nr;
+        uint32_t max_msix =3D dev->msix_entries_nr;
         if (max_msix) {
             _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix=
));
         }
@@ -1319,33 +1337,6 @@ static void spapr_populate_pci_child_dt(PCIDevice =
*dev, void *fdt, int offset,
     }
=20
     spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
-}
-
-/* create OF node for pci device and required OF DT properties */
-static int spapr_create_pci_child_dt(SpaprPhbState *phb, PCIDevice *dev,
-                                     void *fdt, int node_offset)
-{
-    int offset;
-    const gchar *basename;
-    char *nodename;
-    int slot =3D PCI_SLOT(dev->devfn);
-    int func =3D PCI_FUNC(dev->devfn);
-    uint32_t ccode =3D pci_default_read_config(dev, PCI_CLASS_PROG, 3);
-
-    basename =3D dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) &=
 0xff,
-                                  ccode & 0xff);
-
-    if (func !=3D 0) {
-        nodename =3D g_strdup_printf("%s@%x,%x", basename, slot, func);
-    } else {
-        nodename =3D g_strdup_printf("%s@%x", basename, slot);
-    }
-
-    _FDT(offset =3D fdt_add_subnode(fdt, node_offset, nodename));
-
-    g_free(nodename);
-
-    spapr_populate_pci_child_dt(dev, fdt, offset, phb);
=20
     return offset;
 }
@@ -1393,7 +1384,7 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachi=
neState *spapr,
     SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(plug_handler);
     PCIDevice *pdev =3D PCI_DEVICE(drc->dev);
=20
-    *fdt_start_offset =3D spapr_create_pci_child_dt(sphb, pdev, fdt, 0);
+    *fdt_start_offset =3D spapr_dt_pci_device(sphb, pdev, fdt, 0);
     return 0;
 }
=20
@@ -2086,7 +2077,7 @@ static void spapr_populate_pci_devices_dt(PCIBus *b=
us, PCIDevice *pdev,
     int offset;
     SpaprFdt s_fdt;
=20
-    offset =3D spapr_create_pci_child_dt(p->sphb, pdev, p->fdt, p->node_=
off);
+    offset =3D spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->node_off);
     if (!offset) {
         error_report("Failed to create pci child device tree node");
         return;
--=20
2.21.0


