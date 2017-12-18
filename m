Received: from eggs.gnu.org ([2001:4830:134:3::10]:55773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUW-0008Gj-E0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUV-00026f-8Q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:16 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUV-000266-1B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:15 -0500
Received: by mail-pg0-x243.google.com with SMTP id m25so9422366pgv.12
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:41 -0800
Message-Id: <20171218174552.18871-13-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/23] target/arm: Implement SVE bitwise shift
 by vector (predicated)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 27 +++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 25 +++++++++++++++++++++++++
 target/arm/translate-sve.c |  4 ++++
 target/arm/sve.def         |  8 ++++++++
 4 files changed, 64 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 2b265e9892..61b1287269 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -162,6 +162,33 @@ DEF_HELPER_FLAGS_5(sve_udiv_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_udiv_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_asr_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_asr_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_asr_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_asr_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_lsr_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsr_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsr_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsr_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_lsl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_orv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_orv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_orv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9146e35e5b..20f1e60fda 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -492,6 +492,28 @@ DO_ZPZZ_D(sve_umulh_zpzz_d, uint64_t, do_umulh_d)
 DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_DIV)
 DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
 
+/* Note that all bits of the shift are significant
+   and not modulo the element size.  */
+#define DO_ASR(N, M)  (N >> MIN(M, sizeof(N) * 8 - 1))
+#define DO_LSR(N, M)  (M < sizeof(N) * 8 ? N >> M : 0)
+#define DO_LSL(N, M)  (M < sizeof(N) * 8 ? N << M : 0)
+
+DO_ZPZZ(sve_asr_zpzz_b, int8_t, H1, DO_ASR)
+DO_ZPZZ(sve_lsr_zpzz_b, uint8_t, H1_2, DO_LSR)
+DO_ZPZZ(sve_lsl_zpzz_b, uint8_t, H1_4, DO_LSL)
+
+DO_ZPZZ(sve_asr_zpzz_h, int16_t, H1, DO_ASR)
+DO_ZPZZ(sve_lsr_zpzz_h, uint16_t, H1_2, DO_LSR)
+DO_ZPZZ(sve_lsl_zpzz_h, uint16_t, H1_4, DO_LSL)
+
+DO_ZPZZ(sve_asr_zpzz_s, int32_t, H1, DO_ASR)
+DO_ZPZZ(sve_lsr_zpzz_s, uint32_t, H1_2, DO_LSR)
+DO_ZPZZ(sve_lsl_zpzz_s, uint32_t, H1_4, DO_LSL)
+
+DO_ZPZZ_D(sve_asr_zpzz_d, int64_t, DO_ASR)
+DO_ZPZZ_D(sve_lsr_zpzz_d, uint64_t, DO_LSR)
+DO_ZPZZ_D(sve_lsl_zpzz_d, uint64_t, DO_LSL)
+
 #undef DO_ZPZZ
 #undef DO_ZPZZ_D
 
@@ -595,6 +617,9 @@ DO_VPZ_D(sve_uminv_d, uint64_t, uint64_t, -1, DO_MIN)
 #undef DO_ABD
 #undef DO_MUL
 #undef DO_DIV
+#undef DO_ASR
+#undef DO_LSR
+#undef DO_LSL
 
 /* Three-operand expander, immediate operand, controlled by a predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 08388c0a07..685a3ba249 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -190,6 +190,10 @@ DO_ZPZZ(MUL, mul)
 DO_ZPZZ(SMULH, smulh)
 DO_ZPZZ(UMULH, umulh)
 
+DO_ZPZZ(ASR, asr)
+DO_ZPZZ(LSR, lsr)
+DO_ZPZZ(LSL, lsl)
+
 void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
 {
     gen_helper_gvec_4 *fn;
diff --git a/target/arm/sve.def b/target/arm/sve.def
index f1d2801b94..9f9c0803a0 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -133,6 +133,14 @@ LSR_zpzi		00000100 .. 000 001 100 ... .. ... .....	@rdn_pg_tszimm imm=%tszimm_sh
 LSL_zpzi		00000100 .. 000 011 100 ... .. ... .....	@rdn_pg_tszimm imm=%tszimm_shr
 ASRD			00000100 .. 000 100 100 ... .. ... .....	@rdn_pg_tszimm imm=%tszimm_shr
 
+# SVE bitwise shift by vector (predicated)
+ASR_zpzz		00000100 .. 010 000 100 ... ..... .....		@rdn_pg_rm_esz
+LSR_zpzz		00000100 .. 010 001 100 ... ..... .....		@rdn_pg_rm_esz
+LSL_zpzz		00000100 .. 010 011 100 ... ..... .....		@rdn_pg_rm_esz
+ASR_zpzz		00000100 .. 010 100 100 ... ..... .....		@rdm_pg_rn_esz # ASRR
+LSR_zpzz		00000100 .. 010 101 100 ... ..... .....		@rdm_pg_rn_esz # LSRR
+LSL_zpzz		00000100 .. 010 111 100 ... ..... .....		@rdm_pg_rn_esz # LSLR
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.14.3
