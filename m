Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32FC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1522070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5fhP+cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1522070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Md-000119-Gz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IE-0003aD-2t
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IC-0002sy-GH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:01 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:39501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2IC-0002rv-8e
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:00 -0500
Received: by mail-pf1-x433.google.com with SMTP id q10so905893pfs.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RJG/9WXsiYhyTY2e8WA3sBBf4U0aC4vD0LzEvAIaj5k=;
 b=g5fhP+czOZPdzPmkjhJU5VvW4Idkk3N9UBKnngs5uziDurB6kYIM3rUXoYUS6cqVwq
 tEdgWriwe1iY8PxCsQ0i9QxYf8BbM2crK1NmSNWldFIn8xM+i4yD4TATDcfdixppklCA
 jZA1Ta69iLIggN8MN091avlJooLs9YHK+K7XUmOQYnQCBZjNBKTiZOdTG5UyPUqZ+z+Y
 4kdRv/67CQ9GSUT2X3Kd4dcC7MwWKDpbFtiJt90UkgkOrwmUVAVQdnGGukUnIHNsQJG4
 1DMgsV+TLPhGRvgReKUCZk4P+6cxPS9CdOxBAB4sxYmYPLc0O/qO67k4E903UYIheEsf
 0M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RJG/9WXsiYhyTY2e8WA3sBBf4U0aC4vD0LzEvAIaj5k=;
 b=jbS329DaPOhRG8mDRf7u1D8t80DEw29Y8A2tfghI/sN266x8nW4CE4uvc0tCYCCKeG
 E5ZDVJcoI62/6GjNl1RCUszAz//iTiKSiarUOLWweabKU9Ze5O6urwivzfdkiOnP2EE3
 YZfq0zDGErK9UZy885K+SHQmMyLNeqRnBwX2NdcA9+qVFRGr/jXp/v9vqZiXympIsWSO
 qSmLmwPHTUJGo+LFPDQVqwNJZpIZgkOE1OyH76r0jxlPOGkUsBbLpaOVO9SPfSsD7zNI
 psd+co3FkmLayh16TTXjKf2+l8xtiKTZQ24OjDK8MvHAHcpHxDHU4dVyWzv3IkZWan+3
 XPFQ==
X-Gm-Message-State: APjAAAWSsd7Ndn9yRmMBIbpL1A2NuvCdfVc9WXZtMib207Wk1355TgZG
 Ij1fo5T+imiwcVHszyvX70v6m4azGK/JyQ==
X-Google-Smtp-Source: APXvYqySHh7BLcOT+IT2kGdSD+7QJ+Mg8drwHiI5BJ/3Xg3IZH8Kq6mr8dCV/ccbCO2cnZAJA4azcA==
X-Received: by 2002:aa7:9145:: with SMTP id 5mr2919081pfi.74.1578455159001;
 Tue, 07 Jan 2020 19:45:59 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] trace: Remove trace_mem_build_info_no_se_[bl]e
Date: Wed,  8 Jan 2020 14:44:52 +1100
Message-Id: <20200108034523.17349-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
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

It is easy for the atomic helpers to use trace_mem_build_info
directly, without resorting to symbol pasting.  For this usage,
we cannot use trace_mem_get_info, because the MemOp does not
support 16-byte accesses.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 67 +++++++++++++------------------------
 trace/mem-internal.h        | 17 ----------
 2 files changed, 24 insertions(+), 60 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 837676231f..26969487d6 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -64,13 +64,10 @@
    the ATOMIC_NAME macro, and redefined below.  */
 #if DATA_SIZE == 1
 # define END
-# define MEND _be /* either le or be would be fine */
 #elif defined(HOST_WORDS_BIGENDIAN)
 # define END  _be
-# define MEND _be
 #else
 # define END  _le
-# define MEND _le
 #endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
@@ -79,8 +76,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
@@ -99,8 +96,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
@@ -114,8 +111,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true,
-                                                          ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, true,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_st_pre(env, addr, info);
     atomic16_set(haddr, val);
@@ -130,8 +127,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
-                                                          ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, val);
@@ -147,10 +144,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,    \
+                                         ATOMIC_MMU_IDX);           \
     atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
@@ -183,10 +178,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,    \
+                                         ATOMIC_MMU_IDX);           \
     atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
@@ -213,7 +206,6 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 #endif /* DATA SIZE >= 16 */
 
 #undef END
-#undef MEND
 
 #if DATA_SIZE > 1
 
@@ -221,10 +213,8 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
    within the ATOMIC_NAME macro.  */
 #ifdef HOST_WORDS_BIGENDIAN
 # define END  _le
-# define MEND _le
 #else
 # define END  _be
-# define MEND _be
 #endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
@@ -233,9 +223,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
@@ -254,9 +243,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
@@ -270,9 +258,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           true,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, true,
+                                         ATOMIC_MMU_IDX);
 
     val = BSWAP(val);
     atomic_trace_st_pre(env, addr, info);
@@ -289,9 +276,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, BSWAP(val));
@@ -307,10 +293,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP,    \
+                                         false, ATOMIC_MMU_IDX);    \
     atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
@@ -341,10 +325,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP,    \
+                                         false, ATOMIC_MMU_IDX);    \
     atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
@@ -378,7 +360,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #endif /* DATA_SIZE >= 16 */
 
 #undef END
-#undef MEND
 #endif /* DATA_SIZE > 1 */
 
 #undef BSWAP
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index 0a32aa22ca..8b72b678fa 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -47,21 +47,4 @@ static inline uint16_t trace_mem_get_info(MemOp op,
                                 mmu_idx);
 }
 
-/* Used by the atomic helpers */
-static inline
-uint16_t trace_mem_build_info_no_se_be(int size_shift, bool store,
-                                       TCGMemOpIdx oi)
-{
-    return trace_mem_build_info(size_shift, false, MO_BE, store,
-                                get_mmuidx(oi));
-}
-
-static inline
-uint16_t trace_mem_build_info_no_se_le(int size_shift, bool store,
-                                       TCGMemOpIdx oi)
-{
-    return trace_mem_build_info(size_shift, false, MO_LE, store,
-                                get_mmuidx(oi));
-}
-
 #endif /* TRACE__MEM_INTERNAL_H */
-- 
2.20.1


