Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E57C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470D72089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470D72089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKRD-0004cd-14
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKF1-0007vI-Hf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKEz-0006eX-53
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:47 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKEt-0006EQ-E6; Tue, 15 Oct 2019 06:39:39 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id BFAE8BF926;
 Tue, 15 Oct 2019 10:39:16 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 12/20] nvme: bump supported specification version to 1.3
Date: Tue, 15 Oct 2019 12:38:52 +0200
Message-Id: <20191015103900.313928-13-its@irrelevant.dk>
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

Add the new Namespace Identification Descriptor List (CNS 03h) and track
creation of queues to enable the controller to return Command Sequence
Error if Set Features is called for Number of Queues after any queues
have been created.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 82 +++++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h       |  1 +
 hw/block/trace-events |  8 +++--
 include/block/nvme.h  | 30 +++++++++++++---
 4 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e7d46dcc6afe..1e2320b38b14 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,20 +9,22 @@
  */
=20
 /**
- * Reference Specification: NVM Express 1.2.1
+ * Reference Specification: NVM Express 1.3d
  *
  *   https://nvmexpress.org/resources/specifications/
  */
=20
 /**
  * Usage: add options:
- *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
- *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
- *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
- *              num_queues=3D<N[optional]>
+ *     -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
+ *     -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[option=
al]>
  *
- * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
- * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
+ * Advanced optional options:
+ *
+ *   num_queues=3D<uint32>      : Maximum number of IO Queues.
+ *                              Default: 64
+ *   cmb_size_mb=3D<uint32>     : Size of Controller Memory Buffer in MB=
s.
+ *                              Default: 0 (disabled)
  */
=20
 #include "qemu/osdep.h"
@@ -345,6 +347,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
+
+    trace_nvme_enqueue_req_completion(req->cid, cq->cqid, req->status);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -530,6 +534,7 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
     if (sq->sqid) {
         g_free(sq);
     }
+    n->qs_created--;
 }
=20
 static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -596,6 +601,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     cq =3D n->cq[cqid];
     QTAILQ_INSERT_TAIL(&(cq->sq_list), sq, entry);
     n->sq[sqid] =3D sq;
+    n->qs_created++;
 }
=20
 static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -742,7 +748,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
     uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
-    uint16_t lid =3D dw10 & 0xff;
+    uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  lsp =3D (dw10 >> 8) & 0xf;
     uint8_t  rae =3D (dw10 >> 15) & 0x1;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
@@ -760,7 +767,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    trace_nvme_get_log(req->cid, lid, rae, len, off);
+    trace_nvme_get_log(req->cid, lid, lsp, rae, len, off);
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
@@ -784,6 +791,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
     if (cq->cqid) {
         g_free(cq);
     }
+    n->qs_created--;
 }
=20
 static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -824,6 +832,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n,=
 uint64_t dma_addr,
     msix_vector_use(&n->parent_obj, cq->vector);
     n->cq[cqid] =3D cq;
     cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
+    n->qs_created++;
 }
=20
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -897,7 +906,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
         prp1, prp2);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -907,7 +916,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
-    trace_nvme_identify_nslist(min_nsid);
+    trace_nvme_identify_ns_list(min_nsid);
=20
     list =3D g_malloc0(data_len);
     for (i =3D 0; i < n->num_namespaces; i++) {
@@ -924,6 +933,41 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nv=
meIdentify *c)
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
+    trace_nvme_identify_ns_descr_list(nsid);
+
+    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
+        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
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
@@ -934,7 +978,9 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
     case 0x01:
         return nvme_identify_ctrl(n, c);
     case 0x02:
-        return nvme_identify_nslist(n, c);
+        return nvme_identify_ns_list(n, c);
+    case 0x03:
+        return nvme_identify_ns_descr_list(n, cmd);
     default:
         trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1101,6 +1147,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        if (n->qs_created > 2) {
+            return NVME_CMD_SEQ_ERROR | NVME_DNR;
+        }
+
+        if ((dw11 & 0xffff) =3D=3D 0xffff || ((dw11 >> 16) & 0xffff) =3D=
=3D 0xffff) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
         trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
                                 ((dw11 >> 16) & 0xFFFF) + 1,
                                 n->params.num_queues - 1,
@@ -1816,7 +1870,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
-    id->ver =3D cpu_to_le32(0x00010201);
+    id->ver =3D cpu_to_le32(0x00010300);
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
     id->aerl =3D n->params.aerl;
@@ -1847,7 +1901,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
=20
-    n->bar.vs =3D 0x00010201;
+    n->bar.vs =3D 0x00010300;
     n->bar.intmc =3D n->bar.intms =3D 0;
 }
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index d74b0e0f9b2c..3f7bd627e824 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -102,6 +102,7 @@ typedef struct NvmeCtrl {
     uint16_t    temperature;
     uint8_t     elp_index;
     uint64_t    error_count;
+    uint32_t    qs_created;
=20
     QEMUTimer   *aer_timer;
     uint8_t     aer_mask;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index a20a68d85d5a..f62fa99dc2cd 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -39,8 +39,9 @@ nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t v=
ector, uint16_t size, uin
 nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
 nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
 nvme_identify_ctrl(void) "identify controller"
-nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
+nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
+nvme_identify_ns_list(uint32_t ns) "nsid %"PRIu32""
+nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 nvme_getfeat(uint32_t fid) "fid 0x%"PRIx32""
 nvme_setfeat(uint32_t fid, uint32_t val) "fid 0x%"PRIx32" val 0x%"PRIx32=
""
 nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
@@ -48,12 +49,13 @@ nvme_getfeat_numq(int result) "get feature number of =
queues, result=3D%d"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
 nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
 nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
-nvme_get_log(uint16_t cid, uint16_t lid, uint8_t rae, uint32_t len, uint=
64_t off) "cid %"PRIu16" lid 0x%"PRIx16" rae 0x%"PRIx8" len %"PRIu32" off=
 %"PRIu64""
+nvme_get_log(uint16_t cid, uint16_t lid, uint8_t lsp, uint8_t rae, uint3=
2_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx16" lsp 0x%"PRIx8" rae =
0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 nvme_process_aers(void) "processing aers"
 nvme_aer(uint16_t cid) "cid %"PRIu16""
 nvme_aer_aerl_exceeded(void) "aerl exceeded"
 nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
 nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status=
) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
 nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
 nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9726839f75bb..f0f5728b5ec4 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -550,7 +550,9 @@ typedef struct NvmeIdCtrl {
     uint32_t    rtd3e;
     uint32_t    oaes;
     uint32_t    ctratt;
-    uint8_t     rsvd255[156];
+    uint8_t     rsvd111[12];
+    uint8_t     fguid[16];
+    uint8_t     rsvd255[128];
     uint16_t    oacs;
     uint8_t     acl;
     uint8_t     aerl;
@@ -568,9 +570,15 @@ typedef struct NvmeIdCtrl {
     uint8_t     tnvmcap[16];
     uint8_t     unvmcap[16];
     uint32_t    rpmbs;
-    uint8_t     rsvd319[4];
+    uint16_t    edstt;
+    uint8_t     dsto;
+    uint8_t     fwug;
     uint16_t    kas;
-    uint8_t     rsvd511[190];
+    uint16_t    hctma;
+    uint16_t    mntmt;
+    uint16_t    mxtmt;
+    uint32_t    sanicap;
+    uint8_t     rsvd511[180];
     uint8_t     sqes;
     uint8_t     cqes;
     uint16_t    maxcmd;
@@ -678,7 +686,21 @@ typedef struct NvmeIdNs {
     uint8_t     mc;
     uint8_t     dpc;
     uint8_t     dps;
-    uint8_t     res30[98];
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint8_t     dlfeat;
+    uint16_t    nawun;
+    uint16_t    nawupf;
+    uint16_t    nacwu;
+    uint16_t    nabsn;
+    uint16_t    nabo;
+    uint16_t    nabspf;
+    uint16_t    noiob;
+    uint8_t     nvmcap[16];
+    uint8_t     resv103[40];
+    uint8_t     nguid[16];
+    uint64_t    eui64;
     NvmeLBAF    lbaf[16];
     uint8_t     res192[192];
     uint8_t     vs[3712];
--=20
2.23.0


