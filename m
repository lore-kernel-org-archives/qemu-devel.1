Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F09CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F29206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcXAeJIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F29206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu0d-0007ZL-GC
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpz-0004fv-84
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpw-0007DG-Qm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpw-0007Cg-KU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id r141so854609wme.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X9uOunAsx7Jvs5CSUNvC6FsYnZMcFnpqu3r55fNjaWc=;
 b=EcXAeJIbBofHsAmXdo9HkxWK4GDPA6Inthin6Vro718hYwG0R8S6P+i77th3z4vA/Q
 nwgL0BCRwlMWT7Y7Xhd6Z1D5wLhFfL69mtRvmwTBKs3DZsJhN/c6ik8KfV7do8owDaZN
 Uc7qwyVbckPWiW/xC707QV8I1pDXoyr5Og2MRacf7qYrbdHqnxVC82k8Z/xT6fJsF8YB
 lcPGAXc6YP4Ks7g/pCUsHFPz834I01/JLWDMKm6FTuwUpWKYHPAPJ9J3RhAIQTo7Pfk5
 x9+fZ79yQSBMmFJQrAfUjYGF/SNU9rPXjmbM8FnokvvnPnYKGam4XNWH4Yc5uvD/1LDn
 8/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X9uOunAsx7Jvs5CSUNvC6FsYnZMcFnpqu3r55fNjaWc=;
 b=Og/fIwtmldWvgSGs7o4od1RUiUa5X6v0snhQj793me5CZQZ+JkzvxaXUWHMsWkAQVz
 4061cKIDckqCz5URJOLsupszN4NCA6IIc0r+f+zpvQj86fSancMszO5tH/uSjUJ4Bio/
 23VZx5y2o1JePeWzaQfob4ezikOZAbxPZpATTpgBpmguETQ7TMGnHgxourodKE/tExPK
 LU0bbd6G3qCFTT6ZVWaB9Impkl4ISeO8TY1hUFaFqhoB5KxeyxDxQueeeAL7zk/27rvD
 wyYoKTHKqIKHmEPQhffgByZpRVXfWVW+kONxN5A/OU6D6Y4dksKHgDLMfuXQ9kukxXkX
 IpHg==
X-Gm-Message-State: APjAAAVlRNBoP0sa0EpN6K7nqexu6aG6FI6vON0i2yrm1v4Q8YXmy28w
 gP76vzgf5cNEMuLhC71hjXSHUQ==
X-Google-Smtp-Source: APXvYqzUlEi8FnWZJov6QVM70qN5jcx0vGbHdHRM5O4dmiWehvAkoR261XjkP6tQ4DVMdlh24XIiMA==
X-Received: by 2002:a05:600c:219:: with SMTP id
 25mr1910518wmi.174.1571987799347; 
 Fri, 25 Oct 2019 00:16:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r3sm1519258wre.29.2019.10.25.00.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E5561FFBF;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 39/73] translator: add translator_ld{ub,sw,uw,l,q}
Date: Fri, 25 Oct 2019 07:36:39 +0100
Message-Id: <20191025063713.23374-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
index 180c51d5092..459dd72aabc 100644
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
+#define DO_LOAD(type, name, shift)               \
+    do {                                         \
+        set_helper_retaddr(1);                   \
+        ret = name ## _p(g2h(pc));               \
+        clear_helper_retaddr();                  \
+    } while (0)
+
+#else
+
+#define DO_LOAD(type, name, shift)                          \
+    do {                                                    \
+        int mmu_idx = cpu_mmu_index(env, true);             \
+        TCGMemOpIdx oi = make_memop_idx(shift, mmu_idx);    \
+        ret = helper_ret_ ## name ## _cmmu(env, pc, oi, 0); \
+    } while (0)
+
+#endif
+
+#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
+    static inline type                                                  \
+    fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
+    {                                                                   \
+        type ret;                                                       \
+        DO_LOAD(type, name, shift);                                     \
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
+GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, 0, /* no swap */ )
+GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 1, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 2, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 3, bswap64)
+#undef GEN_TRANSLATOR_LD
+
+#endif  /* EXEC__TRANSLATOR_H */
-- 
2.20.1


