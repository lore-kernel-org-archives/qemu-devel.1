Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD0DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94F820650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcKcYb4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94F820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgW8-00025d-1P
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxv-0007cI-MP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxt-0000rI-Dl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxt-0000qo-7a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id r141so3206480wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AY2/tIXkLZV7yrWE3pOZo6OjdcTvWP16EPP+NMcPWOY=;
 b=rcKcYb4Q/C6aJJS7RCxWq/1+9rYHncrV6q41sNHFI/21mW++j72hExwaa4beHA0AA3
 Gu/SbVrRB4T983waVo533cEl0BSpGEQlDk6I/D2vAaTMmo/evCpadKor5vYzVsD+ybRA
 5cVsEafLhmYPQZsineSASfQiodZVhWCWHZZhD78TEnuY1ioY9d3pai5e64MwqA0UorLN
 a98YK5giwQf+3q+MHRWdttSvg6PMvGuHAjQkrrY9VGyX/LufVwxnk0+lUaJQT8CG5wSk
 RH9oYavr+37dRDiTQqS724yGmZfeJE8SydO9ey4shwVZI5CHsNJgms9lNTO4v+pjIt47
 l2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AY2/tIXkLZV7yrWE3pOZo6OjdcTvWP16EPP+NMcPWOY=;
 b=GLXAPiEunqo6QTx7gf7zY3iX6oWfzmZrfcOsXgzK7eybwxlFPhPYdYqGNkrleYMQHy
 29TRDfoYe720z7VppAp0t5WHcogUC2RtP17rwbBjwgzv3Y1k+2hixaSIIwD26roQQ2tr
 /B/A39Tv9QhlfScrxWzeSIDS5NsdQAqnjeMp0H8V1WRbzWpiQBv1IHQhhatg7Aick1vs
 e9cQ5rl7gpn+5LBgAsVV8V1oeDl9UnnVidgGiomzgDeKCnFeOuKbdp+cXAD8vJ3mca5F
 qFCHVjvwgrnQbp/Rl4cuNsxXFgt0gz8dyjzJ9rhgTe9bjLEfxQ71KQ3P5bDc1e7oV8/i
 Qhmg==
X-Gm-Message-State: APjAAAWupHZm1ExQ4JHA5d29Dh8uCIV64t035Z9yH6r1LGi3j3YYZSRY
 OMJh2dBbbY+uuOPoi82TouZ3N50ryQk=
X-Google-Smtp-Source: APXvYqwCXIgrKooOxhOXVjcGh/+VvflhVDg+EFPTi4pljyMlERcPGVrKypgba3h22dIg3fnvTZJlGA==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr5688761wma.75.1571934475889; 
 Thu, 24 Oct 2019 09:27:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/51] target/arm: Rebuild hflags for M-profile NVIC
Date: Thu, 24 Oct 2019 17:26:56 +0100
Message-Id: <20191024162724.31675-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Richard Henderson <richard.henderson@linaro.org>

Continue setting, but not relying upon, env->hflags.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8e93e51e815..e8c74f9ebaf 100644
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
2.20.1


