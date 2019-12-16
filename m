Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524BBC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152F2206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBtwE3Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152F2206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyi1-00056H-Cp
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb6-0004qL-I4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb5-0006zU-8n
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:12 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyb5-0006zM-30
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:11 -0500
Received: by mail-pg1-x543.google.com with SMTP id a33so4500417pgm.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LZjfj7f7LiMXr9N5B8njH/lhRDK1JnIrdikl5tdqwbU=;
 b=tBtwE3Luzpx99iyXa1B18fGUgCPrg1ftkjeQ8PHIDqiOc6Zbh716zAL7gEeLtx1fAO
 fB5k5pF6eLsNxcTdaGqGdpafX2uRyYNagaO08Ea7ghtVoIHaR7c7E2l4VvU3Y93tCcPx
 47V08FW/4EkQqMmHfZ2epFhrN1KZp7PumR79OihzCFHl3nEYtKfVKMpcN+x0Hvl3yrGK
 wKwnJJey2a4RmQ7BOJR5AKvG4Dg9WGy0W4tn4LS6G12BDSDjsvH8VsrMjFV2Lyfdd4bh
 eMEE7E2jxKb0U+hk9WObnp/8WESuroPCl4Np3o4sabr5i1HTDWnEIcf80VSRj9CpDo+E
 ERCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LZjfj7f7LiMXr9N5B8njH/lhRDK1JnIrdikl5tdqwbU=;
 b=o012W0CnY0d6PK482iIkZWXt2yS44SshXnzn1/LPh2eE4f+g89d6oHNz7SmQTTbQuk
 vHQw+mv9d3gc6ewpYuli1y90ShAo9dE7pLqp6Bb8CzHFW1QfHUaaF0a2e8LUQL28DbOX
 bArmLkYMfZFumq7d9dkscR7+L1ZQOZzKzb407SfEjZsOlD82ctCoOd9rhbTcPz3/6PME
 ATSLtUZX1zY/cpZ2iR9JRqENqNnljVstjsFpMDI1vbhLNICjnRy8tZScg+xwfCHVvWGE
 aLXQpnVxTvD1cFsuIQoJ5qVpSKgl46RVPgdssb7O5ShIx1uNB7VzATrSPhwptOkg0DUn
 rowQ==
X-Gm-Message-State: APjAAAUho4DQTXa4vQwzIjL5HHpeEzVqM6gxVbUhD9kdF0NQHX/Ifpdw
 W04IW1WpQi3AzkRT8OrPMnTDVjm52OA=
X-Google-Smtp-Source: APXvYqytm1kFEqDYZcdN5HhkOTof18hUgRP0vZOsVZXgxa34t0v2ADS4nSdoD7hgqyNFT/vX/3r8QA==
X-Received: by 2002:a65:530d:: with SMTP id m13mr21246848pgq.351.1576534329663; 
 Mon, 16 Dec 2019 14:12:09 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/28] translator: Use cpu_ld*_code instead of open-coding
Date: Mon, 16 Dec 2019 12:11:35 -1000
Message-Id: <20191216221158.29572-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

The DO_LOAD macros replicate the distinction already performed
by the cpu_ldst.h functions.  Use them.

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


