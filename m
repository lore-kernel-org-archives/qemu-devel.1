Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7903C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 20:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A7D20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 20:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAjkkLxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A7D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8VHU-0002Ld-3x
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 16:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8VFk-00011R-NJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8VFj-0005Is-O2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:59:40 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:32991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8VFj-0005Id-Jx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:59:39 -0400
Received: by mail-qk1-x733.google.com with SMTP id x134so25784694qkb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GVLFTA60hlmj+H2/7YDDPt5FNC57y3vvDPP1cxQ2fC0=;
 b=UAjkkLxRH9fiRL8QLbkLEsnY+SDmrDdWDNJx3wJcdb2Ga9eQl9yuayfALMFNe2gjMu
 ue5qJaiR/wDLfrLM4I0WDE9U4eLCzg2fK57XdaKI5PX15NikPbbtXXrKZGdBJ57vdxjQ
 3+fIPmfxNRGSIbwHn/su8ygSIf4n0JSwf/n5O302Da0ZMSZs+XZLC9chUH8b11bHRjPQ
 YNP9CRJZ1K/UKOaagjoP4B0IS2jhzYYA1MRt083ywk2/loHZcTOkG/erLGQufpAmnydU
 q5eWVhD7lGAtbT+g8VbeAUt+GtJYv1ky1WBXVQy29DpMuDtkoF6/1swN1tZL3Ch8G/LD
 G+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GVLFTA60hlmj+H2/7YDDPt5FNC57y3vvDPP1cxQ2fC0=;
 b=R+6dJ85/TXKyYWsX1aEK3pvBBLJG+oYKqiy0oi3LwerSvop4upcKlCvQkN18EJP5A/
 /Vz0kZZWjhPAvAtwpfV55QIYcfxBwT7V23Xp714CFx8YeY8uiVJ1HBNsLpvs6DhaSRK3
 SDPyI9XKIV0oVN+yGIxUyWVwlwduAs6Ixt64IReK3ChLi2PI0R3BUH+6dFmi3dt3mTm3
 zWrUlfipITQ99TOUlUbviGmRgj4jIubFywUUwM4olTnl6GcmNp9GzSXQ1AOFz/Jo9QQe
 ll+YfkOzfcxmRCnTOAccswlqKpUI3HlXwp3YqQ+rOgXl/zcQizY52CY7NzBgWBeljccK
 cYSw==
X-Gm-Message-State: APjAAAUHDyqKLRa/33hHdF8rDAwEZa0Ms5KW3GIQwwhAxikXjcEwCLkl
 KdFiJ2D/aKy0ZMLouYGkiynM9KL20WyyWw==
X-Google-Smtp-Source: APXvYqzpsU3w77HoI8lQa3q1cKwnrIaA1/jji48ZT2H0nO2h+gdhNi+lEg0U5CVimvCnMcmFeMx8/Q==
X-Received: by 2002:a37:a48b:: with SMTP id
 n133mr37221462qke.398.1568318378422; 
 Thu, 12 Sep 2019 12:59:38 -0700 (PDT)
Received: from localhost.localdomain ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id k11sm11140897qtp.26.2019.09.12.12.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 12:59:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 15:59:32 -0400
Message-Id: <20190912195934.13502-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912195934.13502-1-richard.henderson@linaro.org>
References: <20190912195934.13502-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::733
Subject: [Qemu-devel] [PATCH v2 1/3] cputlb: Disable __always_inline__
 without optimization
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This forced inlining can result in missing symbols,
which makes a debugging build harder to follow.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 11 +++++++++++
 accel/tcg/cputlb.c      |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 09fc44cca4..d6d400c523 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -170,6 +170,17 @@
 # define QEMU_NONSTRING
 #endif
 
+/*
+ * Forced inlining may be desired to encourage constant propagation
+ * of function parameters.  However, it can also make debugging harder,
+ * so disable it for a non-optimizing build.
+ */
+#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
+#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
+#else
+#define QEMU_ALWAYS_INLINE
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abae79650c..2222b87764 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1281,7 +1281,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
-static inline uint64_t __attribute__((always_inline))
+static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
@@ -1530,7 +1530,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static inline void __attribute__((always_inline))
+static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
-- 
2.17.1


