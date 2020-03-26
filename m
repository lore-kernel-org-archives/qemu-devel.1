Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEDEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166A320663
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4spmkhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166A320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbqq-0000n6-80
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbci-00035U-Nw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbch-0001xl-7z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbch-0001wZ-1c
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:15 -0400
Received: by mail-pf1-x441.google.com with SMTP id z65so3545055pfz.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gruaHJOeD8WvnhMIfKkze3XKHGHvv2/+9IJLAI7Js3I=;
 b=T4spmkhxY+XY0VoCM6cAeio6xDP/bnRE+S2bIyjiIN6IYxOPv8exi560GTi6kAUcpa
 hBnOBO5v3dTcj4NFoyWvTsPXW1uekeOEIunYMZjwaInR5jTKkNqMEXYLMniEMsXCl+ow
 6M2TwsX5S4MklHqCSZkpDBx+P2v6tTMJhOk+5eZGOAdFH863SIRwai13pMHeC/BGqvPv
 iEz3E3u/tRsBJdwT/8ixdmUtNJ0qrYf7Ns4/MmT/K9BlsJok8Vm6tas1oUT5FBczpHLv
 iXcxkPKScIo8Jhmsgf+/9smNbjaJSeRSsZx8zAcPHXCnupl75DAxTMYtD+Gm/ZPSsZlQ
 oXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gruaHJOeD8WvnhMIfKkze3XKHGHvv2/+9IJLAI7Js3I=;
 b=I05k7XVlskPStGMVpycqCrWV9AQsWA26hgHHGziBhBzAcwHPIdnFMVaRFWArGbgzzL
 Kxaxn2AfzyBUJO11/IJDdwiGxq72q0/T2cliln4uhBN4Qmtm8puZ8DAeAd7TV9Dl0Yk0
 s0YRNnyqKDEDFsxc4QarCHoPtUqP7lQkhrNWJp9hzixVVdh6hQhJZJ2DbbclqAYb8NIW
 8m3BwVoYO32oU7kV+OHLgJ707M1CZAaHSEGRenmiSHFdkhpoFlA/uHZl7/wrIRvPd3aR
 Lpq+Wj6+Ox8MHM+WivVLT0LzTwQDqY6xorAZbXnXv8PuZHUyTG9ELecmFgsaQUrvHyQf
 q3Iw==
X-Gm-Message-State: ANhLgQ1xRaFs4ZooEb6yORTuh3kPbuKL9E8yIFZn4RbnunmS11AdMj5X
 LQ5+yF753Fg1jOZJgPUNweJF4lWwvuw=
X-Google-Smtp-Source: ADFU+vs3L1Sl/5tE2cuoMtF8BNkjYIlc26nth96PD2LmJTnnhwR02hfCEuj2EdMm8qWVWxs+NBz5Gw==
X-Received: by 2002:a63:7159:: with SMTP id b25mr10696807pgn.72.1585264153691; 
 Thu, 26 Mar 2020 16:09:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/31] target/arm: Tidy handle_vec_simd_shri
Date: Thu, 26 Mar 2020 16:08:34 -0700
Message-Id: <20200326230838.31112-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we've converted all cases to gvec, there is quite a bit
of dead code at the end of the function.  Remove it.

Sink the call to gen_gvec_fn2i to the end, loading a function
pointer within the switch statement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 56 ++++++++++----------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f7d492cce4..fc156a217a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11096,16 +11096,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = 2 * (8 << size) - immhb;
-    bool accumulate = false;
-    int dsize = is_q ? 128 : 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    MemOp memop = size | (is_u ? 0 : MO_SIGN);
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
-    TCGv_i64 tcg_round;
-    uint64_t round_const;
-    int i;
+    GVecGen2iFn *gvec_fn;
 
     if (extract32(immh, 3, 1) && !is_q) {
         unallocated_encoding(s);
@@ -11119,13 +11110,12 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? arm_gen_gvec_usra : arm_gen_gvec_ssra, size);
-        return;
+        gvec_fn = is_u ? arm_gen_gvec_usra : arm_gen_gvec_ssra;
+        break;
 
     case 0x08: /* SRI */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, arm_gen_gvec_sri, size);
-        return;
+        gvec_fn = arm_gen_gvec_sri;
+        break;
 
     case 0x00: /* SSHR / USHR */
         if (is_u) {
@@ -11133,49 +11123,31 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                 /* Shift count the same size as element size produces zero.  */
                 tcg_gen_gvec_dup8i(vec_full_reg_offset(s, rd),
                                    is_q ? 16 : 8, vec_full_reg_size(s), 0);
-            } else {
-                gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri, size);
+                return;
             }
+            gvec_fn = tcg_gen_gvec_shri;
         } else {
             /* Shift count the same size as element size produces all sign.  */
             if (shift == 8 << size) {
                 shift -= 1;
             }
-            gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_sari, size);
+            gvec_fn = tcg_gen_gvec_sari;
         }
-        return;
+        break;
 
     case 0x04: /* SRSHR / URSHR (rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? arm_gen_gvec_urshr : arm_gen_gvec_srshr, size);
-        return;
+        gvec_fn = is_u ? arm_gen_gvec_urshr : arm_gen_gvec_srshr;
+        break;
 
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? arm_gen_gvec_ursra : arm_gen_gvec_srsra, size);
-        return;
+        gvec_fn = is_u ? arm_gen_gvec_ursra : arm_gen_gvec_srsra;
+        break;
 
     default:
         g_assert_not_reached();
     }
 
-    round_const = 1ULL << (shift - 1);
-    tcg_round = tcg_const_i64(round_const);
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, memop);
-        if (accumulate) {
-            read_vec_element(s, tcg_rd, rd, i, memop);
-        }
-
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
-                                accumulate, is_u, size, shift);
-
-        write_vec_element(s, tcg_rd, rd, i, size);
-    }
-    tcg_temp_free_i64(tcg_round);
-
-    clear_vec_high(s, is_q, rd);
+    gen_gvec_fn2i(s, is_q, rd, rn, shift, gvec_fn, size);
 }
 
 /* SHL/SLI - Vector shift left */
-- 
2.20.1


