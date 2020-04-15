Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D69C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF1621556
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF1621556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhpk-0006s7-Gt
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOhgo-0007Vx-KV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOhgn-0004Xw-KN
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:02:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOhgk-0004CB-Jk; Wed, 15 Apr 2020 09:02:46 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 4867EBF7AF;
 Wed, 15 Apr 2020 13:02:24 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 11/16] nvme: factor out block backend setup
Date: Wed, 15 Apr 2020 15:01:54 +0200
Message-Id: <20200415130159.611361-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415130159.611361-1-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
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
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 45a352b63d89..80da0825d295 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1351,6 +1351,13 @@ static void nvme_init_state(NvmeCtrl *n)
     n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
 }
=20
+static void nvme_init_blk(NvmeCtrl *n, Error **errp)
+{
+    blkconf_blocksizes(&n->conf);
+    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk=
),
+                                  false, errp);
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n =3D NVME(pci_dev);
@@ -1375,9 +1382,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         return;
     }
=20
-    blkconf_blocksizes(&n->conf);
-    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
-                                       false, errp)) {
+    nvme_init_blk(n, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
=20
--=20
2.26.0


