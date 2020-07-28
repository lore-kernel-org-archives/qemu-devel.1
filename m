Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AAFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E7920759
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNfq+3tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E7920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0LfO-0000sW-IV
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Ld9-0006Ok-RR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:10:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Ld8-0007Df-9g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595927437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=BizKAjSDHwqLVrq96cuiIXoDoNkf2Pbi3L5JlP/JAHo=;
 b=NNfq+3tDlUgum+tX/fc4QPR30/gtTOAuRdzW9Zhj5R6mh2B1LpcJIKwypPTZrybl5LRahZ
 dZ5yoNM6EqdHt4L0JnkMVcfThZMW1cEO32dmiGQ9uJFLNk9jNdqJuXx1KJQbf9ewl9kO4i
 zoAdVHPtVxMQ/rSE3KcziAfE3m3MKi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-jK5oLramPnaKBWu5pCTfiQ-1; Tue, 28 Jul 2020 05:10:35 -0400
X-MC-Unique: jK5oLramPnaKBWu5pCTfiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26E51932480;
 Tue, 28 Jul 2020 09:10:34 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-214.pek2.redhat.com
 [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7EE90E62;
 Tue, 28 Jul 2020 09:10:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 3/3] net: forbid the reentrant RX
Date: Tue, 28 Jul 2020 17:10:19 +0800
Message-Id: <1595927419-27346-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
References: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory API allows DMA into NIC's MMIO area. This means the NIC's
RX routine must be reentrant. Instead of auditing all the NIC, we can
simply detect the reentrancy and return early. The queue->delivering
is set and cleared by qemu_net_queue_deliver() for other queue helpers
to know whether the delivering in on going (NIC's receive is being
called). We can check it and return early in qemu_net_queue_flush() to
forbid reentrant RX.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/queue.c b/net/queue.c
index 0164727..19e32c8 100644
--- a/net/queue.c
+++ b/net/queue.c
@@ -250,6 +250,9 @@ void qemu_net_queue_purge(NetQueue *queue, NetClientState *from)
 
 bool qemu_net_queue_flush(NetQueue *queue)
 {
+    if (queue->delivering)
+        return false;
+
     while (!QTAILQ_EMPTY(&queue->packets)) {
         NetPacket *packet;
         int ret;
-- 
2.7.4


