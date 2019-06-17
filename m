Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBBC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D068D2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUCOyFhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D068D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvsn-0004x6-47
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvp1-0007iS-Om
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvp0-0000gH-1R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvox-0000ee-Sj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so328870wmm.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zKgJAfwPo8FOYTHjapPuTGTNS3c99ejdEGatbxYgWDQ=;
 b=xUCOyFhemrpJA+/iI2WRVZ2yl1on1d11KGVAusGcu+jFM1tubF2R0lZnSu9OYt39ML
 ywYiqPlVQDh5aG6EeZPUVakYpUpsck5ZePwRTDzuG1mHZMTF01owgQ8/OucjwlUOPVWv
 4wbddUAlu4RkwoLOuZMjSNAj6NE030fyMgomAT727nXYbdcphl6GLxeh+0vtCDkFRyzG
 JHJ+qhbdCYVjbISs6diRyfDOWAy1popaLjovZTclhZe8HERkTx757tNdnfrRUA4f3rjs
 qAO6+ViHOr7An63iXBEFIk/WSIIaR6VTNB22LoV8e741wCIYv/KpMnABVfhGkmgI3pUN
 saTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zKgJAfwPo8FOYTHjapPuTGTNS3c99ejdEGatbxYgWDQ=;
 b=O4rxnNiMkLGoYjSRma3npMz527qfN3yey6bFN6plxEyP63s1YZB5kCXcSVh3lyyqW+
 Dm2QRNxhdeiUncC0ngBwDte4rgqlyXW3AJx90VWwh9Jw6JCZlTBK8lhGdOjqjG7P/ZrL
 7aiRkCWzUhHzgE8oxcz5wA49q+O4Wfcp2NqZfCCU3NfhPxSIm0jVP8G/gucbIkYm6zWV
 j5vgL94ZYCqRTErxaPfRCpqc0VXN90iQVri/1WUCqW5jOaRDrqj8P9CcjY5MdOw4csaT
 voHHLE+xxwdMqUr/zEEWjMqm5l6/GWlWLgfPYoogZmOU+IUlIHFnR+oNE9C/q7b2L7Fh
 lpPQ==
X-Gm-Message-State: APjAAAVhAw4scL/nxigxt59Ehxg7dV9uY9dmQUYvPoiCMJoKrc8LGI70
 cSr7uRhW4Fv1dX88Sd0DbpWTEg==
X-Google-Smtp-Source: APXvYqzKz4CgcE0hxMFqOLCKeyn2LbkbtbZgqnmDrQReJgP1+kGxBVCGmIFQHxdvW7sDrshwdLIFUw==
X-Received: by 2002:a1c:e0c4:: with SMTP id
 x187mr19004489wmg.177.1560794006206; 
 Mon, 17 Jun 2019 10:53:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:15 +0100
Message-Id: <20190617175317.27557-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175317.27557-1-peter.maydell@linaro.org>
References: <20190617175317.27557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 4/6] target/arm: Use _ra versions of
 cpu_stl_data() in v7M helpers
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

In the various helper functions for v7M/v8M instructions, use
the _ra versions of cpu_stl_data() and friends. Otherwise we
may get wrong behaviour or an assert() due to not being able
to locate the TB if there is an exception on the memory access
or if it performs an IO operation when in icount mode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 375249d3c72..866fe54780e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8141,8 +8141,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     }
 
     /* Note that these stores can throw exceptions on MPU faults */
-    cpu_stl_data(env, sp, nextinst);
-    cpu_stl_data(env, sp + 4, saved_psr);
+    cpu_stl_data_ra(env, sp, nextinst, GETPC());
+    cpu_stl_data_ra(env, sp + 4, saved_psr, GETPC());
 
     env->regs[13] = sp;
     env->regs[14] = 0xfeffffff;
@@ -8557,6 +8557,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     /* fptr is the value of Rn, the frame pointer we store the FP regs to */
     bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
+    uintptr_t ra = GETPC();
 
     assert(env->v7m.secure);
 
@@ -8582,7 +8583,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
      * Note that we do not use v7m_stack_write() here, because the
      * accesses should not set the FSR bits for stacking errors if they
      * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
-     * or AccType_LAZYFP). Faults in cpu_stl_data() will throw exceptions
+     * or AccType_LAZYFP). Faults in cpu_stl_data_ra() will throw exceptions
      * and longjmp out.
      */
     if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
@@ -8598,10 +8599,10 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
             if (i >= 16) {
                 faddr += 8; /* skip the slot for the FPSCR */
             }
-            cpu_stl_data(env, faddr, slo);
-            cpu_stl_data(env, faddr + 4, shi);
+            cpu_stl_data_ra(env, faddr, slo, ra);
+            cpu_stl_data_ra(env, faddr + 4, shi, ra);
         }
-        cpu_stl_data(env, fptr + 0x40, vfp_get_fpscr(env));
+        cpu_stl_data_ra(env, fptr + 0x40, vfp_get_fpscr(env), ra);
 
         /*
          * If TS is 0 then s0 to s15 and FPSCR are UNKNOWN; we choose to
@@ -8622,6 +8623,8 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
 
 void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 {
+    uintptr_t ra = GETPC();
+
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
     assert(env->v7m.secure);
 
@@ -8655,13 +8658,13 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
                 faddr += 8; /* skip the slot for the FPSCR */
             }
 
-            slo = cpu_ldl_data(env, faddr);
-            shi = cpu_ldl_data(env, faddr + 4);
+            slo = cpu_ldl_data_ra(env, faddr, ra);
+            shi = cpu_ldl_data_ra(env, faddr + 4, ra);
 
             dn = (uint64_t) shi << 32 | slo;
             *aa32_vfp_dreg(env, i / 2) = dn;
         }
-        fpscr = cpu_ldl_data(env, fptr + 0x40);
+        fpscr = cpu_ldl_data_ra(env, fptr + 0x40, ra);
         vfp_set_fpscr(env, fpscr);
     }
 
-- 
2.20.1


