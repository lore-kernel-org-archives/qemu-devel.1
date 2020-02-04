Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E552C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3433220674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JqVkGnDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3433220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv9D-0001AV-C8
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusy-0004yD-FJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusv-0007vs-7d
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusu-0007Wn-TK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095232euoutp015632032c0fb5f8597192eff767f21495~wKkasIugG3108931089euoutp01m
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095232euoutp015632032c0fb5f8597192eff767f21495~wKkasIugG3108931089euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809952;
 bh=IazNnu4T3VGBINiCZXkg+2ZtSt/8ULAx2P7cwd2Ta04=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=JqVkGnDHQSyCcviQOT5o3Jz9VVtPTMluinxnuqMivKolvGG9z4IAAik55gbMzqAX9
 o0mkKdhb43p5fpXv1qvX2bJWyid86hr+evJdEZf/6dDkv5qwDPykXySYqB+BgPZTOZ
 K4jWLcBfv9UciOpsA3OdioMFwxrE/FLAUd9xBLQA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095232eucas1p29887cc7138b4620421586ec2edca8c30~wKkal8GX72201922019eucas1p2M;
 Tue,  4 Feb 2020 09:52:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id CB.EF.60698.0EE393E5; Tue,  4
 Feb 2020 09:52:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095231eucas1p1f2b78a655b1a217fe4f7006f79e37f86~wKkaULmHV2086720867eucas1p1H;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095231eusmtrp2e3c3a485dd04d897505b540157bc93e2~wKkaTkZow0489204892eusmtrp2X;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-1b-5e393ee08482
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.7A.07950.FDE393E5; Tue,  4
 Feb 2020 09:52:31 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095231eusmtip1fe697f8904332ae7bc9d9bce809dce56~wKkaI962s3043730437eusmtip1e;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:31 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:30 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 25/26] nvme: remove redundant NvmeCmd pointer parameter
Date: Tue, 4 Feb 2020 10:52:07 +0100
Message-ID: <20200204095208.269131-26-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7oP7CzjDBa2s1ls7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1jug3PHeHSwO7B7ndpxn99i0qpPN4861PWweT65tZvJ4v+8qWwBr
 FJdNSmpOZllqkb5dAlfGkw/32QpOzGCsuL1XsoHxUGkXIyeHhICJxNKjbxi7GLk4hARWMEps
 +bybDcL5wihx8fFlZgjnM6PEn8cb2GFaHrc/gKpaDtTy+h4bXNX70wegWk4zSlw4fRcqs5NR
 4tTMDmaQfjYBTYntf/6zgNgiAtIS7VcnsYIUMQv8ZpSY2ziRDSQhLOAl8XzxcbAGFgEViam3
 /zF1MXJw8ApYS7T0h0DcIS8xu/E0WDknUHj/qhNMIDavgKDEyZlPwOYzA9U0b53NDGFLSBx8
 8YIZoncbu8S+qe4QtovEj/4DjBC2sMSr41ug/pSR+L9zPhPIbRIC3YwSfR++MkM4Mxglpi/7
 zgZykATQ5r4zORANjhIvr69khAjzSdx4Kwixl09i0rbpzBBhXomONiGIajWJHU1bGScwKs9C
 cvUsJFfPQnL1AkbmVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIEJ5/S/4193MO77k3SI
 UYCDUYmHV8PRIk6INbGsuDL3EKMEB7OSCO95fcs4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzG
 i17GCgmkJ5akZqemFqQWwWSZODilGhjNt3UePjOVa/Z+lcp7OUX1LVE/TjsffP1vffK6xNiJ
 jZ2XRR32Wgb+3nb7+I/L+q4X5l71UA+3feEofHXNscdKC783uYssaeILXX/ilEJ8eZDK1N1i
 kUeMK8Ku6Zur9yc89DT7G7br25GU9MdKAbxnbdeKe774vtBsZ+UV/YtK5QZWUY/qVNKUWIoz
 Eg21mIuKEwEjTTIeNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7r37SzjDL7c1LXY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GU8+
 3GcrODGDseL2XskGxkOlXYycHBICJhKP2x+wdTFycQgJLGWUmHnuNiNEQkbi05WP7BC2sMSf
 a11QRR8ZJWZP2sEO4ZxmlNjd1coE4exklGjc9BushU1AU2L7n/8sILaIgLRE+9VJrCA2s8Bv
 Rok/fYEgtrCAl8TzxceZQWwWARWJqbf/AQ3i4OAVsJZo6Q+B2CwvMbvxNBuIzQkU3r/qBFiJ
 kICVROtRbpAwr4CgxMmZT1ggpstLNG+dzQxhS0gcfPGCeQKj8CwkZbOQlM1CUraAkXkVo0hq
 aXFuem6xkV5xYm5xaV66XnJ+7iZGYMxtO/Zzyw7GrnfBhxgFOBiVeHg1HC3ihFgTy4orcw8x
 SnAwK4nwnte3jBPiTUmsrEotyo8vKs1JLT7EaAr02kRmKdHkfGA6yCuJNzQ1NLewNDQ3Njc2
 s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwJj6ul099NWpigu8+XXLvGVmKTzWdHZWsecq
 MHPwkLi+hff+kc4TwU0P4l9+O/hWstiBx1RRIzDtZdAdu2k/g6wPKZb9mi97VqTj9N175498
 +dNek+y0vaQzLmPxmivGHN+Tc7dkalt6dYq+FDFrtmH6HZB6x+dH/eFnouUTHc5P/2OQ+Xb9
 YSWW4oxEQy3mouJEAHgBD8LPAgAA
X-CMS-MailID: 20200204095231eucas1p1f2b78a655b1a217fe4f7006f79e37f86
X-Msg-Generator: CA
X-RootMTR: 20200204095231eucas1p1f2b78a655b1a217fe4f7006f79e37f86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095231eucas1p1f2b78a655b1a217fe4f7006f79e37f86
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095231eucas1p1f2b78a655b1a217fe4f7006f79e37f86@eucas1p1.samsung.com>
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

The command struct is available in the NvmeRequest that we generally
pass around anyway.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 198 ++++++++++++++++++++++++------------------------
 1 file changed, 98 insertions(+), 100 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index bdef53a590b0..5fe2e2fe1fa9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -566,16 +566,18 @@ unmap:
 }
=20
 static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-    NvmeCmd *cmd, DMADirection dir, NvmeRequest *req)
+    DMADirection dir, NvmeRequest *req)
 {
     uint16_t status =3D NVME_SUCCESS;
     size_t bytes;
+    uint64_t prp1, prp2;
=20
-    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
     case PSDT_PRP:
-        status =3D nvme_map_prp(n, &req->qsg, &req->iov,
-            le64_to_cpu(cmd->dptr.prp.prp1), le64_to_cpu(cmd->dptr.prp.p=
rp2),
-            len, req);
+        prp1 =3D le64_to_cpu(req->cmd.dptr.prp.prp1);
+        prp2 =3D le64_to_cpu(req->cmd.dptr.prp.prp2);
+
+        status =3D nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len=
, req);
         if (status) {
             return status;
         }
@@ -589,7 +591,7 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, u=
int32_t len,
             return NVME_INVALID_FIELD;
         }
=20
-        status =3D nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, =
len,
+        status =3D nvme_map_sgl(n, &req->qsg, &req->iov, req->cmd.dptr.s=
gl, len,
             req);
         if (status) {
             return status;
@@ -632,20 +634,21 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr,=
 uint32_t len,
     return status;
 }
=20
-static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_map(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t len =3D req->nlb << nvme_ns_lbads(req->ns);
     uint64_t prp1, prp2;
=20
-    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
     case PSDT_PRP:
-        prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
-        prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+        prp1 =3D le64_to_cpu(req->cmd.dptr.prp.prp1);
+        prp2 =3D le64_to_cpu(req->cmd.dptr.prp.prp2);
=20
         return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, re=
q);
     case PSDT_SGL_MPTR_CONTIGUOUS:
     case PSDT_SGL_MPTR_SGL:
-        return nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len,=
 req);
+        return nvme_map_sgl(n, &req->qsg, &req->iov, req->cmd.dptr.sgl, =
len,
+            req);
     default:
         return NVME_INVALID_FIELD;
     }
@@ -1024,7 +1027,7 @@ static void nvme_aio_cb(void *opaque, int ret)
     nvme_aio_destroy(aio);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns =3D req->ns;
     NvmeAIO *aio =3D g_new0(NvmeAIO, 1);
@@ -1040,12 +1043,12 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeAIO *aio;
=20
     NvmeNamespace *ns =3D req->ns;
-    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
=20
     int64_t offset;
     size_t count;
@@ -1081,9 +1084,9 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
     NvmeNamespace *ns =3D req->ns;
     int status;
=20
@@ -1103,7 +1106,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, =
NvmeRequest *req)
         return status;
     }
=20
-    status =3D nvme_map(n, cmd, req);
+    status =3D nvme_map(n, req);
     if (status) {
         block_acct_invalid(blk_get_stats(ns->blk), acct);
         return status;
@@ -1115,12 +1118,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
),
-        cmd->opcode);
+        req->cmd.opcode);
=20
     req->ns =3D nvme_ns(n, nsid);
=20
@@ -1128,16 +1131,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return nvme_nsid_err(n, nsid);
     }
=20
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, cmd, req);
+        return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROS:
-        return nvme_write_zeros(n, cmd, req);
+        return nvme_write_zeros(n, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, cmd, req);
+        return nvme_rw(n, req);
     default:
-        trace_nvme_dev_err_invalid_opc(cmd->opcode);
+        trace_nvme_dev_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -1153,10 +1156,10 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl=
 *n)
     }
 }
=20
-static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c =3D (NvmeDeleteQ *)cmd;
-    NvmeRequest *req, *next;
+    NvmeDeleteQ *c =3D (NvmeDeleteQ *) &req->cmd;
+    NvmeRequest *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
     NvmeAIO *aio;
@@ -1224,10 +1227,10 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl=
 *n, uint64_t dma_addr,
     n->sq[sqid] =3D sq;
 }
=20
-static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
-    NvmeCreateSq *c =3D (NvmeCreateSq *)cmd;
+    NvmeCreateSq *c =3D (NvmeCreateSq *) &req->cmd;
=20
     uint16_t cqid =3D le16_to_cpu(c->cqid);
     uint16_t sqid =3D le16_to_cpu(c->sqid);
@@ -1262,10 +1265,10 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeC=
md *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
-    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_l=
en,
+    uint64_t off, NvmeRequest *req)
 {
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     uint32_t trans_len;
     time_t current_ms;
@@ -1320,12 +1323,12 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma(n, (uint8_t *) &smart + off, trans_len, cmd,
+    return nvme_dma(n, (uint8_t *) &smart + off, trans_len,
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
-    uint64_t off, NvmeRequest *req)
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t=
 off,
+    NvmeRequest *req)
 {
     uint32_t trans_len;
     NvmeFwSlotInfoLog fw_log;
@@ -1338,16 +1341,16 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, Nvm=
eCmd *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len, cmd,
+    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
-    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
-    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
-    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 =3D le32_to_cpu(req->cmd.cdw11);
+    uint32_t dw12 =3D le32_to_cpu(req->cmd.cdw12);
+    uint32_t dw13 =3D le32_to_cpu(req->cmd.cdw13);
     uint8_t  lid =3D dw10 & 0xff;
     uint8_t  lsp =3D (dw10 >> 8) & 0xf;
     uint8_t  rae =3D (dw10 >> 15) & 0x1;
@@ -1387,9 +1390,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
=20
         return NVME_SUCCESS;
     case NVME_LOG_SMART_INFO:
-        return nvme_smart_info(n, cmd, rae, len, off, req);
+        return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
-        return nvme_fw_log_info(n, cmd, len, off, req);
+        return nvme_fw_log_info(n, len, off, req);
     default:
         trace_nvme_dev_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1407,9 +1410,9 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *=
n)
     }
 }
=20
-static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c =3D (NvmeDeleteQ *)cmd;
+    NvmeDeleteQ *c =3D (NvmeDeleteQ *) &req->cmd;
     NvmeCQueue *cq;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
@@ -1447,10 +1450,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl=
 *n, uint64_t dma_addr,
     cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
 }
=20
-static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-    NvmeCreateCq *c =3D (NvmeCreateCq *)cmd;
+    NvmeCreateCq *c =3D (NvmeCreateCq *) &req->cmd;
     uint16_t cqid =3D le16_to_cpu(c->cqid);
     uint16_t vector =3D le16_to_cpu(c->irq_vector);
     uint16_t qsize =3D le16_to_cpu(c->qsize);
@@ -1489,18 +1492,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeC=
md *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeReques=
t *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_identify_ctrl();
=20
-    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl), cmd,
+    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl),
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdNs *id_ns, inactive =3D { 0 };
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
     NvmeNamespace *ns =3D nvme_ns(n, nsid);
=20
     trace_nvme_dev_identify_ns(nsid);
@@ -1517,15 +1520,14 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eCmd *cmd, NvmeRequest *req)
         id_ns =3D &ns->id_ns;
     }
=20
-    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs), cmd,
+    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs),
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
-    uint32_t min_nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t min_nsid =3D le32_to_cpu(req->cmd.nsid);
     uint32_t *list;
     uint16_t ret;
     int i, j =3D 0;
@@ -1542,14 +1544,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
, NvmeCmd *cmd,
             break;
         }
     }
-    ret =3D nvme_dma(n, (uint8_t *) list, data_len, cmd,
+    ret =3D nvme_dma(n, (uint8_t *) list, data_len,
         DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
 {
     static const int len =3D 4096;
=20
@@ -1560,7 +1561,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeCmd *cmd,
         uint8_t nid[16];
     };
=20
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     struct ns_descr *list;
     uint16_t ret;
@@ -1582,34 +1583,33 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeCmd *cmd,
     list->nidl =3D 0x10;
     *(uint32_t *) &list->nid[12] =3D cpu_to_be32(nsid);
=20
-    ret =3D nvme_dma(n, (uint8_t *) list, len, cmd, DMA_DIRECTION_FROM_D=
EVICE,
-        req);
+    ret =3D nvme_dma(n, (uint8_t *) list, len, DMA_DIRECTION_FROM_DEVICE=
, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c =3D (NvmeIdentify *)cmd;
+    NvmeIdentify *c =3D (NvmeIdentify *) &req->cmd;
=20
     switch (le32_to_cpu(c->cns)) {
     case 0x00:
-        return nvme_identify_ns(n, cmd, req);
+        return nvme_identify_ns(n, req);
     case 0x01:
-        return nvme_identify_ctrl(n, cmd, req);
+        return nvme_identify_ctrl(n, req);
     case 0x02:
-        return nvme_identify_ns_list(n, cmd, req);
+        return nvme_identify_ns_list(n, req);
     case 0x03:
-        return nvme_identify_ns_descr_list(n, cmd, req);
+        return nvme_identify_ns_descr_list(n, req);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
=20
-static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint16_t sqid =3D le32_to_cpu(cmd->cdw10) & 0xffff;
+    uint16_t sqid =3D le32_to_cpu(req->cmd.cdw10) & 0xffff;
=20
     req->cqe.result =3D 1;
     if (nvme_check_sqid(n, sqid)) {
@@ -1659,19 +1659,18 @@ static inline uint64_t nvme_get_timestamp(const N=
vmeCtrl *n)
     return cpu_to_le64(ts.all);
 }
=20
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req=
)
 {
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp), cmd,
+    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
-    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 =3D le32_to_cpu(req->cmd.cdw11);
     uint32_t result;
=20
     trace_nvme_dev_getfeat(nvme_cid(req), dw10);
@@ -1717,7 +1716,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd, req);
+        return nvme_get_feature_timestamp(n, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1743,13 +1742,12 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvm=
eCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req=
)
 {
     uint16_t ret;
     uint64_t timestamp;
=20
-    ret =3D nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp), cmd,
+    ret =3D nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp),
         DMA_DIRECTION_TO_DEVICE, req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
@@ -1760,12 +1758,12 @@ static uint16_t nvme_set_feature_timestamp(NvmeCt=
rl *n, NvmeCmd *cmd,
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
=20
-    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
-    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 =3D le32_to_cpu(req->cmd.cdw11);
=20
     trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
=20
@@ -1824,7 +1822,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
             ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd, req);
+        return nvme_set_feature_timestamp(n, req);
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
@@ -1843,7 +1841,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_aer(nvme_cid(req));
=20
@@ -1862,31 +1860,31 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *r=
eq)
+static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
-        return nvme_del_sq(n, cmd);
+        return nvme_del_sq(n, req);
     case NVME_ADM_CMD_CREATE_SQ:
-        return nvme_create_sq(n, cmd);
+        return nvme_create_sq(n, req);
     case NVME_ADM_CMD_GET_LOG_PAGE:
-        return nvme_get_log(n, cmd, req);
+        return nvme_get_log(n, req);
     case NVME_ADM_CMD_DELETE_CQ:
-        return nvme_del_cq(n, cmd);
+        return nvme_del_cq(n, req);
     case NVME_ADM_CMD_CREATE_CQ:
-        return nvme_create_cq(n, cmd);
+        return nvme_create_cq(n, req);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd, req);
+        return nvme_identify(n, req);
     case NVME_ADM_CMD_ABORT:
-        return nvme_abort(n, cmd, req);
+        return nvme_abort(n, req);
     case NVME_ADM_CMD_SET_FEATURES:
-        return nvme_set_feature(n, cmd, req);
+        return nvme_set_feature(n, req);
     case NVME_ADM_CMD_GET_FEATURES:
-        return nvme_get_feature(n, cmd, req);
+        return nvme_get_feature(n, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
-        return nvme_aer(n, cmd, req);
+        return nvme_aer(n, req);
     default:
-        trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
+        trace_nvme_dev_err_invalid_admin_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -1919,8 +1917,8 @@ static void nvme_process_sq(void *opaque)
         req->cqe.cid =3D cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
=20
-        status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
-            nvme_admin_cmd(n, &cmd, req);
+        status =3D sq->sqid ? nvme_io_cmd(n, req) :
+            nvme_admin_cmd(n, req);
         if (status !=3D NVME_NO_COMPLETE) {
             req->status =3D status;
             nvme_enqueue_req_completion(cq, req);
--=20
2.25.0


