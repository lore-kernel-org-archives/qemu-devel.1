Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D71C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634CD20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrU2WswT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634CD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLPi-00009r-1s
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFg-0004rn-9o
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFe-00067X-S5
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:08 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFe-00062d-Kf
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:06 -0500
Received: by mail-pf1-x444.google.com with SMTP id 4so16523766pfz.9
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1Tjfb9SeZwoP+jBqe2wdJ6MBodnhM7nlLGRuc9cKpc=;
 b=XrU2WswTKopE2H/YsaObV1VEkPWJaFvc3EjTeZrF2NQqg/Ny9i7ovoBe6AhkSoF6s+
 HZw4RuQjztwf7wvJoQoeHAx+MqlsXiGC4x5h1cSRLGGHf/29ABXdMIuzfT46men4kpr7
 UqUGs2BtBU2xle1gvE79kkTYzaCbfgnUmj/fUr6V9gn/VDP4lNQgC0gk68QeqFclo0ho
 PnqH0JNmuNFgujM1Amne2+tQLCZvbJfPbr6V28gxg0SDnFkoloigLkHKelmIFbpi3Z6c
 Ns2actVIyuEbhkkJ0UdHweymqOVyNI3fx9vG6BYhkE9quTZqT+kZ9ec9AtRSNl1Q+weh
 0efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1Tjfb9SeZwoP+jBqe2wdJ6MBodnhM7nlLGRuc9cKpc=;
 b=dhSyg5PMLpyZtNC81CUeVPLSuRrlLj5i9aQS3GYAEimKQLfiAgYep8lGjTHhtDyUV2
 zWFxQQz78W7RoxAZFsxS5JE/6NXH3Ic7tPbxketyrBKl1dBpyBy3xvnsIhsuOX3+1TW/
 GEO7p2zLDbM1nZhv1H0774yfDu1r+dymryykn7FwqvIl2H0b1W84GzCmusU1G7/uyNgi
 kD9DO5cbS38w9WPx3HHyfvnknlpNNkUvKeSqK4+IjDT8RBIpqyEpFz0QBPk4cJ6LmsJV
 Fk/ZcUFwSEy9p60qaM0zIV+tlGzFLWKlkp611j58e6QDu8hn6JVfNvOIUiex14m7G+Vi
 7ddA==
X-Gm-Message-State: APjAAAXtSP+MiUfexGBBqqnax0QZtME9Wb6kPfaYyoGARIpPpp+CaV77
 3bsGEj17SjST1oeljEU4rAYSOXYXMgY=
X-Google-Smtp-Source: APXvYqwsov8L8sQ2JwtxJaioF4TvjB7+efUBNBoeaAkOelRL5JiOi8zBGcdE0ghz1CFwZsqwk7nkxg==
X-Received: by 2002:a63:696:: with SMTP id 144mr65402768pgg.260.1577574725329; 
 Sat, 28 Dec 2019 15:12:05 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/29] translator: Use cpu_ld*_code instead of open-coding
Date: Sun, 29 Dec 2019 10:11:06 +1100
Message-Id: <20191228231124.18307-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DO_LOAD macros replicate the distinction already performed
by the cpu_ldst.h functions.  Use them.

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


