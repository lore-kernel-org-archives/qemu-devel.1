Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0BD20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0BD20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt3c-0006nM-EP
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlF-0000QJ-KO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlC-0004VT-8i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDql6-0001sC-SE; Mon, 16 Mar 2020 10:30:25 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id B0D31BF965;
 Mon, 16 Mar 2020 14:29:46 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 22/42] nvme: memset preallocated requests structures
Date: Mon, 16 Mar 2020 07:29:08 -0700
Message-Id: <20200316142928.153431-23-its@irrelevant.dk>
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

This is preparatory to subsequent patches that change how QSGs/IOVs are
handled. It is important that the qsg and iov members of the NvmeRequest
are initially zeroed.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 26c4b6e69f72..08267e847671 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -597,7 +597,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     sq->size =3D size;
     sq->cqid =3D cqid;
     sq->head =3D sq->tail =3D 0;
-    sq->io_req =3D g_new(NvmeRequest, sq->size);
+    sq->io_req =3D g_new0(NvmeRequest, sq->size);
=20
     QTAILQ_INIT(&sq->req_list);
     QTAILQ_INIT(&sq->out_req_list);
--=20
2.25.1


