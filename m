Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96982C10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693352087C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693352087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG297-0006Bw-8a
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:59:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27U-00055s-84
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27T-0007xl-D3
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hG27R-0007uV-B3; Mon, 15 Apr 2019 09:57:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8D94308FC4D;
	Mon, 15 Apr 2019 13:57:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EEB81001DE8;
	Mon, 15 Apr 2019 13:57:52 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 16:57:43 +0300
Message-Id: <20190415135746.7571-3-mlevitsk@redhat.com>
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 15 Apr 2019 13:57:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/5] block/nvme: fix doorbell stride
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415135743.oSLIBtdQCQlUrms6lVdDALtRgXXOvLBZAmMIEBw4cW8@z>

Fix the math involving non standard doorbell stride

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 2d208000df..208242cf1f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -216,7 +216,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
         error_propagate(errp, local_err);
         goto fail;
     }
-    q->cq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale + 1];
+    q->cq.doorbell = &s->regs->doorbells[(idx * 2 + 1) * s->doorbell_scale];
 
     return q;
 fail:
-- 
2.17.2


