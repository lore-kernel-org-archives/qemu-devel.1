Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B16C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984612073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2IVHxe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984612073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUczm-0001Cj-N4
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyq-0008Bo-JR
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUcyp-0005ut-J2
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyp-0005n3-3G
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id s18so5065726pgl.12
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3UIiAqWxRQSzQef8dIuVVnVIZspSlNbG4WcR7Cqf/AI=;
 b=M2IVHxe5U95TMLynAu7DNIgpVy0TBHgeiCcRvhSc/boIIClheNr2Wh8hrp3o/M2wa5
 RHA6A2f7SmdvovtrhLydvC/Y+eMNDiB1qhPOR9PctnmkiMjDs27UGYwPxExrW158vrpO
 CcSPnMUalKT4mrbh5uVwfCs//1VfdhymjwF8XQSKmTGREyMDBz+fb6W/0gVkyA+miauk
 J7VT84EVEvoDldOG7oJMSoDNpvsPU6zBiWrEDq2O4RIjrBaVV8LTtPjTWvk6LLQA+Uhg
 8cPEAdXM8FDmwvtGftlEQIzIkpch4oxswyO0mr5t9v6zJGChewVrraVqW81D3mG55/9+
 O+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3UIiAqWxRQSzQef8dIuVVnVIZspSlNbG4WcR7Cqf/AI=;
 b=Hh1ZRp3fDuikspTn8EChdBeKG4FIhTSMD92q201PxWtMroVRAc9Rl7j/AzCAqWEwhy
 hAP8vBLuayeA6Gu8fePS0s6NtEf+HWToPE/cuduLUS7SE/guiY0ydg5THFyehsHSK6rG
 MX1sW0poo9AGI1byfLuijRiiUogjkO8j/n177hG7vsLIzYfSkqhuVREbJ8BVTubo9Fo2
 m7W9kB81aHLd95Say1hTwBaK4+iQWDvSnWK7gk62iMpfoUGy34zvfWR/NUTIDjQSkHTi
 9TdpW9MXH8Akt/fshidsFaMi3tK5Cr9X1joAxt7So4vqCEx/nFBURkA9yz3E5xO/D29d
 p49w==
X-Gm-Message-State: AGi0PuaERWILX0c+iBAodMt1p/FKtdzaj4qJIjPSpLhuRh2pKmBwJ8cn
 DQOwOeSS9nvHWQsMzyiFBJt4UmUf2sM=
X-Google-Smtp-Source: APiQypIantLL6uZmEN2mdDEvpebQgUGgmoyuIy8ZvDJEFSRKgAxH2q2+a/sBdyw5nY8vXBxpx3tBDA==
X-Received: by 2002:a63:d23:: with SMTP id c35mr6082043pgl.191.1588367633179; 
 Fri, 01 May 2020 14:13:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g22sm514552pju.21.2020.05.01.14.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 14:13:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/arm: Tidy handle_vec_simd_shri
Date: Fri,  1 May 2020 14:13:44 -0700
Message-Id: <20200501211345.30410-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501211345.30410-1-richard.henderson@linaro.org>
References: <20200501211345.30410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org
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
index bc326dadda..5937069992 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10172,16 +10172,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
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
@@ -10195,13 +10186,12 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_usra : gen_gvec_ssra, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_usra : gen_gvec_ssra;
+        break;
 
     case 0x08: /* SRI */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sri, size);
-        return;
+        gvec_fn = gen_gvec_sri;
+        break;
 
     case 0x00: /* SSHR / USHR */
         if (is_u) {
@@ -10209,49 +10199,31 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                 /* Shift count the same size as element size produces zero.  */
                 tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
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
-                      is_u ? gen_gvec_urshr : gen_gvec_srshr, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_urshr : gen_gvec_srshr;
+        break;
 
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_ursra : gen_gvec_srsra, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_ursra : gen_gvec_srsra;
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


