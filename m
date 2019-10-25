Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B8BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF6E21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFcHWczN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF6E21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtdL-0008Ad-0d
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMu-0007vx-7g
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMs-00039l-CS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMs-00038q-4N
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id z11so914570wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dvKj57A9L+pl8UQofu98oEK7aBByVTgI27jwik1jQTA=;
 b=YFcHWczNciX39Fj2/074URfAdSgfRo1Izxm1htRd/CBAvARp3Buj52CsDkVF+DHK7f
 tW0XJomPKaD2vmNlHmKIT3AVlTL8LmqxmiT7e69fXl11qDnQMZySDViQcYG9s88t1DiK
 ObtwM7CQtJOkxN7SyyKQyGAaJWJ87JkzB2m8P1yncvmJ2U31+McCDZKmAakYrhXnA8OU
 ygRzEXbeD4OhP62JzzU1hAinQ2FprvOKFgkpEgPrBIuzADplOGSO/oX68ZDs6FJNP5KW
 t6l9ebcS4plOesugPfcYwusYyFC0m0ZKvzTBMaZ63I2rluHGEkX04atpBS2qe2AGEWm2
 0caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dvKj57A9L+pl8UQofu98oEK7aBByVTgI27jwik1jQTA=;
 b=mxex7eJ4+n+hkWWbg5WVKK1lpc1tDwVIrxAGVfJLkrycvp7Lfm6wWw09UM3B0QuhGG
 7SddosipGYwx1QLIf0cudasEIBq2PaDiWqGwctolwISxiMTKV98oY5kHaHi4DZtVV0jg
 pmNhp6+aTXyxfU+cQW/44Ge1EzjH/HTt2O2z+AA+LwB8uNM8FbHesjTxnlJOZRcqCLeg
 uPI7VKHWnGrDioKbHmMtK1Xe4Gxmr9xCns23dzEFscRnJim1REx+PWuAYWw8aSuhNy4a
 nSDDB6dT89qjjWPwsnxYfO/rTWxsGjIuYcc/vWXO/au/RLMovH5rtFrZ8t42wMw2p3kl
 yVAQ==
X-Gm-Message-State: APjAAAXVr+QCCDQ4ykJ6lJ4NmL6P38bzCTncOp5wzcNbZoPEbberhGJC
 DYofeD41xibpVboEahUWFOmY8f16HTk=
X-Google-Smtp-Source: APXvYqw3us4QQnsmeRKDPiXs6jT7/z8vwIT1mwyVBnMJl+pj+zsz/xVajN6sSp0HuVVg2X8TFSAJOA==
X-Received: by 2002:adf:ea83:: with SMTP id s3mr1310048wrm.43.1571985996505;
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p5sm1536491wmi.4.2019.10.24.23.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 96E361FFB7;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 30/73] atomic_template: add inline trace/plugin helpers
Date: Fri, 25 Oct 2019 07:36:30 +0100
Message-Id: <20191025063713.23374-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

In preparation for plugin support.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/tcg/atomic_common.inc.c b/accel/tcg/atomic_common.inc.c
new file mode 100644
index 00000000000..a86098fb2de
--- /dev/null
+++ b/accel/tcg/atomic_common.inc.c
@@ -0,0 +1,50 @@
+/*
+ * Common Atomic Helper Functions
+ *
+ * This file should be included before the various instantiations of
+ * the atomic_template.h helpers.
+ *
+ * Copyright (c) 2019 Linaro
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+static inline
+void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint16_t info)
+{
+    CPUState *cpu = env_cpu(env);
+
+    trace_guest_mem_before_exec(cpu, addr, info);
+    trace_guest_mem_before_exec(cpu, addr, info | TRACE_MEM_ST);
+}
+
+static inline void
+atomic_trace_rmw_post(CPUArchState *env, target_ulong addr, uint16_t info)
+{
+}
+
+static inline
+void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint16_t info)
+{
+    trace_guest_mem_before_exec(env_cpu(env), addr, info);
+}
+
+static inline
+void atomic_trace_ld_post(CPUArchState *env, target_ulong addr, uint16_t info)
+{
+}
+
+static inline
+void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint16_t info)
+{
+    trace_guest_mem_before_exec(env_cpu(env), addr, info);
+}
+
+static inline
+void atomic_trace_st_post(CPUArchState *env, target_ulong addr, uint16_t info)
+{
+}
diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 473d7e5a943..84d3370bf01 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -59,29 +59,6 @@
 # define ABI_TYPE  uint32_t
 #endif
 
-#define ATOMIC_TRACE_RMW do {                                           \
-        uint16_t info = glue(trace_mem_build_info_no_se, MEND)          \
-            (SHIFT, false, ATOMIC_MMU_IDX);                             \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);          \
-        trace_guest_mem_before_exec(env_cpu(env), addr,                 \
-                                    info | TRACE_MEM_ST);               \
-    } while (0)
-
-#define ATOMIC_TRACE_LD do {                                            \
-        uint16_t info = glue(trace_mem_build_info_no_se, MEND)          \
-            (SHIFT, false, ATOMIC_MMU_IDX);                             \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);          \
-    } while (0)
-
-#define ATOMIC_TRACE_ST do {                                           \
-        uint16_t info = glue(trace_mem_build_info_no_se, MEND)         \
-            (SHIFT, true, ATOMIC_MMU_IDX);                             \
-                                                                       \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);         \
-    } while (0)
-
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
 #if DATA_SIZE == 1
@@ -101,14 +78,17 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
+                                                           ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, cmpv, newv);
 #else
     ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, info);
     return ret;
 }
 
@@ -118,10 +98,13 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
+                                                           ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_LD;
+    atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_ld_post(env, addr, info);
     return val;
 }
 
@@ -130,10 +113,13 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true,
+                                                          ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_ST;
+    atomic_trace_st_pre(env, addr, info);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_st_post(env, addr, info);
 }
 #endif
 #else
@@ -143,10 +129,13 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
+                                                          ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, info);
     return ret;
 }
 
@@ -157,10 +146,14 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
+                                                           false,   \
+                                                           ATOMIC_MMU_IDX); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, info);                         \
     return ret;                                                     \
 }
 
@@ -189,8 +182,11 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
+                                                           false,   \
+                                                           ATOMIC_MMU_IDX); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -198,6 +194,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         cmp = atomic_cmpxchg__nocheck(haddr, old, new);             \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, info);                         \
     return RET;                                                     \
 }
 
@@ -235,14 +232,18 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
+                                                           false,
+                                                           ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
 #else
     ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, info);
     return BSWAP(ret);
 }
 
@@ -252,10 +253,14 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
+                                                           false,
+                                                           ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_LD;
+    atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_ld_post(env, addr, info);
     return BSWAP(val);
 }
 
@@ -264,11 +269,16 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
+                                                           true,
+                                                           ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_ST;
+    val = BSWAP(val);
+    atomic_trace_st_pre(env, addr, info);
     val = BSWAP(val);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_st_post(env, addr, info);
 }
 #endif
 #else
@@ -278,10 +288,14 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
+                                                           false,
+                                                           ATOMIC_MMU_IDX);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, info);
     return BSWAP(ret);
 }
 
@@ -292,10 +306,14 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
+                                                           false,   \
+                                                           ATOMIC_MMU_IDX); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, info);                         \
     return BSWAP(ret);                                              \
 }
 
@@ -322,8 +340,11 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
+                                                           false,   \
+                                                           ATOMIC_MMU_IDX); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -331,6 +352,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));      \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, info);                         \
     return RET;                                                     \
 }
 
@@ -358,10 +380,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef MEND
 #endif /* DATA_SIZE > 1 */
 
-#undef ATOMIC_TRACE_ST
-#undef ATOMIC_TRACE_LD
-#undef ATOMIC_TRACE_RMW
-
 #undef BSWAP
 #undef ABI_TYPE
 #undef DATA_TYPE
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 82a5783a2bc..82282d30d93 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1825,6 +1825,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define ATOMIC_MMU_CLEANUP
 #define ATOMIC_MMU_IDX   get_mmuidx(oi)
 
+#include "atomic_common.inc.c"
+
 #define DATA_SIZE 1
 #include "atomic_template.h"
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 8d315a65876..b09f7a15770 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -756,6 +756,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
 
+#include "atomic_common.inc.c"
+
 #define DATA_SIZE 1
 #include "atomic_template.h"
 
-- 
2.20.1


