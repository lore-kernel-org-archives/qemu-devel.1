Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E49EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E1420663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L3YZWQuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E1420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwV7-0005Cm-Rp
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZD-0001wl-F8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ8-0007Ns-IH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:10 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvZ7-00071z-Vm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:06 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130951euoutp029e2dbd1ffaa9af638e8cf612eb8d7f3a~hx8RvtPlG0791707917euoutp02D
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130951euoutp029e2dbd1ffaa9af638e8cf612eb8d7f3a~hx8RvtPlG0791707917euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760991;
 bh=vYoVWM25vloxEIG2CPdP0C89+YmfF6tF705MuMM7siA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=L3YZWQuqBQNjJjN/ZcC2whMx6LFcD10v21cwvBrbXFrEuPMIe1aqGZRkdMvU/kIfg
 LABGxgrY+IsTB1NNxGF3GnRao5p6eggPK68ZCWna26V2XAOUNEQQszRRfHNYP0HpvN
 f1OubzOjXewm88jZdXfu1zqtJC2ADnTl4qkLp2FY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130950eucas1p1d3cbfd465eaa16af953a956972811c91~hx8RagrV91797517975eucas1p1r;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.00.61286.E967BFD5; Thu, 19
 Dec 2019 13:09:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130950eucas1p2333a6d25cb3539362b4e8dc77ebde1d6~hx8Q-7dfs0349703497eucas1p2Z;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130950eusmtrp245ee9e2138aa40c0c174c1b52cc8fc9d~hx8Q-Wk373120131201eusmtrp2d;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-7d-5dfb769ec557
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.4D.08375.E967BFD5; Thu, 19
 Dec 2019 13:09:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130950eusmtip2fe52749635bd8e3ac848de0f2a846ff7~hx8QzWQ4U3240732407eusmtip27;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:49 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:49 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 23/24] nvme: remove redundant NvmeCmd pointer parameter
Date: Thu, 19 Dec 2019 14:09:20 +0100
Message-ID: <20191219130921.309264-24-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7rzyn7HGjx9r2yxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4MqY3r+YpWDFTMaKrUe3sDUwzivrYuTkkBAwkfix5gZTFyMXh5DACkaJ5/Mb2SGcL4wS
 rd/vsEE4nxklpt58zQrT8unAe0aIxHJGib5l31jgqr6vecwIUiUkcIZRYtpZRYjELkaJVauf
 g7WzCWhKbP/znwXEFhGQlmi/OokVpIhZ4DqjxKHfF9lBEsICXhJzVu8HK2IRUJWY0PqDGcTm
 FbCWuLGniR3iDnmJrd8+gQ3lBIpv6b3NCFEjKHFy5hOwXmagmuats5khbAmJgy9eMIMskxBY
 xS5x6/gdRohBLhJfl62Bek5Y4tXxLVALZCT+75zPBNHQDfToh69Q3TMYJaYv+w4MGw4gx1qi
 70wORIOjxIsmkM0gYT6JG28FIRbzSUzaNp0ZIswr0dEmBFGtJrGjaSvjBEblWUjOnoXk7FlI
 zl7AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMMGc/nf80w7Gr5eSDjEKcDAq8fA6
 pP2OFWJNLCuuzD3EKMHBrCTCe7vjZ6wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNIT
 S1KzU1MLUotgskwcnFINjBZbj/4S3f9pSsr858a6DIwe+eX/bhw7reZQ73r2f9G/ymNf/R/l
 ZeXuVpqTUaBTtvLitgl7O27J3jrltjagpqX0QYLbk0Os5bJd5aeYp0w6XOn47HSyr9tCpa1T
 jf/t7ymunjG9WjjXyqtbziHk5NTINSEhO39d3f7/9vITAjecl9zKe2h9tluJpTgj0VCLuag4
 EQDBCXc7LAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7rzyn7HGpxYxGWxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuY3r+YpWDFTMaKrUe3
 sDUwzivrYuTkkBAwkfh04D1jFyMXh5DAUkaJpzsOM0MkZCQ+XfnIDmELS/y51sUGUfSRUeLx
 lkfMEM4ZRokrH9dAte9ilHiz/x4bSAubgKbE9j//WUBsEQFpifark1hBipgFrjNKHPp9EWyu
 sICXxJzV+8GKWARUJSa0/gDbzStgLXFjTxPUbnmJrd8+sYLYnEDxLb23GUFsIQEricc/P7JA
 1AtKnJz5BMxmBqpv3jqbGcKWkDj44gXzBEbhWUjKZiEpm4WkbAEj8ypGkdTS4tz03GJDveLE
 3OLSvHS95PzcTYzAONt27OfmHYyXNgYfYhTgYFTi4X2Z/DtWiDWxrLgy9xCjBAezkgjv7Y6f
 sUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wBeSXxhqaG5haWhubG5sZmFkrivB0CB2OE
 BNITS1KzU1MLUotg+pg4OKUaGCWX3WaLSt4g/1tC6PKqTUZ3ZD7+2rXwn8u1HMbH4qv5bOyn
 L7D4a/qhdn7Ffcfv7H5ZaSvXHj9pa6r+r/Gf35bl3pv8jGO/ndCfISLxh6fnbE/DZ4+FsUE1
 vb9nm3MGT44PPFn+pCb0za6pL8snaB0uEWdYaxv9tNbMIHP+zooj5nXsb7zVlZRYijMSDbWY
 i4oTAfs67UnJAgAA
X-CMS-MailID: 20191219130950eucas1p2333a6d25cb3539362b4e8dc77ebde1d6
X-Msg-Generator: CA
X-RootMTR: 20191219130950eucas1p2333a6d25cb3539362b4e8dc77ebde1d6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130950eucas1p2333a6d25cb3539362b4e8dc77ebde1d6
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130950eucas1p2333a6d25cb3539362b4e8dc77ebde1d6@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command struct is available in the NvmeRequest that we generally
pass around anyway.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 198 ++++++++++++++++++++++++------------------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 68c433415169..0ebb9aabbeb2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -568,17 +568,20 @@ unmap:
 }
=20
 static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-    NvmeCmd *cmd, DMADirection dir, NvmeRequest *req)
+    DMADirection dir, NvmeRequest *req)
 {
     QEMUSGList qsg;
     QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
     size_t bytes;
+    uint64_t prp1, prp2;
=20
-    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
     case PSDT_PRP:
-        status =3D nvme_map_prp(n, &qsg, &iov, le64_to_cpu(cmd->dptr.prp=
.prp1),
-            le64_to_cpu(cmd->dptr.prp.prp2), len, req);
+        prp1 =3D le64_to_cpu(req->cmd.dptr.prp.prp1);
+        prp2 =3D le64_to_cpu(req->cmd.dptr.prp.prp2);
+
+        status =3D nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
         if (status) {
             return status;
         }
@@ -592,7 +595,7 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, u=
int32_t len,
             return NVME_INVALID_FIELD;
         }
=20
-        status =3D nvme_map_sgl(n, &qsg, &iov, cmd->dptr.sgl, len, req);
+        status =3D nvme_map_sgl(n, &qsg, &iov, req->cmd.dptr.sgl, len, r=
eq);
         if (status) {
             return status;
         }
@@ -638,20 +641,21 @@ static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr,=
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
@@ -1047,7 +1051,7 @@ static void nvme_aio_cb(void *opaque, int ret)
     nvme_aio_destroy(aio);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns =3D req->ns;
     NvmeAIO *aio =3D nvme_aio_new(ns->blk, 0x0, 0, NULL, NULL, req, NULL=
);
@@ -1058,12 +1062,12 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *=
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
@@ -1092,9 +1096,9 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeC=
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
@@ -1114,7 +1118,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, =
NvmeRequest *req)
         return status;
     }
=20
-    status =3D nvme_map(n, cmd, req);
+    status =3D nvme_map(n, req);
     if (status) {
         block_acct_invalid(blk_get_stats(ns->blk), acct);
         return status;
@@ -1126,11 +1130,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd=
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
-    trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
), cmd->opcode);
+    trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
),
+        req->cmd.opcode);
=20
     req->ns =3D nvme_ns(n, nsid);
=20
@@ -1138,16 +1143,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd =
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
@@ -1163,10 +1168,10 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl=
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
@@ -1234,10 +1239,10 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl=
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
@@ -1272,10 +1277,10 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeC=
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
@@ -1330,12 +1335,12 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
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
@@ -1348,16 +1353,16 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, Nvm=
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
@@ -1397,9 +1402,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *=
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
@@ -1417,9 +1422,9 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *=
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
@@ -1457,10 +1462,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl=
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
@@ -1499,18 +1504,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeC=
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
@@ -1527,15 +1532,14 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
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
@@ -1552,14 +1556,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
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
@@ -1570,7 +1573,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeCmd *cmd,
         uint8_t nid[16];
     };
=20
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     struct ns_descr *list;
     uint16_t ret;
@@ -1592,34 +1595,33 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
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
@@ -1669,19 +1671,18 @@ static inline uint64_t nvme_get_timestamp(const N=
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
@@ -1727,7 +1728,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd, req);
+        return nvme_get_feature_timestamp(n, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1753,13 +1754,12 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvm=
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
@@ -1770,12 +1770,12 @@ static uint16_t nvme_set_feature_timestamp(NvmeCt=
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
@@ -1834,7 +1834,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
             ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd, req);
+        return nvme_set_feature_timestamp(n, req);
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
@@ -1853,7 +1853,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_aer(nvme_cid(req));
=20
@@ -1872,31 +1872,31 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cm=
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
@@ -1931,8 +1931,8 @@ static void nvme_process_sq(void *opaque)
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
2.24.1


