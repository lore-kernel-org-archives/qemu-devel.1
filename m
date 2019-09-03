Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F27CC3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6082077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhaqZomN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6082077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5AtX-0004Xq-V5
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArI-0002ek-KQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArH-0005qm-5v
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArG-0005pp-SW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id l11so9173911wrx.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+yNac1qJC9Kh92Gr5cseXT2mTxIseX7RPiOfC11845I=;
 b=MhaqZomN+PtvJ+EGr4UackucruyA34Du8esAUre2WihdDrm1BeIoCKyA8gkDLUwb2L
 9s+c+p8Zmju8dYBtKXf6QZk5Jg4Xtav5CBZvZIow1f4V7MnM9dp1jwphU3FvA/n8UMbh
 9PQxiWU1EvvzvZoQg/4K3WwJBqSZoJ7hhOjkMG5IYsj7dzjUWNy8YcRJiX4Ybc71buwo
 HjiQT6mlw13zOSPbENQft8uc9vcfnUThdNevJHQ0jtyxYSx+Jiv411soECHrouI9vnvP
 uKudhXcARFSRceK4BBErffTRsKZO1DyWePL32Gi7fyg9yxpxsywPu5199FBbnfp3/BgB
 PEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+yNac1qJC9Kh92Gr5cseXT2mTxIseX7RPiOfC11845I=;
 b=UahgrE53oMKK/RR3TgO8neCA2EbGrzwWnexFXNs0HZR5TMRaW2p0t0V45R2S1aB7xy
 c5bZRWhDMDskDn1yVWrZEqi3oCLf3kyYHpr1XzSjWe50t1/HvVev1iAzPNYVC5de27Dl
 kP1/VOYTyynmZg4MA3BUkT7Hoh9YlyzZWDeRV+NOjqanU/nh94XXjPj9iJzxx1NBPyAQ
 jodSN+BPZRYS4FTdw60+uk6TH+53meJHKaY27SfjRxnK+Xr4kwKClZiekBgDXiH0sgO7
 WLao5rcN5+RIzwjqq5vbsekNPcc6K4knRE2ZbyfvbZTvfb/viaL0SadMjxNNlHepfc/P
 UTaA==
X-Gm-Message-State: APjAAAVqBgWBQpMC3A6mF+CjFfR2/a2IPjX3HxxB3tXdgprLltwTNBke
 Q6NjDFQWbzDwIU9BBfkFqsFE09LfFe9urg==
X-Google-Smtp-Source: APXvYqxzfpSKnYM2mAa7xU3o2e6dXQxJx0izSe2ksg8gzfsOSF4+WuGhD/4yK+Mw0Yw/57P0KWKjVg==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr4321024wrt.154.1567524997305; 
 Tue, 03 Sep 2019 08:36:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:13 +0100
Message-Id: <20190903153633.6651-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 01/21] Revert "target/arm: Use
 unallocated_encoding for aarch32"
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

This reverts commit 3cb36637157088892e9e33ddb1034bffd1251d3b.

Despite the fact that the text for the call to gen_exception_insn
is identical for aarch64 and aarch32, the implementation inside
gen_exception_insn is totally different.

This fixes exceptions raised from aarch64.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190826151536.6771-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h     |  2 ++
 target/arm/translate.h         |  2 --
 target/arm/translate-a64.c     |  7 +++++++
 target/arm/translate-vfp.inc.c |  3 ++-
 target/arm/translate.c         | 22 ++++++++++------------
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 12ad8ac6ed1..9cd2b3d2389 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -18,6 +18,8 @@
 #ifndef TARGET_ARM_TRANSLATE_A64_H
 #define TARGET_ARM_TRANSLATE_A64_H
 
+void unallocated_encoding(DisasContext *s);
+
 #define unsupported_encoding(s, insn)                                    \
     do {                                                                 \
         qemu_log_mask(LOG_UNIMP,                                         \
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 92ef790be9e..64304c957ee 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -99,8 +99,6 @@ typedef struct DisasCompare {
     bool value_global;
 } DisasCompare;
 
-void unallocated_encoding(DisasContext *s);
-
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
 extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
 extern TCGv_i64 cpu_exclusive_addr;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6fd0b779d37..9183f89ba39 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -338,6 +338,13 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
     }
 }
 
+void unallocated_encoding(DisasContext *s)
+{
+    /* Unallocated and reserved encodings are uncategorized */
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
+}
+
 static void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 3e8ea80493b..5065d4524cd 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -108,7 +108,8 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        unallocated_encoding(s);
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                           default_exception_el(s));
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cbe19b7a625..2aac9aae681 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1231,13 +1231,6 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-void unallocated_encoding(DisasContext *s)
-{
-    /* Unallocated and reserved encodings are uncategorized */
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
-}
-
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -1268,7 +1261,8 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    unallocated_encoding(s);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7580,7 +7574,8 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        unallocated_encoding(s);
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                           default_exception_el(s));
         return;
     }
 
@@ -9201,7 +9196,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            unallocated_encoding(s);
+            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                               default_exception_el(s));
             break;
         }
     }
@@ -10886,7 +10882,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    unallocated_encoding(s);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11709,7 +11706,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    unallocated_encoding(s);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.20.1


