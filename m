Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6060FC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27986218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27986218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIrl-0000KZ-BU
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIaF-0005gb-W9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIa9-000698-5e
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:36 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZr-0005jO-Va; Fri, 05 Jul 2019 03:24:16 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id CDDAFC0656;
 Fri,  5 Jul 2019 07:23:54 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:33 +0200
Message-Id: <20190705072333.17171-17-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 16/16] nvme: support multiple namespaces
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

This adds support for multiple namespaces by introducing a new 'nvme-ns'
device model. The nvme device creates a bus named from the device name
('id'). The nvme-ns devices then connect to this and registers
themselves with the nvme device.

This changes how an nvme device is created. Example with two namespaces:

  -drive file=3Dnvme0n1.img,if=3Dnone,id=3Ddisk1
  -drive file=3Dnvme0n2.img,if=3Dnone,id=3Ddisk2
  -device nvme,serial=3Ddeadbeef,id=3Dnvme0
  -device nvme-ns,drive=3Ddisk1,bus=3Dnvme0,nsid=3D1
  -device nvme-ns,drive=3Ddisk2,bus=3Dnvme0,nsid=3D2

A maximum of 256 namespaces can be configured.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/Makefile.objs |   2 +-
 hw/block/nvme-ns.c     | 139 +++++++++++++++++++++++++++++++++
 hw/block/nvme-ns.h     |  35 +++++++++
 hw/block/nvme.c        | 169 ++++++++++++++++-------------------------
 hw/block/nvme.h        |  29 ++++---
 hw/block/trace-events  |   1 +
 6 files changed, 255 insertions(+), 120 deletions(-)
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index f5f643f0cc06..d44a2f4b780d 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -7,7 +7,7 @@ common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
 common-obj-$(CONFIG_XEN) +=3D xen-block.o
 common-obj-$(CONFIG_ECC) +=3D ecc.o
 common-obj-$(CONFIG_ONENAND) +=3D onenand.o
-common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
+common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o nvme-ns.o
=20
 obj-$(CONFIG_SH4) +=3D tc58128.o
=20
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
new file mode 100644
index 000000000000..11b594467991
--- /dev/null
+++ b/hw/block/nvme-ns.c
@@ -0,0 +1,139 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "hw/block/block.h"
+#include "hw/pci/msix.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+
+#include "hw/qdev-core.h"
+
+#include "nvme.h"
+#include "nvme-ns.h"
+
+static uint64_t nvme_ns_calc_blks(NvmeNamespace *ns)
+{
+    return ns->size / nvme_ns_lbads_bytes(ns);
+}
+
+static void nvme_ns_init_identify(NvmeIdNs *id_ns)
+{
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+}
+
+static int nvme_ns_init(NvmeNamespace *ns)
+{
+    uint64_t ns_blks;
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+
+    nvme_ns_init_identify(id_ns);
+
+    ns_blks =3D nvme_ns_calc_blks(ns);
+    id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D cpu_to_le64(ns_blks)=
;
+
+    return 0;
+}
+
+static int nvme_ns_init_blk(NvmeNamespace *ns, NvmeIdCtrl *id, Error **e=
rrp)
+{
+    blkconf_blocksizes(&ns->conf);
+
+    if (!blkconf_apply_backend_options(&ns->conf,
+        blk_is_read_only(ns->conf.blk), false, errp)) {
+        return 1;
+    }
+
+    ns->size =3D blk_getlength(ns->conf.blk);
+    if (ns->size < 0) {
+        error_setg_errno(errp, -ns->size, "blk_getlength");
+        return 1;
+    }
+
+    if (!blk_enable_write_cache(ns->conf.blk)) {
+        id->vwc =3D 0;
+    }
+
+    return 0;
+}
+
+static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
+{
+    if (!ns->conf.blk) {
+        error_setg(errp, "nvme-ns: block backend not configured");
+        return 1;
+    }
+
+    return 0;
+}
+
+
+static void nvme_ns_realize(DeviceState *dev, Error **errp)
+{
+    NvmeNamespace *ns =3D NVME_NS(dev);
+    BusState *s =3D qdev_get_parent_bus(dev);
+    NvmeCtrl *n =3D NVME(s->parent);
+    Error *local_err =3D NULL;
+
+    if (nvme_ns_check_constraints(ns, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+            "nvme_ns_check_constraints: ");
+        return;
+    }
+
+    if (nvme_ns_init_blk(ns, &n->id_ctrl, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_ns_init_blk: ");
+        return;
+    }
+
+    nvme_ns_init(ns);
+    if (nvme_register_namespace(n, ns, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_register_namespac=
e: ");
+        return;
+    }
+}
+
+static Property nvme_ns_props[] =3D {
+    DEFINE_BLOCK_PROPERTIES(NvmeNamespace, conf),
+    DEFINE_NVME_NS_PROPERTIES(NvmeNamespace, params),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nvme_ns_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    dc->bus_type =3D TYPE_NVME_BUS;
+    dc->realize =3D nvme_ns_realize;
+    dc->props =3D nvme_ns_props;
+    dc->desc =3D "virtual nvme namespace";
+}
+
+static void nvme_ns_instance_init(Object *obj)
+{
+    NvmeNamespace *ns =3D NVME_NS(obj);
+    char *bootindex =3D g_strdup_printf("/namespace@%d,0", ns->params.ns=
id);
+
+    device_add_bootindex_property(obj, &ns->conf.bootindex, "bootindex",
+        bootindex, DEVICE(obj), &error_abort);
+
+    g_free(bootindex);
+}
+
+static const TypeInfo nvme_ns_info =3D {
+    .name =3D TYPE_NVME_NS,
+    .parent =3D TYPE_DEVICE,
+    .class_init =3D nvme_ns_class_init,
+    .instance_size =3D sizeof(NvmeNamespace),
+    .instance_init =3D nvme_ns_instance_init,
+};
+
+static void nvme_ns_register_types(void)
+{
+    type_register_static(&nvme_ns_info);
+}
+
+type_init(nvme_ns_register_types)
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
new file mode 100644
index 000000000000..f563bb14eceb
--- /dev/null
+++ b/hw/block/nvme-ns.h
@@ -0,0 +1,35 @@
+#ifndef NVME_NS_H
+#define NVME_NS_H
+
+#define TYPE_NVME_NS "nvme-ns"
+#define NVME_NS(obj) \
+    OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
+
+#define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
+    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
+
+typedef struct NvmeNamespaceParams {
+    uint32_t nsid;
+} NvmeNamespaceParams;
+
+typedef struct NvmeNamespace {
+    DeviceState parent_obj;
+    BlockConf   conf;
+    int64_t     size;
+
+    NvmeIdNs            id_ns;
+    NvmeNamespaceParams params;
+} NvmeNamespace;
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    NvmeIdNs *id =3D &ns->id_ns;
+    return id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].ds;
+}
+
+static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
+{
+    return 1 << nvme_ns_lbads(ns);
+}
+
+#endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 6bf62952dd13..6448798132d6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -17,7 +17,8 @@
 /**
  * Usage: add options:
  *     -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
- *     -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[option=
al]>
+ *     -device nvme,serial=3D<serial>,id=3Dnvme0
+ *     -device nvme-ns,drive=3D<drive_id>,bus=3Dnvme0,nsid=3D1
  *
  * Advanced optional options:
  *
@@ -41,6 +42,7 @@
=20
 #include "trace.h"
 #include "nvme.h"
+#include "nvme-ns.h"
=20
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
 #define NVME_TEMPERATURE 0x143
@@ -848,15 +850,16 @@ static void nvme_rw_cb(void *opaque, int ret)
     NvmeSQueue *sq =3D req->sq;
     NvmeCtrl *n =3D sq->ctrl;
     NvmeCQueue *cq =3D n->cq[sq->cqid];
+    NvmeNamespace *ns =3D req->ns;
=20
     QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
=20
-    trace_nvme_rw_cb(req->cqe.cid, req->cmd.nsid);
+    trace_nvme_rw_cb(req->cqe.cid, ns->params.nsid);
=20
     if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &blk_req->acct);
+        block_acct_done(blk_get_stats(ns->conf.blk), &blk_req->acct);
     } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &blk_req->acct);
+        block_acct_failed(blk_get_stats(ns->conf.blk), &blk_req->acct);
         NVME_GUEST_ERR(nvme_err_internal_dev_error, "block request faile=
d: %s",
             strerror(-ret));
         req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_DNR;
@@ -871,6 +874,7 @@ static void nvme_rw_cb(void *opaque, int ret)
=20
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
+    NvmeNamespace *ns =3D req->ns;
     NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, NULL);
     if (!blk_req) {
         NVME_GUEST_ERR(nvme_err_internal_dev_error, "nvme_blk_req_get: %=
s",
@@ -878,9 +882,9 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd,=
 NvmeRequest *req)
         return NVME_INTERNAL_DEV_ERROR;
     }
=20
-    block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct, 0,
+    block_acct_start(blk_get_stats(ns->conf.blk), &blk_req->acct, 0,
          BLOCK_ACCT_FLUSH);
-    blk_req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, blk_req);
+    blk_req->aiocb =3D blk_aio_flush(ns->conf.blk, nvme_rw_cb, blk_req);
=20
     QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
=20
@@ -890,6 +894,7 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd,=
 NvmeRequest *req)
 static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
+    NvmeNamespace *ns =3D req->ns;
     NvmeBlockBackendRequest *blk_req;
     const uint8_t lbads =3D nvme_ns_lbads(req->ns);
     uint64_t slba =3D le64_to_cpu(rw->slba);
@@ -909,10 +914,10 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         return NVME_INTERNAL_DEV_ERROR;
     }
=20
-    block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct, 0,
+    block_acct_start(blk_get_stats(ns->conf.blk), &blk_req->acct, 0,
         BLOCK_ACCT_WRITE);
=20
-    blk_req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
+    blk_req->aiocb =3D blk_aio_pwrite_zeroes(ns->conf.blk, offset, count=
,
         BDRV_REQ_MAY_UNMAP, nvme_rw_cb, blk_req);
=20
     QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
@@ -929,7 +934,7 @@ static uint16_t nvme_rw_check_req(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     uint32_t data_size =3D req->nlb << nvme_ns_lbads(ns);
=20
     if (unlikely((req->slba + req->nlb) > ns->id_ns.nsze)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), req->is_write ?
+        block_acct_invalid(blk_get_stats(ns->conf.blk), req->is_write ?
             BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
         trace_nvme_err_invalid_lba_range(req->slba, req->nlb, ns->id_ns.=
nsze);
         return NVME_LBA_RANGE | NVME_DNR;
@@ -950,18 +955,19 @@ static void nvme_blk_submit_dma(NvmeCtrl *n, NvmeBl=
ockBackendRequest *blk_req,
     BlockCompletionFunc *cb)
 {
     NvmeRequest *req =3D blk_req->req;
+    NvmeNamespace *ns =3D req->ns;
=20
     if (req->is_write) {
-        dma_acct_start(n->conf.blk, &blk_req->acct, blk_req->qsg,
+        dma_acct_start(ns->conf.blk, &blk_req->acct, blk_req->qsg,
             BLOCK_ACCT_WRITE);
=20
-        blk_req->aiocb =3D dma_blk_write(n->conf.blk, blk_req->qsg,
+        blk_req->aiocb =3D dma_blk_write(ns->conf.blk, blk_req->qsg,
             blk_req->blk_offset, BDRV_SECTOR_SIZE, cb, blk_req);
     } else {
-        dma_acct_start(n->conf.blk, &blk_req->acct, blk_req->qsg,
+        dma_acct_start(ns->conf.blk, &blk_req->acct, blk_req->qsg,
             BLOCK_ACCT_READ);
=20
-        blk_req->aiocb =3D dma_blk_read(n->conf.blk, blk_req->qsg,
+        blk_req->aiocb =3D dma_blk_read(ns->conf.blk, blk_req->qsg,
             blk_req->blk_offset, BDRV_SECTOR_SIZE, cb, blk_req);
     }
 }
@@ -970,21 +976,22 @@ static void nvme_blk_submit_cmb(NvmeCtrl *n, NvmeBl=
ockBackendRequest *blk_req,
     BlockCompletionFunc *cb)
 {
     NvmeRequest *req =3D blk_req->req;
+    NvmeNamespace *ns =3D req->ns;
=20
     qemu_iovec_init(&blk_req->iov, blk_req->qsg->nsg);
     dma_to_cmb(n, blk_req->qsg, &blk_req->iov);
=20
     if (req->is_write) {
-        block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+        block_acct_start(blk_get_stats(ns->conf.blk), &blk_req->acct,
             blk_req->iov.size, BLOCK_ACCT_WRITE);
=20
-        blk_req->aiocb =3D blk_aio_pwritev(n->conf.blk, blk_req->blk_off=
set,
+        blk_req->aiocb =3D blk_aio_pwritev(ns->conf.blk, blk_req->blk_of=
fset,
             &blk_req->iov, 0, cb, blk_req);
     } else {
-        block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+        block_acct_start(blk_get_stats(ns->conf.blk), &blk_req->acct,
             blk_req->iov.size, BLOCK_ACCT_READ);
=20
-        blk_req->aiocb =3D blk_aio_preadv(n->conf.blk, blk_req->blk_offs=
et,
+        blk_req->aiocb =3D blk_aio_preadv(ns->conf.blk, blk_req->blk_off=
set,
             &blk_req->iov, 0, cb, blk_req);
     }
 }
@@ -1042,7 +1049,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
-    req->ns =3D &n->namespace;
+    req->ns =3D n->namespaces[nsid - 1];
+
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, cmd, req);
@@ -1302,7 +1310,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
-    ns =3D &n->namespace;
+    ns =3D n->namespaces[nsid - 1];
=20
     return nvme_dma_read(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), c=
md,
         req);
@@ -1444,6 +1452,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd,
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
+    NvmeNamespace *ns =3D req->ns;
+
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
@@ -1464,7 +1474,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         result =3D cpu_to_le32(n->features.err_rec);
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        result =3D blk_enable_write_cache(n->conf.blk);
+        result =3D blk_enable_write_cache(ns->conf.blk);
         trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
@@ -1518,6 +1528,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd,
=20
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
+    NvmeNamespace *ns =3D req->ns;
+
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
@@ -1532,7 +1544,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         }
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
+        blk_set_enable_write_cache(ns->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
         if (n->qs_created > 2) {
@@ -1835,7 +1847,9 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
     NvmeAsyncEvent *event;
     int i;
=20
-    blk_drain(n->conf.blk);
+    for (int i =3D 0; i < n->num_namespaces; i++) {
+        blk_drain(n->namespaces[i]->conf.blk);
+    }
=20
     for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->sq[i] !=3D NULL) {
@@ -1858,7 +1872,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         g_free(event);
     }
=20
-    blk_flush(n->conf.blk);
+    for (int i =3D 0; i < n->num_namespaces; i++) {
+        blk_flush(n->namespaces[i]->conf.blk);
+    }
+
     n->bar.cc =3D 0;
     n->outstanding_aers =3D 0;
 }
@@ -2280,8 +2297,8 @@ static int nvme_check_constraints(NvmeCtrl *n, Erro=
r **errp)
 {
     NvmeParams *params =3D &n->params;
=20
-    if (!n->conf.blk) {
-        error_setg(errp, "nvme: block backend not configured");
+    if (!n->parent_obj.qdev.id) {
+        error_setg(errp, "nvme: invalid 'id' parameter");
         return 1;
     }
=20
@@ -2298,20 +2315,9 @@ static int nvme_check_constraints(NvmeCtrl *n, Err=
or **errp)
     return 0;
 }
=20
-static int nvme_init_blk(NvmeCtrl *n, Error **errp)
-{
-    blkconf_blocksizes(&n->conf);
-    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
-        false, errp)) {
-        return 1;
-    }
-
-    return 0;
-}
-
 static void nvme_init_state(NvmeCtrl *n)
 {
-    n->num_namespaces =3D 1;
+    n->num_namespaces =3D 0;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
@@ -2404,11 +2410,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
-
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc =3D 1;
-    }
-
+    id->vwc =3D 1;
     id->sgls =3D cpu_to_le32(0x1);
=20
     strcpy((char *) id->subnqn, "nqn.2014-08.org.nvmexpress:uuid:");
@@ -2430,52 +2432,26 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     n->bar.intmc =3D n->bar.intms =3D 0;
 }
=20
-static uint64_t nvme_ns_calc_blks(NvmeCtrl *n, NvmeNamespace *ns)
-{
-    return n->ns_size / nvme_ns_lbads_bytes(ns);
-}
-
-static void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
-{
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-    id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-        cpu_to_le64(n->ns_size >>
-            id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)].ds);
-}
-
-static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
-{
-    uint64_t ns_blks;
-    NvmeIdNs *id_ns =3D &ns->id_ns;
-
-    nvme_ns_init_identify(n, id_ns);
-
-    ns_blks =3D nvme_ns_calc_blks(n, ns);
-    id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D cpu_to_le64(ns_blks)=
;
-
-    return 0;
-}
-
-static int nvme_init_namespaces(NvmeCtrl *n, Error **errp)
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp=
)
 {
-    int64_t bs_size;
-    Error *local_err =3D NULL;
-    NvmeNamespace *ns =3D &n->namespace;
+    uint32_t nsid =3D ns->params.nsid;
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg_errno(errp, -bs_size, "blk_getlength");
+    if (nsid =3D=3D 0 || nsid > NVME_MAX_NAMESPACES) {
+        error_setg(errp, "invalid namespace id");
         return 1;
     }
=20
-    n->ns_size =3D bs_size / (uint64_t) n->num_namespaces;
-
-    if (nvme_init_namespace(n, ns, &local_err)) {
-        error_propagate_prepend(errp, local_err,
-            "nvme_init_namespace: ");
+    if (n->namespaces[nsid - 1]) {
+        error_setg(errp, "namespace ids must be unique");
         return 1;
     }
=20
+    trace_nvme_register_namespace(nsid);
+
+    n->namespaces[nsid - 1] =3D ns;
+    n->num_namespaces++;
+    n->id_ctrl.nn++;
+
     return 0;
 }
=20
@@ -2489,19 +2465,10 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
         return;
     }
=20
-    nvme_init_state(n);
-
-    if (nvme_init_blk(n, &local_err)) {
-        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
-        return;
-    }
-
-    if (nvme_init_namespaces(n, &local_err)) {
-        error_propagate_prepend(errp, local_err,
-            "nvme_init_namespaces: ");
-        return;
-    }
+    qbus_create_inplace(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS,
+        &pci_dev->qdev, n->parent_obj.qdev.id);
=20
+    nvme_init_state(n);
     nvme_init_pci(n, pci_dev);
     nvme_init_ctrl(n);
 }
@@ -2524,7 +2491,6 @@ static void nvme_exit(PCIDevice *pci_dev)
 }
=20
 static Property nvme_props[] =3D {
-    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
     DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2552,30 +2518,27 @@ static void nvme_class_init(ObjectClass *oc, void=
 *data)
     dc->vmsd =3D &nvme_vmstate;
 }
=20
-static void nvme_instance_init(Object *obj)
-{
-    NvmeCtrl *s =3D NVME(obj);
-
-    device_add_bootindex_property(obj, &s->conf.bootindex,
-                                  "bootindex", "/namespace@1,0",
-                                  DEVICE(obj), &error_abort);
-}
-
 static const TypeInfo nvme_info =3D {
     .name          =3D TYPE_NVME,
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(NvmeCtrl),
     .class_init    =3D nvme_class_init,
-    .instance_init =3D nvme_instance_init,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
 };
=20
+static const TypeInfo nvme_bus_info =3D {
+    .name =3D TYPE_NVME_BUS,
+    .parent =3D TYPE_BUS,
+    .instance_size =3D sizeof(NvmeBus),
+};
+
 static void nvme_register_types(void)
 {
     type_register_static(&nvme_info);
+    type_register_static(&nvme_bus_info);
 }
=20
 type_init(nvme_register_types)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1d52b183d263..9aff5c82a51b 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -2,6 +2,9 @@
 #define HW_NVME_H
=20
 #include "block/nvme.h"
+#include "nvme-ns.h"
+
+#define NVME_MAX_NAMESPACES 256
=20
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
@@ -86,9 +89,12 @@ typedef struct NvmeCQueue {
     QTAILQ_HEAD(, NvmeRequest) req_list;
 } NvmeCQueue;
=20
-typedef struct NvmeNamespace {
-    NvmeIdNs        id_ns;
-} NvmeNamespace;
+#define TYPE_NVME_BUS "nvme-bus"
+#define NVME_BUS(obj) OBJECT_CHECK(NvmeBus, (obj), TYPE_NVME_BUS)
+
+typedef struct NvmeBus {
+    BusState parent_bus;
+} NvmeBus;
=20
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
@@ -99,7 +105,6 @@ typedef struct NvmeCtrl {
     MemoryRegion iomem;
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
-    BlockConf    conf;
     NvmeParams   params;
=20
     uint64_t    starttime_ms;
@@ -112,7 +117,6 @@ typedef struct NvmeCtrl {
     uint32_t    reg_size;
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
-    uint64_t    ns_size;
     uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
@@ -128,13 +132,15 @@ typedef struct NvmeCtrl {
     QSIMPLEQ_HEAD(, NvmeAsyncEvent) aer_queue;
=20
     NvmeErrorLog    *elpes;
-    NvmeNamespace   namespace;
+    NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeFeatureVal  features;
     NvmeIdCtrl      id_ctrl;
+
+    NvmeBus bus;
 } NvmeCtrl;
=20
 static inline bool nvme_rw_is_write(NvmeRequest *req)
@@ -148,15 +154,6 @@ static inline bool nvme_is_error(uint16_t status, ui=
nt16_t err)
     return (status & 0xfff) =3D=3D err;
 }
=20
-static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
-{
-    NvmeIdNs *id =3D &ns->id_ns;
-    return id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].ds;
-}
-
-static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
-{
-    return 1 << nvme_ns_lbads(ns);
-}
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp=
);
=20
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index b239e92294e4..0809c248aa54 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -29,6 +29,7 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t he=
ads, uint32_t secs, int t
=20
 # nvme.c
 # nvme traces for successful events
+nvme_register_namespace(uint32_t nsid) "nsid %"PRIu32""
 nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
 nvme_irq_pin(void) "pulsing IRQ pin"
 nvme_irq_masked(void) "IRQ is masked"
--=20
2.20.1


