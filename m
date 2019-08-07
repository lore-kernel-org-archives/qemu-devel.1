Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB681C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E0C21743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFp+JZxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E0C21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvE1h-0002Gt-TN
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40806)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxW-0001Vt-Hz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxV-0004vJ-9g
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxV-0004uH-3y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id b13so42762441pfo.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GZbt2b6q6zC+AHslpvt/yBukAaZDdWPbQRYzrmp82HY=;
 b=tFp+JZxQA7az7Mi2xYjdbzV6BXaWFW6JH2twX9RL9qQjAtjeGhzoErJs6dQCWTKu8q
 7eOXH4X3rlo7bnLQYz6s7QXzmeAwnPh0jv245HC+4z+UBnLSkbhQsYgEwBPsg4euOGot
 SIbXXaz2z+YBNs+0s8cXuKleShyBBJSPs7WUO9U7b9pjg9433Xv0ffUz2nOBMzwn/s5N
 mJVumDXqcPqHgVqlJjfAEb9kMWO0OlxRNxIzukqRVCX6ARGVHF+XJ7qCz2MW4c0UQRXo
 OfOG+z8zVpUr+vOefiCnqeCQcqZPf0OX4bINk9KiNivF2utz8upKAXcXIC14C+gbZ6/I
 CuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GZbt2b6q6zC+AHslpvt/yBukAaZDdWPbQRYzrmp82HY=;
 b=rZpiDztaskP2YmRLuY27cAJhGFP3f2ZpvQS8Ojkd/5SfuyM+a5LYYnNCRK6olJKxYk
 gxWQbksNaw+SpTBxCJL6Ct51tB7fO3modqBwPFkLVR/SASk5L8Z+Hhb/AtmsLt90BDeZ
 7avMx3sHPoSOUfpRz3zYOMe8mmtIQEdOIFlG786c8GepgUCzxagmKBi401eKwK5BIFv2
 TatAqW5Ap7fPmnEh5ZMHe0MZmER4ZkR69X2p/3giowiwMHXEAXxAsYddE8GvvBYozyxt
 rNOrgkPTL88ZjkfX1ZydgYHS8xXZ4Pa/k8Ie481gAtATOymGS7Le55JESg7IP6A+IcnO
 QuRg==
X-Gm-Message-State: APjAAAWLX5RKi0CZXPNcq2pXCbvMRJ7LKH7hHX8l/zOf7hfimgiVTr+S
 j2NNrTYScDCnx6nt0FOdGjAtop2WOtw=
X-Google-Smtp-Source: APXvYqxvVZuNWgA8hefXQhiafNALa4X666v1wlbjum7o7jQelug+6vdO5C9ibHrlc2GB7AUqhgKlcw==
X-Received: by 2002:aa7:9834:: with SMTP id q20mr7548885pfl.196.1565153635874; 
 Tue, 06 Aug 2019 21:53:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:34 -0700
Message-Id: <20190807045335.1361-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 10/11] target/arm: Use unallocated_encoding for
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Promote this function from aarch64 to fully general use.
Use it to unify the code sequences for generating illegal
opcode exceptions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h     |  2 --
 target/arm/translate.h         |  2 ++
 target/arm/translate-a64.c     |  7 -------
 target/arm/translate-vfp.inc.c |  3 +--
 target/arm/translate.c         | 22 ++++++++++++----------
 5 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9cd2b3d238..12ad8ac6ed 100644
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
index de600073d8..6a65df0b27 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -98,6 +98,8 @@ typedef struct DisasCompare {
     bool value_global;
 } DisasCompare;
 
+void unallocated_encoding(DisasContext *s);
+
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
 extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
 extern TCGv_i64 cpu_exclusive_addr;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d68bfc66d3..9e1ffe9cfb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -352,13 +352,6 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
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
index 5065d4524c..3e8ea80493 100644
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
index d6b0ab7247..2d447d4b90 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1285,6 +1285,13 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
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
@@ -1315,8 +1322,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7638,8 +7644,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return;
     }
 
@@ -9266,8 +9271,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                               default_exception_el(s));
+            unallocated_encoding(s);
             break;
         }
     }
@@ -10955,8 +10959,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11779,8 +11782,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


