Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF498C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B17218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B17218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIcf-0000QK-Or
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIa1-0005aE-2D
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZy-000622-VE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:25 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZr-0005hm-N3; Fri, 05 Jul 2019 03:24:16 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id CE5ACC063F;
 Fri,  5 Jul 2019 07:23:53 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:29 +0200
Message-Id: <20190705072333.17171-13-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 12/16] nvme: bump supported NVMe revision to
 1.3d
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
Cc: kwolf@redhat.com, matt.fitzpatrick@oakgatetech.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the new Namespace Identification Descriptor List (CNS 03h) and track
creation of queues to enable the controller to return Command Sequence
Error if Set Features is called for Number of Queues after any queues
have been created.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 84 ++++++++++++++++++++++++++++++++++++-------
 hw/block/nvme.h       |  1 +
 hw/block/trace-events |  4 ++-
 include/block/nvme.h  | 30 +++++++++++++---
 4 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8259dd7c1d6c..8ad95fdfa261 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,20 +9,22 @@
  */
=20
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.3d, 1.2, 1.1, 1.0e
  *
  *  http://www.nvmexpress.org/resources/
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
@@ -43,6 +45,7 @@
 #define NVME_ELPE 3
 #define NVME_AERL 3
 #define NVME_OP_ABORTED 0xff
+
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
         (trace_##trace)(__VA_ARGS__); \
@@ -316,6 +319,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
+
+    trace_nvme_enqueue_req_completion(req->cqe.cid, cq->cqid);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -534,6 +539,7 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
     if (sq->sqid) {
         g_free(sq);
     }
+    n->qs_created--;
 }
=20
 static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -600,6 +606,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     cq =3D n->cq[cqid];
     QTAILQ_INSERT_TAIL(&(cq->sq_list), sq, entry);
     n->sq[sqid] =3D sq;
+    n->qs_created++;
 }
=20
 static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -649,6 +656,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
     if (cq->cqid) {
         g_free(cq);
     }
+    n->qs_created--;
 }
=20
 static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -689,6 +697,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n,=
 uint64_t dma_addr,
     msix_vector_use(&n->parent_obj, cq->vector);
     n->cq[cqid] =3D cq;
     cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
+    n->qs_created++;
 }
=20
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -762,7 +771,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
         prp1, prp2);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -772,7 +781,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
-    trace_nvme_identify_nslist(min_nsid);
+    trace_nvme_identify_ns_list(min_nsid);
=20
     list =3D g_malloc0(data_len);
     for (i =3D 0; i < n->num_namespaces; i++) {
@@ -789,6 +798,47 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nv=
meIdentify *c)
     return ret;
 }
=20
+static uint16_t nvme_identify_ns_descriptor_list(NvmeCtrl *n, NvmeCmd *c=
)
+{
+    static const int data_len =3D 4 * KiB;
+
+    /*
+     * The device model does not have anywhere to store a persistent UUI=
D, so
+     * conjure up something that is reproducible. We generate an UUID of=
 the
+     * form "00000000-0000-0000-0000-<nsid>", where nsid is similar to, =
say,
+     * 000000000001.
+     */
+    struct ns_descr {
+        uint8_t nidt;
+        uint8_t nidl;
+        uint8_t rsvd[14];
+        uint32_t nid;
+    };
+
+    uint32_t nsid =3D le32_to_cpu(c->nsid);
+    uint64_t prp1 =3D le64_to_cpu(c->prp1);
+    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+
+    struct ns_descr *list;
+    uint16_t ret;
+
+    trace_nvme_identify_ns_descriptor_list(nsid);
+
+    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
+        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    list =3D g_malloc0(data_len);
+    list->nidt =3D 0x3;
+    list->nidl =3D 0x10;
+    list->nid =3D cpu_to_be32(nsid);
+
+    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, data_len, prp1, prp2)=
;
+    g_free(list);
+    return ret;
+}
+
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
@@ -799,7 +849,9 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
     case 0x01:
         return nvme_identify_ctrl(n, c);
     case 0x02:
-        return nvme_identify_nslist(n, c);
+        return nvme_identify_ns_list(n, c);
+    case 0x03:
+        return nvme_identify_ns_descriptor_list(n, cmd);
     default:
         trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -951,6 +1003,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
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
@@ -1798,7 +1858,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
-    id->ver =3D cpu_to_le32(0x00010201);
+    id->ver =3D cpu_to_le32(0x00010300);
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
     id->aerl =3D NVME_AERL;
@@ -1829,7 +1889,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
=20
-    n->bar.vs =3D 0x00010201;
+    n->bar.vs =3D 0x00010300;
     n->bar.intmc =3D n->bar.intms =3D 0;
 }
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index ed3fa3faa718..a502a3dbbbfd 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -95,6 +95,7 @@ typedef struct NvmeCtrl {
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
+    uint32_t    qs_created;
     QEMUTimer   *aer_timer;
     uint8_t     aer_mask;
     uint8_t     aer_mask_queued;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 17485bb0375b..66f6c2c07d20 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -40,7 +40,8 @@ nvme_del_sq(uint16_t qid) "deleting submission queue sq=
id=3D%"PRIu16""
 nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
 nvme_identify_ctrl(void) "identify controller"
 nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
+nvme_identify_ns_list(uint16_t ns) "identify namespace list, nsid=3D%"PR=
Iu16""
+nvme_identify_ns_descriptor_list(uint16_t ns) "identify namespace descri=
ptor list, nsid=3D%"PRIu16""
 nvme_getfeat(uint32_t fid) "fid 0x%"PRIx32""
 nvme_setfeat(uint32_t fid, uint32_t val) "fid 0x%"PRIx32" val 0x%"PRIx32=
""
 nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
@@ -54,6 +55,7 @@ nvme_aer(uint16_t cid) "cid %"PRIu16""
 nvme_aer_aerl_exceeded(void) "aerl exceeded"
 nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
 nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid) "cid %"PRIu16" =
cqid %"PRIu16""
 nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index d24b1f28e0fc..30f1d8b00fc5 100644
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
2.20.1


