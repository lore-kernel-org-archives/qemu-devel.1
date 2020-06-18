Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F9EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379D5207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxd+qwTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379D5207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlulv-0004hL-8v
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVe-0007MP-5n
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVb-0005qW-Vt
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=5Gi6cBzf5l3uKd3fW93e7qFjVJl3npUVGDjlWniZTbQ=;
 b=cxd+qwTAIfZCy8ODTOV6i7KoboUxVyyXYLMmp9vp37FkCMqs/vyz/jg60GbltZ0Ii7k6xJ
 LGxXl9NWNIrpTCSb3d7B2zRE2loJ+7RNASxVvsljLM9qwzQDYk4F8Ny0T00pAtjQ3Ty9hI
 jttVhPG9AZNlDA6/TLqhI72uCgBAW/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-rSCrm84SOOC7eQQJa8KuAg-1; Thu, 18 Jun 2020 09:23:07 -0400
X-MC-Unique: rSCrm84SOOC7eQQJa8KuAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B87D480F5C1;
 Thu, 18 Jun 2020 13:23:06 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81C9F5BAC2;
 Thu, 18 Jun 2020 13:23:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 23/33] net: use peer when purging queue in
 qemu_flush_or_purge_queue_packets()
Date: Thu, 18 Jun 2020 21:21:38 +0800
Message-Id: <1592486508-6135-24-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sender of packet will be checked in the qemu_net_queue_purge() but
we use NetClientState not its peer when trying to purge the incoming
queue in qemu_flush_or_purge_packets(). This will trigger the assert
in virtio_net_reset since we can't pass the sender check:

hw/net/virtio-net.c:533: void virtio_net_reset(VirtIODevice *): Assertion
`!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
#9 0x55a33fa31b78 in virtio_net_reset hw/net/virtio-net.c:533:13
#10 0x55a33fc88412 in virtio_reset hw/virtio/virtio.c:1919:9
#11 0x55a341d82764 in virtio_bus_reset hw/virtio/virtio-bus.c:95:9
#12 0x55a341dba2de in virtio_pci_reset hw/virtio/virtio-pci.c:1824:5
#13 0x55a341db3e02 in virtio_pci_common_write hw/virtio/virtio-pci.c:1252:13
#14 0x55a33f62117b in memory_region_write_accessor memory.c:496:5
#15 0x55a33f6205e4 in access_with_adjusted_size memory.c:557:18
#16 0x55a33f61e177 in memory_region_dispatch_write memory.c:1488:16

Reproducer:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg701914.html

Fix by using the peer.

Reported-by: "Alexander Bulekov" <alxndr@bu.edu>
Acked-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: ca77d85e1dbf9 ("net: complete all queued packets on VM stop")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index cbeeead..4c62b10 100644
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
2.5.0


