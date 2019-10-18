Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8CACA9EAB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1F92246B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uvo+O8B5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1F92246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWeV-0004UH-90
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJC-0006wS-6Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJA-0005gO-QP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:01 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWJA-0005fm-Kt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:00 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so4340457pfl.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X22okviioTNDt7zI04Hhn7/Ba9cdRHpUwnG0LrTV7qc=;
 b=Uvo+O8B5nhB1hCuO8tXl8IgS+fjESYIng+bYLuPYt0ykIXNCI9m9GMcqDYYKDAKUKA
 B7NgaY+lnBS5CbCpqcZccKMYBn9koqvBa6866Y8ApTyAAH+4mUVRGAKNhEwRrnUmE5Sg
 GcoVkm338NIhcWuUElXc2hMzpc0a73HGAdUeC55c7a0KTnUWQFFeoVD2Z6z/U8mq70Q8
 meuefAnx0EK/BAeNBVRQDbWW2m0g+J3ZMpQZ59xkw+IcR66NyyykpZoM+gXWKxIjbUa7
 YZSxTyooCpviez/XFSKbT+Gej1f2p8N6ODFg1jmHiLx5sJGGGWtn4zz81uP1FoLWuh7D
 cMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X22okviioTNDt7zI04Hhn7/Ba9cdRHpUwnG0LrTV7qc=;
 b=BirXQzCuSv3Z3FW+HAEU/fk944JJvFkip6fqjJ8fyxfUo4aDKSaB4CNYazlwdiVs9i
 lKlPMD6R2QBPen+qaPyzWAPJSJ6ykkEbIc0zfdZwbk3f6C1xc8Ckk//3oDEdyHld29v2
 U2k0bWfgRpd3ZQM7kroROjvm8Gr/Xauey4qrSdhMTLtXPDtWXKM0RaoqJfeQyLUreQKW
 rhAPe3ekY3PsLPiHqGUhnG32o92NsEaH8xv/K6mFlip6wrvnXGwpn+DFTwsu/Rc1pD5p
 q1tP/LHC4xKv550+4+88D6n06xVrH+gCR0/K+6S2/q/RiZ/LKN6NhPT9diP4H4zcjThR
 IcDg==
X-Gm-Message-State: APjAAAWnGVJ7xPu/ACOwVaM5MaRffX01o2WymN61BqTZjlqrzdQ4Lm/x
 e1/PuKYt2RdPFBQh12tMrJBCivBVS9U=
X-Google-Smtp-Source: APXvYqxEiMHTFWd0+8+Jjwot2B4GNA7AKnYndljV5p2qZvznW7FluKoKIk5gs03JrCesOj8KQEDmxA==
X-Received: by 2002:a17:90a:f311:: with SMTP id
 ca17mr12070981pjb.112.1571420699116; 
 Fri, 18 Oct 2019 10:44:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 21/22] target/arm: Rebuild hflags for M-profile NVIC
Date: Fri, 18 Oct 2019 10:44:30 -0700
Message-Id: <20191018174431.1784-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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


