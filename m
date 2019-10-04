Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07957C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C897C20867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DA7UU1pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C897C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKVN-0001IW-Ie
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2i-0005Lt-FY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2g-0005U4-J1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48665 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2g-0005Rc-3T; Fri, 04 Oct 2019 05:38:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YL6sWQz9sS6; Fri,  4 Oct 2019 19:37:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181878;
 bh=QmCNEYj6rsNSU0nPBYpM3iu9q/HkIOe/NTiRHUO55lM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DA7UU1pbu9w0TtmTCb9ho8OLzKRtkR9oN1hr6R+momIKh95rO1by5zB/V5+fOo+oh
 BZ8zfRE/ZnEi49Fg56pCDJyXcbx0Z6GPJce8+F3LHYHbMF+CyZ3ODX6rUmQQ5KyK43
 qhGOv7Sitc0HQOy0k7hXvHQyPjbJ7BhtOzYFRfN0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 29/53] spapr-pci: Stop providing assigned-addresses
Date: Fri,  4 Oct 2019 19:37:23 +1000
Message-Id: <20191004093747.31350-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

QEMU does not allocate PCI resources (BARs) in any case - coldplug device=
s
are configured by the firmware and hotplug devices rely on the guest
system to do the assignment via the PCI rescan mechanism. Also in order
to create non empty "assigned-addresses", the device has to be enabled
(i.e. PCI_COMMAND needs the MMIO bit set) first as otherwise
io_regions[i].addr are -1, and devices are not enabled at this point.

This removes "assigned-addresses" and leaves it to those who actually
do resource allocation.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190927022651.71642-1-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 42 +++++++-----------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7b71ad7c74..c1c9634755 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -835,7 +835,7 @@ static char *spapr_phb_get_loc_code(SpaprPhbState *sp=
hb, PCIDevice *pdev)
 #define b_fff(x)        b_x((x), 8, 3)  /* function number */
 #define b_rrrrrrrr(x)   b_x((x), 0, 8)  /* register number */
=20
-/* for 'reg'/'assigned-addresses' OF properties */
+/* for 'reg' OF properties */
 #define RESOURCE_CELLS_SIZE 2
 #define RESOURCE_CELLS_ADDRESS 3
=20
@@ -849,17 +849,14 @@ typedef struct ResourceFields {
=20
 typedef struct ResourceProps {
     ResourceFields reg[8];
-    ResourceFields assigned[7];
     uint32_t reg_len;
-    uint32_t assigned_len;
 } ResourceProps;
=20
-/* fill in the 'reg'/'assigned-resources' OF properties for
+/* fill in the 'reg' OF properties for
  * a PCI device. 'reg' describes resource requirements for a
- * device's IO/MEM regions, 'assigned-addresses' describes the
- * actual resource assignments.
+ * device's IO/MEM regions.
  *
- * the properties are arrays of ('phys-addr', 'size') pairs describing
+ * the property is an array of ('phys-addr', 'size') pairs describing
  * the addressable regions of the PCI device, where 'phys-addr' is a
  * RESOURCE_CELLS_ADDRESS-tuple of 32-bit integers corresponding to
  * (phys.hi, phys.mid, phys.lo), and 'size' is a
@@ -888,18 +885,7 @@ typedef struct ResourceProps {
  * phys.mid and phys.lo correspond respectively to the hi/lo portions
  * of the actual address of the region.
  *
- * how the phys-addr/size values are used differ slightly between
- * 'reg' and 'assigned-addresses' properties. namely, 'reg' has
- * an additional description for the config space region of the
- * device, and in the case of QEMU has n=3D0 and phys.mid=3Dphys.lo=3D0
- * to describe the region as relocatable, with an address-mapping
- * that corresponds directly to the PHB's address space for the
- * resource. 'assigned-addresses' always has n=3D1 set with an absolute
- * address assigned for the resource. in general, 'assigned-addresses'
- * won't be populated, since addresses for PCI devices are generally
- * unmapped initially and left to the guest to assign.
- *
- * note also that addresses defined in these properties are, at least
+ * note also that addresses defined in this property are, at least
  * for PAPR guests, relative to the PHBs IO/MEM windows, and
  * correspond directly to the addresses in the BARs.
  *
@@ -913,8 +899,8 @@ static void populate_resource_props(PCIDevice *d, Res=
ourceProps *rp)
     uint32_t dev_id =3D (b_bbbbbbbb(bus_num) |
                        b_ddddd(PCI_SLOT(d->devfn)) |
                        b_fff(PCI_FUNC(d->devfn)));
-    ResourceFields *reg, *assigned;
-    int i, reg_idx =3D 0, assigned_idx =3D 0;
+    ResourceFields *reg;
+    int i, reg_idx =3D 0;
=20
     /* config space region */
     reg =3D &rp->reg[reg_idx++];
@@ -943,21 +929,9 @@ static void populate_resource_props(PCIDevice *d, Re=
sourceProps *rp)
         reg->phys_lo =3D 0;
         reg->size_hi =3D cpu_to_be32(d->io_regions[i].size >> 32);
         reg->size_lo =3D cpu_to_be32(d->io_regions[i].size);
-
-        if (d->io_regions[i].addr =3D=3D PCI_BAR_UNMAPPED) {
-            continue;
-        }
-
-        assigned =3D &rp->assigned[assigned_idx++];
-        assigned->phys_hi =3D cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_=
n(1));
-        assigned->phys_mid =3D cpu_to_be32(d->io_regions[i].addr >> 32);
-        assigned->phys_lo =3D cpu_to_be32(d->io_regions[i].addr);
-        assigned->size_hi =3D reg->size_hi;
-        assigned->size_lo =3D reg->size_lo;
     }
=20
     rp->reg_len =3D reg_idx * sizeof(ResourceFields);
-    rp->assigned_len =3D assigned_idx * sizeof(ResourceFields);
 }
=20
 typedef struct PCIClass PCIClass;
@@ -1471,8 +1445,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb,=
 PCIDevice *dev,
=20
     populate_resource_props(dev, &rp);
     _FDT(fdt_setprop(fdt, offset, "reg", (uint8_t *)rp.reg, rp.reg_len))=
;
-    _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
-                     (uint8_t *)rp.assigned, rp.assigned_len));
=20
     if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));
--=20
2.21.0


