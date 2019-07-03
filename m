Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65832187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65832187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hii3Z-0006Y4-NX
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54990)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hihg9-0007Qa-1u
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hihg7-0002Lk-0B
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hihfy-0002DO-OA; Wed, 03 Jul 2019 12:00:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 485D985A04;
 Wed,  3 Jul 2019 16:00:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com
 [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCD72519C2;
 Wed,  3 Jul 2019 15:59:53 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 18:59:39 +0300
Message-Id: <20190703155944.9637-2-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-1-mlevitsk@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 16:00:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/6] block/nvme: don't touch the completion
 entries
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Completion entries are meant to be only read by the host and written by the device.
The driver is supposed to scan the completions from the last point where it left,
and until it sees a completion with non flipped phase bit.


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 73ed5fa75f..6d4e7f3d83 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -315,7 +315,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
     while (q->inflight) {
         int16_t cid;
         c = (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES];
-        if (!c->cid || (le16_to_cpu(c->status) & 0x1) == q->cq_phase) {
+        if ((le16_to_cpu(c->status) & 0x1) == q->cq_phase) {
             break;
         }
         q->cq.head = (q->cq.head + 1) % NVME_QUEUE_SIZE;
@@ -339,10 +339,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
         qemu_mutex_unlock(&q->lock);
         req.cb(req.opaque, nvme_translate_error(c));
         qemu_mutex_lock(&q->lock);
-        c->cid = cpu_to_le16(0);
         q->inflight--;
-        /* Flip Phase Tag bit. */
-        c->status = cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
         progress = true;
     }
     if (progress) {
-- 
2.17.2


