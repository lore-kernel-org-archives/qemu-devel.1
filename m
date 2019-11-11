Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050C2C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD62820856
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD62820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU8rQ-0005Ms-8F
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 07:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iU8li-0007ca-84
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iU8lh-0003Rv-0r
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:26:06 -0500
Received: from charlie.dont.surf ([128.199.63.193]:52200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iU8ld-0003Oa-GW; Mon, 11 Nov 2019 07:26:01 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 714AABFAE9;
 Mon, 11 Nov 2019 12:26:00 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/21] nvme: add logging to error information log page
Date: Mon, 11 Nov 2019 13:25:34 +0100
Message-Id: <20191111122545.252478-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111122545.252478-1-its@irrelevant.dk>
References: <20191111122545.252478-1-its@irrelevant.dk>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Javier Gonzalez <javier@javigon.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Keith Busch <kbusch@kernel.org>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the nvme_set_error_page function which allows errors to be
written to the error information log page. The functionality is largely
unused in the device, but with this in place we can at least try to push
new contributions to use it.

NOTE: In violation of the specification the Error Count field is *not*
retained across power off conditions because the device currently has no
place to store this kind of persistent state.

Cribbed from Keith's qemu-nvme tree.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 22 ++++++++++++++++++++--
 hw/block/nvme.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f1a9b2cf5cbd..47f7c5cfcff9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -161,6 +161,22 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueu=
e *cq)
     }
 }
=20
+static void nvme_set_error_page(NvmeCtrl *n, uint16_t sqid, uint16_t cid=
,
+    uint16_t status, uint16_t location, uint64_t lba, uint32_t nsid)
+{
+    NvmeErrorLog *elp;
+
+    elp =3D &n->elpes[n->elp_index];
+    elp->error_count =3D n->error_count++;
+    elp->sqid =3D sqid;
+    elp->cid =3D cid;
+    elp->status_field =3D status;
+    elp->param_error_location =3D location;
+    elp->lba =3D lba;
+    elp->nsid =3D nsid;
+    n->elp_index =3D (n->elp_index + 1) % n->params.elpe;
+}
+
 static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_=
t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
@@ -386,7 +402,9 @@ static void nvme_rw_cb(void *opaque, int ret)
         req->status =3D NVME_SUCCESS;
     } else {
         block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        req->status =3D NVME_INTERNAL_DEV_ERROR;
+        nvme_set_error_page(n, sq->sqid, cpu_to_le16(req->cid),
+            NVME_INTERNAL_DEV_ERROR, 0, 0, 1);
+        req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_MORE;
     }
     if (req->has_sg) {
         qemu_sglist_destroy(&req->qsg);
@@ -677,7 +695,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
     smart.host_read_commands[0] =3D cpu_to_le64(read_commands);
     smart.host_write_commands[0] =3D cpu_to_le64(write_commands);
=20
-    smart.number_of_error_log_entries[0] =3D cpu_to_le64(0);
+    smart.number_of_error_log_entries[0] =3D cpu_to_le64(n->error_count)=
;
     smart.temperature[0] =3D n->temperature & 0xff;
     smart.temperature[1] =3D (n->temperature >> 8) & 0xff;
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 3fc36f577b46..d74b0e0f9b2c 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -100,6 +100,8 @@ typedef struct NvmeCtrl {
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
     uint64_t    starttime_ms;
     uint16_t    temperature;
+    uint8_t     elp_index;
+    uint64_t    error_count;
=20
     QEMUTimer   *aer_timer;
     uint8_t     aer_mask;
--=20
2.24.0


