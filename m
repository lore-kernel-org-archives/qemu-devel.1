Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F13C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F94206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax4qgRZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F94206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTa4-0001VV-23
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9Y-0000Ap-QB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9W-0001FS-WE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Mbj5vgjss3CvRpPXq7RdlTUMRKOXIk7ERJJk8CCfwI=;
 b=ax4qgRZcff3poGzVeKIKqp3j5W6cCki1fV5nDu/MyI7Evf9/VXrPOJLbKw3BwfaSGt2ikb
 KfJ88HcwGqxvundhtj7Wlp67QCRvWq1XmpSDe/3cFMVc7yFDKxsawtljdxFWEuKuMi7sNa
 vCB4Mkg3xKXOr9TrnV2FgqSSmrz6yak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-6illYicoP4OvH4nl9KDMqA-1; Thu, 11 Jun 2020 15:45:32 -0400
X-MC-Unique: 6illYicoP4OvH4nl9KDMqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE57107ACF3;
 Thu, 11 Jun 2020 19:45:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D1E45C1B2;
 Thu, 11 Jun 2020 19:45:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 048/115] megasas: use unsigned type for reply_queue_head and
 check index
Date: Thu, 11 Jun 2020 15:43:42 -0400
Message-Id: <20200611194449.31468-49-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Ren Ding <rding@gatech.edu>, Alexander Bulekov <alxndr@bu.edu>,
 Prasad J Pandit <pjp@fedoraproject.org>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

A guest user may set 'reply_queue_head' field of MegasasState to
a negative value. Later in 'megasas_lookup_frame' it is used to
index into s->frames[] array. Use unsigned type to avoid OOB
access issue.

Also check that 'index' value stays within s->frames[] bounds
through the while() loop in 'megasas_lookup_frame' to avoid OOB
access.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Acked-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200513192540.1583887-2-ppandit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index af18c88b65..6ce598cd69 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -112,7 +112,7 @@ typedef struct MegasasState {
     uint64_t reply_queue_pa;
     void *reply_queue;
     int reply_queue_len;
-    int reply_queue_head;
+    uint16_t reply_queue_head;
     int reply_queue_tail;
     uint64_t consumer_pa;
     uint64_t producer_pa;
@@ -445,7 +445,7 @@ static MegasasCmd *megasas_lookup_frame(MegasasState *s,
 
     index = s->reply_queue_head;
 
-    while (num < s->fw_cmds) {
+    while (num < s->fw_cmds && index < MEGASAS_MAX_FRAMES) {
         if (s->frames[index].pa && s->frames[index].pa == frame) {
             cmd = &s->frames[index];
             break;
-- 
2.26.2



