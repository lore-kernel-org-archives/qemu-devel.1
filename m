Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03019CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05A42064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7hUYkvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05A42064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIlt-0000sd-Fi
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8x-0008F7-08
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8s-0001Ic-BS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:46 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8s-0001BC-1G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:42 -0400
Received: by mail-qt1-x844.google.com with SMTP id o49so24899748qta.7
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X22okviioTNDt7zI04Hhn7/Ba9cdRHpUwnG0LrTV7qc=;
 b=W7hUYkvBV4U84FkGgu5j4qdKyHLytPYVaAmgc1TcoF7kDY+hBgJktlSMHu+sOn8g8v
 6j2aDHaY00/K32dfJPL8WYfJtG4JCQ3olPYZFb+7LrS6dlWB7SXkMRgIHCj9mebasoL3
 nvSC2yN9Lsu+cyPMophx5upiL8QYj2jR0y9R7/xk49LkWcVJv0UDchl71MIj74mUk2HL
 GJVCqsBeYj4ytI5c8gMrf2CcO6NkTvHJ6e+eNrQq7m03xCHMOs1/5RVkH8YzxB07hI3i
 UFQSIbaqNeJALnezQuP1x8/VT1Xv51oTQswEnCSpxJScLmL+00Ykn81brw/Z821lJMKZ
 Ftyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X22okviioTNDt7zI04Hhn7/Ba9cdRHpUwnG0LrTV7qc=;
 b=iVbz34qPHy+poOgbzXhKsrmI40gtO5VoQnHnFrohudynp7Wj26z3d3nYX/2i8K+7Ox
 /y3Jonlrrg4nm3MbcMBKeNC3lgfJEg6J1n2X3Z6pwLia179BHu1rAmz8YuCaG8SoyDfD
 2c747v/joNZZ1xYz8YYRKyE8hP/xbyM9YBZp6ZHbYceaiuyM13qqQ9Pn0y8srfzZ/Mqq
 a2ymdexCXo6DbWAWBkmRUfxVDL+h7j20dVGlTRyD+2xswRTK/OVC3/tXpKONJ2yrYQCN
 igXkWnr6Gs6NBedmTIqE0GJiErRLOLSTRy9lGwFBXgLEBdfHxEXURGVxu+X5ovaniKym
 15Kg==
X-Gm-Message-State: APjAAAXbagvgJozcISCl5kSUB5U8Htk/GwjKX2VsbYOTrHIHGWlzkC0V
 J3i1LndJkvQYT+BhGAr+5Cx3bRiBXuw=
X-Google-Smtp-Source: APXvYqzwMsqdinJ/S+z+oMWC3UdLEQNd1VjGgTpfl9fj+J99q/H/udX72efLIoZwIysab7KRXflctg==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr9752190qtj.275.1571842890760; 
 Wed, 23 Oct 2019 08:01:30 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 21/24] target/arm: Rebuild hflags for M-profile NVIC
Date: Wed, 23 Oct 2019 11:00:54 -0400
Message-Id: <20191023150057.25731-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/armv7m_nvic.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8e93e51e81..e8c74f9eba 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2251,7 +2251,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0x200 ... 0x23f: /* NVIC Set pend */
         /* the special logic in armv7m_nvic_set_pending()
          * is not needed since IRQs are never escalated
@@ -2269,9 +2269,9 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0x300 ... 0x33f: /* NVIC Active */
-        return MEMTX_OK; /* R/O */
+        goto exit_ok; /* R/O */
     case 0x400 ... 0x5ef: /* NVIC Priority */
         startvec = (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
 
@@ -2281,10 +2281,10 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
-            return MEMTX_OK;
+            goto exit_ok;
         }
         /* fall through */
     case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
@@ -2299,10 +2299,10 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             set_prio(s, hdlidx, sbank, newprio);
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
-            return MEMTX_OK;
+            goto exit_ok;
         }
         /* All bits are W1C, so construct 32 bit value with 0s in
          * the parts not written by the access size
@@ -2322,15 +2322,19 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
              */
             s->cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
         }
-        return MEMTX_OK;
+        goto exit_ok;
     }
     if (size == 4) {
         nvic_writel(s, offset, value, attrs);
-        return MEMTX_OK;
+        goto exit_ok;
     }
     qemu_log_mask(LOG_GUEST_ERROR,
                   "NVIC: Bad write of size %d at offset 0x%x\n", size, offset);
     /* This is UNPREDICTABLE; treat as RAZ/WI */
+
+ exit_ok:
+    /* Ensure any changes made are reflected in the cached hflags.  */
+    arm_rebuild_hflags(&s->cpu->env);
     return MEMTX_OK;
 }
 
-- 
2.17.1


