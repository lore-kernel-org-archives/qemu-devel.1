Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D97DC46486
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F15F218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhEdfjUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F15F218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4XO-0007Qo-JQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4He-00084M-6W
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Hb-0002JG-VN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HU-000273-90
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id v19so6665283wmj.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5wnKprFO/ti+kN4tLaASb1pcE7lyZq24vpfhZiH+fvc=;
 b=XhEdfjUoB0lVWD6VZG5D22/kRWGs7Iem0vrbNPguu8wIaCs2mIAkoix7/e+z6XQUFr
 JRGkLDO+IeZ7PvXVe9wEcyGv38WNEQsZ5qFEQpe9i6zye5F9G/1eP3sto8aw3azKQzcR
 9vl6SprLy4DMbrmNTN+xFQG0XUrOGRvPfE/i1lH4/91x74m+WUFMhQWn7KEWA8c1WzWi
 inPq7EMw7AgWgLwE3pZJ4uI+x+ROAJiuoDgwH0WOUWdMoi0zEOu2aJoWy5sTqcOG0oMu
 N7lVfyE0U82zf+uHghIfuu8wA63FyYZJYXx668sXoQNBxvTf38AG/DEHy/GO1jJQWoit
 a1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5wnKprFO/ti+kN4tLaASb1pcE7lyZq24vpfhZiH+fvc=;
 b=gjyBpfOkKCvNEOoMvIzR6ceWBB9RDjvPvqlmZmEdjD/HGdgAOJmntROB1VnffJYLCA
 fPCAM/KO+cfOubsE3PMkNcROcIJ55/tKD2nXC3d7X+TzC8WpSucePBBx8907GOZE2frX
 aqWgeBVpp8GfyIaRSwYInWuBHUzi7PMfYpCcxf9pfrsiYiqmLgio5LoVCTvBcHn9+Kmf
 cXeOxPcra3+JjGls5i5UOizWezCHqlnV2P9j5jlSIUJMZ1lszaagC+kMwfyZRxha2e1v
 s5BPIAyQdYnEfYDjG6xPVGRcvZE5hV2WOuREAW4T0Cx+CvB8L65FbS8CCMQtp4wflUGa
 nXag==
X-Gm-Message-State: APjAAAXeZVhIPFgm3qCgK/afqmNvQ/MJoHsbqd9Rl2reQ248ShaK07vs
 3nHUDn6oeF3qkHuMu6cMYn6+/5aLynI4OQ==
X-Google-Smtp-Source: APXvYqxrw3LuhmVaU4JoV2JQvyZrWQlOtJSaW4RKKpSfPB5o9ezfwWCyrTnH+5ijRY5ZoqelHGMIYQ==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr192061wmj.43.1562256493136;
 Thu, 04 Jul 2019 09:08:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:07:57 +0100
Message-Id: <20190704160802.12419-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 4/9] arm v8M: Forcibly clear negative-priority
 exceptions on deactivate
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To prevent execution priority remaining negative if the guest
returns from an NMI or HardFault with a corrupted IPSR, the
v8M interrupt deactivation process forces the HardFault and NMI
to inactive based on the current raw execution priority,
even if the interrupt the guest is trying to deactivate
is something else. In the pseudocode this is done in the
Deactivate() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190617175317.27557-3-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index b8ede30b3cb..330eb728dd5 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -812,15 +812,45 @@ void armv7m_nvic_get_pending_irq_info(void *opaque,
 int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
 {
     NVICState *s = (NVICState *)opaque;
-    VecInfo *vec;
+    VecInfo *vec = NULL;
     int ret;
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
 
-    if (secure && exc_is_banked(irq)) {
-        vec = &s->sec_vectors[irq];
-    } else {
-        vec = &s->vectors[irq];
+    /*
+     * For negative priorities, v8M will forcibly deactivate the appropriate
+     * NMI or HardFault regardless of what interrupt we're being asked to
+     * deactivate (compare the DeActivate() pseudocode). This is a guard
+     * against software returning from NMI or HardFault with a corrupted
+     * IPSR and leaving the CPU in a negative-priority state.
+     * v7M does not do this, but simply deactivates the requested interrupt.
+     */
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
+        switch (armv7m_nvic_raw_execution_priority(s)) {
+        case -1:
+            if (s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+                vec = &s->vectors[ARMV7M_EXCP_HARD];
+            } else {
+                vec = &s->sec_vectors[ARMV7M_EXCP_HARD];
+            }
+            break;
+        case -2:
+            vec = &s->vectors[ARMV7M_EXCP_NMI];
+            break;
+        case -3:
+            vec = &s->sec_vectors[ARMV7M_EXCP_HARD];
+            break;
+        default:
+            break;
+        }
+    }
+
+    if (!vec) {
+        if (secure && exc_is_banked(irq)) {
+            vec = &s->sec_vectors[irq];
+        } else {
+            vec = &s->vectors[irq];
+        }
     }
 
     trace_nvic_complete_irq(irq, secure);
-- 
2.20.1


