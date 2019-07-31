Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CBE206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dvqjhk3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CBE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrMH-0002Wj-IO
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42403)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG7-0005w8-Mh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG5-00049K-Nd
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG1-00046g-Qo
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so70436154wru.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wNexri908PTiPWm1XMgESUAKCJc8K1I1ZWLPF6fkVnU=;
 b=Dvqjhk3Whwr8YN8/XkYURjnj4DWkrCi0NowTwwgxYkqW4060jU1KZZsC2IN1B4kkpm
 TOxOYFy+sFzJaf/rLKBoA0WvXzow82jIuz304gOpvApHbPrUjWJmF+sXsi/dPIyRQR89
 B8yEYtGDEL2+BUDhSbPXWI/vqIEtpNizPeD/a4P1F9Y/Rz95xhfQPTS/LiNqsb3iRnRu
 RgN9mNAyhQ91EG15Ytx89ylQZxs6dDg9liPjtVrWMfWhCNQEocu3Mkwl5iXIp/Y/obtB
 wiaxaJwadnPQDpsBrNq4Ju20tg9xNExnNHdmF68NOPAfIkNIi81AruurYcgcEabw1ID9
 X/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wNexri908PTiPWm1XMgESUAKCJc8K1I1ZWLPF6fkVnU=;
 b=leUzcjLsJSS2/2KLNrZGvinw1Aa0xAr6l8mVeYJntEVjkOI3+GrTkIgiAPAikIc2Pw
 SUuiUBqAnt3L+UTIBw8YLPC9w7dr1XXlcgoXDDiDJ1Yw+wgm+wmgOta9N82ElY2Fpv4r
 g5HbDzM9ebwJMN0YXjbUA/gWmCC4Jd/DC1kQSN/HC0BqquEkWH3BjbKtwb0bTvqAp8Be
 Cd8iYN6iuvy6Vji6AplJNaq3CpDRxpZVaA4QY+1S0AKFiCzdYS9Tjx5edC2yqE+/k7J/
 AHSkvcCaQ3jRFoazPuycpw1FrDhzZLIBQiKLkIENL5NOnC5xKpgXhSW/mbBzNzebIAth
 KYRA==
X-Gm-Message-State: APjAAAUUzg5MdUEFdzdXdhN+/mGa/fNLpT8gQ0K/QRFVZg/jQnBc3cbl
 b2QvJM7jv8Ef0eXa3MeroyXGfA==
X-Google-Smtp-Source: APXvYqy8k1e8wQ6s4CapOQFYxk5nty4PAj1rYhjZFNGeTNWMzpJFxo4aI+qyuFM54HBFeCZZcIlG+Q==
X-Received: by 2002:adf:80e1:: with SMTP id 88mr48054009wrl.127.1564589716736; 
 Wed, 31 Jul 2019 09:15:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r11sm107266157wre.14.2019.07.31.09.15.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A32A1FFB4;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:55 +0100
Message-Id: <20190731160719.11396-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH  v4 30/54] translator: add translator_ld{ub, sw,
 uw, l, q}
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: directly plumb into softmmu/user helpers]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - don't use the cpu_ldst helpers, plumb directly into the lower
  level
  - mark the CODE_ACCESS/SOFTMMU_CODE_ACCESS as deprecated
---
 include/exec/cpu_ldst.h   | 11 ++++++++
 include/exec/translator.h | 58 ++++++++++++++++++++++++++++++++++++++-
 include/qemu/bswap.h      |  5 ++++
 tcg/tcg.h                 |  2 ++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 9151fdb042c..fd499f7e2ff 100644
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
index 180c51d5092..30b1a594fc1 100644
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
+ * relevant at translation time.
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
+GEN_TRANSLATOR_LD(translator_ldub, ldb, uint8_t, 1, /* no swap needed */)
+GEN_TRANSLATOR_LD(translator_ldsw, lduw, int16_t, 2, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 2, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 3, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 4, bswap64)
+#undef GEN_TRANSLATOR_LD
+
+#endif  /* EXEC__TRANSLATOR_H */
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783e..4f707278740 100644
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
index 93f52f4ca93..c918fdd87c4 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1404,6 +1404,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
 # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
+# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1417,6 +1418,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
 # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
+# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
-- 
2.20.1


