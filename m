Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5815F21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fybt316F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5815F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHt9n-0000Dd-05
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7R-0006cM-8B
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7P-0002EB-OE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7P-0002DR-CR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so3928256wml.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=naa7xg2s4V4Ih3fFkoGzCGOvDaxJr7Ss6St8GXFDrdg=;
 b=Fybt316FzjeS3HF9a6qrViSMmsZaV7kgC+Ee2l59Zh4st3gK8fyskTJqzmxDnjfi9a
 bPt0U7taa+Rlc3QixUjfB5WdUmUSP+rTgsgdp75LsXvZVl2+rKUQwvO2ORbuKgeN6Oa0
 FsinJEwk9YmXf6rPSgpjDJYD6d5/QdD6JWFt+arGUcLkBQBtEIL3+UFVbJDcGUbkgov5
 lHRODwz5kUJ1gDE1zwzlAMo5RE3+zjvVHqkn3eAXhHs4GNpIkab3epgaILUJJZHeIZah
 YaOAHYdxxjLF1aa5KtiqPk+bf2SXbGzA2pSZTCsWW4zHnJnAkFfVsDKR2Ndk+lmdlhmq
 OBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=naa7xg2s4V4Ih3fFkoGzCGOvDaxJr7Ss6St8GXFDrdg=;
 b=pbHCGJMzMLS+FlKTCA5AXZ7TN2H4D1Of6E3RAboLhdfRtkqi3EchL8/N/N55cQ9P6G
 /fVmNfyqk/RUXF3OkaqgpxccI3jUmCJCvXv2rrySLVw+7ghH5r7q8Gd4gOKNYEjfFuXT
 b5BWlpZzT6qEfk+te+chtobJmbUXrIkHCqFyfwIib3GBLops1OCEOQYe441lMpulZAiR
 1+880x9bfVUemCds3LE//NIYzcoKdV4qodHollCUfEs1LJPhCWjyXtGZ7pSc1Tkl40WG
 6dJoZ7BtLG9vKipMTJ9jXF3iKi938/xtvbT3DfsVFAqDHssqZzSpP4A+O+2O+J49K/Sz
 LyXg==
X-Gm-Message-State: APjAAAW6pJZPuvq9vlsYTkp3LcMtMD5ajpqVUHQHwpV3LETcg8qIskuF
 MA6rMhnpbJpXG4jyyc817Mks9g==
X-Google-Smtp-Source: APXvYqxoykkcq0rqepQ6/Dmopbc1EYZU6JfJU4M2jEIy2g9wRQ1+G8FrLEd+SR+mMqx5bIX8bVR7DA==
X-Received: by 2002:a05:600c:2489:: with SMTP id
 9mr4591426wms.131.1570555070234; 
 Tue, 08 Oct 2019 10:17:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/21] hw/arm/musicpal.c: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:24 +0100
Message-Id: <20191008171740.9679-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the musicpal code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b3624d5e280..f68a399a984 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -843,13 +843,10 @@ static void mv88w8618_timer_tick(void *opaque)
 static void mv88w8618_timer_init(SysBusDevice *dev, mv88w8618_timer_state *s,
                                  uint32_t freq)
 {
-    QEMUBH *bh;
-
     sysbus_init_irq(dev, &s->irq);
     s->freq = freq;
 
-    bh = qemu_bh_new(mv88w8618_timer_tick, s);
-    s->ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(mv88w8618_timer_tick, s, PTIMER_POLICY_DEFAULT);
 }
 
 static uint64_t mv88w8618_pit_read(void *opaque, hwaddr offset,
@@ -879,16 +876,19 @@ static void mv88w8618_pit_write(void *opaque, hwaddr offset,
     case MP_PIT_TIMER1_LENGTH ... MP_PIT_TIMER4_LENGTH:
         t = &s->timer[offset >> 2];
         t->limit = value;
+        ptimer_transaction_begin(t->ptimer);
         if (t->limit > 0) {
             ptimer_set_limit(t->ptimer, t->limit, 1);
         } else {
             ptimer_stop(t->ptimer);
         }
+        ptimer_transaction_commit(t->ptimer);
         break;
 
     case MP_PIT_CONTROL:
         for (i = 0; i < 4; i++) {
             t = &s->timer[i];
+            ptimer_transaction_begin(t->ptimer);
             if (value & 0xf && t->limit > 0) {
                 ptimer_set_limit(t->ptimer, t->limit, 0);
                 ptimer_set_freq(t->ptimer, t->freq);
@@ -896,6 +896,7 @@ static void mv88w8618_pit_write(void *opaque, hwaddr offset,
             } else {
                 ptimer_stop(t->ptimer);
             }
+            ptimer_transaction_commit(t->ptimer);
             value >>= 4;
         }
         break;
@@ -914,8 +915,11 @@ static void mv88w8618_pit_reset(DeviceState *d)
     int i;
 
     for (i = 0; i < 4; i++) {
-        ptimer_stop(s->timer[i].ptimer);
-        s->timer[i].limit = 0;
+        mv88w8618_timer_state *t = &s->timer[i];
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_stop(t->ptimer);
+        ptimer_transaction_commit(t->ptimer);
+        t->limit = 0;
     }
 }
 
-- 
2.20.1


