Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284AC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D431A20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av7d6JyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D431A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhrr-0004CY-2p
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqr-0002nx-T1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqp-0005Ju-IF
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=w85ALhbZJIWqBZs4TodH+Ktr0CFpkx0wPRvmrKgX/54=;
 b=Av7d6JyTL7B+SSBqGftDVotZ9Rs6RPzvuoPX1zio8V1LbrCG+EtvpCX/g/lMmsVE4ss8eH
 oQkDTVDnsK41MtZadgUxeNjie7JJ6q3pTKdAWQ8qLuZNaCQXyc0wOoDjS3hpffpN+t6Z+H
 dlNMJmWrW+ktundD3Ew3z6lRpr911oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-mN0sqVA3PWavkmrTMDebzA-1; Wed, 15 Jul 2020 09:53:32 -0400
X-MC-Unique: mN0sqVA3PWavkmrTMDebzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81650E91C;
 Wed, 15 Jul 2020 13:53:31 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1FB5C57D;
 Wed, 15 Jul 2020 13:53:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 1/7] virtio-net: fix removal of failover device
Date: Wed, 15 Jul 2020 21:53:15 +0800
Message-Id: <1594821201-3708-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
References: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Juan Quintela <quintela@redhat.com>

If you have a networking device and its virtio failover device, and
you remove them in this order:
- virtio device
- the real device

You get qemu crash.
See bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1820120

Bug exist on qemu 4.2 and 5.0.
But in 5.0 don't shows because commit
77b06bba62034a87cc61a9c8de1309ae3e527d97

somehow papers over it.

CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 10cc958..4895af1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3416,6 +3416,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     g_free(n->vlans);
 
     if (n->failover) {
+        device_listener_unregister(&n->primary_listener);
         g_free(n->primary_device_id);
         g_free(n->standby_id);
         qobject_unref(n->primary_device_dict);
-- 
2.5.0


