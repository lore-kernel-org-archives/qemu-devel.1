Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6CBC2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F87206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F87206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfRU-00060p-OP
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOfEb-0004AV-UN
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOfEZ-0005Eg-Vd
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:25:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOfEQ-0004xR-E1; Wed, 15 Apr 2020 06:25:22 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1B060BFA0B;
 Wed, 15 Apr 2020 10:25:01 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 14/16] nvme: factor out pci setup
Date: Wed, 15 Apr 2020 12:24:43 +0200
Message-Id: <20200415102445.564803-15-its@irrelevant.dk>
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
 hw/block/nvme.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 08f7ae0a48b3..16d01af53a07 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1382,6 +1382,24 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNa=
mespace *ns, Error **errp)
     return 0;
 }
=20
+static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    uint8_t *pci_conf =3D pci_dev->config;
+
+    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
+    pci_config_set_prog_interface(pci_conf, 0x2);
+    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+    pci_config_set_device_id(pci_conf, 0x5845);
+    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+
+    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme=
",
+                          n->reg_size);
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
+    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
@@ -1400,19 +1418,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
         return;
     }
=20
+    nvme_init_pci(n, pci_dev);
+
     pci_conf =3D pci_dev->config;
-    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(pci_dev, 0x80);
-
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
-                          "nvme", n->reg_size);
-    pci_register_bar(pci_dev, 0,
-        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
-        &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
-
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
--=20
2.26.0


