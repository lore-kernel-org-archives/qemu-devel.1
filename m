Received: from eggs.gnu.org ([2001:4830:134:3::10]:36083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3L-0000m8-GO
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3J-0007XH-0g
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3I-0007W3-HT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3H-0004rS-9k
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:55 +0100
Message-Id: <20180518172009.14416-19-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/32] target/arm: Implement SVE bitwise shift
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 27 +++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 25 +++++++++++++++++++++++++
 target/arm/translate-sve.c |  4 ++++
 target/arm/sve.decode      |  8 ++++++++
 4 files changed, 64 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index b3c89579af..0cc02ee59e 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -168,6 +168,33 @@ DEF_HELPER_FLAGS_5(sve_udiv_zpzz_s, TCG_CALL_NO_RWG,
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
index b6b9a08965..ece3a81ad3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -440,6 +440,28 @@ DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_DIV)
 DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_DIV)
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
 
@@ -544,6 +566,9 @@ DO_VPZ_D(sve_uminv_d, uint64_t, uint64_t, -1, DO_MIN)
 #undef DO_ABD
 #undef DO_MUL
 #undef DO_DIV
+#undef DO_ASR
+#undef DO_LSR
+#undef DO_LSL
 
 /* Similar to the ARM LastActiveElement pseudocode function, except the
    result is multiplied by the element size.  This includes the not found
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7607a90a4a..f0400e35d9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -301,6 +301,10 @@ DO_ZPZZ(MUL, mul)
 DO_ZPZZ(SMULH, smulh)
 DO_ZPZZ(UMULH, umulh)
 
+DO_ZPZZ(ASR, asr)
+DO_ZPZZ(LSR, lsr)
+DO_ZPZZ(LSL, lsl)
+
 static bool trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
 {
     static gen_helper_gvec_4 * const fns[4] = {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a1791c1d7b..8267963b6b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -149,6 +149,14 @@ LSL_zpzi        00000100 .. 000 011 100 ... .. ... ..... \
 ASRD            00000100 .. 000 100 100 ... .. ... ..... \
                 @rdn_pg_tszimm imm=%tszimm_shr
 
+# SVE bitwise shift by vector (predicated)
+ASR_zpzz        00000100 .. 010 000 100 ... ..... .....   @rdn_pg_rm
+LSR_zpzz        00000100 .. 010 001 100 ... ..... .....   @rdn_pg_rm
+LSL_zpzz        00000100 .. 010 011 100 ... ..... .....   @rdn_pg_rm
+ASR_zpzz        00000100 .. 010 100 100 ... ..... .....   @rdm_pg_rn # ASRR
+LSR_zpzz        00000100 .. 010 101 100 ... ..... .....   @rdm_pg_rn # LSRR
+LSL_zpzz        00000100 .. 010 111 100 ... ..... .....   @rdm_pg_rn # LSLR
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0
