Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15961C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED542075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaiz465d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED542075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXzhT-0003bC-21
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 00:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXzgp-0002ee-Lc
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:05:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXzgk-00031I-6o
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589169906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fyFRwCc6QxaUaElcPQY1UK+XmfhSoaN7N7ZlRv46jlQ=;
 b=aaiz465dYtFt+LKybO21WsiX2hsqpjv3PdN5G0TGnNs2TywaoqGHfrQXAArQv50lBS9hAV
 Fw5NYcYzGORq2FGGgMirSqoWTnL5UHEMY1MVjvJwHsmNpbIZaKmwF8u4k2SJCw+GN8wWqY
 Jf74vTqScKyJ3p4xmEgCqhEqVIwBvQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-4bZG_wYLOSmfaQOsQULkiQ-1; Mon, 11 May 2020 00:05:04 -0400
X-MC-Unique: 4bZG_wYLOSmfaQOsQULkiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CE02461;
 Mon, 11 May 2020 04:05:03 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 967E11001925;
 Mon, 11 May 2020 04:04:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com
Subject: [PATCH] net: use peer when purging queue in
 qemu_flush_or_purge_queue_packets()
Date: Mon, 11 May 2020 12:04:53 +0800
Message-Id: <20200511040453.23956-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 23:06:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alxndr@bu.edu, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sender of packet will be checked in the qemu_net_queue_purge() but
we use NetClientState not its peer when trying to purge the incoming
queue in qemu_flush_or_purge_packets(). This will trigger the assert
in virtio_net_reset since we can't pass the sender check.

Fix by using the peer.

Reported-by: "Alexander Bulekov" <alxndr@bu.edu>
Fixes: ca77d85e1dbf9 ("net: complete all queued packets on VM stop")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 38778e831d..9e47cf727d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -610,7 +610,7 @@ void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge)
         qemu_notify_event();
     } else if (purge) {
         /* Unable to empty the queue, purge remaining packets */
-        qemu_net_queue_purge(nc->incoming_queue, nc);
+        qemu_net_queue_purge(nc->incoming_queue, nc->peer);
     }
 }
 
-- 
2.20.1


