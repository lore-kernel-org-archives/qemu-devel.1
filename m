Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCFEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767F2206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gfsRyh4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767F2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwZz-00064W-Ru
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ4-0001os-GG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYz-0007CM-Fl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:00 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYy-0006Uz-Qh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130945euoutp020087ec243ec176f90e7e60f307d131a1~hx8MSMKRa0700607006euoutp02M
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130945euoutp020087ec243ec176f90e7e60f307d131a1~hx8MSMKRa0700607006euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760985;
 bh=NwxlIJdyYXXSXKJZHZ5AKQdjbhk+SrxBM9GxqEaVRZ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=gfsRyh4EpAyV6VXQ041C4/Vr7TA4dab9c5Rpi8siPOLQcaVwlbcfAXOgpcyduMhSg
 06ilewi49/FWlkgUaVQ8ZAousCfFAs9ebuz5j54yyjn4A/QQIadXjQ7+sqJv2axjTl
 RLJkgwf/KRxw09f+y96CGtVfr3eJOcNYybmZzP0w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130945eucas1p2451fdf5ec414debf6c886a2ea6b176e4~hx8MLzrCw0341303413eucas1p25;
 Thu, 19 Dec 2019 13:09:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.5F.60698.9967BFD5; Thu, 19
 Dec 2019 13:09:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130944eucas1p1c2c335692dc0a44467e33afa6aa5e558~hx8L55IJw1260812608eucas1p1h;
 Thu, 19 Dec 2019 13:09:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130944eusmtrp27ea06610164033e4941b53d407b7652b~hx8L5PNNo3120131201eusmtrp2C;
 Thu, 19 Dec 2019 13:09:44 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-6a-5dfb769933a7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.BE.07950.8967BFD5; Thu, 19
 Dec 2019 13:09:44 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130944eusmtip19ba356e1f6b4d0270b2461ca173bb6ae~hx8Lt_TeN2151321513eusmtip1d;
 Thu, 19 Dec 2019 13:09:44 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:43 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:43 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 15/24] nvme: bump supported specification to 1.3
Date: Thu, 19 Dec 2019 14:09:12 +0100
Message-ID: <20191219130921.309264-16-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7ozy37HGhz4x2yxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4Mp4tOokS8F3x4qvC5axNDD+MOxi5OSQEDCRuHPwOVsXIxeHkMAKRokPJ1ayQDhfGCV+
 /OyBcj4zShzZe4EdpuX2loPMEInljBJnHm9kAUmAVXXt84JInGGU2LjyBlTVLkaJP31nWUGq
 2AQ0Jbb/+Q/WISIgLdF+dRIrSBGzwHVGiUO/L4LtEBZwlug61gNmswioSpya0MAEYvMKWEtc
 PbuTDeIOeYmt3z6BDeUEim/pvc0IUSMocXLmE7AFzEA1zVtnM0PYEhIHX7xghuhdxS6xfFsW
 hO0isWbCCkYIW1ji1fEtUH/KSPzfOZ8J5DgJgW5Gib4PX5khnBmMEtOXfQe6ggPIsZboO5MD
 0eAo8fLODnaIMJ/EjbeCEHv5JCZtm84MEeaV6GgTgqhWk9jRtJVxAqPyLCRXz0Jy9SwkVy9g
 ZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmFxO/zv+dQfjvj9JhxgFOBiVeHgd0n7H
 CrEmlhVX5h5ilOBgVhLhvd3xM1aINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZ
 qakFqUUwWSYOTqkGRuFEfq37G8seVLK51KzjLf25b73HZbunh9qyfgQ73IwVzP/zNeqrqula
 aVPfDu/prVfXPO585T/pwUfjthLrQ3Ynt+3RDxA8dIEl2N/12tQgi4s3psgEsc8z3+q/hzdX
 VTrDQdt01vJ1V/sUjx/pXzWDi+Gllh/nxRpe5XOLlj06tfv8J1Pxu0osxRmJhlrMRcWJANBO
 6YEqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7ozyn7HGiw7qWmxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4tOokS8F3x4qvC5ax
 NDD+MOxi5OSQEDCRuL3lIHMXIxeHkMBSRonlH/cyQiRkJD5d+cgOYQtL/LnWxQZR9JFR4lLD
 J2aQhJDAGUaJSQs4IRK7GCVOvN3OBJJgE9CU2P7nPwuILSIgLdF+dRIrSBGzwHVGiUO/L4KN
 FRZwlug61gNmswioSpya0ADWzCtgLXH17E42iNXyElu/fWIFsTmB4lt6bzNCbLaSePzzIwtE
 vaDEyZlPwGxmoPrmrbOZIWwJiYMvXjBPYBSehaRsFpKyWUjKFjAyr2IUSS0tzk3PLTbSK07M
 LS7NS9dLzs/dxAiMsW3Hfm7Zwdj1LvgQowAHoxIPr0Pa71gh1sSy4srcQ4wSHMxKIry3O37G
 CvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MP7zSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJ
 pCeWpGanphakFsH0MXFwSjUwWoisbREue/5SU5EtN/fxyZJbTnelltdqHRc2uroo94ht2u49
 2tfr9za47V36s1A3KODwKwOzE+J7vjx1k+awUBQ0ea4ZN6fdbNV9cYGXO54YLtgpXXNi0+Tb
 oh+UnmVxr/zq5yxymW/DtmixjXZiX57W3a/bqLlEMPVL+es5fNKi+xUNxXZvU2Ipzkg01GIu
 Kk4EAJNOm1/HAgAA
X-CMS-MailID: 20191219130944eucas1p1c2c335692dc0a44467e33afa6aa5e558
X-Msg-Generator: CA
X-RootMTR: 20191219130944eucas1p1c2c335692dc0a44467e33afa6aa5e558
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130944eucas1p1c2c335692dc0a44467e33afa6aa5e558
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130944eucas1p1c2c335692dc0a44467e33afa6aa5e558@eucas1p1.samsung.com>
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
index 040dec234714..6d942c47ce58 100644
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
=20
@@ -733,6 +733,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
     uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
     uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  lsp =3D (dw10 >> 8) & 0xf;
     uint8_t  rae =3D (dw10 >> 15) & 0x1;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
@@ -750,7 +751,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
+    trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
@@ -861,6 +862,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
     cq =3D g_malloc0(sizeof(*cq));
     nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
         NVME_CQ_FLAGS_IEN(qflags));
+
+    n->qs_created =3D true;
     return NVME_SUCCESS;
 }
=20
@@ -922,6 +925,47 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, N=
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
@@ -933,6 +977,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
         return nvme_identify_ctrl(n, c);
     case 0x02:
         return nvme_identify_ns_list(n, c);
+    case 0x03:
+        return nvme_identify_ns_descr_list(n, cmd);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1131,6 +1177,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
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
@@ -1265,6 +1315,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
2.24.1


