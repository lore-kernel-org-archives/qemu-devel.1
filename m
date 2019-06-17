Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A10C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C447D20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQnFthMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C447D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvsG-0004kC-23
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvp0-0007hq-Dm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvox-0000f5-RE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvov-0000do-W1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so10944984wrt.6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=v8vwTZLuhwp+bmBixmmWp52i36uK/epxo9J3L5qAyYw=;
 b=qQnFthMSJo8bfP4HEGAgZBvsS1BmZaBI2he8FBMFZln/yYefl8iffG5CDe/FQCaaoz
 /VbmNkeZ7Q5CljJMhl+5A4Wl7KgcnpOPA6fmvxdbbHorj4vdDcrkVlPuQWCOMJfKRfQI
 9CJMqwtN9y2sjTAyAf9/GH6LlNfn9pCifvGvQ15JSq2cOJj9ffzsI5T8EDAxvH905JS4
 tQcsojAIxQqGO+8Elf74KN/udytwcM2zTY+cGuqCH2hg8M3VWQbGL4SRRjYI4dciXZPj
 wj3NAPb+aQGLs78EdDOgXQw41rS6CAwVXBo1yx1fAnI5Zb+XOeJlXXzeAV081w48sKSC
 tZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v8vwTZLuhwp+bmBixmmWp52i36uK/epxo9J3L5qAyYw=;
 b=S+Abpxi7WLAh6fcvLfMRZRvGigo1mCyVG6XN2cCjRDfRM98kBKCxZkh5MPfpuSbxBD
 1myq+COcCeD+qB933cZ32btikrvTpovI+yCvL717bBwSq7OgQgHH+/yTnJzhkly1i/Op
 9RMlMuKX7p9F4YMyLUwPNIZ2njBYedP6AWc0Ehx3T9Ki9HmFoFv8eQ6WPrC5lCdzNKYi
 Fe4yeETM8heSKNfOrkwUX1dmSOkbMMtf6MZruKP+s3EOhIvt1hSSkQo2INzSi66zvtKZ
 i+pc7de6KrohoRwyk+6Gvp8rsCn0kKFIMpxP9PARcHHrMzllxRd9qQoSRKrpKfJkQ08I
 2vPw==
X-Gm-Message-State: APjAAAWii1pYQ0Pzonh1SnSvyw5McB7QqImCSbFvkUcaboooJxNGxmnH
 CrrelBoaCOfMvQKciI8h/WadIw==
X-Google-Smtp-Source: APXvYqwqM6w1EFZ19R3JVc93kj/DKxukQ0NwhiM6EyRBOTehEAg9+aMsVIP9qi+b2TvlEKsDG8/HAQ==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr62712766wrv.347.1560794008245; 
 Mon, 17 Jun 2019 10:53:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:16 +0100
Message-Id: <20190617175317.27557-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175317.27557-1-peter.maydell@linaro.org>
References: <20190617175317.27557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 5/6] hw/timer/armv7m_systick: Forbid
 non-privileged accesses
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

Like most of the v7M memory mapped system registers, the systick
registers are accessible to privileged code only and user accesses
must generate a BusFault. We implement that for registers in
the NVIC proper already, but missed it for systick since we
implement it as a separate device. Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/armv7m_systick.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index a17317ce2fe..94640743b5d 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -75,11 +75,17 @@ static void systick_timer_tick(void *opaque)
     }
 }
 
-static uint64_t systick_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult systick_read(void *opaque, hwaddr addr, uint64_t *data,
+                                unsigned size, MemTxAttrs attrs)
 {
     SysTickState *s = opaque;
     uint32_t val;
 
+    if (attrs.user) {
+        /* Generate BusFault for unprivileged accesses */
+        return MEMTX_ERROR;
+    }
+
     switch (addr) {
     case 0x0: /* SysTick Control and Status.  */
         val = s->control;
@@ -121,14 +127,21 @@ static uint64_t systick_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     trace_systick_read(addr, val, size);
-    return val;
+    *data = val;
+    return MEMTX_OK;
 }
 
-static void systick_write(void *opaque, hwaddr addr,
-                          uint64_t value, unsigned size)
+static MemTxResult systick_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size,
+                                 MemTxAttrs attrs)
 {
     SysTickState *s = opaque;
 
+    if (attrs.user) {
+        /* Generate BusFault for unprivileged accesses */
+        return MEMTX_ERROR;
+    }
+
     trace_systick_write(addr, value, size);
 
     switch (addr) {
@@ -172,11 +185,12 @@ static void systick_write(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "SysTick: Bad write offset 0x%" HWADDR_PRIx "\n", addr);
     }
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps systick_ops = {
-    .read = systick_read,
-    .write = systick_write,
+    .read_with_attrs = systick_read,
+    .write_with_attrs = systick_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-- 
2.20.1


