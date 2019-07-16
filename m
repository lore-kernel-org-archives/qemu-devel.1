Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA5C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6181B206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6181B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQMP-000743-PJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnQLg-0004JA-2q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnQLf-00021f-2S
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnQLc-00020b-KG; Tue, 16 Jul 2019 12:30:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7556285AE;
 Tue, 16 Jul 2019 16:30:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC65C5C28D;
 Tue, 16 Jul 2019 16:30:32 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 19:30:20 +0300
Message-Id: <20190716163020.13383-4-mlevitsk@redhat.com>
In-Reply-To: <20190716163020.13383-1-mlevitsk@redhat.com>
References: <20190716163020.13383-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 16 Jul 2019 16:30:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 3/3] block/nvme: don't touch the completion
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/nvme.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 35ce10dc79..c28755cc31 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -318,7 +318,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
     while (q->inflight) {
         int16_t cid;
         c = (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES];
-        if (!c->cid || (le16_to_cpu(c->status) & 0x1) == q->cq_phase) {
+        if ((le16_to_cpu(c->status) & 0x1) == q->cq_phase) {
             break;
         }
         q->cq.head = (q->cq.head + 1) % NVME_QUEUE_SIZE;
@@ -342,10 +342,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
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


