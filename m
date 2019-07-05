Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD3C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A209218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A209218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIfH-0004CW-Sh
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZc-0005Hi-9Y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZZ-0005lv-NB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:23:59 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZW-0005h8-41; Fri, 05 Jul 2019 03:23:54 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 98055C0579;
 Fri,  5 Jul 2019 07:23:52 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:24 +0200
Message-Id: <20190705072333.17171-8-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 07/16] nvme: support Abort command
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

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.1 ("Abort command").

Extracted from Keith's qemu-nvme tree. Modified to only consider queued
and not executing commands.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b31e5ff681bd..4b9ff51868c0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -38,6 +38,7 @@
 #include "trace.h"
 #include "nvme.h"
=20
+#define NVME_OP_ABORTED 0xff
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
         (trace_##trace)(__VA_ARGS__); \
@@ -848,6 +849,54 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+
+    return NVME_SUCCESS;
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
@@ -868,6 +917,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_ABORT:
+        return nvme_abort(n, cmd, req);
     default:
         trace_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -890,6 +941,10 @@ static void nvme_process_sq(void *opaque)
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
@@ -1376,6 +1431,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     id->ieee[2] =3D 0xb3;
     id->ver =3D cpu_to_le32(0x00010201);
     id->oacs =3D cpu_to_le16(0);
+    id->acl =3D 3;
     id->frmw =3D 7 << 1;
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
--=20
2.20.1


