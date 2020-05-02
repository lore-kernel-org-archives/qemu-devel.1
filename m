Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8968C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E6A206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C188vxqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV10g-0002HD-SO
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sl-0003BH-9a
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sk-0004c0-7a
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:14 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sj-0004ZK-OV
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id h11so5176587plr.11
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3UIiAqWxRQSzQef8dIuVVnVIZspSlNbG4WcR7Cqf/AI=;
 b=C188vxqXhvrX8VRnIDVlQkbXfft2SY0Pny/vL0K80OzUbMAU2BYM9Xe2aBXu3gI9Ju
 Gm2HOupePMmO7WOok8NpgPt13J89fcTcA8F6XCKBbQPWVMRNKr9YTa8MTjPPggFzYnVU
 0a7wz9AYIchnqbEQhlwRTYbBqAL98nqpve2uHQX2bGovjz5lHSnZ8TiEtdnL5xdDRqi1
 05Q1PjQVumWFI+NvR/skhdWPW6cJBtzfLDOzD6UDLAjlu96Mssydl1Peu06mqgwN2NaR
 xx+APlX65kDfVN/RVNgsshnn8FtNrArwjIDGHmU/InlznsHexzebApK7kq2Me2Uicp61
 +MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3UIiAqWxRQSzQef8dIuVVnVIZspSlNbG4WcR7Cqf/AI=;
 b=dKNhFeYbX9htPYcnvEC+KwXZHMy6tjqE0QI2FlrzLOYmQFLdmt9Nv+J5tqw8bPoBN3
 Q5hOjOReXB/PEw9hJrOa3v/PGk8cg7sdZOVWzzez4A2BhxpfFeIsNleX1vdgRVvxWgnh
 PfKFndLAhGl+cvNxtzM11kapuNybslSRlknS9SjQH9hWLcLsZ7Hqo5ov+o4ZbA+Q72Q7
 epDUp3mtZoTLUil7w41EJZ7T7kIhaHoMedb3QtPRNkI3N90JiTr4NAoJ50E8MKJSt/S/
 10aUPgkBOFviz871ZD2/KYzHc/8n8Ab7KN+NJ1CsKHecozXyWzpo++eVbcTpMG4HRZ6b
 rmXQ==
X-Gm-Message-State: AGi0PubzC+H2/vfRwSJkhed0pUkZudCBLzrAMwNApGYks78LK63BCCHj
 y49qNPqhjKVCTTufFONUlwjsRld/qUM=
X-Google-Smtp-Source: APiQypKyav7GngGIm187OkUh+YHL7uiV9zoUDkje7QZGnltkMHEIsIMWj2bYy5ng+vzu5Jscu8JeKA==
X-Received: by 2002:a17:902:7042:: with SMTP id
 h2mr3730319plt.204.1588459512053; 
 Sat, 02 May 2020 15:45:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/15] target/arm: Tidy handle_vec_simd_shri
Date: Sat,  2 May 2020 15:44:53 -0700
Message-Id: <20200502224503.2282-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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


