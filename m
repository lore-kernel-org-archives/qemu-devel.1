Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3103FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA95206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjfjWLiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA95206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0un-0006c6-VJ
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sk-00039K-1R
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sh-0004V0-7J
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:13 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sg-0004Th-OW
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:10 -0400
Received: by mail-pj1-x1041.google.com with SMTP id fu13so1859654pjb.5
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CXF9hoqm6JD/UN9y51ciG1nlrGUHFw+zFqLn1o/FF0w=;
 b=PjfjWLiCqCG/TZMjdoIEHx/dBZful6RG2jVph5feRlPcCRH9ZHH8014Ijhkb7/BnNF
 8HQAG0QJxmQVPDOTXkEBZj+t0XjGn192iA11NJTldnlcP7OkWiTAhTng9lCar4ehiNRQ
 MRpBc5R+I+tY3ochuokxFsoGS1wlWZvHJQjcHqbvwLrZwqvuzRi5poTHMW8qGSKlHKX8
 /m+JLDLEY2aJ1I/iq+4ffJ+NSEl+KuYsZVV/v0opXWW4aW6skPu0g1INQRwNPZOJrN9U
 yn0RF/IV9Xs2IFxft4BQxs/Km5NXyiEdNBJMTPPKyzi8NXBkQzqfTMcMC45vLnDbiRb/
 xy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CXF9hoqm6JD/UN9y51ciG1nlrGUHFw+zFqLn1o/FF0w=;
 b=uAXRRF1ROJEg0tpm472QG/D0HfTHYqtVLa89bwEGPet5ePp+yl2osbwK/hwM2xOiQx
 /IPgX/v5ywhPV2RQOEvlZpbx0aGL4+0qjfPhdrFFBlH0BE0hUV5H4o4vhXNHucb7FjSf
 d6cEYrRyC6WtLURM9IIj1VIj/NtMXO0F7Ff+q1SnCmhaIsSWKwZ+xKMjduOpVk/LJArG
 hSfORmfyfBk385BP3MEdPjOwQ+ne50wAz+3fE7NW2V7GGfH3DyMNTcRnA6pogHyISFTD
 MiEdGRnQghTYecVnMuhhpD4VdZHpzjaWrqtcRx0oxiwyZ4O4Nw+/gtoe9lfBfbPFC6qB
 5UBA==
X-Gm-Message-State: AGi0PuZuvdGCtmhdZXbFflOKB6e4XfX6oFdNq3IApsPDunnA8xL35oZu
 M5xGVRC1CiM41Dn0krsLurs5VO5xAzY=
X-Google-Smtp-Source: APiQypICgQzffxn/l+B4gVHuLhA04feB41Z0nRHdCDyuZ6lJ29hUvZVt50brn63ZbKQ6v5Ih5rEJwQ==
X-Received: by 2002:a17:902:c487:: with SMTP id
 n7mr10713728plx.316.1588459508292; 
 Sat, 02 May 2020 15:45:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] target/arm: Create gen_gvec_{u,s}{rshr,rsra}
Date: Sat,  2 May 2020 15:44:50 -0700
Message-Id: <20200502224503.2282-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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

Create vectorized versions of handle_shri_with_rndacc
for shift+round and shift+round+accumulate.  Add out-of-line
helpers in preparation for longer vector lengths from SVE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  20 ++
 target/arm/translate.h     |   9 +
 target/arm/translate-a64.c |  11 +-
 target/arm/translate.c     | 461 +++++++++++++++++++++++++++++++++++--
 target/arm/vec_helper.c    |  50 ++++
 5 files changed, 525 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9bc162345c..aeb1f52455 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -701,6 +701,26 @@ DEF_HELPER_FLAGS_3(gvec_usra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_usra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_usra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_srshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_urshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_srsra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_ursra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index a39cf22666..823821f82c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -302,6 +302,15 @@ void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 03f4dc5805..1ef05d5ce1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10235,10 +10235,15 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         return;
 
     case 0x04: /* SRSHR / URSHR (rounding) */
-        break;
+        gen_gvec_fn2i(s, is_q, rd, rn, shift,
+                      is_u ? gen_gvec_urshr : gen_gvec_srshr, size);
+        return;
+
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        accumulate = true;
-        break;
+        gen_gvec_fn2i(s, is_q, rd, rn, shift,
+                      is_u ? gen_gvec_ursra : gen_gvec_srsra, size);
+        return;
+
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 04114906d7..d724022cb6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4272,6 +4272,422 @@ void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
     }
 }
 
+/*
+ * Shift one less than the requested amount, and the low bit is
+ * the rounding bit.  For the 8 and 16-bit operations, because we
+ * mask the low bit, we can perform a normal integer shift instead
+ * of a vector shift.
+ */
+static void gen_srshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_sar8i_i64(d, a, sh);
+    tcg_gen_vec_add8_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_sar16i_i64(d, a, sh);
+    tcg_gen_vec_add16_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_extract_i32(t, a, sh - 1, 1);
+    tcg_gen_sari_i32(d, a, sh);
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_extract_i64(t, a, sh - 1, 1);
+    tcg_gen_sari_i64(d, a, sh);
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shri_vec(vece, t, a, sh - 1);
+    tcg_gen_dupi_vec(vece, ones, 1);
+    tcg_gen_and_vec(vece, t, t, ones);
+    tcg_gen_sari_vec(vece, d, a, sh);
+    tcg_gen_add_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(ones);
+}
+
+void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_srshr8_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_srshr16_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_srshr32_i32,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_srshr64_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    if (shift == (8 << vece)) {
+        /*
+         * Shifts larger than the element size are architecturally valid.
+         * Signed results in all sign bits.  With rounding, this produces
+         *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
+         * I.e. always zero.
+         */
+        tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_srsra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_srshr8_i64(t, a, sh);
+    tcg_gen_vec_add8_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srsra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_srshr16_i64(t, a, sh);
+    tcg_gen_vec_add16_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srsra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    gen_srshr32_i32(t, a, sh);
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_srsra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_srshr64_i64(t, a, sh);
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_srsra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    gen_srshr_vec(vece, t, a, sh);
+    tcg_gen_add_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_srsra8_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_srsra16_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_srsra32_i32,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_srsra64_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Signed results in all sign bits.  With rounding, this produces
+     *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
+     * I.e. always zero.  With accumulation, this leaves D unchanged.
+     */
+    if (shift == (8 << vece)) {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_urshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_shr8i_i64(d, a, sh);
+    tcg_gen_vec_add8_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_urshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_shr16i_i64(d, a, sh);
+    tcg_gen_vec_add16_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_urshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_extract_i32(t, a, sh - 1, 1);
+    tcg_gen_shri_i32(d, a, sh);
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_extract_i64(t, a, sh - 1, 1);
+    tcg_gen_shri_i64(d, a, sh);
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_urshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shri_vec(vece, t, a, shift - 1);
+    tcg_gen_dupi_vec(vece, ones, 1);
+    tcg_gen_and_vec(vece, t, t, ones);
+    tcg_gen_shri_vec(vece, d, a, shift);
+    tcg_gen_add_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(ones);
+}
+
+void gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_urshr8_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_urshr16_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_urshr32_i32,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_urshr64_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    if (shift == (8 << vece)) {
+        /*
+         * Shifts larger than the element size are architecturally valid.
+         * Unsigned results in zero.  With rounding, this produces a
+         * copy of the most significant bit.
+         */
+        tcg_gen_gvec_shri(vece, rd_ofs, rm_ofs, shift - 1, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_ursra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (sh == 8) {
+        tcg_gen_vec_shr8i_i64(t, a, 7);
+    } else {
+        gen_urshr8_i64(t, a, sh);
+    }
+    tcg_gen_vec_add8_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_ursra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (sh == 16) {
+        tcg_gen_vec_shr16i_i64(t, a, 15);
+    } else {
+        gen_urshr16_i64(t, a, sh);
+    }
+    tcg_gen_vec_add16_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_ursra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    if (sh == 32) {
+        tcg_gen_shri_i32(t, a, 31);
+    } else {
+        gen_urshr32_i32(t, a, sh);
+    }
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_ursra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (sh == 64) {
+        tcg_gen_shri_i64(t, a, 63);
+    } else {
+        gen_urshr64_i64(t, a, sh);
+    }
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_ursra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    if (sh == (8 << vece)) {
+        tcg_gen_shri_vec(vece, t, a, sh - 1);
+    } else {
+        gen_urshr_vec(vece, t, a, sh);
+    }
+    tcg_gen_add_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_ursra8_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_ursra16_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_ursra32_i32,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_ursra64_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+}
+
 static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
     uint64_t mask = dup_const(MO_8, 0xff >> shift);
@@ -5645,6 +6061,28 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     return 0;
 
+                case 2: /* VRSHR */
+                    /* Right shift comes here negative.  */
+                    shift = -shift;
+                    if (u) {
+                        gen_gvec_urshr(size, rd_ofs, rm_ofs, shift,
+                                       vec_size, vec_size);
+                    } else {
+                        gen_gvec_srshr(size, rd_ofs, rm_ofs, shift,
+                                       vec_size, vec_size);
+                    }
+                    return 0;
+
+                case 3: /* VRSRA */
+                    if (u) {
+                        gen_gvec_ursra(size, rd_ofs, rm_ofs, shift,
+                                       vec_size, vec_size);
+                    } else {
+                        gen_gvec_srsra(size, rd_ofs, rm_ofs, shift,
+                                       vec_size, vec_size);
+                    }
+                    return 0;
+
                 case 4: /* VSRI */
                     if (!u) {
                         return 1;
@@ -5696,13 +6134,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         neon_load_reg64(cpu_V0, rm + pass);
                         tcg_gen_movi_i64(cpu_V1, imm);
                         switch (op) {
-                        case 2: /* VRSHR */
-                        case 3: /* VRSRA */
-                            if (u)
-                                gen_helper_neon_rshl_u64(cpu_V0, cpu_V0, cpu_V1);
-                            else
-                                gen_helper_neon_rshl_s64(cpu_V0, cpu_V0, cpu_V1);
-                            break;
                         case 6: /* VQSHLU */
                             gen_helper_neon_qshlu_s64(cpu_V0, cpu_env,
                                                       cpu_V0, cpu_V1);
@@ -5719,11 +6150,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         default:
                             g_assert_not_reached();
                         }
-                        if (op == 3) {
-                            /* Accumulate.  */
-                            neon_load_reg64(cpu_V1, rd + pass);
-                            tcg_gen_add_i64(cpu_V0, cpu_V0, cpu_V1);
-                        }
                         neon_store_reg64(cpu_V0, rd + pass);
                     } else { /* size < 3 */
                         /* Operands in T0 and T1.  */
@@ -5731,10 +6157,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = tcg_temp_new_i32();
                         tcg_gen_movi_i32(tmp2, imm);
                         switch (op) {
-                        case 2: /* VRSHR */
-                        case 3: /* VRSRA */
-                            GEN_NEON_INTEGER_OP(rshl);
-                            break;
                         case 6: /* VQSHLU */
                             switch (size) {
                             case 0:
@@ -5760,13 +6182,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             g_assert_not_reached();
                         }
                         tcg_temp_free_i32(tmp2);
-
-                        if (op == 3) {
-                            /* Accumulate.  */
-                            tmp2 = neon_load_reg(rd, pass);
-                            gen_neon_add(size, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
-                        }
                         neon_store_reg(rd, pass, tmp);
                     }
                 } /* for pass */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 230085b35e..fd8b2bff49 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -924,6 +924,56 @@ DO_SRA(gvec_usra_d, uint64_t)
 
 #undef DO_SRA
 
+#define DO_RSHR(NAME, TYPE)                             \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        TYPE tmp = n[i] >> (shift - 1);                 \
+        d[i] = (tmp >> 1) + (tmp & 1);                  \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_RSHR(gvec_srshr_b, int8_t)
+DO_RSHR(gvec_srshr_h, int16_t)
+DO_RSHR(gvec_srshr_s, int32_t)
+DO_RSHR(gvec_srshr_d, int64_t)
+
+DO_RSHR(gvec_urshr_b, uint8_t)
+DO_RSHR(gvec_urshr_h, uint16_t)
+DO_RSHR(gvec_urshr_s, uint32_t)
+DO_RSHR(gvec_urshr_d, uint64_t)
+
+#undef DO_RSHR
+
+#define DO_RSRA(NAME, TYPE)                             \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        TYPE tmp = n[i] >> (shift - 1);                 \
+        d[i] += (tmp >> 1) + (tmp & 1);                 \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_RSRA(gvec_srsra_b, int8_t)
+DO_RSRA(gvec_srsra_h, int16_t)
+DO_RSRA(gvec_srsra_s, int32_t)
+DO_RSRA(gvec_srsra_d, int64_t)
+
+DO_RSRA(gvec_ursra_b, uint8_t)
+DO_RSRA(gvec_ursra_h, uint16_t)
+DO_RSRA(gvec_ursra_s, uint32_t)
+DO_RSRA(gvec_ursra_d, uint64_t)
+
+#undef DO_RSRA
+
 /*
  * Convert float16 to float32, raising no exceptions and
  * preserving exceptional values, including SNaN.
-- 
2.20.1


