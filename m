Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1035FC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3482189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AISnyTEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3482189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4NW-0006Sq-1E
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4He-00084I-6W
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Hb-0002J3-Qy
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HU-00029V-8V
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id p11so1674521wro.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZYBnDUJAtZx/GB1Y3ulbQN75K6eLU21AWTYRu4y7eKY=;
 b=AISnyTEvdVKOJfjt6IejblXYshj9aENKpqh+Ur/b/hX3dMAA7E7EunEMkLtXZtxrmO
 55JJWGpVEoulv5hO59X2SknscOR5EItwZJvUb7RZne8CKYL2WK4FaR7jEWtXIwITiicL
 QUscExFORSmRgRGjy40UXiPm5Ah3BAVJEXQYxiEf4AHYYrARKmVcxfKX3apgtavF3kBz
 zbzI7ImOM7N5f6vcemUD7iKT+8Oc9gTQ0TFErXHoQ5vt5Da445fBmhy2m400Gxwr7yX5
 Ny1eFog0PtBXj1zASCJJvmkjb15Z/tboeDx/c2gaQfp/MvExohXWdn36mgse3u5dy8o2
 Xuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZYBnDUJAtZx/GB1Y3ulbQN75K6eLU21AWTYRu4y7eKY=;
 b=FnqlBZrg7af3dyqLw2kBErIDQ/EfQXQUhcWjo6PkTsOVkeLxkW9O8UyUGNm1/sEI+n
 vcxZR5HwgcnOki6hWsqP55jQ+daDDIUX3v2f0lSNNw5VHt0W2MD8xLf15lL+k3jioCJU
 R4rYEBStTZP0bn0z65RLNbCgDq0wmLuYmhdPXd0cnvjQUv9EFzfwDKA3FdRLEq9bBKbx
 PRTvcxtb0+fzbqmP/ZnGlK8SGd3PzHZPPBYPaB21l47qilAyrhNc+sfB4W+4tsEo55Nu
 ZQZUc/PiGMTNYjPnLwOklDeTp/2cu+J8AZYkQDAKf918Z+DTVjeq/k7xguLB29HAXtU0
 VZfw==
X-Gm-Message-State: APjAAAVFxucRl7jDE5uLZ1yoxH5PFP+tgdrW01SHQxWyi3YQO+S9aI5Q
 9B6pUl6hHl8+XSY3Nu5qJ6AtC1IIqO0Ojw==
X-Google-Smtp-Source: APXvYqz5HTYdfWdWgpV0Q6MGOZLcygTIq1IOI6fMwO27e11z406Xm6NwEnGE4ZDJMBXbHl5KgA0SqQ==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr28912059wrq.193.1562256495923; 
 Thu, 04 Jul 2019 09:08:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:08:00 +0100
Message-Id: <20190704160802.12419-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 7/9] hw/timer/armv7m_systick: Forbid
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190617175317.27557-6-peter.maydell@linaro.org
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


