Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9591DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609712074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRYUh8wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609712074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5X9-0001GH-IE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5Mg-0001lg-D6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5Ma-0005jB-GQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=nldiXqM8VmDWW6GXBzbsTcrmDvrvu3iO6lJu8FE0+Yk=;
 b=iRYUh8wc6bOUg/Kj7EFGV2UqKCDJcRdEmGibWe5FonAS3Qt883Lqhldciyf9EPAx3/47Iz
 xNHbf8YATZ4CE+VKksjMsPJvA2ilmUT5I4RjYsZli0AsE6FfKFM8KHpm+My6NL+mQHXaPQ
 Gcgb0jJ0nCZ7s6zowWPAAco7+CF0T1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-MfQ27YytNuqbjZSVeMjSXw-1; Tue, 16 Jun 2020 02:46:24 -0400
X-MC-Unique: MfQ27YytNuqbjZSVeMjSXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC57E915;
 Tue, 16 Jun 2020 06:46:23 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B74D90341;
 Tue, 16 Jun 2020 06:46:21 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 14/33] net: cadence_gem: Define access permission for interrupt
 registers
Date: Tue, 16 Jun 2020 14:45:25 +0800
Message-Id: <1592289944-13727-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Q1 to Q7 ISR's are clear-on-read, IER/IDR registers
are write-only, mask reg are read-only.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/cadence_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 4ad6c8e..72e7cf9 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -458,6 +458,7 @@ static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
  */
 static void gem_init_register_masks(CadenceGEMState *s)
 {
+    unsigned int i;
     /* Mask of register bits which are read only */
     memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
     s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
@@ -470,10 +471,19 @@ static void gem_init_register_masks(CadenceGEMState *s)
     s->regs_ro[GEM_ISR]      = 0xFFFFFFFF;
     s->regs_ro[GEM_IMR]      = 0xFFFFFFFF;
     s->regs_ro[GEM_MODID]    = 0xFFFFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_ro[GEM_INT_Q1_STATUS + i] = 0xFFFFFFFF;
+        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFF319;
+        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFF319;
+        s->regs_ro[GEM_INT_Q1_MASK + i] = 0xFFFFFFFF;
+    }
 
     /* Mask of register bits which are clear on read */
     memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
     s->regs_rtc[GEM_ISR]      = 0xFFFFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_rtc[GEM_INT_Q1_STATUS + i] = 0x00000CE6;
+    }
 
     /* Mask of register bits which are write 1 to clear */
     memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c));
@@ -485,6 +495,10 @@ static void gem_init_register_masks(CadenceGEMState *s)
     s->regs_wo[GEM_NWCTRL]   = 0x00073E60;
     s->regs_wo[GEM_IER]      = 0x07FFFFFF;
     s->regs_wo[GEM_IDR]      = 0x07FFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_wo[GEM_INT_Q1_ENABLE + i] = 0x00000CE6;
+        s->regs_wo[GEM_INT_Q1_DISABLE + i] = 0x00000CE6;
+    }
 }
 
 /*
-- 
2.5.0


