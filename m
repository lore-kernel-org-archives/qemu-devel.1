Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD027C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95ABF206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ABF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs17F-0005ce-TJ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hs16P-0004QO-Fc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hs16O-0003E6-GL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hs16O-0003Dh-BL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0D68A3B46;
 Mon, 29 Jul 2019 08:33:51 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-203.pek2.redhat.com
 [10.72.12.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45CC710190AA;
 Mon, 29 Jul 2019 08:33:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon, 29 Jul 2019 16:33:42 +0800
Message-Id: <1564389226-4489-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1564389226-4489-1-git-send-email-jasowang@redhat.com>
References: <1564389226-4489-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 29 Jul 2019 08:33:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/5] e1000: don't raise interrupt in pre_save()
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should not raise any interrupt after VM has been stopped but this
is what e1000 currently did when mit timer is active in
pre_save(). Fixing this by scheduling a timer in post_load() which can
make sure the interrupt was raised when VM is running.

Reported-and-tested-by: Longpeng <longpeng2@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 1dc1466..a023ceb 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1381,11 +1381,6 @@ static int e1000_pre_save(void *opaque)
     E1000State *s = opaque;
     NetClientState *nc = qemu_get_queue(s->nic);
 
-    /* If the mitigation timer is active, emulate a timeout now. */
-    if (s->mit_timer_on) {
-        e1000_mit_timer(s);
-    }
-
     /*
      * If link is down and auto-negotiation is supported and ongoing,
      * complete auto-negotiation immediately. This allows us to look
@@ -1423,7 +1418,8 @@ static int e1000_post_load(void *opaque, int version_id)
         s->mit_irq_level = false;
     }
     s->mit_ide = 0;
-    s->mit_timer_on = false;
+    s->mit_timer_on = true;
+    timer_mod(s->mit_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1);
 
     /* nc.link_down can't be migrated, so infer link_down according
      * to link status bit in mac_reg[STATUS].
-- 
2.5.0


