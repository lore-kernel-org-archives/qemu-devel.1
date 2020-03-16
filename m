Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC07206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC07206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsrB-0001G9-N7
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkU-0008PS-8g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkS-0007td-Tz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:46 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkO-0007IY-NY; Mon, 16 Mar 2020 10:29:40 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 60924BF8F5;
 Mon, 16 Mar 2020 14:29:39 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 08/42] nvme: add support for the abort command
Date: Mon, 16 Mar 2020 07:28:54 -0700
Message-Id: <20200316142928.153431-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.1 ("Abort command").

The Abort command is a best effort command; for now, the device always
fails to abort the given command.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 08a83d449de3..7cf7cf55143e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -729,6 +729,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *=
cmd)
     }
 }
=20
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    uint16_t sqid =3D le32_to_cpu(cmd->cdw10) & 0xffff;
+
+    req->cqe.result =3D 1;
+    if (nvme_check_sqid(n, sqid)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
 {
     trace_nvme_dev_setfeat_timestamp(ts);
@@ -863,6 +875,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
         return nvme_identify(n, cmd);
+    case NVME_ADM_CMD_ABORT:
+        return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
@@ -1375,6 +1389,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
     id->oacs =3D cpu_to_le16(0);
+
+    /*
+     * Because the controller always completes the Abort command immedia=
tely,
+     * there can never be more than one concurrently executing Abort com=
mand,
+     * so this value is never used for anything. Note that there can eas=
ily be
+     * many Abort commands in the queues, but they are not considered
+     * "executing" until processed by nvme_abort.
+     *
+     * The specification recommends a value of 3 for Abort Command Limit=
 (four
+     * concurrently outstanding Abort commands), so lets use that though=
 it is
+     * inconsequential.
+     */
+    id->acl =3D 3;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 0;
     id->sqes =3D (0x6 << 4) | 0x6;
--=20
2.25.1


