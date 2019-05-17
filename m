Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D270C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E1C20833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E1C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYbL-0005pv-Ev
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:52:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTI-0007Vx-Fu
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTF-00065J-U3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:08 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT9-0005yB-ML; Fri, 17 May 2019 04:43:59 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id B4D03C06EA;
	Fri, 17 May 2019 08:43:56 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:32 +0200
Message-Id: <20190517084234.26923-7-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 6/8] nvme: add support for scatter gather lists
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

Add partial SGL support. For now, only support a single data block or
last segment descriptor. This is in line with what, for instance, SPDK
currently supports.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 block/nvme.c          |  18 ++--
 hw/block/nvme.c       | 242 +++++++++++++++++++++++++++++++++---------
 hw/block/nvme.h       |   6 ++
 hw/block/trace-events |   1 +
 include/block/nvme.h  |  81 +++++++++++++-
 5 files changed, 285 insertions(+), 63 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0684bbd077dd..12d98c0d0be6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -437,7 +437,7 @@ static void nvme_identify(BlockDriverState *bs, int n=
amespace, Error **errp)
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
-    cmd.prp1 =3D cpu_to_le64(iova);
+    cmd.dptr.prp.prp1 =3D cpu_to_le64(iova);
=20
     if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
         error_setg(errp, "Failed to identify controller");
@@ -511,7 +511,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_CQ,
-        .prp1 =3D cpu_to_le64(q->cq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->cq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x3),
     };
@@ -522,7 +522,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_SQ,
-        .prp1 =3D cpu_to_le64(q->sq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->sq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x1 | (n << 16)),
     };
@@ -857,16 +857,16 @@ try_map:
     case 0:
         abort();
     case 1:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D 0;
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D 0;
         break;
     case 2:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D pagelist[1];
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D pagelist[1];
         break;
     default:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(uint64_t))=
;
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(u=
int64_t));
         break;
     }
     trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 675967a596d1..81201a8b4834 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -279,6 +279,96 @@ unmap:
     return status;
 }
=20
+static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg,
+    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
+{
+    NvmeSglDescriptor *sgl_descriptors;
+    uint64_t nsgld;
+    uint16_t status =3D NVME_SUCCESS;
+
+    trace_nvme_map_sgl(req->cqe.cid, le64_to_cpu(sgl.generic.type), req-=
>nlb,
+        len);
+
+    int cmb =3D 0;
+
+    switch (le64_to_cpu(sgl.generic.type)) {
+    case SGL_DESCR_TYPE_DATA_BLOCK:
+        sgl_descriptors =3D &sgl;
+        nsgld =3D 1;
+
+        break;
+
+    case SGL_DESCR_TYPE_LAST_SEGMENT:
+        sgl_descriptors =3D g_malloc0(le64_to_cpu(sgl.unkeyed.len));
+        nsgld =3D le64_to_cpu(sgl.unkeyed.len) / sizeof(NvmeSglDescripto=
r);
+
+        if (nvme_addr_is_cmb(n, sgl.addr)) {
+            cmb =3D 1;
+        }
+
+        nvme_addr_read(n, le64_to_cpu(sgl.addr), sgl_descriptors,
+            le64_to_cpu(sgl.unkeyed.len));
+
+        break;
+
+    default:
+        return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
+    }
+
+    if (nvme_addr_is_cmb(n, le64_to_cpu(sgl_descriptors[0].addr))) {
+        if (!cmb) {
+            status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            goto maybe_free;
+        }
+
+        req->is_cmb =3D true;
+    } else {
+        if (cmb) {
+            status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            goto maybe_free;
+        }
+
+        req->is_cmb =3D false;
+    }
+
+    pci_dma_sglist_init(qsg, &n->parent_obj, nsgld);
+
+    for (int i =3D 0; i < nsgld; i++) {
+        uint64_t addr;
+        uint32_t trans_len;
+
+        if (len =3D=3D 0) {
+            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
+                status =3D NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+                qemu_sglist_destroy(qsg);
+                goto maybe_free;
+            }
+
+            break;
+        }
+
+        addr =3D le64_to_cpu(sgl_descriptors[i].addr);
+        trans_len =3D MIN(len, le64_to_cpu(sgl_descriptors[i].unkeyed.le=
n));
+
+        if (req->is_cmb && !nvme_addr_is_cmb(n, addr)) {
+            status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            qemu_sglist_destroy(qsg);
+            goto maybe_free;
+        }
+
+        qemu_sglist_add(qsg, addr, trans_len);
+
+        len -=3D trans_len;
+    }
+
+maybe_free:
+    if (nsgld > 1) {
+        g_free(sgl_descriptors);
+    }
+
+    return status;
+}
+
 static void dma_to_cmb(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov)
 {
     for (int i =3D 0; i < qsg->nsg; i++) {
@@ -324,6 +414,56 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8=
_t *ptr, uint32_t len,
     return err;
 }
=20
+static uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
+    NvmeSglDescriptor sgl, NvmeCmd *cmd, NvmeRequest *req)
+{
+    QEMUSGList qsg;
+    uint16_t err =3D NVME_SUCCESS;
+
+    err =3D nvme_map_sgl(n, &qsg, sgl, len, req);
+    if (err) {
+        return err;
+    }
+
+    if (req->is_cmb) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
+        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
+            err =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        qemu_iovec_destroy(&iov);
+
+        return err;
+    }
+
+    if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        err =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    qemu_sglist_destroy(&qsg);
+
+    return err;
+}
+
+static uint16_t nvme_dma_read(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    NvmeCmd *cmd, NvmeRequest *req)
+{
+    if (cmd->psdt) {
+        return nvme_dma_read_sgl(n, ptr, len, cmd->dptr.sgl, cmd, req);
+    }
+
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+
+    return nvme_dma_read_prp(n, ptr, len, prp1, prp2, req);
+}
+
 static void nvme_blk_req_destroy(NvmeBlockBackendRequest *blk_req)
 {
     if (blk_req->qsg.nalloc) {
@@ -385,17 +525,26 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
     uint16_t err;
=20
     QEMUSGList qsg;
+    NvmeSglDescriptor sgl;
=20
     uint32_t unit_len =3D nvme_ns_lbads_bytes(ns);
     uint32_t len =3D req->nlb * unit_len;
     uint32_t meta_unit_len =3D nvme_ns_ms(ns);
     uint32_t meta_len =3D req->nlb * meta_unit_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
-    err =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
-    if (err) {
-        return err;
+    if (cmd->psdt) {
+        err =3D nvme_map_sgl(n, &qsg, cmd->dptr.sgl, len, req);
+        if (err) {
+            return err;
+        }
+    } else {
+        uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+        uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+
+        err =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
+        if (err) {
+            return err;
+        }
     }
=20
     err =3D nvme_blk_setup(n, ns, &qsg, ns->blk_offset, unit_len, req);
@@ -407,7 +556,25 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
     qsg.size =3D 0;
=20
     if (cmd->mptr && n->params.ms) {
-        qemu_sglist_add(&qsg, le64_to_cpu(cmd->mptr), meta_len);
+        if (cmd->psdt =3D=3D PSDT_SGL_MPTR_SGL) {
+            nvme_addr_read(n, le64_to_cpu(cmd->mptr), &sgl,
+                sizeof(NvmeSglDescriptor));
+
+            err =3D nvme_map_sgl(n, &qsg, sgl, meta_len, req);
+            if (err) {
+                /*
+                 * nvme_map_sgl does not know if it was mapping a data o=
r meta
+                 * data SGL, so fix the error code if needed.
+                 */
+                if (nvme_is_error(err, NVME_DATA_SGL_LENGTH_INVALID)) {
+                    err =3D NVME_METADATA_SGL_LENGTH_INVALID | NVME_DNR;
+                }
+
+                return err;
+            }
+        } else {
+            qemu_sglist_add(&qsg, le64_to_cpu(cmd->mptr), meta_len);
+        }
=20
         err =3D nvme_blk_setup(n, ns, &qsg, ns->blk_offset_md, meta_unit=
_len,
             req);
@@ -416,8 +583,6 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
         }
     }
=20
-    qemu_sglist_destroy(&qsg);
-
     return NVME_SUCCESS;
 }
=20
@@ -978,25 +1143,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCm=
d *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeReques=
t *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
-
     trace_nvme_identify_ctrl();
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
-        prp1, prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl),=
 cmd,
+        req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     NvmeNamespace *ns;
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     trace_nvme_identify_ns(nsid);
=20
@@ -1007,17 +1165,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eIdentify *c,
=20
     ns =3D &n->namespaces[nsid - 1];
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
-        prp1, prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), c=
md,
+        req);
 }
=20
-static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
-    uint32_t min_nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t min_nsid =3D le32_to_cpu(cmd->nsid);
     uint32_t *list;
     uint16_t ret;
     int i, j =3D 0;
@@ -1034,18 +1190,16 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
, NvmeIdentify *c,
             break;
         }
     }
-    ret =3D nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2, =
req);
+    ret =3D nvme_dma_read(n, (uint8_t *) list, data_len, cmd, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descriptor_list(NvmeCtrl *n, NvmeCmd *c=
,
+static uint16_t nvme_identify_ns_descriptor_list(NvmeCtrl *n, NvmeCmd *c=
md,
     NvmeRequest *req)
 {
     static const int data_len =3D sizeof(NvmeIdentifyNamespaceDescriptor=
) + 0x10;
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
     NvmeIdentifyNamespaceDescriptor *list;
     uint16_t ret;
=20
@@ -1055,7 +1209,7 @@ static uint16_t nvme_identify_ns_descriptor_list(Nv=
meCtrl *n, NvmeCmd *c,
     list->nidt =3D 0x3;
     list->nidl =3D 0x10;
=20
-    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, data_len, prp1, prp2,=
 req);
+    ret =3D nvme_dma_read(n, (uint8_t *) list, data_len, cmd, req);
     g_free(list);
     return ret;
 }
@@ -1066,11 +1220,11 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
=20
     switch (le32_to_cpu(c->cns)) {
     case 0x00:
-        return nvme_identify_ns(n, c, req);
+        return nvme_identify_ns(n, cmd, req);
     case 0x01:
-        return nvme_identify_ctrl(n, c, req);
+        return nvme_identify_ctrl(n, cmd, req);
     case 0x02:
-        return nvme_identify_ns_list(n, c, req);
+        return nvme_identify_ns_list(n, cmd, req);
     case 0x03:
         return nvme_identify_ns_descriptor_list(n, cmd, req);
     default:
@@ -1199,8 +1353,6 @@ static uint16_t nvme_error_log_info(NvmeCtrl *n, Nv=
meCmd *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
     if (off > sizeof(*n->elpes) * (NVME_ELPE + 1)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1212,16 +1364,12 @@ static uint16_t nvme_error_log_info(NvmeCtrl *n, =
NvmeCmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_ERROR);
     }
=20
-    return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
-        prp2, req);
+    return nvme_dma_read(n, (uint8_t *) n->elpes + off, trans_len, cmd, =
req);
 }
=20
 static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
-
     uint32_t trans_len;
     time_t current_ms;
     NvmeSmartLog smart;
@@ -1255,16 +1403,13 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
-        prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &smart + off, trans_len, cmd, re=
q);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
     uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
     NvmeFwSlotInfoLog fw_log;
=20
     if (off > sizeof(fw_log)) {
@@ -1275,8 +1420,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
-        prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &fw_log + off, trans_len, cmd, r=
eq);
 }
=20
=20
@@ -2058,7 +2202,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     }
     id->awun =3D cpu_to_le16(0);
     id->awupf =3D cpu_to_le16(0);
-    id->sgls =3D cpu_to_le32(0);
+    id->sgls =3D cpu_to_le32(params->ms ? 0xa00001 : 0x1);
=20
     strcpy((char *) id->subnqn, "nqn.2014-08.org.nvmexpress:uuid:");
     qemu_uuid_unparse(&qemu_uuid,
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 81ee0c5173d5..70f4781a1b61 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -146,6 +146,12 @@ static inline bool nvme_rw_is_write(NvmeRequest *req=
)
     return req->cmd_opcode =3D=3D NVME_CMD_WRITE;
 }
=20
+static inline bool nvme_is_error(uint16_t status, uint16_t err)
+{
+    /* strip DNR and MORE */
+    return (status & 0xfff) =3D=3D err;
+}
+
 static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 {
     NvmeIdNs *id =3D &ns->id_ns;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 56fec40d130c..3324aac41dbb 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -36,6 +36,7 @@ nvme_irq_pin(void) "pulsing IRQ pin"
 nvme_irq_masked(void) "IRQ is masked"
 nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
 nvme_map_prp(uint8_t cmd_opcode, uint64_t trans_len, uint32_t len, uint6=
4_t prp1, uint64_t prp2, int num_prps) "cmd_opcode=3D0x%"PRIx8", trans_le=
n=3D%"PRIu64", len=3D%"PRIu32", prp1=3D0x%"PRIx64", prp2=3D0x%"PRIx64", n=
um_prps=3D%d"
+nvme_map_sgl(uint16_t cid, uint64_t typ, uint16_t nlb, uint64_t len) "ci=
d %"PRIu16" type %"PRIu64" nlb %"PRIu16" len %"PRIu64""
 nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
 nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index c90c36b66971..583b61a76570 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -205,15 +205,71 @@ enum NvmeCmbszMask {
 #define NVME_CMBSZ_GETSIZE(cmbsz) \
     (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
=20
+enum NvmeSglDescriptorType {
+    SGL_DESCR_TYPE_DATA_BLOCK           =3D 0x0,
+    SGL_DESCR_TYPE_BIT_BUCKET           =3D 0x1,
+    SGL_DESCR_TYPE_SEGMENT              =3D 0x2,
+    SGL_DESCR_TYPE_LAST_SEGMENT         =3D 0x3,
+    SGL_DESCR_TYPE_KEYED_DATA_BLOCK     =3D 0x4,
+
+    SGL_DESCR_TYPE_VENDOR_SPECIFIC      =3D 0xf,
+};
+
+enum NvmeSglDescriptorSubtype {
+    SGL_DESCR_SUBTYPE_ADDRESS =3D 0x0,
+    SGL_DESCR_SUBTYPE_OFFSET  =3D 0x1,
+};
+
+typedef struct NvmeSglDescriptor {
+    uint64_t addr;
+
+    union {
+        struct {
+            uint64_t rsvd:56;
+            uint64_t subtype:4;
+            uint64_t type:4;
+        } generic;
+        struct {
+            uint64_t len:32;
+            uint64_t rsvd:24;
+            uint64_t subtype:4;
+            uint64_t type:4;
+        } unkeyed;
+
+        struct {
+            uint64_t len:24;
+            uint64_t key:32;
+            uint64_t subtype:4;
+            uint64_t type:4;
+        } keyed;
+    };
+} NvmeSglDescriptor;
+
+typedef union NvmeCmdDptr {
+    struct {
+        uint64_t    prp1;
+        uint64_t    prp2;
+    } prp;
+
+    NvmeSglDescriptor sgl;
+} NvmeCmdDptr;
+
+enum NvmePsdt {
+    PSDT_PRP                 =3D 0x0,
+    PSDT_SGL_MPTR_CONTIGUOUS =3D 0x1,
+    PSDT_SGL_MPTR_SGL        =3D 0x2,
+};
+
 typedef struct NvmeCmd {
-    uint8_t     opcode;
-    uint8_t     fuse;
+    uint16_t    opcode:8;
+    uint16_t    fuse:2;
+    uint16_t    rsvd1:4;
+    uint16_t    psdt:2;
     uint16_t    cid;
     uint32_t    nsid;
-    uint64_t    res1;
+    uint64_t    rsvd2;
     uint64_t    mptr;
-    uint64_t    prp1;
-    uint64_t    prp2;
+    NvmeCmdDptr dptr;
     uint32_t    cdw10;
     uint32_t    cdw11;
     uint32_t    cdw12;
@@ -427,6 +483,11 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
     NVME_INVALID_NSID           =3D 0x000b,
     NVME_CMD_SEQ_ERROR          =3D 0x000c,
+    NVME_INVALID_SGL_SEG_DESCRIPTOR  =3D 0x000d,
+    NVME_INVALID_NUM_SGL_DESCRIPTORS =3D 0x000e,
+    NVME_DATA_SGL_LENGTH_INVALID     =3D 0x000f,
+    NVME_METADATA_SGL_LENGTH_INVALID =3D 0x0010,
+    NVME_SGL_DESCRIPTOR_TYPE_INVALID =3D 0x0011,
     NVME_INVALID_USE_OF_CMB     =3D 0x0012,
     NVME_LBA_RANGE              =3D 0x0080,
     NVME_CAP_EXCEEDED           =3D 0x0081,
@@ -629,6 +690,16 @@ enum NvmeIdCtrlOncs {
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
 #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
=20
+#define NVME_CTRL_SGLS_SUPPORTED(sgls)                 ((sgls) & 0x3)
+#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT(sgls)    ((sgls) & (0x1 <<=
  0))
+#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT(sgls) ((sgls) & (0x1 <<=
  1))
+#define NVME_CTRL_SGLS_KEYED(sgls)                     ((sgls) & (0x1 <<=
  2))
+#define NVME_CTRL_SGLS_BITBUCKET(sgls)                 ((sgls) & (0x1 <<=
 16))
+#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS(sgls)           ((sgls) & (0x1 <<=
 17))
+#define NVME_CTRL_SGLS_EXCESS_LENGTH(sgls)             ((sgls) & (0x1 <<=
 18))
+#define NVME_CTRL_SGLS_MPTR_SGL(sgls)                  ((sgls) & (0x1 <<=
 19))
+#define NVME_CTRL_SGLS_ADDR_OFFSET(sgls)               ((sgls) & (0x1 <<=
 20))
+
 typedef struct NvmeFeatureVal {
     uint32_t    arbitration;
     uint32_t    power_mgmt;
--=20
2.21.0


