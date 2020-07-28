Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D44C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 05:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E55320658
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6a82oKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Ie0-0002lv-Dw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 01:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Id3-0001Sv-I3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 01:58:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Id1-0007Bg-W2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 01:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595915899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=BizKAjSDHwqLVrq96cuiIXoDoNkf2Pbi3L5JlP/JAHo=;
 b=O6a82oKFwGMeEhCRzI4wI+bfYB49kfxgRGeiCbA2LIHYJ1eOxZcV0eqX6gjaavqFIGC9U+
 81lM4JqssiWH0L89JGPmkna26JPTvzbLZXHDGNm1AmLiySAwnikFTqel8q53puPHclyp54
 hFR951Uibl6ITiJ/X3yBcaZ6BU0BjJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-rG0HKfY3Psqa8S7ykjuuww-1; Tue, 28 Jul 2020 01:58:15 -0400
X-MC-Unique: rG0HKfY3Psqa8S7ykjuuww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A091005504;
 Tue, 28 Jul 2020 05:58:14 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-130.pek2.redhat.com
 [10.72.13.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA021002388;
 Tue, 28 Jul 2020 05:58:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 4/4] net: forbid the reentrant RX
Date: Tue, 28 Jul 2020 13:57:58 +0800
Message-Id: <1595915878-22568-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595915878-22568-1-git-send-email-jasowang@redhat.com>
References: <1595915878-22568-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
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


