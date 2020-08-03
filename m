Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B666C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C8420738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdReBHCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C8420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YWm-00078I-7h
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUi-0003uU-4s
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUf-0004tG-NG
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id a5so23863808wrm.6
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jk9fS55Yi0cM18IUj1sLUkIZI7PH5doTh14I0Z0+qSY=;
 b=FdReBHCRxRGw8EVp65mXUCYrSLHaqPIjGXqhfmj7y5tGe35uSPz7fTJME8CnkypRkp
 YXPBizA9JJ5u3U1h6h6xU4IViNAkv0GcpeMjWMUomNAV5946azN3tTws9VnudXTP23zK
 lkpJIpI+ANmei935KcOjjy2GknuxCNM2PmI29ApbANm8mm85ktqaiub98yGljHm8XuX+
 4i39H5MQlUvC8SWI95eohXafQ8xmsD0CCZ1GtwTg/eubhWSkU1ntGVSz8jQwbYRb2Mhc
 go8nzNOwuR5Z45VO8hDv7kFOSO/vsNzztlCRvPh0UY6IWgNWffbDgItAPKcCpdUW6JmG
 /2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jk9fS55Yi0cM18IUj1sLUkIZI7PH5doTh14I0Z0+qSY=;
 b=Gp/pcnNatBtdRHfSGGtPiOor6qa0gqaRXJ6D+xQFOgejy2xPqbpx5YAU3SvbzY4M9T
 DVf1o2Utd74vZLCc5oOUoLrmZvtJ5hFMYiimoywBlo6pgMndNo8AiijCwLpt/qlrqfWt
 enE6p1qiXbV9TlU91n7nC3u68vKSfeRCUq2tKi5OCIcHcLjJNnMU8IM0sSxjRxnfBO6H
 33mrlfkei6nJJJZAR6BQk4GG4AEh8WhrB/0h9XW1MIJD6MI9QV/hDf5io65CgnkQsVbi
 Pq5JEQRqKmeS7b++w2H1vck65hwqOM6sfgZtFuV6B+mNPojHez8kN50qJGDiWGYYuHA8
 8BNA==
X-Gm-Message-State: AOAM5301O/ganUT8jeAUWv27hdUE0Kx+ELMoiDUGdNDUWmVg7FYYSR8I
 JBc2vDoNJMI9yUNayEs+YOgtvFgvLwWosQ==
X-Google-Smtp-Source: ABdhPJwztkgMf9tWnhYV+nV8DvEgL6YeYPO5SRwx5q8z0Q0t+4OByU8d/6v3Q7wvGEIn5rORn7fY4Q==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr15902499wrm.301.1596453539893; 
 Mon, 03 Aug 2020 04:18:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:18:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/arm: Do M-profile NOCP checks early and via
 decodetree
Date: Mon,  3 Aug 2020 12:18:47 +0100
Message-Id: <20200803111849.13368-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

For M-profile CPUs, the architecture specifies that the NOCP
exception when a coprocessor is not present or disabled should cover
the entire wide range of coprocessor-space encodings, and should take
precedence over UNDEF exceptions.  (This is the opposite of
A-profile, where checking for a disabled FPU has to happen last.)

Implement this with decodetree patterns that cover the specified
ranges of the encoding space.  There are a few instructions (VLLDM,
VLSTM, and in v8.1 also VSCCLRM) which are in copro-space but must
not be NOCP'd: these must be handled also in the new m-nocp.decode so
they take precedence.

This is a minor behaviour change: for unallocated insn patterns in
the VFP area (cp=10,11) we will now NOCP rather than UNDEF when the
FPU is disabled.

As well as giving us the correct architectural behaviour for v8.1M
and the recommended behaviour for v8.0M, this refactoring also
removes the old NOCP handling from the remains of the 'legacy
decoder' in disas_thumb2_insn(), paving the way for cleaning that up.

Since we don't currently have a v8.1M feature bit or any v8.1M CPUs,
the minor changes to this logic that we'll need for v8.1M are marked
up with TODO comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/m-nocp.decode       | 42 +++++++++++++++++++++++++++
 target/arm/vfp.decode          |  2 --
 target/arm/translate-vfp.inc.c | 52 +++++++++++++++++++++++++++-------
 target/arm/translate.c         | 30 ++++++++++----------
 target/arm/Makefile.objs       |  6 ++++
 5 files changed, 105 insertions(+), 27 deletions(-)
 create mode 100644 target/arm/m-nocp.decode

diff --git a/target/arm/m-nocp.decode b/target/arm/m-nocp.decode
new file mode 100644
index 00000000000..7182d7d1217
--- /dev/null
+++ b/target/arm/m-nocp.decode
@@ -0,0 +1,42 @@
+# M-profile UserFault.NOCP exception handling
+#
+#  Copyright (c) 2020 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
+# For M-profile, the architecture specifies that NOCP UsageFaults
+# should take precedence over UNDEF faults over the whole wide
+# range of coprocessor-space encodings, with the exception of
+# VLLDM and VLSTM. (Compare v8.1M IsCPInstruction() pseudocode and
+# v8M Arm ARM rule R_QLGM.) This isn't mandatory for v8.0M but we choose
+# to behave the same as v8.1M.
+# This decode is handled before any others (and in particular before
+# decoding FP instructions which are in the coprocessor space).
+# If the coprocessor is not present or disabled then we will generate
+# the NOCP exception; otherwise we let the insn through to the main decode.
+
+{
+  # Special cases which do not take an early NOCP: VLLDM and VLSTM
+  VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
+  # TODO: VSCCLRM (new in v8.1M) is similar:
+  #VSCCLRM      1110 1100 1-01 1111 ---- 1011 ---- ---0
+
+  NOCP         111- 1110 ---- ---- ---- cp:4 ---- ----
+  NOCP         111- 110- ---- ---- ---- cp:4 ---- ----
+  # TODO: From v8.1M onwards we will also want this range to NOCP
+  #NOCP_8_1     111- 1111 ---- ---- ---- ---- ---- ---- cp=10
+}
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 5fd70f975ae..2c793e3e87f 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -213,5 +213,3 @@ VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
-
-VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index afa8a5f8885..463253de90b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -95,14 +95,11 @@ static inline long vfp_f16_offset(unsigned reg, bool top)
 static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 {
     if (s->fp_excp_el) {
-        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
-                               s->fp_excp_el);
-        } else {
-            gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                               syn_fp_access_trap(1, 0xe, false),
-                               s->fp_excp_el);
-        }
+        /* M-profile handled this earlier, in disas_m_profile_nocp() */
+        assert (!arm_dc_feature(s, ARM_FEATURE_M));
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                           syn_fp_access_trap(1, 0xe, false),
+                           s->fp_excp_el);
         return false;
     }
 
@@ -2842,9 +2839,14 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
         !arm_dc_feature(s, ARM_FEATURE_V8)) {
         return false;
     }
-    /* If not secure, UNDEF. */
+    /*
+     * If not secure, UNDEF. We must emit code for this
+     * rather than returning false so that this takes
+     * precedence over the m-nocp.decode NOCP fallback.
+     */
     if (!s->v8m_secure) {
-        return false;
+        unallocated_encoding(s);
+        return true;
     }
     /* If no fpu, NOP. */
     if (!dc_isar_feature(aa32_vfp, s)) {
@@ -2863,3 +2865,33 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
     s->base.is_jmp = DISAS_UPDATE_EXIT;
     return true;
 }
+
+static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
+{
+    /*
+     * Handle M-profile early check for disabled coprocessor:
+     * all we need to do here is emit the NOCP exception if
+     * the coprocessor is disabled. Otherwise we return false
+     * and the real VFP/etc decode will handle the insn.
+     */
+    assert(arm_dc_feature(s, ARM_FEATURE_M));
+
+    if (a->cp == 11) {
+        a->cp = 10;
+    }
+    /* TODO: in v8.1M cp 8, 9, 14, 15 also are governed by the cp10 enable */
+
+    if (a->cp != 10) {
+        gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                           syn_uncategorized(), default_exception_el(s));
+        return true;
+    }
+
+    if (s->fp_excp_el != 0) {
+        gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                           syn_uncategorized(), s->fp_excp_el);
+        return true;
+    }
+
+    return false;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 639fe121a2e..adcd2127290 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1176,6 +1176,7 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 #define ARM_CP_RW_BIT   (1 << 20)
 
 /* Include the VFP and Neon decoders */
+#include "decode-m-nocp.inc.c"
 #include "translate-vfp.inc.c"
 #include "translate-neon.inc.c"
 
@@ -8433,6 +8434,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         ARCH(6T2);
     }
 
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        /*
+         * NOCP takes precedence over any UNDEF for (almost) the
+         * entire wide range of coprocessor-space encodings, so check
+         * for it first before proceeding to actually decode eg VFP
+         * insns. This decode also handles the few insns which are
+         * in copro space but do not have NOCP checks (eg VLLDM, VLSTM).
+         */
+        if (disas_m_nocp(s, insn)) {
+            return;
+        }
+    }
+
     if ((insn & 0xef000000) == 0xef000000) {
         /*
          * T32 encodings 0b111p_1111_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
@@ -8481,21 +8495,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
             /* 0b111x_11xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx */
-            if (extract32(insn, 24, 2) == 3) {
-                goto illegal_op; /* op0 = 0b11 : unallocated */
-            }
-
-            if (((insn >> 8) & 0xe) == 10 &&
-                dc_isar_feature(aa32_fpsp_v2, s)) {
-                /* FP, and the CPU supports it */
-                goto illegal_op;
-            } else {
-                /* All other insns: NOCP */
-                gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
-                                   syn_uncategorized(),
-                                   default_exception_el(s));
-            }
-            break;
+            goto illegal_op;
         }
         if (((insn >> 24) & 3) == 3) {
             /* Neon DP, but failed disas_neon_dp() */
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index fa39fd7c831..7abb12868ae 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -43,6 +43,11 @@ target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/target/arm/vfp-uncond.decode $(D
 	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
+target/arm/decode-m-nocp.inc.c: $(SRC_PATH)/target/arm/m-nocp.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_m_nocp -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
 target/arm/decode-a32.inc.c: $(SRC_PATH)/target/arm/a32.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
@@ -69,6 +74,7 @@ target/arm/translate.o: target/arm/decode-neon-dp.inc.c
 target/arm/translate.o: target/arm/decode-neon-ls.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
+target/arm/translate.o: target/arm/decode-m-nocp.inc.c
 target/arm/translate.o: target/arm/decode-a32.inc.c
 target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
 target/arm/translate.o: target/arm/decode-t32.inc.c
-- 
2.20.1


