Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566A1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2048421556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpmm9ywG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2048421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if8k4-0005Ez-Rv
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 15:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1if8ib-0003rD-4X
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1if8iZ-0001X7-BJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:20 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1if8iZ-0001VI-4C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:19 -0500
Received: by mail-pf1-x442.google.com with SMTP id b19so2379655pfo.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=knjG1W+JMFdlNWZyzKDLUOddBzH6VeQ/PZgBz+DCRgI=;
 b=hpmm9ywGfEi6WZ2fF0Dua2mHOE3+l5Mou6ixp7CB2qeoaNXqZbGrKqHSxUWFTAyk8u
 9kNONPI8dBsQOVcr6rmOajuyjQHI1KHnvKYOUoORs+zu8h9Fslzbl2VhVTnprMCMut1L
 /s+F+C4ka5G+JmfXGxzhvGP911iSs+FFU/qg+WbDhfgvyS3KvDUjjA53DLUfzhumOjWk
 3NkP3e8Mpt7a9Uq5yiJPkr9ylVNRM6hrVLgVkj4y9kFU0mDZPqTxjHNfcs8WoSvXWh41
 9oB2wIiA0D7iApThXsB+O+pE37HnJfelel9CbeGXBk1Pb20tMAO5hKD1uZJ30573irbA
 t4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=knjG1W+JMFdlNWZyzKDLUOddBzH6VeQ/PZgBz+DCRgI=;
 b=eYTL65FvjEEvJGLDQ8SN/FXVImlPn7j8pJs1xTgZ1ZIiY/VxKw4zf0cVX2i/1HJCgQ
 hD3DO/dsI+Pt8idWSX5AjKcULXpq2b5U73PfRG1Y9oEBMhYrt64Swoe/CyyQK/fbWhUS
 iArH3p6WQdICTVGJDiYKJvqWd/Qx9qGBBM0bPqApBVFHFlaNlfwhSOKJh+vqGwMjQ7Hi
 v1kspH3JimwCQYQ9tcpbkQADonRaeXwRMM5+MaqzO0OTU+cSS54mpWC3gye4vE/1AdiK
 6/bARkFtEHNtVBBJefJSO4wNNMkaH18qx26bKJrnsvKaiAwlp73WQDmrFIL08Vmj/gkV
 mzJA==
X-Gm-Message-State: APjAAAUD6yPII7CRW6PqOtbjkIU8mtrJc406kQ1xymuH5DZsm659NtqI
 yFxwDftX+v84sGnrdn1DMOQRzxy1/Pg=
X-Google-Smtp-Source: APXvYqw+vb75bgErOOTSVVYvrWTY/k89v08R+x1wuT871LpZYZ7yE/HWHZNk/hylxDZ+vXQD8O8X1g==
X-Received: by 2002:a62:ac03:: with SMTP id v3mr5764507pfe.17.1576096577195;
 Wed, 11 Dec 2019 12:36:17 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b21sm4280335pfp.0.2019.12.11.12.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 12:36:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/s390x: Split out helper_per_store_real
Date: Wed, 11 Dec 2019 12:36:13 -0800
Message-Id: <20191211203614.15611-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211203614.15611-1-richard.henderson@linaro.org>
References: <20191211203614.15611-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split the PER handling for store-to-real-address into its
own helper function, conditionally called when PER is
enabled, just as we do for per_branch and per_ifetch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h      |  1 +
 target/s390x/mem_helper.c  | 16 ----------------
 target/s390x/misc_helper.c | 10 ++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 56e8149866..f5b4bb6a31 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -331,6 +331,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_2(xsch, void, env, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2325767f17..b1b3f406c9 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2344,27 +2344,11 @@ uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
 void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
-
-    if ((env->psw.mask & PSW_MASK_PER) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
-        /* PSW is saved just before calling the helper.  */
-        env->per_address = env->psw.addr;
-        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
-    }
 }
 
 void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
-
-    if ((env->psw.mask & PSW_MASK_PER) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
-        /* PSW is saved just before calling the helper.  */
-        env->per_address = env->psw.addr;
-        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
-    }
 }
 
 /* load real address */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index bfb457fb63..58dbc023eb 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -620,6 +620,16 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
         }
     }
 }
+
+void HELPER(per_store_real)(CPUS390XState *env)
+{
+    if ((env->cregs[9] & PER_CR9_EVENT_STORE) &&
+        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
+        /* PSW is saved just before calling the helper.  */
+        env->per_address = env->psw.addr;
+        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
+    }
+}
 #endif
 
 static uint8_t stfl_bytes[2048];
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 151dfa91fb..ef751fefa4 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4507,12 +4507,20 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
     gen_helper_stura(cpu_env, o->in2, o->in1);
+    if (s->base.tb->flags & FLAG_MASK_PER) {
+        update_psw_addr(s);
+        gen_helper_per_store_real(cpu_env);
+    }
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
 {
     gen_helper_sturg(cpu_env, o->in2, o->in1);
+    if (s->base.tb->flags & FLAG_MASK_PER) {
+        update_psw_addr(s);
+        gen_helper_per_store_real(cpu_env);
+    }
     return DISAS_NEXT;
 }
 #endif
-- 
2.20.1


