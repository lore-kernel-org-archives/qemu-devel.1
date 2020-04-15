Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B0DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6E920737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6E920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObAW-00078m-AB
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz1-0002tA-NM
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayz-0002r6-N7
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayv-0002aK-NU; Wed, 15 Apr 2020 01:53:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id BE3E6BFDAB;
 Wed, 15 Apr 2020 05:52:29 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 32/48] nvme: add check for mdts
Date: Wed, 15 Apr 2020 07:51:24 +0200
Message-Id: <20200415055140.466900-33-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add 'mdts' device parameter to control the Maximum Data Transfer Size of
the controller and check that it is respected.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 29 ++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  4 +++-
 hw/block/trace-events |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7528d75905d4..d8edd071b261 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -19,7 +19,8 @@
  *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
  *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
  *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
- *              max_ioqpairs=3D<N[optional]>
+ *              max_ioqpairs=3D<N[optional]>, \
+ *              mdts=3D<mdts[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -499,6 +500,19 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t e=
vent_type)
     }
 }
=20
+static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
+                                       NvmeRequest *req)
+{
+    uint8_t mdts =3D n->params.mdts;
+
+    if (mdts && len > n->page_size << mdts) {
+        trace_nvme_dev_err_mdts(nvme_cid(req), n->page_size << mdts, len=
);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb,
                                          NvmeRequest *req)
@@ -593,6 +607,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *=
ns, NvmeCmd *cmd,
=20
     trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba)=
;
=20
+    status =3D nvme_check_mdts(n, data_size, req);
+    if (status) {
+        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        return status;
+    }
+
     status =3D nvme_check_bounds(n, ns, slba, nlb, req);
     if (status) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
@@ -884,6 +904,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
+    uint16_t status;
=20
     numdl =3D (dw10 >> 16);
     numdu =3D (dw11 & 0xffff);
@@ -899,6 +920,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
=20
     trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
=20
+    status =3D nvme_check_mdts(n, len, req);
+    if (status) {
+        return status;
+    }
+
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
         return nvme_error_info(n, cmd, rae, len, off, req);
@@ -2033,6 +2059,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
+    id->mdts =3D params->mdts;
     id->ver =3D cpu_to_le32(NVME_SPEC_VER);
     id->oacs =3D cpu_to_le16(0);
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index a946ae88d817..a25568723d0d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -9,7 +9,8 @@
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
     DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64),=
 \
     DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
-    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, =
64)
+    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, =
64), \
+    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
=20
 typedef struct NvmeParams {
     char     *serial;
@@ -18,6 +19,7 @@ typedef struct NvmeParams {
     uint32_t cmb_size_mb;
     uint8_t  aerl;
     uint32_t aer_max_queued;
+    uint8_t  mdts;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
diff --git a/hw/block/trace-events b/hw/block/trace-events
index e050af87ece4..291422a5b77d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -83,6 +83,7 @@ nvme_dev_mmio_doorbell_cq(uint16_t cqid, uint16_t new_h=
ead) "cqid %"PRIu16" new_
 nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu=
16" new_tail %"PRIu16""
=20
 # nvme traces for error conditions
+nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" =
mdts %"PRIu64" len %"PRIu64""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
--=20
2.26.0


