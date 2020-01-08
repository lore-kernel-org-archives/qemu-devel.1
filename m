Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C3C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCD62077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA+UsOjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCD62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Pa-0005Xj-US
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Id-0004Ll-W6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ib-0003HX-NW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:27 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:46828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ib-0003Gk-HF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:25 -0500
Received: by mail-pf1-x42c.google.com with SMTP id n9so886044pff.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=faAugBeokiD1YGU1Iv9nZEtzi4df+5lrosBg6LkytF4=;
 b=VA+UsOjFKlY61VQaDHsbZN9LSpBs1MmQFOLMGasuE53FaPgTjlxxIXJxjfjKvOGonT
 JmND89cf580Lf9eTSvzveBybwCnnuG0aO7Zc/Swt3cKmvP0L7riGSTv8Lgs/+U9OWNe3
 aK5hcIRqIRcfP35fgnnizeG0pqMps9cfoG4gQsv1AtTBB9Q8r8hZp6+P2w8Bf+NIdkUr
 HZFIawlt5H9gZ1MXie9FYlwproVxPfoegooqIK1JFC3XWx7fjnspHYW90tGYf32mH5L6
 5ZJNP7efPJwaHszxhbEv9IMYCk8U531lTXYPm++cUBby/m4xsfEPsCAb8dlpr7MUJGl9
 BTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=faAugBeokiD1YGU1Iv9nZEtzi4df+5lrosBg6LkytF4=;
 b=pjsBPfz3e9s6CFGANdxzU4YodI2T9coP1FtvcllTkkdhFBcbdpIYYHC+eHr7m7bMsY
 yMiyng/9K6KPYWJW/xGormgSwxC3I0avdVUlUv3P47iVPERLWBteC5Xkru9rgFRiMGmE
 aU8YH8JH9o3NJrH9mMP1qRrJM+h2HfT9nmKKvKiP8mQG6HTJGZkwRO5iToSEQbaWy/+/
 3OB9v6D1+6B2eLwIC/23/lSOpb7W2MDfJJrr0SQZasxu2AgPqqVqXo/Vq95hUddHG7AS
 Ub1c7Z3hLLypYfgUCq5Y+AqJWDCHybO9+H9XVZ1YBcgVMmWHH1Vba6Y8rhRGaQ8iNXLD
 zo8w==
X-Gm-Message-State: APjAAAV84sgfKOK7BbJao3hJax6jFWhSWYve+6U03F1McBky8lGdxL+2
 rSyvNKDXcvi8GzOMET3uXt5ponX4KIzEgQ==
X-Google-Smtp-Source: APXvYqyOrA9OPJd0cREdG6BKsOr8xOK8T2HQC0U25pfEA99x01SvrCVMTGfYHJSHnb5sh6vvCAqivw==
X-Received: by 2002:a63:9d07:: with SMTP id i7mr3262741pgd.344.1578455184175; 
 Tue, 07 Jan 2020 19:46:24 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] translator: Use cpu_ld*_code instead of open-coding
Date: Wed,  8 Jan 2020 14:45:00 +1100
Message-Id: <20200108034523.17349-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DO_LOAD macros replicate the distinction already performed
by the cpu_ldst.h functions.  Use them.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h   | 11 ---------
 include/exec/translator.h | 48 +++++++++++----------------------------
 2 files changed, 13 insertions(+), 46 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index cf8af36dbc..399ff6c3da 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -129,11 +129,6 @@ static inline void clear_helper_retaddr(void)
 #include "exec/cpu_ldst_useronly_template.h"
 #undef MEMSUFFIX
 
-/*
- * Code access is deprecated in favour of translator_ld* functions
- * (see translator.h). However there are still users that need to
- * converted so for now these stay.
- */
 #define MEMSUFFIX _code
 #define CODE_ACCESS
 #define DATA_SIZE 1
@@ -455,12 +450,6 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
 #undef CPU_MMU_INDEX
 #undef MEMSUFFIX
 
-/*
- * Code access is deprecated in favour of translator_ld* functions
- * (see translator.h). However there are still users that need to
- * converted so for now these stay.
- */
-
 #define CPU_MMU_INDEX (cpu_mmu_index(env, true))
 #define MEMSUFFIX _code
 #define SOFTMMU_CODE_ACCESS
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 459dd72aab..638e1529c5 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -148,41 +148,19 @@ void translator_loop_temp_check(DisasContextBase *db);
 /*
  * Translator Load Functions
  *
- * These are intended to replace the old cpu_ld*_code functions and
- * are mandatory for front-ends that have been migrated to the common
- * translator_loop. These functions are only intended to be called
- * from the translation stage and should not be called from helper
- * functions. Those functions should be converted to encode the
- * relevant information at translation time.
+ * These are intended to replace the direct usage of the cpu_ld*_code
+ * functions and are mandatory for front-ends that have been migrated
+ * to the common translator_loop. These functions are only intended
+ * to be called from the translation stage and should not be called
+ * from helper functions. Those functions should be converted to encode
+ * the relevant information at translation time.
  */
 
-#ifdef CONFIG_USER_ONLY
-
-#define DO_LOAD(type, name, shift)               \
-    do {                                         \
-        set_helper_retaddr(1);                   \
-        ret = name ## _p(g2h(pc));               \
-        clear_helper_retaddr();                  \
-    } while (0)
-
-#else
-
-#define DO_LOAD(type, name, shift)                          \
-    do {                                                    \
-        int mmu_idx = cpu_mmu_index(env, true);             \
-        TCGMemOpIdx oi = make_memop_idx(shift, mmu_idx);    \
-        ret = helper_ret_ ## name ## _cmmu(env, pc, oi, 0); \
-    } while (0)
-
-#endif
-
-#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
+#define GEN_TRANSLATOR_LD(fullname, type, load_fn, swap_fn)             \
     static inline type                                                  \
     fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
     {                                                                   \
-        type ret;                                                       \
-        DO_LOAD(type, name, shift);                                     \
-                                                                        \
+        type ret = load_fn(env, pc);                                    \
         if (do_swap) {                                                  \
             ret = swap_fn(ret);                                         \
         }                                                               \
@@ -195,11 +173,11 @@ void translator_loop_temp_check(DisasContextBase *db);
         return fullname ## _swap(env, pc, false);                       \
     }
 
-GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, 0, /* no swap */ )
-GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, 1, bswap16)
-GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 1, bswap16)
-GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 2, bswap32)
-GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 3, bswap64)
+GEN_TRANSLATOR_LD(translator_ldub, uint8_t, cpu_ldub_code, /* no swap */)
+GEN_TRANSLATOR_LD(translator_ldsw, int16_t, cpu_ldsw_code, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, uint16_t, cpu_lduw_code, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, uint32_t, cpu_ldl_code, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, uint64_t, cpu_ldq_code, bswap64)
 #undef GEN_TRANSLATOR_LD
 
 #endif  /* EXEC__TRANSLATOR_H */
-- 
2.20.1


