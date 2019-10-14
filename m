Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9AC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAE7206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlUiZfx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAE7206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJygk-0002E4-Kr
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBm-0007ja-Cs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBk-0007DQ-N7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyBk-0007CV-Fs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id r19so16802104wmh.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UmjqCmwbmhQzwY3KN2Q9UhV5BJN5OMPhX9Z6rr8BWhM=;
 b=wlUiZfx6xF81J09wWzT/wL3q/PdUZlLM3p0JXUvOuYGKYEMooDU2GVAlwRA+eCQSbu
 HRGqgbNBkFQPOBUezZQl1F4AlL/6z7pNdAzfGMV5MHXAapq84DVtvd8tbUH4dN4HfCkV
 u4anDhGwXuX+OI/u87lSngQUtjJUXAzk04Oyk9nEAvnpwzYCzivAekT2WWBf14Hkz/NH
 a6Ut04l6feYfKWv36EBXRjUvYqOUjzEjI+YQUnziLGX2plhtkbNmn6K+YzCQ1hCbAs5I
 T2FmRNicQl6ediR+A1jw8pm04Uh98nhvBhzVzfzC6AFbW56Ik8CMIPjPExU+SXicFdR1
 Ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UmjqCmwbmhQzwY3KN2Q9UhV5BJN5OMPhX9Z6rr8BWhM=;
 b=Zrt1I/BqFEixcwd/49ABcLjo7DHm940iMkpvLnlDQ+JxXVJzLNKHN3CuIh6iRE2JRT
 WhygeVk48TcjLq8lTSXqC8i2JYCTTx7zkhB3aEDRUnpx4wMSLpMlWdy/djZCUfh4J5xB
 eQxZUe68oA+kvCfERGjrGJlrY89uRliyt14BUN4hORHMaU4VcxEiugDdEHCl/KLE0QNc
 qYjoJCK2c76CKitT6t4ROEXY970+rAq0TyfKL3DoW+GBZmMKs/EqzMfCmjBZcHEJ+ZsM
 w3AmvfIDJ1KTb8z9G08IBv15oyonfOa/t1Nm2imzgwkNtv5Gjn/VwXLMKGAM5SXZISNy
 OuDA==
X-Gm-Message-State: APjAAAVFXdyraz8wnXTwjJ31Hz4+T1CrVucdpLRIyKKhoZkBQJ808J3x
 jxyoGuBrkqCvCudom1hQOVfagA==
X-Google-Smtp-Source: APXvYqyu5GJoheLAeoGew32vAUVPvBLlck/U4SlAI63Ajoc2oET2288y8GumTGuwJ3EQfJAauEAwTg==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr14723200wmh.76.1571051215371; 
 Mon, 14 Oct 2019 04:06:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm17185468wro.16.2019.10.14.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:06:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AAE441FFAB;
 Mon, 14 Oct 2019 11:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 23/55] translator: add translator_ld{ub,sw,uw,l,q}
Date: Mon, 14 Oct 2019 11:49:16 +0100
Message-Id: <20191014104948.4291-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

We don't bother with replicating the fast path (tlb_hit) of the old
cpu_ldst helpers as it has no measurable effect on performance. This
probably indicates we should consider flattening the whole set of
helpers but that is out of scope for this change.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: directly plumb into softmmu/user helpers]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - don't use the cpu_ldst helpers, plumb directly into the lower
  level
  - mark the CODE_ACCESS/SOFTMMU_CODE_ACCESS as deprecated
v5
  - expand commit message w.r.t. fast path.
---
 include/exec/cpu_ldst.h   | 11 ++++++++
 include/exec/translator.h | 58 ++++++++++++++++++++++++++++++++++++++-
 include/qemu/bswap.h      |  5 ++++
 tcg/tcg.h                 |  2 ++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 9151fdb042..fd499f7e2f 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -129,6 +129,11 @@ static inline void clear_helper_retaddr(void)
 #include "exec/cpu_ldst_useronly_template.h"
 #undef MEMSUFFIX
 
+/*
+ * Code access is deprecated in favour of translator_ld* functions
+ * (see translator.h). However there are still users that need to
+ * converted so for now these stay.
+ */
 #define MEMSUFFIX _code
 #define CODE_ACCESS
 #define DATA_SIZE 1
@@ -427,6 +432,12 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 #undef CPU_MMU_INDEX
 #undef MEMSUFFIX
 
+/*
+ * Code access is deprecated in favour of translator_ld* functions
+ * (see translator.h). However there are still users that need to
+ * converted so for now these stay.
+ */
+
 #define CPU_MMU_INDEX (cpu_mmu_index(env, true))
 #define MEMSUFFIX _code
 #define SOFTMMU_CODE_ACCESS
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 180c51d509..7a9dc1b937 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 
+#include "qemu/bswap.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/plugin-gen.h"
 #include "tcg/tcg.h"
 
 
@@ -142,4 +145,57 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
 void translator_loop_temp_check(DisasContextBase *db);
 
-#endif /* EXEC__TRANSLATOR_H */
+/*
+ * Translator Load Functions
+ *
+ * These are intended to replace the old cpu_ld*_code functions and
+ * are mandatory for front-ends that have been migrated to the common
+ * translator_loop. These functions are only intended to be called
+ * from the translation stage and should not be called from helper
+ * functions. Those functions should be converted to encode the
+ * relevant information at translation time.
+ */
+
+#ifdef CONFIG_USER_ONLY
+
+#define DO_LOAD(type, name, shift)               \
+    set_helper_retaddr(1);                       \
+    ret = name ## _p(g2h(pc));                   \
+    clear_helper_retaddr();
+
+#else
+
+#define DO_LOAD(type, name, shift)                   \
+    int mmu_idx = cpu_mmu_index(env, true);          \
+    TCGMemOpIdx oi = make_memop_idx(shift, mmu_idx); \
+    ret = helper_ret_ ## name ## _cmmu(env, pc, oi, 0);
+
+#endif
+
+#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
+    static inline type                                                  \
+    fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
+    {                                                                   \
+        type ret;                                                       \
+        DO_LOAD(type, name, shift)                                      \
+                                                                        \
+        if (do_swap) {                                                  \
+            ret = swap_fn(ret);                                         \
+        }                                                               \
+        plugin_insn_append(&ret, sizeof(ret));                          \
+        return ret;                                                     \
+    }                                                                   \
+                                                                        \
+    static inline type fullname(CPUArchState *env, abi_ptr pc)          \
+    {                                                                   \
+        return fullname ## _swap(env, pc, false);                       \
+    }
+
+GEN_TRANSLATOR_LD(translator_ldub, ldb, uint8_t, 0, /* no swap needed */)
+GEN_TRANSLATOR_LD(translator_ldsw, lduw, int16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 2, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 3, bswap64)
+#undef GEN_TRANSLATOR_LD
+
+#endif  /* EXEC__TRANSLATOR_H */
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783..4f70727874 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -306,6 +306,11 @@ static inline int ldub_p(const void *ptr)
     return *(uint8_t *)ptr;
 }
 
+static inline int ldb_p(const void *ptr)
+{
+    return ldub_p(ptr);
+}
+
 static inline int ldsb_p(const void *ptr)
 {
     return *(int8_t *)ptr;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a38659ea5b..302533b463 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1317,6 +1317,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
 # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
+# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1330,6 +1331,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
 # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
+# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
-- 
2.20.1


