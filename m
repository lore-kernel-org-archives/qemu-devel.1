Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A04ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6CF2089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6CF2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKOz-0001NU-RJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKF0-0007u7-Nl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKEz-0006ez-Gm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:46 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKEv-0006HG-RX; Tue, 15 Oct 2019 06:39:41 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1D475BF7FB;
 Tue, 15 Oct 2019 10:39:19 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 19/20] nvme: make lba data size configurable
Date: Tue, 15 Oct 2019 12:38:59 +0200
Message-Id: <20191015103900.313928-20-its@irrelevant.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015103900.313928-1-its@irrelevant.dk>
References: <20191015103900.313928-1-its@irrelevant.dk>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c | 2 +-
 hw/block/nvme-ns.h | 4 +++-
 hw/block/nvme.c    | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index aa76bb63ef45..70ff622a5729 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns =3D &ns->id_ns;
=20
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->lbaf[0].ds =3D ns->params.lbads;
     id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D
         cpu_to_le64(nvme_ns_nlbas(ns));
=20
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 64dd054cf6a9..aa1c81d85cde 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -6,10 +6,12 @@
     OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
=20
 #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
-    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
+    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
+    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, 9)
=20
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  lbads;
 } NvmeNamespaceParams;
=20
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 67f92bf5a3ac..d0103c16cfe9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2602,6 +2602,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     if (n->namespace.conf.blk) {
         ns =3D &n->namespace;
         ns->params.nsid =3D 1;
+        ns->params.lbads =3D 9;
=20
         if (nvme_ns_setup(n, ns, &local_err)) {
             error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
--=20
2.23.0


