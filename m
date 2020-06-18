Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E587C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B8A207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNbbsFy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B8A207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlubH-0001FM-JV
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVI-0006Fq-2a
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVG-0005nF-FA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=OibOZtXl0nJKd8+ioRcnMXHkdEee8Tial68a0/hODkQ=;
 b=cNbbsFy1uhRFctTrB0wtisVHq62qErAB8QqGCuzQA5jW3kD54j18yYn2o822ob/5ZEwLnn
 ST+gFzHxgQTQkDSG08lMlDqkhegIIQkpYQrMP1W6ph+HgzvUjYRoLWcZCC8uqQ+sZxA4Ea
 vzDXGcS1vLCe08OI5Q9B5YDICQwTpv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-eczTqWFtNYupTgqTHpJo8g-1; Thu, 18 Jun 2020 09:22:47 -0400
X-MC-Unique: eczTqWFtNYupTgqTHpJo8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED9EA100A47B;
 Thu, 18 Jun 2020 13:22:41 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7AE5BAC2;
 Thu, 18 Jun 2020 13:22:39 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 13/33] net: cadence_gem: Fix irq update w.r.t queue
Date: Thu, 18 Jun 2020 21:21:28 +0800
Message-Id: <1592486508-6135-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Set irq's specific to a queue, present implementation is setting q1 irq
based on q0 status.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/cadence_gem.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index fd3e4a8..4ad6c8e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -554,29 +554,10 @@ static void gem_update_int_status(CadenceGEMState *s)
 {
     int i;
 
-    if (!s->regs[GEM_ISR]) {
-        /* ISR isn't set, clear all the interrupts */
-        for (i = 0; i < s->num_priority_queues; ++i) {
-            qemu_set_irq(s->irq[i], 0);
-        }
-        return;
-    }
+    qemu_set_irq(s->irq[0], !!s->regs[GEM_ISR]);
 
-    /* If we get here we know s->regs[GEM_ISR] is set, so we don't need to
-     * check it again.
-     */
-    if (s->num_priority_queues == 1) {
-        /* No priority queues, just trigger the interrupt */
-        DB_PRINT("asserting int.\n");
-        qemu_set_irq(s->irq[0], 1);
-        return;
-    }
-
-    for (i = 0; i < s->num_priority_queues; ++i) {
-        if (s->regs[GEM_INT_Q1_STATUS + i]) {
-            DB_PRINT("asserting int. (q=%d)\n", i);
-            qemu_set_irq(s->irq[i], 1);
-        }
+    for (i = 1; i < s->num_priority_queues; ++i) {
+        qemu_set_irq(s->irq[i], !!s->regs[GEM_INT_Q1_STATUS + i - 1]);
     }
 }
 
-- 
2.5.0


