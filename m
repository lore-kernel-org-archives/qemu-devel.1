Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB82B20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lGVNmCGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB82B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv6s-0006bj-0N
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusp-0004WV-JW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusn-0007fI-I9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusn-0007EA-9z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095226euoutp02215108d600f6fb54ee476fb75a682bb0~wKkVD6f_e2946329463euoutp02M
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095226euoutp02215108d600f6fb54ee476fb75a682bb0~wKkVD6f_e2946329463euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809946;
 bh=90T5aXZ77p7epVgAhZ/SZGE7dbi/hUSUZiE0zUo9tuM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=lGVNmCGQIAyuDLdOJBlPs/wzthKUIdrZ2jkyMmtAJYf9H8l3g0pKK798QR2b88Hg2
 2tB6adDPnlx9KWGActyZW2XsZpadgRecBTnfDNEd9AtPAzQ+SF/qI6dI66wXTB3EKx
 8j98Ydg3WEYtBoluVFGdce8R6FAgObtYpKT0ZN4U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095225eucas1p1d4ee6ba0d4730d8357e2b922053f81a1~wKkUzWPFu0922609226eucas1p1O;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 24.EF.60698.9DE393E5; Tue,  4
 Feb 2020 09:52:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095225eucas1p1e44b4de86afdf936e3c7f61359d529ce~wKkUMNzOu0923409234eucas1p1_;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095225eusmtrp205bede8b37945caf53d2e3bdb718fc92~wKkUINZpC0485704857eusmtrp2x;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ff-5e393ed92036
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.CC.08375.9DE393E5; Tue,  4
 Feb 2020 09:52:25 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095225eusmtip1fbfea6d528a69c3c5aef69cdcea8924e~wKkUBrjHH3064230642eusmtip1y;
 Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:24 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:24 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 15/26] nvme: bump supported specification to 1.3
Date: Tue, 4 Feb 2020 10:51:57 +0100
Message-ID: <20200204095208.269131-16-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7o37SzjDLa+MrTY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGdN7JjEWzHWqmHd2AWMD4xyjLkZODgkBE4nZd88wdTFycQgJrGCU
 2PDyCguE84VR4ueVNewQzmdGib8bFrLCtGy/188KkVjOKPFxygo2uKrtfy8zgVQJCZxmlGht
 LYdI7GSUmP94DztIgk1AU2L7n/8sILaIgLRE+9VJYKOYBX4zSsxtnMgGkhAWcJZoPzEZbBKL
 gIrE4sa/QA0cHLwC1hL374ZDnCEvMbvxNFg5J1B4/6oTYOW8AoISJ2c+AZvPDFTTvHU2M4Qt
 IXHwxQtmkF0SArvYJQ62/2CEGOQi8WTqF6jfhCVeHd/CDmHLSPzfOZ8JoqGbUaLvw1eo7hmM
 EtOXfWcDuUgCaHXfmRyIBkeJXXfvs0CE+SRuvBWEWMwnMWnbdGaIMK9ER5sQRLWaxI6mrYwT
 GJVnITl7FpKzZyE5ewEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAhHP63/GvOxj3
 /Uk6xCjAwajEw6vhaBEnxJpYVlyZe4hRgoNZSYT3vL5lnBBvSmJlVWpRfnxRaU5q8SFGaQ4W
 JXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MIdYXj8RcPi7d6fHi3qq1VeX3jF4xsE+uTl1j
 +y4z6NIcrmbxja7i/OfW5ebp6lzgDbEROlBlGtz6w1t2v+0C1itbJpzkn6Qav6OnrfToQZmE
 E3cb2VUOWK082DZrS/iE2vdbJFsPdZ5jObQ8pSps/dZ1k09dqN3bcVCUXzuam+n2p/fqc87/
 VmIpzkg01GIuKk4EAMm/bV80AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7o37SzjDJZv4LLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GdN7
 JjEWzHWqmHd2AWMD4xyjLkZODgkBE4nt9/pZuxi5OIQEljJK9M59xA6RkJH4dOUjlC0s8eda
 FxtE0UdGifc3f0E5pxkl2m5+hnJ2MkrMfLWQGaSFTUBTYvuf/ywgtoiAtET71UmsIDazwG9G
 iT99gSC2sICzRPuJyUwgNouAisTixr9A9RwcvALWEvfvhkNslpeY3XiaDcTmBArvX3WCCaRE
 SMBKovUoN0iYV0BQ4uTMJywQ0+UlmrfOZoawJSQOvnjBPIFReBaSsllIymYhKVvAyLyKUSS1
 tDg3PbfYUK84Mbe4NC9dLzk/dxMjMOa2Hfu5eQfjpY3BhxgFOBiVeHgv2FnECbEmlhVX5h5i
 lOBgVhLhPa9vGSfEm5JYWZValB9fVJqTWnyI0RTotYnMUqLJ+cB0kFcSb2hqaG5haWhubG5s
 ZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTFW/5xKTdYD9fTZV9Zy7LiQV+KkdFmpZ7q2
 +ELNpTGhx8/PS7Z1f2X/dM5k2UVHfqrN3cm8d2ZS9dk1O+91TTH7JnrqhvKRTZPm8zP8MmuK
 v+HgPc/FTP1tos6SZZdXnX/ntbDm5TvJtau26tv8b3sU8piJg2WhUc99UYUr3nMinznsW/Tl
 Bke1EktxRqKhFnNRcSIARCwjIM8CAAA=
X-CMS-MailID: 20200204095225eucas1p1e44b4de86afdf936e3c7f61359d529ce
X-Msg-Generator: CA
X-RootMTR: 20200204095225eucas1p1e44b4de86afdf936e3c7f61359d529ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095225eucas1p1e44b4de86afdf936e3c7f61359d529ce
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095225eucas1p1e44b4de86afdf936e3c7f61359d529ce@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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

Add new fields to the Identify Controller and Identify Namespace data
structures accoding to NVM Express 1.3d.

NVM Express 1.3d requires the following additional features:
  - addition of the Namespace Identification Descriptor List (CNS 03h)
    for the Identify command
  - support for returning Command Sequence Error if a Set Features
    command is submitted for the Number of Queues feature after any I/O
    queues have been created.
  - The addition of the Log Specific Field (LSP) in the Get Log Page
    command.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 57 ++++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h       |  1 +
 hw/block/trace-events |  3 ++-
 include/block/nvme.h  | 20 ++++++++++-----
 4 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 900732bb2f38..4acfc85b56a2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
=20
 /**
- * Reference Specification: NVM Express 1.2.1
+ * Reference Specification: NVM Express 1.3d
  *
  *   https://nvmexpress.org/resources/specifications/
  */
@@ -43,7 +43,7 @@
 #include "trace.h"
 #include "nvme.h"
=20
-#define NVME_SPEC_VER 0x00010201
+#define NVME_SPEC_VER 0x00010300
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
 #define NVME_TEMPERATURE 0x143
 #define NVME_TEMPERATURE_WARNING 0x157
@@ -735,6 +735,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
     uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
     uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  lsp =3D (dw10 >> 8) & 0xf;
     uint8_t  rae =3D (dw10 >> 15) & 0x1;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
@@ -752,7 +753,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
+    trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
@@ -863,6 +864,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
     cq =3D g_malloc0(sizeof(*cq));
     nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
         NVME_CQ_FLAGS_IEN(qflags));
+
+    n->qs_created =3D true;
     return NVME_SUCCESS;
 }
=20
@@ -924,6 +927,47 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, N=
vmeIdentify *c)
     return ret;
 }
=20
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
+{
+    static const int len =3D 4096;
+
+    struct ns_descr {
+        uint8_t nidt;
+        uint8_t nidl;
+        uint8_t rsvd2[2];
+        uint8_t nid[16];
+    };
+
+    uint32_t nsid =3D le32_to_cpu(c->nsid);
+    uint64_t prp1 =3D le64_to_cpu(c->prp1);
+    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+
+    struct ns_descr *list;
+    uint16_t ret;
+
+    trace_nvme_dev_identify_ns_descr_list(nsid);
+
+    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
+        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    /*
+     * Because the NGUID and EUI64 fields are 0 in the Identify Namespac=
e data
+     * structure, a Namespace UUID (nidt =3D 0x3) must be reported in th=
e
+     * Namespace Identification Descriptor. Add a very basic Namespace U=
UID
+     * here.
+     */
+    list =3D g_malloc0(len);
+    list->nidt =3D 0x3;
+    list->nidl =3D 0x10;
+    *(uint32_t *) &list->nid[12] =3D cpu_to_be32(nsid);
+
+    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
+    g_free(list);
+    return ret;
+}
+
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
@@ -935,6 +979,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
         return nvme_identify_ctrl(n, c);
     case 0x02:
         return nvme_identify_ns_list(n, c);
+    case 0x03:
+        return nvme_identify_ns_descr_list(n, cmd);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1133,6 +1179,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        if (n->qs_created) {
+            return NVME_CMD_SEQ_ERROR | NVME_DNR;
+        }
+
         if ((dw11 & 0xffff) =3D=3D 0xffff || ((dw11 >> 16) & 0xffff) =3D=
=3D 0xffff) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
@@ -1267,6 +1317,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
=20
     n->aer_queued =3D 0;
     n->outstanding_aers =3D 0;
+    n->qs_created =3D false;
=20
     blk_flush(n->conf.blk);
     n->bar.cc =3D 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1e715ab1d75c..7ced5fd485a9 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -97,6 +97,7 @@ typedef struct NvmeCtrl {
     BlockConf    conf;
     NvmeParams   params;
=20
+    bool        qs_created;
     uint32_t    page_size;
     uint16_t    page_bits;
     uint16_t    max_prp_ents;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index f982ec1a3221..9e5a4548bde0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -41,6 +41,7 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queu=
e, sqid=3D%"PRIu16""
 nvme_dev_identify_ctrl(void) "identify controller"
 nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
 nvme_dev_identify_ns_list(uint32_t ns) "nsid %"PRIu32""
+nvme_dev_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx=
32""
 nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16=
" fid 0x%"PRIx32" val 0x%"PRIx32""
 nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
@@ -48,7 +49,7 @@ nvme_dev_getfeat_numq(int result) "get feature number o=
f queues, result=3D%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
 nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
-nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, u=
int64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" o=
ff %"PRIu64""
+nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, ui=
nt32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" ra=
e 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 nvme_dev_process_aers(int queued) "queued %d"
 nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
 nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 09419ed499d0..31eb9397d8c6 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -550,7 +550,9 @@ typedef struct NvmeIdCtrl {
     uint32_t    rtd3e;
     uint32_t    oaes;
     uint32_t    ctratt;
-    uint8_t     rsvd100[156];
+    uint8_t     rsvd100[12];
+    uint8_t     fguid[16];
+    uint8_t     rsvd128[128];
     uint16_t    oacs;
     uint8_t     acl;
     uint8_t     aerl;
@@ -568,9 +570,15 @@ typedef struct NvmeIdCtrl {
     uint8_t     tnvmcap[16];
     uint8_t     unvmcap[16];
     uint32_t    rpmbs;
-    uint8_t     rsvd316[4];
+    uint16_t    edstt;
+    uint8_t     dsto;
+    uint8_t     fwug;
     uint16_t    kas;
-    uint8_t     rsvd322[190];
+    uint16_t    hctma;
+    uint16_t    mntmt;
+    uint16_t    mxtmt;
+    uint32_t    sanicap;
+    uint8_t     rsvd332[180];
     uint8_t     sqes;
     uint8_t     cqes;
     uint16_t    maxcmd;
@@ -691,19 +699,19 @@ typedef struct NvmeIdNs {
     uint8_t     rescap;
     uint8_t     fpi;
     uint8_t     dlfeat;
-    uint8_t     rsvd33;
     uint16_t    nawun;
     uint16_t    nawupf;
+    uint16_t    nacwu;
     uint16_t    nabsn;
     uint16_t    nabo;
     uint16_t    nabspf;
-    uint8_t     rsvd46[2];
+    uint16_t    noiob;
     uint8_t     nvmcap[16];
     uint8_t     rsvd64[40];
     uint8_t     nguid[16];
     uint64_t    eui64;
     NvmeLBAF    lbaf[16];
-    uint8_t     res192[192];
+    uint8_t     rsvd192[192];
     uint8_t     vs[3712];
 } NvmeIdNs;
=20
--=20
2.25.0


