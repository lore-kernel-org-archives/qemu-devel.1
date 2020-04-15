Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93A4C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA17020732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA17020732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhih-00013t-RI
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOhgT-00079W-0y
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOhgR-0004IW-RU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:02:28 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOhgP-0004BX-2D; Wed, 15 Apr 2020 09:02:25 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D4FC4BFD4F;
 Wed, 15 Apr 2020 13:02:23 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 10/16] nvme: factor out device state setup
Date: Wed, 15 Apr 2020 15:01:53 +0200
Message-Id: <20200415130159.611361-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415130159.611361-1-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/nvme.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5f9ebbd6a1d5..45a352b63d89 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1340,6 +1340,17 @@ static void nvme_check_constraints(NvmeCtrl *n, Er=
ror **errp)
     }
 }
=20
+static void nvme_init_state(NvmeCtrl *n)
+{
+    n->num_namespaces =3D 1;
+    /* add one to max_ioqpairs to account for the admin queue pair */
+    n->reg_size =3D pow2ceil(NVME_REG_SIZE +
+                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SI=
ZE);
+    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
+    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
+    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
@@ -1356,6 +1367,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         return;
     }
=20
+    nvme_init_state(n);
+
     bs_size =3D blk_getlength(n->conf.blk);
     if (bs_size < 0) {
         error_setg(errp, "could not get backing file size");
@@ -1374,17 +1387,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
-    n->num_namespaces =3D 1;
-
-    /* add one to max_ioqpairs to account for the admin queue pair */
-    n->reg_size =3D pow2ceil(NVME_REG_SIZE +
-                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SI=
ZE);
     n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
-    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
-
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
--=20
2.26.0


