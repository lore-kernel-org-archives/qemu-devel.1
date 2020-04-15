Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E93C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB45E20784
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45E20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfTe-0000qR-1f
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOfEb-0004AQ-UU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOfEa-0005Eq-0X
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:25:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOfEP-0004ws-SE; Wed, 15 Apr 2020 06:25:22 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B0F68BF9F3;
 Wed, 15 Apr 2020 10:25:00 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 13/16] nvme: factor out namespace setup
Date: Wed, 15 Apr 2020 12:24:42 +0200
Message-Id: <20200415102445.564803-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415102445.564803-1-its@irrelevant.dk>
References: <20200415102445.564803-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f0989cbb4335..08f7ae0a48b3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1359,13 +1359,35 @@ static int nvme_init_blk(NvmeCtrl *n, Error **err=
p)
     return 0;
 }
=20
+static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
+{
+    int64_t bs_size;
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+
+    bs_size =3D blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg_errno(errp, -bs_size, "could not get backing file siz=
e");
+        return -1;
+    }
+
+    n->ns_size =3D bs_size;
+
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(n, ns));
+
+    /* no thin provisioning */
+    id_ns->ncap =3D id_ns->nsze;
+    id_ns->nuse =3D id_ns->ncap;
+
+    return 0;
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
     NvmeIdCtrl *id =3D &n->id_ctrl;
=20
     int i;
-    int64_t bs_size;
     uint8_t *pci_conf;
=20
     if (nvme_check_constraints(n, errp)) {
@@ -1374,12 +1396,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
=20
     nvme_init_state(n);
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
-    }
-
     if (nvme_init_blk(n, errp)) {
         return;
     }
@@ -1390,8 +1406,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
-    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
-
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
@@ -1455,18 +1469,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     }
=20
     for (i =3D 0; i < n->num_namespaces; i++) {
-        NvmeNamespace *ns =3D &n->namespaces[i];
-        NvmeIdNs *id_ns =3D &ns->id_ns;
-        id_ns->nsfeat =3D 0;
-        id_ns->nlbaf =3D 0;
-        id_ns->flbas =3D 0;
-        id_ns->mc =3D 0;
-        id_ns->dpc =3D 0;
-        id_ns->dps =3D 0;
-        id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-        id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
+        if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
+            return;
+        }
     }
 }
=20
--=20
2.26.0


