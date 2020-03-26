Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC61C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8EE206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TWtIMETV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8EE206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHLIP-0006aq-S3
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 01:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHLFc-0003AH-4D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHLFa-0000pm-NH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:40:20 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41023 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHLFa-0000nT-18; Thu, 26 Mar 2020 01:40:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nv2k50NFz9sRN; Thu, 26 Mar 2020 16:40:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585201214;
 bh=HJM6J14MXwxAnCeEjdieEtsutKN/FoKlqgFsm3PZdCA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TWtIMETVxi8VH1mbflwoAM/xCmrNo9QGHp6PErnp8W33ByCZ32bE5soYFQzqT2oOA
 pmg24lNR92jjiYlBypOBd2hnXOY613IVpefXrvFGHH9Gyzk/qo48eQqROQQNeHEi6l
 ZB/kNDTJsOnMkQO/t1yXXt64AGmMx2h+cMZbTYBc=
From: David Gibson <david@gibson.dropbear.id.au>
To: aik@ozlabs.ru,
	groug@kaod.org
Subject: [RFC for-5.1 1/4] spapr: Refactor locating NVLink2 devices for device
 tree creation
Date: Thu, 26 Mar 2020 16:40:06 +1100
Message-Id: <20200326054009.454477-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326054009.454477-1-david@gibson.dropbear.id.au>
References: <20200326054009.454477-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently spapr_phb_nvgpu_populate_pcidev_dt() works a little cryptically=
.
It steps through all the NVLink2 GPUs and NPUs and if they match the devi=
ce
we're called for, we generate the relevant device tree information.

Make this a little more obvious by introducing helpers to determine it a
given PCI device is an NVLink2 GPU or NPU, returning the NVLink2 slot and
link number information as well.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci_nvlink2.c | 115 +++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 8332d5694e..7d3a685421 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -390,13 +390,12 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState =
*sphb, void *fdt)
=20
 }
=20
-void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
-                                        SpaprPhbState *sphb)
+static bool is_nvgpu(PCIDevice *dev, SpaprPhbState *sphb, int *slot)
 {
-    int i, j;
+    int i;
=20
     if (!sphb->nvgpus) {
-        return;
+        return false;
     }
=20
     for (i =3D 0; i < sphb->nvgpus->num; ++i) {
@@ -406,47 +405,91 @@ void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *=
dev, void *fdt, int offset,
         if (!nvslot->gpdev) {
             continue;
         }
+
         if (dev =3D=3D nvslot->gpdev) {
-            uint32_t npus[nvslot->linknum];
+            if (slot) {
+                *slot =3D i;
+            }
+            return true;
+        }
+    }
=20
-            for (j =3D 0; j < nvslot->linknum; ++j) {
-                PCIDevice *npdev =3D nvslot->links[j].npdev;
+    return false;
+}
=20
-                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
-            }
-            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
-                             j * sizeof(npus[0])));
-            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
-                                   PHANDLE_PCIDEV(sphb, dev))));
+static bool is_nvnpu(PCIDevice *dev, SpaprPhbState *sphb, int *slot, int=
 *link)
+{
+    int i, j;
+
+    if (!sphb->nvgpus) {
+        return false;
+    }
+
+    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
+
+        /* Skip "slot" without attached GPU */
+        if (!nvslot->gpdev) {
             continue;
         }
=20
         for (j =3D 0; j < nvslot->linknum; ++j) {
-            if (dev !=3D nvslot->links[j].npdev) {
-                continue;
+            if (dev =3D=3D nvslot->links[j].npdev) {
+                if (slot) {
+                    *slot =3D i;
+                }
+                if (link) {
+                    *link =3D j;
+                }
+                return true;
             }
+        }
+    }
=20
-            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
-                                   PHANDLE_PCIDEV(sphb, dev))));
-            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
-                                  PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
-            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
-                                   PHANDLE_NVLINK(sphb, i, j))));
-            /*
-             * If we ever want to emulate GPU RAM at the same location a=
s on
-             * the host - here is the encoding GPA->TGT:
-             *
-             * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
-             * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
-             * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
-             * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
-             */
-            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
-                                  PHANDLE_GPURAM(sphb, i)));
-            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
-                                 nvslot->tgt));
-            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
-                                  nvslot->links[j].link_speed));
+    return false;
+}
+
+void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
+                                        SpaprPhbState *sphb)
+{
+    int slot, link;
+
+    if (is_nvgpu(dev, sphb, &slot)) {
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[slot];
+        uint32_t npus[nvslot->linknum];
+
+        for (link =3D 0; link < nvslot->linknum; ++link) {
+            PCIDevice *npdev =3D nvslot->links[link].npdev;
+
+            npus[link] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
         }
+        _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
+                         link * sizeof(npus[0])));
+        _FDT((fdt_setprop_cell(fdt, offset, "phandle",
+                               PHANDLE_PCIDEV(sphb, dev))));
+    } else if (is_nvnpu(dev, sphb, &slot, &link)) {
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[slot];
+
+        _FDT((fdt_setprop_cell(fdt, offset, "phandle",
+                               PHANDLE_PCIDEV(sphb, dev))));
+        _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
+                              PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
+                               PHANDLE_NVLINK(sphb, slot, link))));
+        /*
+         * If we ever want to emulate GPU RAM at the same location as
+         * on the host - here is the encoding GPA->TGT:
+         *
+         * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
+         * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
+         * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
+         * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
+         */
+        _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
+                              PHANDLE_GPURAM(sphb, slot)));
+        _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
+                             nvslot->tgt));
+        _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
+                              nvslot->links[link].link_speed));
     }
 }
--=20
2.25.1


