Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6171C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F87E20856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/+oaWBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F87E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iASXy-0003lc-Pk
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 01:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUO-0002LW-A2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUM-00073e-Bw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iASUM-00072u-5M
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id q15so255258pll.11
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9uud/rh9P2t2h4DIelDsx28iFQpChIhakBWJac9SU70=;
 b=y/+oaWBuyI5yPWanOBQjTAR3Z0htuRA5jPPHDcShFxZq0c1RH+4WxEzr0sIC0N0v5Y
 VIlwG+MFMq2zgpeVY7Z0dt6D5ctHHywnDAip5nHY1T/6UuH2WWuIWvhMftLbkpzVb/NK
 PpWLsdyVBbn4CmKYy/4Ho5INVsfuK6Jo0OR4YoxKc/wYitS55B2tpsWrkJmGTFPQs+WN
 FCumZ0VmMe6h6zzD8cllxustDwK5Mjw+sa0R2ft6NBzZ5vUZQkmi3mv7zlPNgXJcHubF
 quN1bG3tY/JoESN0cgWQuUh5KeEJa2xJg+UhyLkfkuJ7+SEQlEMBG52i/835RSdur6Oy
 9EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9uud/rh9P2t2h4DIelDsx28iFQpChIhakBWJac9SU70=;
 b=IrJqCKLoMt6NZFJC4Nac3QQCdIFTGzXDdNq2sRYJzZSLdtjNzOq1keHBgaMbZVVpVM
 N3cj0hy3U2fZwyeewhZHmZkWROMjC9kZD6mDQFrtEudgYaffKzof7Xm/JHcWYsJ/ZLgY
 JWpuM9q1P4iPfx+TbrCEZhbNNmuBrn6Ce53ix6CIVRfMhKxrC9hCvDyFZcOqoh4rQce+
 dgpdKPCBUI4oJAVsbe2dbReI2/2fiGQjQqridbCdYIXX38DVCetZnSniIcdN5S+uSuA9
 tQDWMfcIsMG29iO0YQf6wvn1N+vd3wkoj7yju7jI6dTZZMiDwkL/t2paCzjcps83nTo3
 kt9A==
X-Gm-Message-State: APjAAAX5B1mQraRb92nN3zB8UWkXTbMgxigAdbatSo4LEXsw/+7hnpL0
 LRFA1PSK8rNQ3FiPhQcET6RW+LzMlbI=
X-Google-Smtp-Source: APXvYqwNuO2yOuuo+tsqTQoa7EkVzRR0KYQHjqtVVrGnEGqhntmbrG5xSJuIe0kmkqzmoXQqT28HFg==
X-Received: by 2002:a17:902:aa4a:: with SMTP id
 c10mr2305065plr.340.1568784408240; 
 Tue, 17 Sep 2019 22:26:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a1sm3457234pgd.74.2019.09.17.22.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 22:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 22:26:41 -0700
Message-Id: <20190918052641.21300-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918052641.21300-1-richard.henderson@linaro.org>
References: <20190918052641.21300-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [RFC 3/3] cputlb: Remove ATOMIC_MMU_DECLS
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This macro no longer has a non-empty definition.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 12 ------------
 accel/tcg/cputlb.c          |  1 -
 accel/tcg/user-exec.c       |  1 -
 3 files changed, 14 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 287433d809..107660d5d3 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -95,7 +95,6 @@
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
 
@@ -113,7 +112,6 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 #if HAVE_ATOMIC128
 ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_LD;
@@ -125,7 +123,6 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
                      ABI_TYPE val EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_ST;
@@ -137,7 +134,6 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
 
@@ -151,7 +147,6 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE val EXTRA_ARGS)                    \
 {                                                                   \
-    ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
                                                                     \
@@ -183,7 +178,6 @@ GEN_ATOMIC_HELPER(xor_fetch)
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE xval EXTRA_ARGS)                   \
 {                                                                   \
-    ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
                                                                     \
@@ -229,7 +223,6 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
 
@@ -247,7 +240,6 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 #if HAVE_ATOMIC128
 ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_LD;
@@ -259,7 +251,6 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
                      ABI_TYPE val EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_ST;
@@ -272,7 +263,6 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
 {
-    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
 
@@ -286,7 +276,6 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE val EXTRA_ARGS)                    \
 {                                                                   \
-    ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
                                                                     \
@@ -316,7 +305,6 @@ GEN_ATOMIC_HELPER(xor_fetch)
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE xval EXTRA_ARGS)                   \
 {                                                                   \
-    ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
                                                                     \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7c4c763b88..d048fc82c9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1748,7 +1748,6 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define EXTRA_ARGS     , TCGMemOpIdx oi, uintptr_t retaddr
 #define ATOMIC_NAME(X) \
     HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
-#define ATOMIC_MMU_DECLS 
 #define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
 #define ATOMIC_MMU_CLEANUP
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 71c4bf6477..c353e452ea 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -748,7 +748,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 }
 
 /* Macro to call the above, with local variables from the use context.  */
-#define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
 #define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
 
-- 
2.17.1


