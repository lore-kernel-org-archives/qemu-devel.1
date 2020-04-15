Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E9C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7883320787
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7883320787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfHV-0000j0-Kf
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOfE8-0003Xr-3w
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOfE6-0004z2-TO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:25:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOfE4-0004vI-86; Wed, 15 Apr 2020 06:25:00 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 272D7BFD3D;
 Wed, 15 Apr 2020 10:24:59 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 09/16] nvme: factor out property/constraint checks
Date: Wed, 15 Apr 2020 12:24:38 +0200
Message-Id: <20200415102445.564803-10-its@irrelevant.dk>
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
 hw/block/nvme.c | 52 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ea613213bd57..635292d6fac4 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1308,6 +1308,37 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     },
 };
=20
+static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
+{
+    NvmeParams *params =3D &n->params;
+
+    if (params->num_queues) {
+        warn_report("num_queues is deprecated; please use max_ioqpairs "
+                    "instead");
+
+        params->max_ioqpairs =3D params->num_queues - 1;
+    }
+
+    if (params->max_ioqpairs < 1 ||
+        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
+        error_setg(errp, "max_ioqpairs must be between 1 and %d",
+                   PCI_MSIX_FLAGS_QSIZE);
+        return -1;
+    }
+
+    if (!n->conf.blk) {
+        error_setg(errp, "drive property not set");
+        return -1;
+    }
+
+    if (!params->serial) {
+        error_setg(errp, "serial property not set");
+        return -1;
+    }
+
+    return 0;
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
@@ -1317,22 +1348,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     int64_t bs_size;
     uint8_t *pci_conf;
=20
-    if (n->params.num_queues) {
-        warn_report("num_queues is deprecated; please use max_ioqpairs "
-                    "instead");
-
-        n->params.max_ioqpairs =3D n->params.num_queues - 1;
-    }
-
-    if (n->params.max_ioqpairs < 1 ||
-        n->params.max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
-        error_setg(errp, "max_ioqpairs must be between 1 and %d",
-                   PCI_MSIX_FLAGS_QSIZE);
-        return;
-    }
-
-    if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
+    if (nvme_check_constraints(n, errp)) {
         return;
     }
=20
@@ -1342,10 +1358,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
         return;
     }
=20
-    if (!n->params.serial) {
-        error_setg(errp, "serial property not set");
-        return;
-    }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
                                        false, errp)) {
--=20
2.26.0


