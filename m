Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD61CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4643320873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjUXeX6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4643320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXr7-0000mA-Ai
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMXkZ-0003ph-A8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMXkX-0004cQ-Nq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:29:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMXkX-0004bo-HV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:29:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id r141so3227015wme.4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ZNzgEh1353JaRCW8MG0bRTeX0T0SnVqDPL3qldPvKI=;
 b=YjUXeX6rJ1DyLXvVWACBhfzTbn8wq4PPhnS6YpTF1tQ4Qz25kL8sVnkyG81RFeMKgh
 BHDgsYUhzxyAeCAChQBTuiSYe0isokJeluvW0jtpp8uZQItFc5OvSlIhBLYYdm39Dogq
 Ge0UYa91GV4if/3Jy8pep11au40Mi1woqhu8rkGqUXM47nFdrjCkDuqrBFVq7nTgp7Fw
 3hHFYUgU1Vf5UOvbzYW3heFKZofuowkycIOwDZy3qGeEjzKzvdUqYIVfxPBsn9RS2weG
 9TeYKIQ7PbERm1eNT+i34/2o9gBZY4DLISo1tUZhnXnReoldYaQN+XajGi4dyv9yyVJw
 kdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ZNzgEh1353JaRCW8MG0bRTeX0T0SnVqDPL3qldPvKI=;
 b=qr2x7XEvWJIs9ws4Q4i76XEBV7MToOWqm2KPhbjWcrhlCjJqNnZI+byQxZHwA0Z4w4
 XDQXvP36T6dY+/favocJoCtE9seUcLXc5MLyJe94FaW8/qlAqVRXJQRRp9g8fLriAg/w
 eS3WaXNh9y6d8PHFmpMiO+gd+rDeDXevUdlgqKp3b6h1ueAyYDjSOgp3R5WCSNSbcxoo
 jIBr4uSGMY4V7EFWrqeEm+IEjTtsjL3RwF6BNWe2Qh13s5wH5+YKhheW1bvsgL067g6W
 amjoQAPQ7qYxhDckyb32f1Y54eEtn4Ld9+87RI5X7gysStiFVCmJ0yUpm5fclXKRBkRE
 lTGw==
X-Gm-Message-State: APjAAAV3zjS7hTqt/lG2YHDBN8ujYTIz+GGo0g42u9D2gZgV7+6ynmKT
 F0Qi12reIT27v2Xzb8SBYqjr0Q==
X-Google-Smtp-Source: APXvYqx/ZN8PKn5lSIBwzr66JR2Eh46+Ltmpx/usEaasXFy8jo3zuGiLtiAEWkoGSHhNqyD8DIAaZw==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr14568121wmk.30.1571664566731; 
 Mon, 21 Oct 2019 06:29:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm19168713wrn.48.2019.10.21.06.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 06:29:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 547B61FF87;
 Mon, 21 Oct 2019 14:29:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] cputlb: ensure _cmmu helper functions follow the naming
 standard
Date: Mon, 21 Oct 2019 14:29:16 +0100
Message-Id: <20191021132916.27818-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We document this in docs/devel/load-stores.rst so lets follow it. The
32 bit and 64 bit access functions have historically not included the
sign so we leave those as is.

The few places that use signed code loads are fixed up to do the
casting themselves.

Fixes: 282dffc8
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c               |  6 +++---
 include/exec/cpu_ldst_template.h | 12 +++++++-----
 target/cris/translate.c          |  4 ++--
 target/cris/translate_v10.inc.c  |  7 +++----
 target/i386/translate.c          |  2 +-
 tcg/tcg.h                        | 14 +++++++-------
 6 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index defc8d59292..0c3f5d3027b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1862,7 +1862,7 @@ static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
     return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
 }
 
-uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
+uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return full_ldub_cmmu(env, addr, oi, retaddr);
@@ -1875,7 +1875,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                        full_le_lduw_cmmu);
 }
 
-uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return full_le_lduw_cmmu(env, addr, oi, retaddr);
@@ -1888,7 +1888,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                        full_be_lduw_cmmu);
 }
 
-uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
+uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return full_be_lduw_cmmu(env, addr, oi, retaddr);
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index af7e0b49f2d..ddfb85da02f 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -65,8 +65,12 @@
 #ifdef SOFTMMU_CODE_ACCESS
 #define ADDR_READ addr_code
 #define MMUSUFFIX _cmmu
-#define URETSUFFIX SUFFIX
-#define SRETSUFFIX SUFFIX
+#define URETSUFFIX USUFFIX
+/*
+ * All code access functions are unsigned, I could poison this but it
+ * it would break further inclusions of this template.
+ */
+#define SRETSUFFIX _unused_
 #else
 #define ADDR_READ addr_read
 #define MMUSUFFIX _mmu
@@ -114,7 +118,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
     return glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(env, ptr, 0);
 }
 
-#if DATA_SIZE <= 2
+#if DATA_SIZE <= 2 && !defined(SOFTMMU_CODE_ACCESS)
 static inline int
 glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
@@ -126,11 +130,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     int mmu_idx;
     TCGMemOpIdx oi;
 
-#if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
-#endif
 
     addr = ptr;
     mmu_idx = CPU_MMU_INDEX;
diff --git a/target/cris/translate.c b/target/cris/translate.c
index e752bd06093..f7d3b3e4fdc 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -231,7 +231,7 @@ static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t addr,
     case 2:
     {
         if (sign) {
-            r = cpu_ldsw_code(env, addr);
+            r = (int16_t) cpu_lduw_code(env, addr);
         } else {
             r = cpu_lduw_code(env, addr);
         }
@@ -240,7 +240,7 @@ static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t addr,
     case 1:
     {
         if (sign) {
-            r = cpu_ldsb_code(env, addr);
+            r = (int8_t) cpu_ldub_code(env, addr);
         } else {
             r = cpu_ldub_code(env, addr);
         }
diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc.c
index a87b8bb2813..0dd77368836 100644
--- a/target/cris/translate_v10.inc.c
+++ b/target/cris/translate_v10.inc.c
@@ -183,9 +183,9 @@ static int dec10_prep_move_m(CPUCRISState *env, DisasContext *dc,
         if (memsize != 4) {
             if (s_ext) {
                 if (memsize == 1)
-                    imm = cpu_ldsb_code(env, dc->pc + 2);
+                    imm = (int8_t) cpu_ldub_code(env, dc->pc + 2);
                 else
-                    imm = cpu_ldsw_code(env, dc->pc + 2);
+                    imm = (int16_t) cpu_lduw_code(env, dc->pc + 2);
             } else {
                 if (memsize == 1)
                     imm = cpu_ldub_code(env, dc->pc + 2);
@@ -1202,8 +1202,7 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
         case CRISV10_IND_BCC_M:
 
             cris_cc_mask(dc, 0);
-            imm = cpu_ldsw_code(env, dc->pc + 2);
-            simm = (int16_t)imm;
+            simm = (int16_t) cpu_lduw_code(env, dc->pc + 2);
             simm += 4;
 
             LOG_DIS("bcc_m: b%s %x\n", cc_name(dc->cond), dc->pc + simm);
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 868b0acafe8..edc915dcfd3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1930,7 +1930,7 @@ static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
 
 static inline int16_t x86_ldsw_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldsw_code(env, advance_pc(env, s, 2));
+    return (int16_t) cpu_lduw_code(env, advance_pc(env, s, 2));
 }
 
 static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a37181c8998..a5388b89827 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1269,16 +1269,16 @@ void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr);
 
-uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
+uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
+uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
@@ -1295,7 +1295,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_be_stw_mmu
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
-# define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
+# define helper_ret_lduw_cmmu  helper_be_lduw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1308,7 +1308,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_le_stw_mmu
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
-# define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
+# define helper_ret_lduw_cmmu  helper_le_lduw_cmmu
 # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
-- 
2.20.1


