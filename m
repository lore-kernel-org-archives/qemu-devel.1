Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B4C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459B92082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459B92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYYa-00030w-F4
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:49:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTR-0007eK-3A
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTM-0006CO-GD
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:16 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT8-0005ts-Sp; Fri, 17 May 2019 04:43:59 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id E0D15C069A;
	Fri, 17 May 2019 08:43:55 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:28 +0200
Message-Id: <20190517084234.26923-3-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 2/8] nvme: bump supported spec to 1.3
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bump the supported NVMe version to 1.3. To do so, this patch adds a
number of missing 'Mandatory' features from the spec:

  * Support for returning a Namespace Identification Descriptor List in
    the Identify command (CNS 03h).
  * Support for the Asynchronous Event Request command.
  * Support for the Get Log Page command and the mandatory Error
    Information, Smart / Health Information and Firmware Slot
    Information log pages.
  * Support for the Abort command.

As a side-effect, this bump also fixes support for multiple namespaces.

The implementation of AER, Get Log Page and Abort commands has been
imported and slightly modified from Keith's qemu-nvme tree[1]. Thanks!

  [1]: http://git.infradead.org/users/kbusch/qemu-nvme.git

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 792 ++++++++++++++++++++++++++++++++++++------
 hw/block/nvme.h       |  31 +-
 hw/block/trace-events |  16 +-
 include/block/nvme.h  |  58 +++-
 4 files changed, 783 insertions(+), 114 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b689c0776e72..65dfc04f71e5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,17 +9,35 @@
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
+ *
+ * The "file" option must point to a path to a real file that you will u=
se as
+ * the backing storage for your NVMe device. It must be a non-zero lengt=
h, as
+ * this will be the disk image that your nvme controller will use to car=
ve up
+ * namespaces for storage.
+ *
+ * Note the "drive" option's "id" name must match the "device nvme" driv=
e's
+ * name to link the block device used for backing storage to the nvme
+ * interface.
+ *
+ * Advanced optional options:
+ *
+ *   num_ns=3D<int>          : Namespaces to make out of the backing sto=
rage,
+ *                           Default:1
+ *   num_queues=3D<int>      : Number of possible IO Queues, Default:64
+ *   cmb_size_mb=3D<int>     : Size of CMB in MBs, Default:0
+ *
+ * Parameters will be verified against conflicting capabilities and attr=
ibutes
+ * and fail to load if there is a conflict or a configuration the emulat=
ed
+ * device is unable to handle.
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -38,6 +56,12 @@
 #include "trace.h"
 #include "nvme.h"
=20
+#define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
+#define NVME_TEMPERATURE 0x143
+#define NVME_ELPE 3
+#define NVME_AERL 3
+#define NVME_OP_ABORTED 0xff
+
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
         (trace_##trace)(__VA_ARGS__); \
@@ -57,6 +81,16 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, v=
oid *buf, int size)
     }
 }
=20
+static void nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf, int siz=
e)
+{
+    if (n->cmbsz && addr >=3D n->ctrl_mem.addr &&
+                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size=
))) {
+        memcpy((void *)&n->cmbuf[addr - n->ctrl_mem.addr], buf, size);
+        return;
+    }
+    pci_dma_write(&n->parent_obj, addr, buf, size);
+}
+
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
     return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
@@ -244,6 +278,24 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8=
_t *ptr, uint32_t len,
     return status;
 }
=20
+static void nvme_post_cqe(NvmeCQueue *cq, NvmeRequest *req)
+{
+    NvmeCtrl *n =3D cq->ctrl;
+    NvmeSQueue *sq =3D req->sq;
+    NvmeCqe *cqe =3D &req->cqe;
+    uint8_t phase =3D cq->phase;
+    hwaddr addr;
+
+    addr =3D cq->dma_addr + cq->tail * n->cqe_size;
+    cqe->status =3D cpu_to_le16((req->status << 1) | phase);
+    cqe->sq_id =3D cpu_to_le16(sq->sqid);
+    cqe->sq_head =3D cpu_to_le16(sq->head);
+    nvme_addr_write(n, addr, (void *) cqe, sizeof(*cqe));
+    nvme_inc_cq_tail(cq);
+
+    QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq =3D opaque;
@@ -251,24 +303,14 @@ static void nvme_post_cqes(void *opaque)
     NvmeRequest *req, *next;
=20
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
-        NvmeSQueue *sq;
-        hwaddr addr;
-
         if (nvme_cq_full(cq)) {
             break;
         }
=20
         QTAILQ_REMOVE(&cq->req_list, req, entry);
-        sq =3D req->sq;
-        req->cqe.status =3D cpu_to_le16((req->status << 1) | cq->phase);
-        req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
-        req->cqe.sq_head =3D cpu_to_le16(sq->head);
-        addr =3D cq->dma_addr + cq->tail * n->cqe_size;
-        nvme_inc_cq_tail(cq);
-        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
-            sizeof(req->cqe));
-        QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
+        nvme_post_cqe(cq, req);
     }
+
     if (cq->tail !=3D cq->head) {
         nvme_irq_assert(n, cq);
     }
@@ -277,11 +319,88 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
+
+    trace_nvme_enqueue_req_completion(req->cqe.cid, cq->cqid);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
 }
=20
+static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
+    uint8_t event_info, uint8_t log_page)
+{
+    NvmeAsyncEvent *event;
+
+    trace_nvme_enqueue_event(event_type, event_info, log_page);
+
+    /*
+     * Do not enqueue the event if something of this type is already que=
ued.
+     * This bounds the size of the event queue and makes sure it does no=
t grow
+     * indefinitely when events are not processed by the host (i.e. does=
 not
+     * issue any AERs).
+     */
+    if (n->aer_mask_queued & (1 << event_type)) {
+        return;
+    }
+    n->aer_mask_queued |=3D (1 << event_type);
+
+    event =3D g_new(NvmeAsyncEvent, 1);
+    event->result =3D (NvmeAerResult) {
+        .event_type =3D event_type,
+        .event_info =3D event_info,
+        .log_page   =3D log_page,
+    };
+
+    QSIMPLEQ_INSERT_TAIL(&n->aer_queue, event, entry);
+
+    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500)=
;
+}
+
+static void nvme_process_aers(void *opaque)
+{
+    NvmeCtrl *n =3D opaque;
+    NvmeRequest *req;
+    NvmeAerResult *result;
+    NvmeAsyncEvent *event, *next;
+
+    trace_nvme_process_aers();
+
+    QSIMPLEQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
+        /* can't post cqe if there is nothing to complete */
+        if (!n->outstanding_aers) {
+            trace_nvme_no_outstanding_aers();
+            break;
+        }
+
+        /* ignore if masked (cqe posted, but event not cleared) */
+        if (n->aer_mask & (1 << event->result.event_type)) {
+            trace_nvme_aer_masked(event->result.event_type, n->aer_mask)=
;
+            continue;
+        }
+
+        QSIMPLEQ_REMOVE_HEAD(&n->aer_queue, entry);
+
+        n->aer_mask |=3D 1 << event->result.event_type;
+        n->aer_mask_queued &=3D ~(1 << event->result.event_type);
+        n->outstanding_aers--;
+
+        req =3D n->aer_reqs[n->outstanding_aers];
+
+        result =3D (NvmeAerResult *) &req->cqe.result;
+        result->event_type =3D event->result.event_type;
+        result->event_info =3D event->result.event_info;
+        result->log_page =3D event->result.log_page;
+        g_free(event);
+
+        req->status =3D NVME_SUCCESS;
+
+        trace_nvme_aer_post_cqe(result->event_type, result->event_info,
+            result->log_page);
+
+        nvme_enqueue_req_completion(&n->admin_cq, req);
+    }
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req =3D opaque;
@@ -318,7 +437,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNam=
espace *ns, NvmeCmd *cmd,
 {
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
     const uint8_t lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
+    const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].lbads;
     uint64_t slba =3D le64_to_cpu(rw->slba);
     uint32_t nlb  =3D le16_to_cpu(rw->nlb) + 1;
     uint64_t offset =3D slba << data_shift;
@@ -347,9 +466,9 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
     uint64_t prp2 =3D le64_to_cpu(rw->prp2);
=20
     uint8_t lba_index  =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
+    uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].lbads;
     uint64_t data_size =3D (uint64_t)nlb << data_shift;
-    uint64_t data_offset =3D slba << data_shift;
+    uint64_t data_offset =3D ns->blk_offset + (slba << data_shift);
     int is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
=20
@@ -391,8 +510,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
-    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+    if (unlikely(nsid =3D=3D 0 || nsid > n->params.num_ns)) {
+        trace_nvme_err_invalid_ns(nsid, n->params.num_ns);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
@@ -420,6 +539,7 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
     if (sq->sqid) {
         g_free(sq);
     }
+    n->qs_created--;
 }
=20
 static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -486,6 +606,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     cq =3D n->cq[cqid];
     QTAILQ_INSERT_TAIL(&(cq->sq_list), sq, entry);
     n->sq[sqid] =3D sq;
+    n->qs_created++;
 }
=20
 static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -535,6 +656,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
     if (cq->cqid) {
         g_free(cq);
     }
+    n->qs_created--;
 }
=20
 static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -575,6 +697,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n,=
 uint64_t dma_addr,
     msix_vector_use(&n->parent_obj, cq->vector);
     n->cq[cqid] =3D cq;
     cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
+    n->qs_created++;
 }
=20
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
@@ -637,8 +760,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
=20
     trace_nvme_identify_ns(nsid);
=20
-    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+    if (unlikely(nsid =3D=3D 0 || nsid > n->params.num_ns)) {
+        trace_nvme_err_invalid_ns(nsid, n->params.num_ns);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
@@ -648,7 +771,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
         prp1, prp2);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -658,10 +781,10 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
-    trace_nvme_identify_nslist(min_nsid);
+    trace_nvme_identify_ns_list(min_nsid);
=20
     list =3D g_malloc0(data_len);
-    for (i =3D 0; i < n->num_namespaces; i++) {
+    for (i =3D 0; i < n->params.num_ns; i++) {
         if (i < min_nsid) {
             continue;
         }
@@ -675,6 +798,25 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nv=
meIdentify *c)
     return ret;
 }
=20
+static uint16_t nvme_identify_ns_descriptor_list(NvmeCtrl *n, NvmeCmd *c=
)
+{
+    static const int data_len =3D sizeof(NvmeIdentifyNamespaceDescriptor=
) + 0x10;
+    uint32_t nsid =3D le32_to_cpu(c->nsid);
+    uint64_t prp1 =3D le64_to_cpu(c->prp1);
+    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    NvmeIdentifyNamespaceDescriptor *list;
+    uint16_t ret;
+
+    trace_nvme_identify_ns_descriptor_list(nsid);
+
+    list =3D g_malloc0(data_len);
+    list->nidt =3D 0x3;
+    list->nidl =3D 0x10;
+
+    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, data_len, prp1, prp2)=
;
+    g_free(list);
+    return ret;
+}
=20
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
@@ -686,7 +828,9 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
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
@@ -696,18 +840,49 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd =
*cmd)
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
=20
+    trace_nvme_getfeat(dw10);
+
     switch (dw10) {
+    case NVME_ARBITRATION:
+        result =3D cpu_to_le32(n->features.arbitration);
+        break;
+    case NVME_POWER_MANAGEMENT:
+        result =3D cpu_to_le32(n->features.power_mgmt);
+        break;
+    case NVME_TEMPERATURE_THRESHOLD:
+        result =3D cpu_to_le32(n->features.temp_thresh);
+        break;
+    case NVME_ERROR_RECOVERY:
+        result =3D cpu_to_le32(n->features.err_rec);
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
         trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
         result =3D cpu_to_le32((n->params.num_queues - 2) |
-            ((n->params.num_queues - 2) << 16));
+                            ((n->params.num_queues - 2) << 16));
         trace_nvme_getfeat_numq(result);
         break;
+    case NVME_INTERRUPT_COALESCING:
+        result =3D cpu_to_le32(n->features.int_coalescing);
+        break;
+    case NVME_INTERRUPT_VECTOR_CONF:
+        if ((dw11 & 0xffff) > n->params.num_queues) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result =3D cpu_to_le32(n->features.int_vector_config[dw11 & 0xff=
ff]);
+        break;
+    case NVME_WRITE_ATOMICITY:
+        result =3D cpu_to_le32(n->features.write_atomicity);
+        break;
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        result =3D cpu_to_le32(n->features.async_config);
+        break;
     default:
         trace_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -722,22 +897,244 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
+    trace_nvme_setfeat(dw10, dw11);
+
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        n->features.temp_thresh =3D dw11;
+        if (n->features.temp_thresh <=3D n->temperature) {
+            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+                NVME_AER_INFO_SMART_TEMP_THRESH, NVME_LOG_SMART_INFO);
+        }
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
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
                                 n->params.num_queues - 1);
         req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
-                                      ((n->params.num_queues - 2) << 16)=
);
+                                     ((n->params.num_queues - 2) << 16))=
;
         break;
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        n->features.async_config =3D dw11;
+        break;
+    case NVME_ARBITRATION:
+    case NVME_POWER_MANAGEMENT:
+    case NVME_ERROR_RECOVERY:
+    case NVME_INTERRUPT_COALESCING:
+    case NVME_INTERRUPT_VECTOR_CONF:
+    case NVME_WRITE_ATOMICITY:
+        return NVME_FEAT_NOT_CHANGABLE | NVME_DNR;
     default:
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+
+    return NVME_SUCCESS;
+}
+
+static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
+{
+    n->aer_mask &=3D ~(1 << event_type);
+    if (!QSIMPLEQ_EMPTY(&n->aer_queue)) {
+        timer_mod(n->aer_timer,
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
+    }
+}
+
+static uint16_t nvme_error_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t r=
ae,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    if (off > sizeof(*n->elpes) * (NVME_ELPE + 1)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(*n->elpes) * (NVME_ELPE + 1) - off, buf_len=
);
+
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
+    }
+
+    return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
+        prp2);
+}
+
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    uint32_t trans_len;
+    time_t current_ms;
+    NvmeSmartLog smart;
+
+    if (cmd->nsid !=3D 0 && cmd->nsid !=3D 0xffffffff) {
+        trace_nvme_err(req->cqe.cid, "smart log not supported for namesp=
ace",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (off > sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(smart) - off, buf_len);
+
+    memset(&smart, 0x0, sizeof(smart));
+    smart.number_of_error_log_entries[0] =3D cpu_to_le64(0);
+    smart.temperature[0] =3D n->temperature & 0xff;
+    smart.temperature[1] =3D (n->temperature >> 8) & 0xff;
+
+    if (n->features.temp_thresh <=3D n->temperature) {
+        smart.critical_warning |=3D NVME_SMART_TEMPERATURE;
+    }
+
+    current_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    smart.power_on_hours[0] =3D cpu_to_le64(
+        (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
+
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_SMART);
+    }
+
+    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
+        prp2);
+}
+
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    NvmeFwSlotInfoLog fw_log;
+
+    if (off > sizeof(fw_log)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    memset(&fw_log, 0, sizeof(NvmeFwSlotInfoLog));
+
+    trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
+        prp2);
+}
+
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
+    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint16_t lid =3D dw10 & 0xff;
+    uint8_t  rae =3D (dw10 >> 15) & 0x1;
+    uint32_t numdl, numdu, len;
+    uint64_t off, lpol, lpou;
+
+    numdl =3D (dw10 >> 16);
+    numdu =3D (dw11 & 0xffff);
+    lpol =3D dw12;
+    lpou =3D dw13;
+
+    len =3D (((numdu << 16) | numdl) + 1) << 2;
+    off =3D (lpou << 32ULL) | lpol;
+
+    if (off & 0x3) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trace_nvme_get_log(req->cqe.cid, lid);
+
+    switch (lid) {
+    case NVME_LOG_ERROR_INFO:
+        return nvme_error_log_info(n, cmd, rae, len, off, req);
+    case NVME_LOG_SMART_INFO:
+        return nvme_smart_info(n, cmd, rae, len, off, req);
+    case NVME_LOG_FW_SLOT_INFO:
+        return nvme_fw_log_info(n, cmd, len, off, req);
+    default:
+        trace_nvme_err_invalid_log_page(req->cqe.cid, lid);
+        return NVME_INVALID_LOG_ID | NVME_DNR;
+    }
+}
+
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    trace_nvme_aer(req->cqe.cid);
+
+    if (n->outstanding_aers > NVME_AERL) {
+        trace_nvme_aer_aerl_exceeded();
+        return NVME_AER_LIMIT_EXCEEDED;
+    }
+
+    n->aer_reqs[n->outstanding_aers] =3D req;
+    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500)=
;
+    n->outstanding_aers++;
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeSQueue *sq;
+    NvmeRequest *new;
+    uint32_t index =3D 0;
+    uint16_t sqid =3D cmd->cdw10 & 0xffff;
+    uint16_t cid =3D (cmd->cdw10 >> 16) & 0xffff;
+
+    req->cqe.result =3D 1;
+    if (nvme_check_sqid(n, sqid)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    sq =3D n->sq[sqid];
+
+    /* only consider queued (and not executing) commands for abort */
+    while ((sq->head + index) % sq->size !=3D sq->tail) {
+        NvmeCmd abort_cmd;
+        hwaddr addr;
+
+        addr =3D sq->dma_addr + ((sq->head + index) % sq->size) * n->sqe=
_size;
+
+        nvme_addr_read(n, addr, (void *) &abort_cmd, sizeof(abort_cmd));
+        if (abort_cmd.cid =3D=3D cid) {
+            req->cqe.result =3D 0;
+            new =3D QTAILQ_FIRST(&sq->req_list);
+            QTAILQ_REMOVE(&sq->req_list, new, entry);
+            QTAILQ_INSERT_TAIL(&sq->out_req_list, new, entry);
+
+            memset(&new->cqe, 0, sizeof(new->cqe));
+            new->cqe.cid =3D cid;
+            new->status =3D NVME_CMD_ABORT_REQ;
+
+            abort_cmd.opcode =3D NVME_OP_ABORTED;
+            nvme_addr_write(n, addr, (void *) &abort_cmd, sizeof(abort_c=
md));
+
+            nvme_enqueue_req_completion(n->cq[sq->cqid], new);
+
+            return NVME_SUCCESS;
+        }
+
+        ++index;
+    }
+
     return NVME_SUCCESS;
 }
=20
@@ -758,6 +1155,12 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log(n, cmd, req);
+    case NVME_ADM_CMD_ASYNC_EV_REQ:
+        return nvme_aer(n, cmd, req);
+    case NVME_ADM_CMD_ABORT:
+        return nvme_abort(n, cmd, req);
     default:
         trace_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -780,6 +1183,10 @@ static void nvme_process_sq(void *opaque)
         nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
         nvme_inc_sq_head(sq);
=20
+        if (cmd.opcode =3D=3D NVME_OP_ABORTED) {
+            continue;
+        }
+
         req =3D QTAILQ_FIRST(&sq->req_list);
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
@@ -797,6 +1204,7 @@ static void nvme_process_sq(void *opaque)
=20
 static void nvme_clear_ctrl(NvmeCtrl *n)
 {
+    NvmeAsyncEvent *event;
     int i;
=20
     blk_drain(n->conf.blk);
@@ -812,8 +1220,19 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
     }
=20
+    if (n->aer_timer) {
+        timer_del(n->aer_timer);
+        timer_free(n->aer_timer);
+        n->aer_timer =3D NULL;
+    }
+    while ((event =3D QSIMPLEQ_FIRST(&n->aer_queue)) !=3D NULL) {
+        QSIMPLEQ_REMOVE_HEAD(&n->aer_queue, entry);
+        g_free(event);
+    }
+
     blk_flush(n->conf.blk);
     n->bar.cc =3D 0;
+    n->outstanding_aers =3D 0;
 }
=20
 static int nvme_start_ctrl(NvmeCtrl *n)
@@ -906,6 +1325,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
         NVME_AQA_ASQS(n->bar.aqa) + 1);
=20
+    n->aer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_aers,=
 n);
+    QSIMPLEQ_INIT(&n->aer_queue);
+
     return 0;
 }
=20
@@ -1098,6 +1520,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            "completion queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
+                    NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1108,6 +1537,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_head=3D%"PRIu16", ignoring",
                            qid, new_head);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_VALUE, NVME_LOG_ERROR_I=
NFO);
+            }
+
             return;
         }
=20
@@ -1136,6 +1571,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            "submission queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
+                    NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1146,6 +1588,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_tail=3D%"PRIu16", ignoring",
                            qid, new_tail);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_VALUE, NVME_LOG_ERROR_I=
NFO);
+            }
+
             return;
         }
=20
@@ -1198,134 +1646,271 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     },
 };
=20
-static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
-    NvmeIdCtrl *id =3D &n->id_ctrl;
-
-    int i;
-    int64_t bs_size;
-    uint8_t *pci_conf;
-
-    if (!n->params.num_queues) {
-        error_setg(errp, "num_queues can't be zero");
-        return;
-    }
+    NvmeParams *params =3D &n->params;
=20
     if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
-        return;
+        error_setg(errp, "nvme: block backend not configured");
+        return 1;
     }
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
+    if (!params->serial) {
+        error_setg(errp, "nvme: serial not configured");
+        return 1;
     }
=20
-    if (!n->params.serial) {
-        error_setg(errp, "serial property not set");
-        return;
+    if ((params->num_queues < 1 || params->num_queues > NVME_MAX_QS)) {
+        error_setg(errp, "nvme: invalid queue configuration");
+        return 1;
     }
+
+    return 0;
+}
+
+static int nvme_init_blk(NvmeCtrl *n, Error **errp)
+{
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
-                                       false, errp)) {
-        return;
+        false, errp)) {
+        return 1;
     }
=20
-    pci_conf =3D pci_dev->config;
-    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(pci_dev, 0x80);
+    return 0;
+}
+
+static int nvme_init_state(NvmeCtrl *n, Error **errp)
+{
+    int64_t bs_size;
+    Error *local_err =3D NULL;
+
+    if (!n->params.serial) {
+        error_setg(errp, "serial property not set");
+        return 1;
+    }
+
+    if (nvme_check_constraints(n, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+            "nvme_check_constraints failed");
+        return 1;
+    }
=20
-    n->num_namespaces =3D 1;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
-    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
-    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
+    bs_size =3D blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg(errp, "could not get backing file size");
+        return 1;
+    }
+
+    n->ns_size =3D bs_size / (uint64_t) n->params.num_ns;
+
+    n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+    n->elpes =3D g_new0(NvmeErrorLog, NVME_ELPE + 1);
+    n->aer_reqs =3D g_new0(NvmeRequest *, NVME_AERL + 1);
+    n->features.int_vector_config =3D g_malloc0_n(n->params.num_queues,
+        sizeof(*n->features.int_vector_config));
=20
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
-                          "nvme", n->reg_size);
+    return 0;
+}
+
+static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
+    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+
+    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
+    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+
+    n->cmbloc =3D n->bar.cmbloc;
+    n->cmbsz =3D n->bar.cmbsz;
+
+    n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                            "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz)=
);
+    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
+        PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+}
+
+static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    uint8_t *pci_conf =3D pci_dev->config;
+
+    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
+    pci_config_set_prog_interface(pci_conf, 0x2);
+    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+    pci_config_set_device_id(pci_conf, 0x5845);
+    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+
+    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme=
",
+        n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
     msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
=20
+    if (n->params.cmb_size_mb) {
+        nvme_init_cmb(n, pci_dev);
+    }
+}
+
+static void nvme_init_ctrl(NvmeCtrl *n)
+{
+    NvmeIdCtrl *id =3D &n->id_ctrl;
+    NvmeParams *params =3D &n->params;
+    uint8_t *pci_conf =3D n->parent_obj.config;
+
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), params->serial, ' ');
     id->rab =3D 6;
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
+    id->cmic =3D 0;
+    id->ver =3D cpu_to_le32(0x00010300);
     id->oacs =3D cpu_to_le16(0);
-    id->frmw =3D 7 << 1;
-    id->lpa =3D 1 << 0;
+    id->acl =3D 3;
+    id->aerl =3D NVME_AERL;
+    id->frmw =3D 7 << 1 | 1;
+    id->lpa =3D 1 << 2;
+    id->elpe =3D NVME_ELPE;
+    id->npss =3D 0;
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
-    id->nn =3D cpu_to_le32(n->num_namespaces);
+    id->nn =3D cpu_to_le32(params->num_ns);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS);
+    id->fuses =3D cpu_to_le16(0);
+    id->fna =3D 0;
+    if (blk_enable_write_cache(n->conf.blk)) {
+        id->vwc =3D 1;
+    }
+    id->awun =3D cpu_to_le16(0);
+    id->awupf =3D cpu_to_le16(0);
+    id->sgls =3D cpu_to_le32(0);
+
+    strcpy((char *) id->subnqn, "nqn.2014-08.org.nvmexpress:uuid:");
+    qemu_uuid_unparse(&qemu_uuid,
+        (char *) id->subnqn + strlen((char *) id->subnqn));
+
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc =3D 1;
+
+    n->temperature =3D NVME_TEMPERATURE;
+    n->features.temp_thresh =3D 0x14d;
+
+    for (int i =3D 0; i < n->params.num_queues; i++) {
+        n->features.int_vector_config[i] =3D i;
     }
=20
     n->bar.cap =3D 0;
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
     NVME_CAP_SET_CQR(n->bar.cap, 1);
-    NVME_CAP_SET_AMS(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
=20
-    n->bar.vs =3D 0x00010200;
+    n->bar.vs =3D 0x00010300;
     n->bar.intmc =3D n->bar.intms =3D 0;
+}
=20
-    if (n->params.cmb_size_mb) {
+static uint64_t nvme_ns_calc_blks(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    return n->ns_size / nvme_ns_lbads_bytes(ns);
+}
=20
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+static void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
+{
+    id_ns->nlbaf =3D 0;
+    id_ns->flbas =3D 0;
+    id_ns->mc =3D 0;
+    id_ns->dpc =3D 0;
+    id_ns->dps =3D 0;
+    id_ns->lbaf[0].lbads =3D BDRV_SECTOR_BITS;
+}
=20
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
+{
+    NvmeIdNs *id_ns =3D &ns->id_ns;
=20
-        n->cmbloc =3D n->bar.cmbloc;
-        n->cmbsz =3D n->bar.cmbsz;
+    nvme_ns_init_identify(n, id_ns);
=20
-        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+    ns->ns_blks =3D nvme_ns_calc_blks(n, ns);
+    id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D cpu_to_le64(ns->ns_b=
lks);
=20
+    return 0;
+}
+
+static int nvme_init_namespaces(NvmeCtrl *n, Error **errp)
+{
+    int64_t bs_size;
+    Error *local_err =3D NULL;
+    NvmeNamespace *ns;
+
+    n->namespaces =3D g_new0(NvmeNamespace, n->params.num_ns);
+
+    bs_size =3D blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg_errno(errp, -bs_size, "blk_getlength");
+        return 1;
+    }
+
+    n->ns_size =3D bs_size / (uint64_t) n->params.num_ns;
+
+    for (int i =3D 0; i < n->params.num_ns; i++) {
+        ns =3D &n->namespaces[i];
+        ns->id =3D i + 1;
+        ns->blk_offset =3D i * n->ns_size;
+
+        if (nvme_init_namespace(n, ns, &local_err)) {
+            error_propagate_prepend(errp, local_err,
+                "nvme_init_namespace: ");
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+{
+    NvmeCtrl *n =3D NVME(pci_dev);
+    Error *local_err =3D NULL;
+
+    if (nvme_check_constraints(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_check_constraints=
: ");
+        return;
+    }
+
+    if (nvme_init_blk(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
+        return;
+    }
+
+    if (nvme_init_state(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_init_state: ");
+        return;
     }
=20
-    for (i =3D 0; i < n->num_namespaces; i++) {
-        NvmeNamespace *ns =3D &n->namespaces[i];
-        NvmeIdNs *id_ns =3D &ns->id_ns;
-        id_ns->nsfeat =3D 0;
-        id_ns->nlbaf =3D 0;
-        id_ns->flbas =3D 0;
-        id_ns->mc =3D 0;
-        id_ns->dpc =3D 0;
-        id_ns->dps =3D 0;
-        id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-        id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
+    nvme_init_pci(n, pci_dev);
+    nvme_init_ctrl(n);
+
+    if (nvme_init_namespaces(n, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+            "nvme_init_namespaces: ");
+        return;
     }
 }
=20
@@ -1337,6 +1922,9 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->elpes);
+    g_free(n->aer_reqs);
+    g_free(n->features.int_vector_config);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8866373058f6..8925a05445da 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,11 +6,13 @@
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
-    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
+    DEFINE_PROP_UINT32("num_ns", _state, _props.num_ns, 1)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
+    uint32_t num_ns;
     uint32_t cmb_size_mb;
 } NvmeParams;
=20
@@ -63,6 +65,9 @@ typedef struct NvmeCQueue {
=20
 typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
+    uint32_t        id;
+    uint64_t        ns_blks;
+    uint64_t        blk_offset;
 } NvmeNamespace;
=20
 #define TYPE_NVME "nvme"
@@ -77,26 +82,48 @@ typedef struct NvmeCtrl {
     BlockConf    conf;
     NvmeParams   params;
=20
+    uint64_t    starttime_ms;
+    uint16_t    temperature;
     uint32_t    page_size;
     uint16_t    page_bits;
     uint16_t    max_prp_ents;
     uint16_t    cqe_size;
     uint16_t    sqe_size;
     uint32_t    reg_size;
-    uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
+    uint32_t    qs_created;
=20
+    QSIMPLEQ_HEAD(, NvmeAsyncEvent) aer_queue;
+    QEMUTimer   *aer_timer;
+    uint8_t     aer_mask;
+    uint8_t     aer_mask_queued;
+
+    NvmeErrorLog    *elpes;
+    NvmeRequest     **aer_reqs;
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
+    NvmeFeatureVal  features;
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    NvmeIdNs *id =3D &ns->id_ns;
+    return id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].lbads;
+}
+
+static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
+{
+    return 1 << nvme_ns_lbads(ns);
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index b92039a5739f..abec518167d0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -42,10 +42,22 @@ nvme_del_sq(uint16_t qid) "deleting submission queue =
sqid=3D%"PRIu16""
 nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
 nvme_identify_ctrl(void) "identify controller"
 nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
+nvme_identify_ns_list(uint16_t ns) "identify namespace list, nsid=3D%"PR=
Iu16""
+nvme_identify_ns_descriptor_list(uint16_t ns) "identify namespace descri=
ptor list, nsid=3D%"PRIu16""
+nvme_getfeat(uint32_t fid) "fid 0x%"PRIx32""
+nvme_setfeat(uint32_t fid, uint32_t val) "fid 0x%"PRIx32" val 0x%"PRIx32=
""
 nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
 nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
+nvme_get_log(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
+nvme_process_aers(void) "processing aers"
+nvme_aer(uint16_t cid) "cid %"PRIu16""
+nvme_aer_aerl_exceeded(void) "aerl exceeded"
+nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
+nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid) "cid %"PRIu16" =
cqid %"PRIu16""
+nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
@@ -60,6 +72,7 @@ nvme_mmio_shutdown_set(void) "shutdown bit set"
 nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
=20
 # nvme traces for error conditions
+nvme_err(uint16_t cid, const char *s, uint16_t status) "cid %"PRIu16" \"=
%s\" status 0x%"PRIx16""
 nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
 nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
@@ -85,6 +98,7 @@ nvme_err_invalid_create_cq_qflags(uint16_t qflags) "fai=
led creating completion q
 nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D0x%=
"PRIx16""
 nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%"PRI=
x32""
 nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D0x=
%"PRIx32""
+nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid=
 0x%"PRIx16""
 nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are no=
n-admin completion queues"
 nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are no=
n-admin submission queues"
 nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the adm=
in submission queue address is null"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 849a6f3fa346..5a169e7ed7ac 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -386,8 +386,8 @@ enum NvmeAsyncEventRequest {
     NVME_AER_TYPE_SMART                     =3D 1,
     NVME_AER_TYPE_IO_SPECIFIC               =3D 6,
     NVME_AER_TYPE_VENDOR_SPECIFIC           =3D 7,
-    NVME_AER_INFO_ERR_INVALID_SQ            =3D 0,
-    NVME_AER_INFO_ERR_INVALID_DB            =3D 1,
+    NVME_AER_INFO_ERR_INVALID_DB_REGISTER   =3D 0,
+    NVME_AER_INFO_ERR_INVALID_DB_VALUE      =3D 1,
     NVME_AER_INFO_ERR_DIAG_FAIL             =3D 2,
     NVME_AER_INFO_ERR_PERS_INTERNAL_ERR     =3D 3,
     NVME_AER_INFO_ERR_TRANS_INTERNAL_ERR    =3D 4,
@@ -445,7 +445,8 @@ enum NvmeStatusCodes {
     NVME_FW_REQ_RESET           =3D 0x010b,
     NVME_INVALID_QUEUE_DEL      =3D 0x010c,
     NVME_FID_NOT_SAVEABLE       =3D 0x010d,
-    NVME_FID_NOT_NSID_SPEC      =3D 0x010f,
+    NVME_FEAT_NOT_CHANGABLE     =3D 0x010e,
+    NVME_FEAT_NOT_NSID_SPEC     =3D 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  =3D 0x0110,
     NVME_CONFLICTING_ATTRS      =3D 0x0180,
     NVME_INVALID_PROT_INFO      =3D 0x0181,
@@ -462,6 +463,13 @@ enum NvmeStatusCodes {
     NVME_NO_COMPLETE            =3D 0xffff,
 };
=20
+typedef struct NvmeIdentifyNamespaceDescriptor {
+    uint8_t nidt;
+    uint8_t nidl;
+    uint8_t rsvd[2];
+    uint8_t nid[];
+} NvmeIdentifyNamespaceDescriptor;
+
 typedef struct NvmeFwSlotInfoLog {
     uint8_t     afi;
     uint8_t     reserved1[7];
@@ -543,7 +551,15 @@ typedef struct NvmeIdCtrl {
     uint8_t     ieee[3];
     uint8_t     cmic;
     uint8_t     mdts;
-    uint8_t     rsvd255[178];
+    uint16_t    cntlid;
+    uint32_t    ver;
+    uint16_t    rtd3r;
+    uint32_t    rtd3e;
+    uint32_t    oaes;
+    uint32_t    ctratt;
+    uint8_t     rsvd111[12];
+    uint8_t     fguid[16];
+    uint8_t     rsvd255[128];
     uint16_t    oacs;
     uint8_t     acl;
     uint8_t     aerl;
@@ -551,10 +567,28 @@ typedef struct NvmeIdCtrl {
     uint8_t     lpa;
     uint8_t     elpe;
     uint8_t     npss;
-    uint8_t     rsvd511[248];
+    uint8_t     avscc;
+    uint8_t     apsta;
+    uint16_t    wctemp;
+    uint16_t    cctemp;
+    uint16_t    mtfa;
+    uint32_t    hmpre;
+    uint32_t    hmmin;
+    uint8_t     tnvmcap[16];
+    uint8_t     unvmcap[16];
+    uint32_t    rpmbs;
+    uint16_t    edstt;
+    uint8_t     dsto;
+    uint8_t     fwug;
+    uint16_t    kas;
+    uint16_t    hctma;
+    uint16_t    mntmt;
+    uint16_t    mxtmt;
+    uint32_t    sanicap;
+    uint8_t     rsvd511[180];
     uint8_t     sqes;
     uint8_t     cqes;
-    uint16_t    rsvd515;
+    uint16_t    maxcmd;
     uint32_t    nn;
     uint16_t    oncs;
     uint16_t    fuses;
@@ -562,8 +596,14 @@ typedef struct NvmeIdCtrl {
     uint8_t     vwc;
     uint16_t    awun;
     uint16_t    awupf;
-    uint8_t     rsvd703[174];
-    uint8_t     rsvd2047[1344];
+    uint8_t     nvscc;
+    uint8_t     rsvd531;
+    uint16_t    acwu;
+    uint16_t    rsvd535;
+    uint32_t    sgls;
+    uint8_t     rsvd767[228];
+    uint8_t     subnqn[256];
+    uint8_t     rsvd2047[1024];
     NvmePSD     psd[32];
     uint8_t     vs[1024];
 } NvmeIdCtrl;
@@ -637,7 +677,7 @@ typedef struct NvmeRangeType {
=20
 typedef struct NvmeLBAF {
     uint16_t    ms;
-    uint8_t     ds;
+    uint8_t     lbads;
     uint8_t     rp;
 } NvmeLBAF;
=20
--=20
2.21.0


