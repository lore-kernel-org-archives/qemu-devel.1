Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7704C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7574C206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="takOPE83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7574C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrjn-00036V-Pr
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrj3-0001h6-R9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrj2-0000r0-3G
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:45:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrj1-0000oo-Rc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:45:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so70418868wrf.11
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eC3XCZD9HgCTHQjJiNXgLX49Tv5qbDgWg1bMsuBuPhU=;
 b=takOPE83F83DP8Y0uqs9thnZZcre+djfNLeM6bfUSMSbdyCxNipsb7VD0deUb21eaP
 LGvvLaGedKyqi5WzgrrzhEHvSe0hI5GGM/eU5G2DVGQh+LotyT6qwudN6oiAKkqlhbr2
 bTk37aClqhEgt3Yj+53W/oxnUCf+M8Z6CIPr1YrxMg4lY/Tdb1S73WsUsXTqdyd9n1Rx
 NTgSejXfPm4/9b+DsXAecnwEDasOSsBEwTzvXVIXWNMMPgQM29gCDgJ/VbN6xzOPABtD
 GvUmwV/A13bjwGe5vs6pRctaXApYJAMPk93Y1nl2yXNEN3DjZfiU6BhTHeWpQUoeOqZN
 qZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eC3XCZD9HgCTHQjJiNXgLX49Tv5qbDgWg1bMsuBuPhU=;
 b=FYZ3wCGkvB8PK0WuMQb43MvUVXFObDO6UPJress9LYs3QJoW8U86BDC+ImZRYD4zEn
 LUJLmJFQAF9UvVAet/Chx0CGf181A9dW4penbJYkR7X1T2mtsJG+zHSYjPZju3wE+dl1
 2yqnSgiyfd4/NMIFaWvtlk98kK/XjIvYhIlTRqveU5JZT7Z+s1yVHjalupxGtDJKE0/V
 UUJBDglssYvuONi4hvNAJHOVpv8iJE0Do71UwKdxE3qAdKVLqKiQeezxxfD/PiMvy1zn
 GH5KGWsN1k8ixYVfIYv5YIHbwaEmtJJGfJf2hWq7SbeRr7Ux/sCYKk9QkMTdhTS6v4IK
 hdfQ==
X-Gm-Message-State: APjAAAXZWPYS/YC2PTobz9blOCZPymaQfGYxSN9CkNbiF2ukAn/aj/+U
 4eeYdY29fD+pgV50Kqnwd5DxcQ==
X-Google-Smtp-Source: APXvYqwNOZNo2trd622Iwn5v+apzFJdp8vZI1sVeiAgni5KV9BHsJEdLirqBw3sE973y37t918s5+w==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr81997425wrs.160.1564591513753; 
 Wed, 31 Jul 2019 09:45:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d10sm57499852wrx.34.2019.07.31.09.45.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:45:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B3441FFAA;
 Wed, 31 Jul 2019 17:07:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:47 +0100
Message-Id: <20190731160719.11396-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 22/54] atomic_template: add inline
 trace/plugin helpers
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
Cc: Riku Voipio <riku.voipio@iki.fi>, aaron@os.amperecomputing.com,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

In preparation for plugin support.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - move common stuff to atomic_common.inc.c
  - fix ups for widened uint16_t info
  - drop haddr in helpers
  - fix wide lines
---
 accel/tcg/atomic_common.inc.c | 50 +++++++++++++++++++
 accel/tcg/atomic_template.h   | 93 +++++++++++++++++++++--------------
 accel/tcg/cputlb.c            |  2 +
 accel/tcg/user-exec.c         |  2 +
 4 files changed, 111 insertions(+), 36 deletions(-)
 create mode 100644 accel/tcg/atomic_common.inc.c

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
index 53899bbbc21..34f891d4a62 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -59,26 +59,6 @@
 # define ABI_TYPE  uint32_t
 #endif
 
-#define ATOMIC_TRACE_RMW do {                                           \
-        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false, ATOMIC_MMU_IDX); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-        trace_guest_mem_before_exec(env_cpu(env), addr,             \
-                                    info | TRACE_MEM_ST);               \
-    } while (0)
-
-#define ATOMIC_TRACE_LD do {                                            \
-        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false, ATOMIC_MMU_IDX); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-    } while (0)
-
-# define ATOMIC_TRACE_ST do {                                           \
-        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true, ATOMIC_MMU_IDX); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-    } while (0)
-
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
 #if DATA_SIZE == 1
@@ -98,14 +78,17 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
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
 
@@ -115,10 +98,13 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
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
 
@@ -127,10 +113,13 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
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
@@ -140,10 +129,13 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
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
 
@@ -154,10 +146,14 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
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
 
@@ -186,8 +182,11 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
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
@@ -195,6 +194,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         cmp = atomic_cmpxchg__nocheck(haddr, old, new);             \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, info);                         \
     return RET;                                                     \
 }
 
@@ -232,14 +232,18 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
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
 
@@ -249,10 +253,14 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
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
 
@@ -261,11 +269,16 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
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
@@ -275,10 +288,14 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
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
 
@@ -289,10 +306,14 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
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
 
@@ -319,8 +340,11 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
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
@@ -328,6 +352,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));      \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, info);                         \
     return RET;                                                     \
 }
 
@@ -355,10 +380,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
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
index 21ba71ea9dd..e4ac06041a2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1701,6 +1701,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     } while (0)
 #define ATOMIC_MMU_IDX oi
 
+#include "atomic_common.inc.c"
+
 #define DATA_SIZE 1
 #include "atomic_template.h"
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bff1934cf1b..1c8aee943dc 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -724,6 +724,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
 
+#include "atomic_common.inc.c"
+
 #define DATA_SIZE 1
 #include "atomic_template.h"
 
-- 
2.20.1


