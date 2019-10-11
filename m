Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0A0ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EA0206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aILbN6xZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EA0206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxTT-00017t-1x
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGt-0002W1-AE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGs-0007is-2p
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:03 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGr-0007iD-VW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:02 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x64so3651768ywg.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4OOGMGav7WyY+i6Vj46PkAX7nW+w3pL8v7F+DMrUq7Y=;
 b=aILbN6xZ30EdzU7O9mibwUqzEqS2SYXFObkfEjAJZKVPFnRsKsQ7cLSrGAVHICGR4V
 y3o7gQPy64gjZJ4lN1GLaHIvu5Gf0AQKQp2Kwnd4hPC4LOoeQj0mDoHM0iTZOxSKp79r
 oKAobjVm6JkBKqFytkWOtvdf/hVVug3pjTQpSpYwLwbi31tVKZsDJg7ocTjwNGL9IMgD
 6Vhs/FsABJEFrTFGsKOCCezZDFf9xrpTXRJh+VkzdHmM2YRkCVblHLmFg9nIkmj8nNdj
 r+/SnYZvW3gGRxeKHEts9pWMhMSsxF7ig26z4IRTkj+4733JmWbcfLjwag+9/wtvfBTI
 lwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4OOGMGav7WyY+i6Vj46PkAX7nW+w3pL8v7F+DMrUq7Y=;
 b=HDbSdpVcYTRwoF4AoThNyJBdnKGPsu7xoTf6GSlelY5yMkEHZn8PdmC91VUXBxVUGd
 NuEm/gdvNFjaE15jh1jLwz98mLDBPeW8uFxchbNLs2716numavHVzJwZQXDJWYymUPp8
 yHSgN/ecFLVYfUKWBEWmnn/9bTP8tgUYQIzQa70kSgcrv6Ya5kJGHQmDXNGmuAWmpi6e
 Ab/bcHHHQU7J3mIaGmHRaRrn7Rp6VBx8MxbZcm7tic1On51vYTeZ0FvCN9IFNpoKoSR9
 1dLiW19dD8z1vibGri+h+UvuShqntoetiAu5mQ6k1rHOeZyH/MRDS936upej8ETfD36w
 Yrow==
X-Gm-Message-State: APjAAAXGsoOSfZ2xUrNSbVgJONwvTS19+gB51vSZTH4JVRhLFxzPL6bE
 qUKv7+kG8n6aWJdmySMnw76SyPkM0Ak=
X-Google-Smtp-Source: APXvYqwHLw2/gfnwTQwIIZFwKjz0TnGLJTXYOlE8nNeeG5UP5SCUJBCwldg/tpfyZvnmrUSQOg0EDQ==
X-Received: by 2002:a0d:d384:: with SMTP id v126mr2818553ywd.166.1570809360832; 
 Fri, 11 Oct 2019 08:56:00 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/20] target/arm: Hoist computation of TBFLAG_A32.VFPEN
Date: Fri, 11 Oct 2019 11:55:37 -0400
Message-Id: <20191011155546.14342-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are 3 conditions that each enable this flag.  M-profile always
enables; A-profile with EL1 as AA64 always enables.  Both of these
conditions can easily be cached.  The final condition relies on the
FPEXC register which we are not prepared to cache.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d961474ce..9909ff89d4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3192,7 +3192,7 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
  * the same thing as the current security state of the processor!
  */
 FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* For M profile only, set if FPCCR.LSPACT is set */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 398e5f5d6d..89aa6fd933 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11088,6 +11088,9 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
 {
     uint32_t flags = 0;
 
+    /* v8M always enables the fpu.  */
+    flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+
     if (arm_v7m_is_handler_mode(env)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
     }
@@ -11119,6 +11122,10 @@ static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
+
+    if (arm_el_is_aa64(env, 1)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+    }
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
@@ -11250,14 +11257,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
                                    env->vfp.vec_stride);
             }
+            if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+            }
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-        }
         pstate_for_ss = env->uncached_cpsr;
     }
 
-- 
2.17.1


