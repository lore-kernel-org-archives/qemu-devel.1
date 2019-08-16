Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5698C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902DC2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAKfaWpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902DC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycJC-0002Vn-12
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6u-0003Qk-JX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6t-0005YN-6J
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6s-0005XM-Sw
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id u16so1539338wrr.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KEH+txSzl73sm2QgQqXxpMSDBSBswm5qkbj4gljngh0=;
 b=jAKfaWpuIAO9DKuxQa47/KunesXA+OzWZtxgT7IJbTNjAVAHN/lL7HFDlYU4Ab3Y4e
 NCV6VDjvJvw7ksKZtTPoqIpGgexNLeybrOGmpv7xbrnPIDbdMTsUNU2mYyaiTymYVhL4
 Ql180MPBdekEPbuNstCSsyDlipc6cqUTkaDzfVB70h/ouJArq4NKdzFZ8AoXRXDONHkl
 /xZIbnwgYFj92PUjj+ZtQuo4hCy7X33jDIB6kYABjhzb/mLQdGbTbJfxesET77xTuSDZ
 VPi9jyPfG4UnlTIdG07v2WFM1CIudRewvY5Yw5M5PF9hqXzYo+dUxV6880xxYMdH/OgJ
 6KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KEH+txSzl73sm2QgQqXxpMSDBSBswm5qkbj4gljngh0=;
 b=U8IL7SvrhN1u54WAbf5w51VpNEJUDvqrZfOekTuMwhuXS//MGShRFIvKQ/diIWMUe/
 XaRWMxboxqBXLMjzvgspiomqtENz453yxiDxfKZYjJwl3MtU2aNbH/Baew3s4lHZRggd
 6nLUCIEvnTGHaezcGX/ykr1mdf3uuPvMRCfKzu9dFz93y+3P5KIPjajPfhPu5w9azIVW
 L6YUNExAmO2bgI0rjDz5xLtvn528zJC3rHhO5QqWn9556bpYaA71olGhnrIcWZwr5CHu
 qYsHMaea8Z4i8NJkhGY34FJ56ms1g59Dk5hrVOcinpEwdIpzrfE6sav0fmJsooh8XB97
 H4pA==
X-Gm-Message-State: APjAAAWBgFsOjwlIYE6LbeXfJbFwG01814WBVB/YHGu9+k5hOgsvh+Ej
 ElfXVhoBNEw64tOFGezJV84brhPtBAyNjQ==
X-Google-Smtp-Source: APXvYqx6VUiB5/94pHFDg4mgJBcJiyp8+h6jwhuHH83CjvDnciqPbzmaTbklLZt3Hn4uHqK4sXR5sg==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr11590586wrs.56.1565961457637; 
 Fri, 16 Aug 2019 06:17:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:05 +0100
Message-Id: <20190816131719.28244-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 15/29] target/arm: Use unallocated_encoding for
 aarch32
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

Promote this function from aarch64 to fully general use.
Use it to unify the code sequences for generating illegal
opcode exceptions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h     |  2 --
 target/arm/translate.h         |  2 ++
 target/arm/translate-a64.c     |  7 -------
 target/arm/translate-vfp.inc.c |  3 +--
 target/arm/translate.c         | 22 ++++++++++++----------
 5 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9cd2b3d2389..12ad8ac6ed1 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -18,8 +18,6 @@
 #ifndef TARGET_ARM_TRANSLATE_A64_H
 #define TARGET_ARM_TRANSLATE_A64_H
 
-void unallocated_encoding(DisasContext *s);
-
 #define unsupported_encoding(s, insn)                                    \
     do {                                                                 \
         qemu_log_mask(LOG_UNIMP,                                         \
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 64304c957ee..92ef790be9e 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -99,6 +99,8 @@ typedef struct DisasCompare {
     bool value_global;
 } DisasCompare;
 
+void unallocated_encoding(DisasContext *s);
+
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
 extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
 extern TCGv_i64 cpu_exclusive_addr;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 55324333dab..fc3e5f5c389 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -338,13 +338,6 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
     }
 }
 
-void unallocated_encoding(DisasContext *s)
-{
-    /* Unallocated and reserved encodings are uncategorized */
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
-}
-
 static void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 5065d4524cd..3e8ea80493b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8bae0c39933..cc7d37b787e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1270,6 +1270,13 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+void unallocated_encoding(DisasContext *s)
+{
+    /* Unallocated and reserved encodings are uncategorized */
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -1300,8 +1307,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7623,8 +7629,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return;
     }
 
@@ -9251,8 +9256,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                               default_exception_el(s));
+            unallocated_encoding(s);
             break;
         }
     }
@@ -10940,8 +10944,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11764,8 +11767,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.20.1


