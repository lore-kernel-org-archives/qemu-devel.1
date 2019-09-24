Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EB9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1774420872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1774420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnet-0006yL-JY
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iCmuR-0008Fp-Or
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iCmuN-0006CW-5g
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:23 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:35702
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iCmuM-0005e9-Tp; Tue, 24 Sep 2019 11:39:19 -0400
Received: from host86-138-245-63.range86-138.btcentralplus.com
 ([86.138.245.63] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iCmrW-0007WZ-KY; Tue, 24 Sep 2019 16:36:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pc@us.ibm.com,
 david@gibson.dropbear.id.au
Date: Tue, 24 Sep 2019 16:35:52 +0100
Message-Id: <20190924153556.27575-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.138.245.63
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/7] target/ppc: update {get, set}_dfp{64,
 128}() helper functions to read/write DFP numbers correctly
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit ef96e3ae96 "target/ppc: move FP and VMX registers into aligned vsr
register array" FP registers are no longer stored consecutively in memory and so
the current method of combining FP register pairs into DFP numbers is incorrect.

Firstly update the definition of the dh_*_fprp defines in helper.h to reflect
that FP registers are now stored as part of an array of ppc_vsr_t elements
rather than plain uint64_t elements, and then introduce a new ppc_fprp_t type
which conceptually represents a DFP even-odd register pair to be consumed by the
DFP helper functions.

Finally update the new DFP {get,set}_dfp{64,128}() helper functions to convert
between DFP numbers and DFP even-odd register pairs correctly, making use of the
existing VsrD() macro to access the correct elements regardless of host endian.

Fixes: ef96e3ae96 "target/ppc: move FP and VMX registers into aligned vsr register array"
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h        |  1 +
 target/ppc/dfp_helper.c | 80 +++++++++++++++++++++--------------------
 target/ppc/helper.h     |  2 +-
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index eaee1a5575..b79bbc171f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -235,6 +235,7 @@ typedef union _ppc_vsr_t {
 } ppc_vsr_t;
 
 typedef ppc_vsr_t ppc_avr_t;
+typedef ppc_vsr_t ppc_fprp_t;
 
 #if !defined(CONFIG_USER_ONLY)
 /* Software TLB cache */
diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index cb98780d20..df9026ea5e 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -36,26 +36,26 @@
 #define LO_IDX 0
 #endif
 
-static void get_dfp64(uint64_t *dst, uint64_t *dfp)
+static void get_dfp64(uint64_t *dst, ppc_fprp_t *dfp)
 {
-    dst[0] = dfp[0];
+    dst[0] = dfp->VsrD(0);
 }
 
-static void get_dfp128(uint64_t *dst, uint64_t *dfp)
+static void get_dfp128(uint64_t *dst, ppc_fprp_t *dfp)
 {
-    dst[0] = dfp[HI_IDX];
-    dst[1] = dfp[LO_IDX];
+    dst[HI_IDX] = dfp[0].VsrD(0);
+    dst[LO_IDX] = dfp[1].VsrD(0);
 }
 
-static void set_dfp64(uint64_t *dfp, uint64_t *src)
+static void set_dfp64(ppc_fprp_t *dfp, uint64_t *src)
 {
-    dfp[0] = src[0];
+    dfp->VsrD(0) = src[0];
 }
 
-static void set_dfp128(uint64_t *dfp, uint64_t *src)
+static void set_dfp128(ppc_fprp_t *dfp, uint64_t *src)
 {
-    dfp[0] = src[HI_IDX];
-    dfp[1] = src[LO_IDX];
+    dfp[0].VsrD(0) = src[HI_IDX];
+    dfp[1].VsrD(0) = src[LO_IDX];
 }
 
 struct PPC_DFP {
@@ -143,8 +143,8 @@ static void dfp_set_round_mode_from_immediate(uint8_t r, uint8_t rmc,
     decContextSetRounding(&dfp->context, rnd);
 }
 
-static void dfp_prepare_decimal64(struct PPC_DFP *dfp, uint64_t *a,
-                uint64_t *b, CPUPPCState *env)
+static void dfp_prepare_decimal64(struct PPC_DFP *dfp, ppc_fprp_t *a,
+                                  ppc_fprp_t *b, CPUPPCState *env)
 {
     decContextDefault(&dfp->context, DEC_INIT_DECIMAL64);
     dfp_prepare_rounding_mode(&dfp->context, env->fpscr);
@@ -167,8 +167,8 @@ static void dfp_prepare_decimal64(struct PPC_DFP *dfp, uint64_t *a,
     }
 }
 
-static void dfp_prepare_decimal128(struct PPC_DFP *dfp, uint64_t *a,
-                uint64_t *b, CPUPPCState *env)
+static void dfp_prepare_decimal128(struct PPC_DFP *dfp, ppc_fprp_t *a,
+                                   ppc_fprp_t *b, CPUPPCState *env)
 {
     decContextDefault(&dfp->context, DEC_INIT_DECIMAL128);
     dfp_prepare_rounding_mode(&dfp->context, env->fpscr);
@@ -416,7 +416,8 @@ static inline int dfp_get_digit(decNumber *dn, int n)
 }
 
 #define DFP_HELPER_TAB(op, dnop, postprocs, size)                              \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *a, uint64_t *b)      \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,               \
+                 ppc_fprp_t *b)                                                \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
     dfp_prepare_decimal##size(&dfp, a, b, env);                                \
@@ -485,7 +486,7 @@ DFP_HELPER_TAB(ddiv, decNumberDivide, DIV_PPs, 64)
 DFP_HELPER_TAB(ddivq, decNumberDivide, DIV_PPs, 128)
 
 #define DFP_HELPER_BF_AB(op, dnop, postprocs, size)                            \
-uint32_t helper_##op(CPUPPCState *env, uint64_t *a, uint64_t *b)               \
+uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)           \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
     dfp_prepare_decimal##size(&dfp, a, b, env);                                \
@@ -517,7 +518,7 @@ DFP_HELPER_BF_AB(dcmpo, decNumberCompare, CMPO_PPs, 64)
 DFP_HELPER_BF_AB(dcmpoq, decNumberCompare, CMPO_PPs, 128)
 
 #define DFP_HELPER_TSTDC(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, uint64_t *a, uint32_t dcm)        \
+uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)      \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int match = 0;                                                       \
@@ -545,7 +546,7 @@ DFP_HELPER_TSTDC(dtstdc, 64)
 DFP_HELPER_TSTDC(dtstdcq, 128)
 
 #define DFP_HELPER_TSTDG(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, uint64_t *a, uint32_t dcm)        \
+uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)      \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int minexp, maxexp, nzero_digits, nzero_idx, is_negative, is_zero,   \
@@ -600,7 +601,7 @@ DFP_HELPER_TSTDG(dtstdg, 64)
 DFP_HELPER_TSTDG(dtstdgq, 128)
 
 #define DFP_HELPER_TSTEX(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, uint64_t *a, uint64_t *b)         \
+uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)     \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int expa, expb, a_is_special, b_is_special;                          \
@@ -632,7 +633,7 @@ DFP_HELPER_TSTEX(dtstex, 64)
 DFP_HELPER_TSTEX(dtstexq, 128)
 
 #define DFP_HELPER_TSTSF(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, uint64_t *a, uint64_t *b)         \
+uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)     \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     unsigned k;                                                          \
@@ -669,7 +670,7 @@ DFP_HELPER_TSTSF(dtstsf, 64)
 DFP_HELPER_TSTSF(dtstsfq, 128)
 
 #define DFP_HELPER_TSTSFI(op, size)                                     \
-uint32_t helper_##op(CPUPPCState *env, uint32_t a, uint64_t *b)         \
+uint32_t helper_##op(CPUPPCState *env, uint32_t a, ppc_fprp_t *b)       \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
     unsigned uim;                                                       \
@@ -729,7 +730,7 @@ static void dfp_quantize(uint8_t rmc, struct PPC_DFP *dfp)
 }
 
 #define DFP_HELPER_QUAI(op, size)                                       \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b,            \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,        \
                  uint32_t te, uint32_t rmc)                             \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
@@ -755,8 +756,8 @@ DFP_HELPER_QUAI(dquai, 64)
 DFP_HELPER_QUAI(dquaiq, 128)
 
 #define DFP_HELPER_QUA(op, size)                                        \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *a,            \
-                 uint64_t *b, uint32_t rmc)                             \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,        \
+                 ppc_fprp_t *b, uint32_t rmc)                           \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
                                                                         \
@@ -832,8 +833,8 @@ static void _dfp_reround(uint8_t rmc, int32_t ref_sig, int32_t xmax,
 }
 
 #define DFP_HELPER_RRND(op, size)                                       \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *a,            \
-                 uint64_t *b, uint32_t rmc)                             \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,        \
+                 ppc_fprp_t *b, uint32_t rmc)                           \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
     uint64_t a64;                                                       \
@@ -861,7 +862,7 @@ DFP_HELPER_RRND(drrnd, 64)
 DFP_HELPER_RRND(drrndq, 128)
 
 #define DFP_HELPER_RINT(op, postprocs, size)                                   \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b,                   \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,               \
              uint32_t r, uint32_t rmc)                                         \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
@@ -899,7 +900,7 @@ static void RINTN_PPs(struct PPC_DFP *dfp)
 DFP_HELPER_RINT(drintn, RINTN_PPs, 64)
 DFP_HELPER_RINT(drintnq, RINTN_PPs, 128)
 
-void helper_dctdp(CPUPPCState *env, uint64_t *t, uint64_t *b)
+void helper_dctdp(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     uint64_t b64;
@@ -915,7 +916,7 @@ void helper_dctdp(CPUPPCState *env, uint64_t *t, uint64_t *b)
     dfp_set_FPRF_from_FRT(&dfp);
 }
 
-void helper_dctqpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
+void helper_dctqpq(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     uint64_t b64;
@@ -930,7 +931,7 @@ void helper_dctqpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
     set_dfp128(t, dfp.t64);
 }
 
-void helper_drsp(CPUPPCState *env, uint64_t *t, uint64_t *b)
+void helper_drsp(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     uint32_t t_short = 0;
@@ -948,7 +949,7 @@ void helper_drsp(CPUPPCState *env, uint64_t *t, uint64_t *b)
     set_dfp64(t, &t64);
 }
 
-void helper_drdpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
+void helper_drdpq(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     dfp_prepare_decimal128(&dfp, 0, b, env);
@@ -967,7 +968,7 @@ void helper_drdpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
 }
 
 #define DFP_HELPER_CFFIX(op, size)                                             \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b)                   \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)               \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
     uint64_t b64;                                                              \
@@ -994,7 +995,7 @@ DFP_HELPER_CFFIX(dcffix, 64)
 DFP_HELPER_CFFIX(dcffixq, 128)
 
 #define DFP_HELPER_CTFIX(op, size)                                            \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b)                  \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)              \
 {                                                                             \
     struct PPC_DFP dfp;                                                       \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                               \
@@ -1057,7 +1058,8 @@ static inline void dfp_set_sign_128(uint64_t *t, uint8_t sgn)
 }
 
 #define DFP_HELPER_DEDPD(op, size)                                        \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b, uint32_t sp) \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,          \
+                 uint32_t sp)                                             \
 {                                                                         \
     struct PPC_DFP dfp;                                                   \
     uint8_t digits[34];                                                   \
@@ -1105,7 +1107,8 @@ static inline uint8_t dfp_get_bcd_digit_128(uint64_t *t, unsigned n)
 }
 
 #define DFP_HELPER_ENBCD(op, size)                                           \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b, uint32_t s)     \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,             \
+                 uint32_t s)                                                 \
 {                                                                            \
     struct PPC_DFP dfp;                                                      \
     uint8_t digits[32];                                                      \
@@ -1166,7 +1169,7 @@ DFP_HELPER_ENBCD(denbcd, 64)
 DFP_HELPER_ENBCD(denbcdq, 128)
 
 #define DFP_HELPER_XEX(op, size)                               \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b)   \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
 {                                                              \
     struct PPC_DFP dfp;                                        \
     uint64_t t64;                                              \
@@ -1212,7 +1215,8 @@ static void dfp_set_raw_exp_128(uint64_t *t, uint64_t raw)
 }
 
 #define DFP_HELPER_IEX(op, size)                                          \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *a, uint64_t *b) \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,          \
+                 ppc_fprp_t *b)                                           \
 {                                                                         \
     struct PPC_DFP dfp;                                                   \
     uint64_t raw_qnan, raw_snan, raw_inf, max_exp, a64;                   \
@@ -1309,7 +1313,7 @@ static void dfp_clear_lmd_from_g5msb(uint64_t *t)
 }
 
 #define DFP_HELPER_SHIFT(op, size, shift_left)                      \
-void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *a,        \
+void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,    \
                  uint32_t sh)                                       \
 {                                                                   \
     struct PPC_DFP dfp;                                             \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 54ea9b9500..f843814b8a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -686,7 +686,7 @@ DEF_HELPER_3(store_601_batu, void, env, i32, tl)
 #endif
 
 #define dh_alias_fprp ptr
-#define dh_ctype_fprp uint64_t *
+#define dh_ctype_fprp ppc_fprp_t *
 #define dh_is_signed_fprp dh_is_signed_ptr
 
 DEF_HELPER_4(dadd, void, env, fprp, fprp, fprp)
-- 
2.20.1


