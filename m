Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A2C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590272087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TyGxTVbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590272087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyutq-000632-HC
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusY-0003qh-HP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusW-00073q-OX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35187)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusW-000723-Hw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:20 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095218euoutp01bb47fd4e983388df79d65fa0017f4b4f~wKkNn-Q-w3027830278euoutp01C
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095218euoutp01bb47fd4e983388df79d65fa0017f4b4f~wKkNn-Q-w3027830278euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809938;
 bh=4x9wPiEKGPtp/YFifz0mZ8W7rAmc9GM74z2k5jKpJ/s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=TyGxTVbqtnfPssrXt6s78zkcAG/Tt/oMu+8H5aZqFl0G+DaQDuZxe2kLZl5NjmgRe
 9/yhVTizKWJ4Dp6uInA0Jr8pfMAihf/5Du7TZDjCQNpZ0NLuIwZ0MgvD91j+I5lHBB
 AXJoiH1EZlZ70+TW9KFLxtRxwRNMl4dmhTUKhN24=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095218eucas1p2017fc1b018152c8e658fd59cfcfce977~wKkNc91h30532305323eucas1p2F;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.8E.61286.1DE393E5; Tue,  4
 Feb 2020 09:52:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095217eucas1p1f3e1d113d5eaad4327de0158d1e480cb~wKkNM8lFe0043700437eucas1p1H;
 Tue,  4 Feb 2020 09:52:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095217eusmtrp2b8dffd43e2ee1be58da4c80a2777062c~wKkNML78P0485704857eusmtrp2V;
 Tue,  4 Feb 2020 09:52:17 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-e6-5e393ed1dbd4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.BC.08375.1DE393E5; Tue,  4
 Feb 2020 09:52:17 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095217eusmtip1ac4e00ca4ac6b0a4cbf41da6711b09ad~wKkNAy04F2623026230eusmtip1f;
 Tue,  4 Feb 2020 09:52:17 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:16 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:16 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 03/26] nvme: move device parameters to separate struct
Date: Tue, 4 Feb 2020 10:51:45 +0100
Message-ID: <20200204095208.269131-4-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87oX7SzjDJbMsbTY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGUuumRUcdKi4vGw+ewPjUYMuRk4OCQETiROf1zB2MXJxCAmsYJTo
 XXYXyvnCKHG4eQcrhPOZUWLyrL9MXYwcYC2953gh4ssZJdq3vWKHK7o8bzMjyFwhgdOMErve
 eUMkdgLZ35exgSTYBDQltv/5zwJiiwhIS7RfnQS2glngN6PE3MaJYEXCAp4SC049YAaxWQRU
 JC5uOws2lVfASuJu51Q2iMvlJWY3ngazOQWsJfavOsEEUSMocXLmE7AFzEA1zVtnM0PYEhIH
 X7xgBlkmIbCLXWJx31F2iEEuEienXYMaKizx6vgWqLiMxP+d85kgGroZJfo+fIXqnsEoMX3Z
 dzZIaFhL9J3JgTAdJV488IQw+SRuvBWE2MsnMWnbdGaIMK9ER5sQxHQ1iR1NWxknMCrPQnL1
 LCRXz0Jy9QJG5lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiByeb0v+OfdjB+vZR0iFGA
 g1GJh/eCnUWcEGtiWXFl7iFGCQ5mJRHe8/qWcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9
 jBUSSE8sSc1OTS1ILYLJMnFwSjUw1i3x4C/LXZW9+W9BV7R/k2posn3pgczw9x2pMt+2Vtc/
 Ofr7V9Sdbier10HPVczXzItff4Wtw80o6HPRw/wyP+H8zyrHGfbI2ZwMDE3+FK/+aOujrtsJ
 0rELIqT7srO+++zYXnygKuB+U9Xfc7nmd+IuXeb/eY4nbUuI6K+j6+J/3PjXJimsxFKckWio
 xVxUnAgAdk72fzIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7oX7SzjDL7+VbPY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GUuu
 mRUcdKi4vGw+ewPjUYMuRg4OCQETid5zvF2MXBxCAksZJRqWHWLsYuQEistIfLrykR3CFpb4
 c62LDaLoI6PEvl0HGSGc04wSP15PhHJ2Mkp8nH6JGaSFTUBTYvuf/ywgtoiAtET71UmsIDaz
 wG9GiT99gSC2sICnxIJTD8DqWQRUJC5uOwu2mlfASuJu51Q2iNXyErMbT4PZnALWEvtXnWAC
 OVsIqKb1KDdEuaDEyZlPWCDGy0s0b53NDGFLSBx88YJ5AqPwLCRls5CUzUJStoCReRWjSGpp
 cW56brGhXnFibnFpXrpecn7uJkZgxG079nPzDsZLG4MPMQpwMCrx8F6ws4gTYk0sK67MPcQo
 wcGsJMJ7Xt8yTog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgckgryTe0NTQ3MLS0NzY3NjM
 Qkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo7HyttvvH78ucJt05x8/g8/xJSeTa48GB+1i
 PX3CdNp77mefleLq6ud8/aPcZWwyW+8Lo/Crz/5H9udM/r+64ti/2keWlUdt5PZufn3zxJ4f
 HB0hSuu66u8xeR51ms5ZZySutEP8QeS03z4zqlvuX2Y8GmKfYzt3ws8jS/SYFNe+Cp24XLaw
 2lCJpTgj0VCLuag4EQCrSnuOzgIAAA==
X-CMS-MailID: 20200204095217eucas1p1f3e1d113d5eaad4327de0158d1e480cb
X-Msg-Generator: CA
X-RootMTR: 20200204095217eucas1p1f3e1d113d5eaad4327de0158d1e480cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095217eucas1p1f3e1d113d5eaad4327de0158d1e480cb
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095217eucas1p1f3e1d113d5eaad4327de0158d1e480cb@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move device configuration parameters to separate struct to make it
explicit what is configurable and what is set internally.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 44 ++++++++++++++++++++++----------------------
 hw/block/nvme.h | 16 +++++++++++++---
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c9ad6aaa5f95..f05ebcce3f53 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -64,12 +64,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->num_queues && n->sq[sqid] !=3D NULL ? 0 : -1;
+    return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
 }
=20
 static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
 {
-    return cqid < n->num_queues && n->cq[cqid] !=3D NULL ? 0 : -1;
+    return cqid < n->params.num_queues && n->cq[cqid] !=3D NULL ? 0 : -1=
;
 }
=20
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -631,7 +631,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
         trace_nvme_dev_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (unlikely(vector > n->num_queues)) {
+    if (unlikely(vector > n->params.num_queues)) {
         trace_nvme_dev_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -783,7 +783,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
+        result =3D cpu_to_le32((n->params.num_queues - 2) |
+            ((n->params.num_queues - 2) << 16));
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -826,9 +827,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         break;
     case NVME_NUMBER_OF_QUEUES:
         trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
-            ((dw11 >> 16) & 0xFFFF) + 1, n->num_queues - 1, n->num_queue=
s - 1);
-        req->cqe.result =3D
-            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
+            ((dw11 >> 16) & 0xFFFF) + 1, n->params.num_queues - 1,
+            n->params.num_queues - 1);
+        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
+            ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
@@ -899,12 +901,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
=20
     blk_drain(n->conf.blk);
=20
-    for (i =3D 0; i < n->num_queues; i++) {
+    for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->sq[i] !=3D NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i =3D 0; i < n->num_queues; i++) {
+    for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->cq[i] !=3D NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -1307,7 +1309,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     int64_t bs_size;
     uint8_t *pci_conf;
=20
-    if (!n->num_queues) {
+    if (!n->params.num_queues) {
         error_setg(errp, "num_queues can't be zero");
         return;
     }
@@ -1323,7 +1325,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         return;
     }
=20
-    if (!n->serial) {
+    if (!n->params.serial) {
         error_setg(errp, "serial property not set");
         return;
     }
@@ -1340,25 +1342,25 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
     n->num_namespaces =3D 1;
-    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
+    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
     n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq =3D g_new0(NvmeSQueue *, n->num_queues);
-    n->cq =3D g_new0(NvmeCQueue *, n->num_queues);
+    n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
+    n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
=20
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
=20
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
     id->rab =3D 6;
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
@@ -1387,7 +1389,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     n->bar.vs =3D 0x00010200;
     n->bar.intmc =3D n->bar.intms =3D 0;
=20
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
=20
         NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
         NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
@@ -1398,7 +1400,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
=20
         n->cmbloc =3D n->bar.cmbloc;
         n->cmbsz =3D n->bar.cmbsz;
@@ -1437,7 +1439,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
=20
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
     }
     msix_uninit_exclusive_bar(pci_dev);
@@ -1445,9 +1447,7 @@ static void nvme_exit(PCIDevice *pci_dev)
=20
 static Property nvme_props[] =3D {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
-    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
-    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
-    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
+    DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 557194ee1954..9957c4a200e2 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,7 +1,19 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
+
 #include "block/nvme.h"
=20
+#define DEFINE_NVME_PROPERTIES(_state, _props) \
+    DEFINE_PROP_STRING("serial", _state, _props.serial), \
+    DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+
+typedef struct NvmeParams {
+    char     *serial;
+    uint32_t num_queues;
+    uint32_t cmb_size_mb;
+} NvmeParams;
+
 typedef struct NvmeAsyncEvent {
     QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
@@ -63,6 +75,7 @@ typedef struct NvmeCtrl {
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
     BlockConf    conf;
+    NvmeParams   params;
=20
     uint32_t    page_size;
     uint16_t    page_bits;
@@ -71,10 +84,8 @@ typedef struct NvmeCtrl {
     uint16_t    sqe_size;
     uint32_t    reg_size;
     uint32_t    num_namespaces;
-    uint32_t    num_queues;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
-    uint32_t    cmb_size_mb;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
@@ -82,7 +93,6 @@ typedef struct NvmeCtrl {
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
=20
-    char            *serial;
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
--=20
2.25.0


