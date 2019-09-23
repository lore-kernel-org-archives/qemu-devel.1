Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D1DC432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8C21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPY2q1BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8C21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXY5-00026i-2b
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJe-0005aS-SL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJb-00083a-VD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:22 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJa-00082R-HO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id s1so7779745pgv.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dvpk1u15QL1a//tCscA4fTR0Q7V0VdpD0cml5SNVwXw=;
 b=jPY2q1BUbJbbn0HIxBFk5OFVhQWSQsIvTzJVNUEoAoYnkUiibsZeQbr80nQ1hr6b7H
 R7uwt4gekkjrm0N7AoQqMmwR1/98KC0/FOa5BFnU2s6b2Kqp0u+/nOTkdqCqvprwOOx+
 KYOPPwlqbtffibReWD4yM/wawcfbP6v2mg/Agr0qrhRxGwkVvi9SQ5Y5XRV2xLHWj7ca
 gAdcK1lWlLUf2kcpWQCJaWwxiedf+5ATo92sZnfYL8eJhVAYbkMg/Yin3Ty1QVu20Hjf
 zY9fQZzP1MM200JBaFwefcu9g7CwSVdqizra0dcqbr4bijYZx8uHoHHug3lkst76jdte
 bjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dvpk1u15QL1a//tCscA4fTR0Q7V0VdpD0cml5SNVwXw=;
 b=jVGbnSSNEVyCD/mECdVUzdv5So4C2Yp/XWiY6J3BMmyhGR2pj7++NBdDdea6zq0Nea
 ZaQuWsNiVz0B4ugqdAPr7i8izO0jjKsizZyX2zWjg8HXoLaNRVGva1YIcH1vzrcmjbvx
 TF8k1ZkmznlWo0AqyC29yI6EKDpVUsQy3jJuX7KHaeDn0XeCHsfJXMYvvOuG2GM06f+V
 i01BenHcKEqPmyBLBMTBG6SNv4P3U4fPggQhIkAO4vhTSIThUoeDLEPU7vKcqc/kplgM
 hbcodh4Va3SDnhtCGoN4MeI0qXF5AqY9c3AndQgMc7Dn6NcQ1nYSzh3CnFqOzknlDfze
 j9qg==
X-Gm-Message-State: APjAAAVUPaA85hzGUK48Itzy6cmGOtOqPmBJAs2sJ2sOz/D7G5Kogkj0
 WW/Z+LrAPKnHTMydFbfyZTmXlSgJOXc=
X-Google-Smtp-Source: APXvYqzcOVvORg6oq9BxB+PzKh++f7hEc08WYoV0ZD6tdNYygMuCQH+xQCy21IxVF9x2rX7ojyp9lw==
X-Received: by 2002:a17:90a:37c9:: with SMTP id
 v67mr2015517pjb.29.1569279615730; 
 Mon, 23 Sep 2019 16:00:15 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/16] cputlb: Split out load/store_memop
Date: Mon, 23 Sep 2019 15:59:53 -0700
Message-Id: <20190923230004.9231-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly be using these more than once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 110 +++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e529af6d09..430ba4a69d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1281,6 +1281,29 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
+static inline uint64_t QEMU_ALWAYS_INLINE
+load_memop(const void *haddr, MemOp op)
+{
+    switch (op) {
+    case MO_UB:
+        return ldub_p(haddr);
+    case MO_BEUW:
+        return lduw_be_p(haddr);
+    case MO_LEUW:
+        return lduw_le_p(haddr);
+    case MO_BEUL:
+        return (uint32_t)ldl_be_p(haddr);
+    case MO_LEUL:
+        return (uint32_t)ldl_le_p(haddr);
+    case MO_BEQ:
+        return ldq_be_p(haddr);
+    case MO_LEQ:
+        return ldq_le_p(haddr);
+    default:
+        optimize_away();
+    }
+}
+
 static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
@@ -1373,33 +1396,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (op) {
-    case MO_UB:
-        res = ldub_p(haddr);
-        break;
-    case MO_BEUW:
-        res = lduw_be_p(haddr);
-        break;
-    case MO_LEUW:
-        res = lduw_le_p(haddr);
-        break;
-    case MO_BEUL:
-        res = (uint32_t)ldl_be_p(haddr);
-        break;
-    case MO_LEUL:
-        res = (uint32_t)ldl_le_p(haddr);
-        break;
-    case MO_BEQ:
-        res = ldq_be_p(haddr);
-        break;
-    case MO_LEQ:
-        res = ldq_le_p(haddr);
-        break;
-    default:
-        optimize_away();
-    }
-
-    return res;
+    return load_memop(haddr, op);
 }
 
 /*
@@ -1415,7 +1412,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_mmu);
+    return load_helper(env, addr, oi, retaddr, MO_UB, false,
+                       full_ldub_mmu);
 }
 
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1530,6 +1528,36 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
+static inline void QEMU_ALWAYS_INLINE
+store_memop(void *haddr, uint64_t val, MemOp op)
+{
+    switch (op) {
+    case MO_UB:
+        stb_p(haddr, val);
+        break;
+    case MO_BEUW:
+        stw_be_p(haddr, val);
+        break;
+    case MO_LEUW:
+        stw_le_p(haddr, val);
+        break;
+    case MO_BEUL:
+        stl_be_p(haddr, val);
+        break;
+    case MO_LEUL:
+        stl_le_p(haddr, val);
+        break;
+    case MO_BEQ:
+        stq_be_p(haddr, val);
+        break;
+    case MO_LEQ:
+        stq_le_p(haddr, val);
+        break;
+    default:
+        optimize_away();
+    }
+}
+
 static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
@@ -1657,31 +1685,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (op) {
-    case MO_UB:
-        stb_p(haddr, val);
-        break;
-    case MO_BEUW:
-        stw_be_p(haddr, val);
-        break;
-    case MO_LEUW:
-        stw_le_p(haddr, val);
-        break;
-    case MO_BEUL:
-        stl_be_p(haddr, val);
-        break;
-    case MO_LEUL:
-        stl_le_p(haddr, val);
-        break;
-    case MO_BEQ:
-        stq_be_p(haddr, val);
-        break;
-    case MO_LEQ:
-        stq_le_p(haddr, val);
-        break;
-    default:
-        optimize_away();
-    }
+    store_memop(haddr, val, op);
 }
 
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-- 
2.17.1


