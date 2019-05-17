Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04359C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAA1206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAA1206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYVO-0000Mq-3m
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:46:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTD-0007PG-Q8
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTC-000610-6L
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT9-0005yG-ON; Fri, 17 May 2019 04:43:59 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id 0BA5CC06EB;
	Fri, 17 May 2019 08:43:56 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:33 +0200
Message-Id: <20190517084234.26923-8-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 7/8] nvme: keep a copy of the NVMe command in
 request
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

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 4 ++--
 hw/block/nvme.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 81201a8b4834..5cd593806701 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -184,7 +184,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, uint64_t prp1,
     int num_prps =3D (len >> n->page_bits) + 1;
     uint16_t status =3D NVME_SUCCESS;
=20
-    trace_nvme_map_prp(req->cmd_opcode, trans_len, len, prp1, prp2, num_=
prps);
+    trace_nvme_map_prp(req->cmd.opcode, trans_len, len, prp1, prp2, num_=
prps);
=20
     if (unlikely(!prp1)) {
         trace_nvme_err_invalid_prp();
@@ -1559,7 +1559,7 @@ static void nvme_init_req(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     memset(&req->cqe, 0, sizeof(req->cqe));
     req->cqe.cid =3D le16_to_cpu(cmd->cid);
=20
-    req->cmd_opcode =3D cmd->opcode;
+    memcpy(&req->cmd, cmd, sizeof(NvmeCmd));
     req->is_cmb =3D false;
=20
     req->status =3D NVME_SUCCESS;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 70f4781a1b61..7e1e026d90e6 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -52,7 +52,7 @@ typedef struct NvmeRequest {
     uint16_t status;
     bool     is_cmb;
     bool     is_write;
-    uint8_t  cmd_opcode;
+    NvmeCmd  cmd;
=20
     QTAILQ_HEAD(, NvmeBlockBackendRequest) blk_req_tailq;
     QTAILQ_ENTRY(NvmeRequest)entry;
@@ -143,7 +143,7 @@ typedef struct NvmeCtrl {
=20
 static inline bool nvme_rw_is_write(NvmeRequest *req)
 {
-    return req->cmd_opcode =3D=3D NVME_CMD_WRITE;
+    return req->cmd.opcode =3D=3D NVME_CMD_WRITE;
 }
=20
 static inline bool nvme_is_error(uint16_t status, uint16_t err)
--=20
2.21.0


