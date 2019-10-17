Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E00CFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4886921848
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lep+GBIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6f8-0002D8-O0
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w9-0005ya-3v
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w7-0004RT-2b
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w5-0004QI-Eu
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id p7so2596395wmp.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ESP6ykQOaykBHMJkZ60Hbuq+EhkqCSyBnm8ZbwocBec=;
 b=lep+GBIxj8+7UQF/2cwrN4OrMr+pOC3QExg4ODk/n+lupFsdwYmPrYa6+DbeJ01Ib7
 zwyPOv+ZBSu+WP9EcMyrt8FUuX2ff/TNQHDLhW9Q0YI3EkPHmJsQOD1w0lib0wikohrU
 4cXgHDG3oW880C+ZRQtzo2f2vAyxGPBgzn88sc4W5e5vDjl38mPbwaVY9vO5OsMxtrmf
 p47tlkZj740/MmWdBqZaDUm9sk2Qs3m75lyZqHtvO04JZf0OY7R2rIxEYWLVHTEEQKVq
 0V4JidfMiKQ5g6Ztrq6XWKOEqrqDet8oTJXfuIDkqefpxiTX77Om4U573ojHmlMvVrLt
 dSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ESP6ykQOaykBHMJkZ60Hbuq+EhkqCSyBnm8ZbwocBec=;
 b=eI/7mUQE6DI04gtG7ONAMoopa+flVGDsPBGmcVz5Xu5ccengnhxjA/HEExvh382DQs
 paJN7hvlN2kjzHxg6XJASZNIm9qEJL9Rj6zXZid+1K3m2MsHAP/tvlpdQSkCMGT0JhQd
 vg7FAmlnNPm7oe2t5pmE6gLE4ydF0kbJwHppMIN4ICPXbZS+/6YzVS/lIjufKfvzVm9I
 h2TWyBmy0hafXywhM1NlopKhv8YCKfhLG+g9qsAt7/iGEqMnOOIDlwSmNMINZW3unbZO
 I7MQVR211Dc0iY5NMrOb10TjOaqIvy0fPqAevqEnt4j26lUgqXyMDHGNeYX6XIZvt3P9
 ZV6A==
X-Gm-Message-State: APjAAAWrUw4oXlahAZb3BLJCO1u7uIRqevV0wTKFD6hZDBTLQeaD66pm
 FEOoHKBbMNO6pu3xsOdUfaTMZw==
X-Google-Smtp-Source: APXvYqwiGHiQ7dIAUEPXKONXnvsVkr7cB4Q4oz1UlCPXyyqVTJ28YmMwk27gn7h0w4afOUmFhky1Ew==
X-Received: by 2002:a05:600c:20ca:: with SMTP id
 y10mr3140261wmm.168.1571319324191; 
 Thu, 17 Oct 2019 06:35:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm2188915wra.82.2019.10.17.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C3BC1FFAA;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 22/54] translator: add translator_ld{ub,sw,uw,l,q}
Date: Thu, 17 Oct 2019 14:15:43 +0100
Message-Id: <20191017131615.19660-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4
  - don't use the cpu_ldst helpers, plumb directly into the lower
  level
  - mark the CODE_ACCESS/SOFTMMU_CODE_ACCESS as deprecated
v5
  - expand commit message w.r.t. fast path.
v6
  - add do {} while (0)
  - expand name/uname instead of adding aliases to cmmu/ldp
  - use signed helper for user-mode
---
 include/exec/cpu_ldst.h   | 11 +++++++
 include/exec/translator.h | 62 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

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
index 180c51d509..f65d6b1a95 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 
+#include "qemu/bswap.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/plugin-gen.h"
 #include "tcg/tcg.h"
 
 
@@ -142,4 +145,61 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
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
+#define DO_LOAD(type, name, uname, shift)        \
+    do {                                         \
+        set_helper_retaddr(1);                   \
+        ret = uname ## _p(g2h(pc));              \
+        clear_helper_retaddr();                  \
+    } while (0)
+
+#else
+
+#define DO_LOAD(type, name, uname, shift)                   \
+    do {                                                    \
+        int mmu_idx = cpu_mmu_index(env, true);             \
+        TCGMemOpIdx oi = make_memop_idx(shift, mmu_idx);    \
+        ret = helper_ret_ ## name ## _cmmu(env, pc, oi, 0); \
+    } while (0)
+
+#endif
+
+#define GEN_TRANSLATOR_LD(fullname, name, uname, type, shift, swap_fn)  \
+    static inline type                                                  \
+    fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
+    {                                                                   \
+        type ret;                                                       \
+        DO_LOAD(type, name, uname, shift);                              \
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
+GEN_TRANSLATOR_LD(translator_ldub, ldb, ldub, uint8_t, 0, /* no swap */ )
+GEN_TRANSLATOR_LD(translator_ldsw, ldw, ldsw, int16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, ldw, lduw, uint16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, ldl, uint32_t, 2, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, ldq, uint64_t, 3, bswap64)
+#undef GEN_TRANSLATOR_LD
+
+#endif  /* EXEC__TRANSLATOR_H */
-- 
2.20.1


