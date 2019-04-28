Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C805C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B905206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B905206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKlAS-0004lf-Bo
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 10:52:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0v-00062k-1M
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0r-00056V-PR
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:44 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:52914
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKl0r-0004bb-GA; Sun, 28 Apr 2019 10:42:41 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxF-0005tp-RA; Sun, 28 Apr 2019 15:38:58 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:35 +0100
Message-Id: <20190428143845.11810-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 04/14] target/ppc: introduce GEN_VSX_HELPER_X3
 macro to fpu_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428143835.95EezLEuKrYzhVUCzF28V168LCL0hDRzkP4-5uOhDpc@z>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X3 macro which performs the decode based
upon xT, xA and xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             |  48 ++++-------
 target/ppc/helper.h                 | 140 ++++++++++++++++---------------
 target/ppc/translate/vsx-impl.inc.c | 163 +++++++++++++++++++++---------------
 3 files changed, 183 insertions(+), 168 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 148ee5ac4c..39c4f4cfb0 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1801,11 +1801,9 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
  *   sfprf - set FPRF
  */
 #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)                    \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
+void helper_##name(CPUPPCState *env, uint32_t opcode,                        \
+                   ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)              \
 {                                                                            \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
     helper_reset_fpstatus(env);                                              \
@@ -1880,11 +1878,9 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
  *   sfprf - set FPRF
  */
 #define VSX_MUL(op, nels, tp, fld, sfprf, r2sp)                              \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                          \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                \
 {                                                                            \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
     helper_reset_fpstatus(env);                                              \
@@ -1954,11 +1950,9 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
  *   sfprf - set FPRF
  */
 #define VSX_DIV(op, nels, tp, fld, sfprf, r2sp)                               \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                 \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     int i;                                                                    \
                                                                               \
     helper_reset_fpstatus(env);                                               \
@@ -2286,11 +2280,9 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23)
  *   sfprf - set FPRF
  */
 #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)              \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                 \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     ppc_vsr_t *b, *c;                                                         \
     int i;                                                                    \
                                                                               \
@@ -2383,11 +2375,9 @@ VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_FLGS, 0, 0, 0)
  *   svxvc - set VXVC bit
  */
 #define VSX_SCALAR_CMP_DP(op, cmp, exp, svxvc)                                \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                 \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     bool vxsnan_flag = false, vxvc_flag = false, vex_flag = false;            \
                                                                               \
     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||             \
@@ -2593,11 +2583,9 @@ VSX_SCALAR_CMPQ(xscmpuqp, 0)
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  */
 #define VSX_MAX_MIN(name, op, nels, tp, fld)                                  \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
+void helper_##name(CPUPPCState *env, uint32_t opcode,                         \
+                   ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)               \
 {                                                                             \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     int i;                                                                    \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
@@ -2723,11 +2711,9 @@ VSX_MAX_MINJ(xsminjdp, 0);
  *   exp   - expected result of comparison
  */
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                       \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)             \
 {                                                                         \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                \
     int i;                                                                \
     int all_true = 1;                                                     \
     int all_false = 1;                                                    \
@@ -3161,11 +3147,9 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
 }
 
 #define VSX_XXPERM(op, indexed)                                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                   \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *pcv)        \
 {                                                                     \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                            \
-    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                            \
-    ppc_vsr_t *pcv = &env->vsr[xB(opcode)];                           \
     int i, idx;                                                       \
                                                                       \
     for (i = 0; i < 16; i++) {                                        \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 638a6e99c4..e2f9010ae0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -108,6 +108,10 @@ DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, i64)
 #define dh_ctype_avr ppc_avr_t *
 #define dh_is_signed_avr dh_is_signed_ptr
 
+#define dh_alias_vsr ptr
+#define dh_ctype_vsr ppc_vsr_t *
+#define dh_is_signed_vsr dh_is_signed_ptr
+
 DEF_HELPER_3(vavgub, void, avr, avr, avr)
 DEF_HELPER_3(vavguh, void, avr, avr, avr)
 DEF_HELPER_3(vavguw, void, avr, avr, avr)
@@ -373,38 +377,38 @@ DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdutrunc, i32, avr, avr, avr, i32)
 
-DEF_HELPER_2(xsadddp, void, env, i32)
+DEF_HELPER_5(xsadddp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsaddqp, void, env, i32)
-DEF_HELPER_2(xssubdp, void, env, i32)
-DEF_HELPER_2(xsmuldp, void, env, i32)
+DEF_HELPER_5(xssubdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmuldp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsmulqp, void, env, i32)
-DEF_HELPER_2(xsdivdp, void, env, i32)
+DEF_HELPER_5(xsdivdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_2(xsredp, void, env, i32)
 DEF_HELPER_2(xssqrtdp, void, env, i32)
 DEF_HELPER_2(xsrsqrtedp, void, env, i32)
 DEF_HELPER_2(xstdivdp, void, env, i32)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
-DEF_HELPER_2(xsmaddadp, void, env, i32)
-DEF_HELPER_2(xsmaddmdp, void, env, i32)
-DEF_HELPER_2(xsmsubadp, void, env, i32)
-DEF_HELPER_2(xsmsubmdp, void, env, i32)
-DEF_HELPER_2(xsnmaddadp, void, env, i32)
-DEF_HELPER_2(xsnmaddmdp, void, env, i32)
-DEF_HELPER_2(xsnmsubadp, void, env, i32)
-DEF_HELPER_2(xsnmsubmdp, void, env, i32)
-DEF_HELPER_2(xscmpeqdp, void, env, i32)
-DEF_HELPER_2(xscmpgtdp, void, env, i32)
-DEF_HELPER_2(xscmpgedp, void, env, i32)
-DEF_HELPER_2(xscmpnedp, void, env, i32)
+DEF_HELPER_5(xsmaddadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmaddmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmsubadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmsubmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmaddadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmaddmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmsubadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmsubmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xscmpeqdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xscmpgtdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xscmpgedp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xscmpnedp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xscmpexpdp, void, env, i32)
 DEF_HELPER_2(xscmpexpqp, void, env, i32)
 DEF_HELPER_2(xscmpodp, void, env, i32)
 DEF_HELPER_2(xscmpudp, void, env, i32)
 DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
-DEF_HELPER_2(xsmaxdp, void, env, i32)
-DEF_HELPER_2(xsmindp, void, env, i32)
+DEF_HELPER_5(xsmaxdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmindp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsmaxcdp, void, env, i32)
 DEF_HELPER_2(xsmincdp, void, env, i32)
 DEF_HELPER_2(xsmaxjdp, void, env, i32)
@@ -444,46 +448,46 @@ DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
 DEF_HELPER_2(xssubqp, void, env, i32)
 
-DEF_HELPER_2(xsaddsp, void, env, i32)
-DEF_HELPER_2(xssubsp, void, env, i32)
-DEF_HELPER_2(xsmulsp, void, env, i32)
-DEF_HELPER_2(xsdivsp, void, env, i32)
+DEF_HELPER_5(xsaddsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xssubsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmulsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsdivsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xsresp, void, env, i32)
 DEF_HELPER_2(xsrsp, i64, env, i64)
 DEF_HELPER_2(xssqrtsp, void, env, i32)
 DEF_HELPER_2(xsrsqrtesp, void, env, i32)
-DEF_HELPER_2(xsmaddasp, void, env, i32)
-DEF_HELPER_2(xsmaddmsp, void, env, i32)
-DEF_HELPER_2(xsmsubasp, void, env, i32)
-DEF_HELPER_2(xsmsubmsp, void, env, i32)
-DEF_HELPER_2(xsnmaddasp, void, env, i32)
-DEF_HELPER_2(xsnmaddmsp, void, env, i32)
-DEF_HELPER_2(xsnmsubasp, void, env, i32)
-DEF_HELPER_2(xsnmsubmsp, void, env, i32)
+DEF_HELPER_5(xsmaddasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmaddmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmsubasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsmsubmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmaddasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmaddmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmsubasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xsnmsubmsp, void, env, i32, vsr, vsr, vsr)
 
-DEF_HELPER_2(xvadddp, void, env, i32)
-DEF_HELPER_2(xvsubdp, void, env, i32)
-DEF_HELPER_2(xvmuldp, void, env, i32)
-DEF_HELPER_2(xvdivdp, void, env, i32)
+DEF_HELPER_5(xvadddp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvsubdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmuldp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvdivdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xvredp, void, env, i32)
 DEF_HELPER_2(xvsqrtdp, void, env, i32)
 DEF_HELPER_2(xvrsqrtedp, void, env, i32)
 DEF_HELPER_2(xvtdivdp, void, env, i32)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
-DEF_HELPER_2(xvmaddadp, void, env, i32)
-DEF_HELPER_2(xvmaddmdp, void, env, i32)
-DEF_HELPER_2(xvmsubadp, void, env, i32)
-DEF_HELPER_2(xvmsubmdp, void, env, i32)
-DEF_HELPER_2(xvnmaddadp, void, env, i32)
-DEF_HELPER_2(xvnmaddmdp, void, env, i32)
-DEF_HELPER_2(xvnmsubadp, void, env, i32)
-DEF_HELPER_2(xvnmsubmdp, void, env, i32)
-DEF_HELPER_2(xvmaxdp, void, env, i32)
-DEF_HELPER_2(xvmindp, void, env, i32)
-DEF_HELPER_2(xvcmpeqdp, void, env, i32)
-DEF_HELPER_2(xvcmpgedp, void, env, i32)
-DEF_HELPER_2(xvcmpgtdp, void, env, i32)
-DEF_HELPER_2(xvcmpnedp, void, env, i32)
+DEF_HELPER_5(xvmaddadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmaddmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmsubadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmsubmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmaddadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmaddmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmsubadp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmsubmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmaxdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmindp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpeqdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpgedp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpgtdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpnedp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xvcvdpsp, void, env, i32)
 DEF_HELPER_2(xvcvdpsxds, void, env, i32)
 DEF_HELPER_2(xvcvdpsxws, void, env, i32)
@@ -499,29 +503,29 @@ DEF_HELPER_2(xvrdpim, void, env, i32)
 DEF_HELPER_2(xvrdpip, void, env, i32)
 DEF_HELPER_2(xvrdpiz, void, env, i32)
 
-DEF_HELPER_2(xvaddsp, void, env, i32)
-DEF_HELPER_2(xvsubsp, void, env, i32)
-DEF_HELPER_2(xvmulsp, void, env, i32)
-DEF_HELPER_2(xvdivsp, void, env, i32)
+DEF_HELPER_5(xvaddsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvsubsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmulsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvdivsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xvresp, void, env, i32)
 DEF_HELPER_2(xvsqrtsp, void, env, i32)
 DEF_HELPER_2(xvrsqrtesp, void, env, i32)
 DEF_HELPER_2(xvtdivsp, void, env, i32)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
-DEF_HELPER_2(xvmaddasp, void, env, i32)
-DEF_HELPER_2(xvmaddmsp, void, env, i32)
-DEF_HELPER_2(xvmsubasp, void, env, i32)
-DEF_HELPER_2(xvmsubmsp, void, env, i32)
-DEF_HELPER_2(xvnmaddasp, void, env, i32)
-DEF_HELPER_2(xvnmaddmsp, void, env, i32)
-DEF_HELPER_2(xvnmsubasp, void, env, i32)
-DEF_HELPER_2(xvnmsubmsp, void, env, i32)
-DEF_HELPER_2(xvmaxsp, void, env, i32)
-DEF_HELPER_2(xvminsp, void, env, i32)
-DEF_HELPER_2(xvcmpeqsp, void, env, i32)
-DEF_HELPER_2(xvcmpgesp, void, env, i32)
-DEF_HELPER_2(xvcmpgtsp, void, env, i32)
-DEF_HELPER_2(xvcmpnesp, void, env, i32)
+DEF_HELPER_5(xvmaddasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmaddmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmsubasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmsubmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmaddasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmaddmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmsubasp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvnmsubmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvmaxsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvminsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpeqsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpgesp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpgtsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xvcmpnesp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_2(xvcvspdp, void, env, i32)
 DEF_HELPER_2(xvcvsphp, void, env, i32)
 DEF_HELPER_2(xvcvhpsp, void, env, i32)
@@ -540,8 +544,8 @@ DEF_HELPER_2(xvrspic, void, env, i32)
 DEF_HELPER_2(xvrspim, void, env, i32)
 DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
-DEF_HELPER_2(xxperm, void, env, i32)
-DEF_HELPER_2(xxpermr, void, env, i32)
+DEF_HELPER_5(xxperm, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_5(xxpermr, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
 DEF_HELPER_2(xvxsigsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index c776d50ddc..083dfa515c 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -20,6 +20,13 @@ static inline void set_cpu_vsrl(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, vsr64_offset(n, false));
 }
 
+static inline TCGv_ptr gen_vsr_ptr(int reg)
+{
+    TCGv_ptr r = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(r, cpu_env, vsr_full_offset(reg));
+    return r;
+}
+
 #define VSX_LOAD_SCALAR(name, operation)                      \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -924,6 +931,26 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_i32(opc);                                                   \
 }
 
+#define GEN_VSX_HELPER_X3(name, op1, op2, inval, type)                        \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xt, xa, xb;                                                      \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
+    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    gen_helper_##name(cpu_env, opc, xt, xa, xb);                              \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -942,38 +969,38 @@ static void gen_##name(DisasContext *ctx)                     \
     tcg_temp_free_i64(t1);                                    \
 }
 
-GEN_VSX_HELPER_2(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
@@ -1010,50 +1037,50 @@ GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
 
-GEN_VSX_HELPER_2(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
 
-GEN_VSX_HELPER_2(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmuldp, 0x00, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmuldp, 0x00, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
@@ -1069,29 +1096,29 @@ GEN_VSX_HELPER_2(xvrdpim, 0x12, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrdpip, 0x12, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrdpiz, 0x12, 0x0D, 0, PPC2_VSX)
 
-GEN_VSX_HELPER_2(xvaddsp, 0x00, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvsubsp, 0x00, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmulsp, 0x00, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvaddsp, 0x00, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvsubsp, 0x00, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmulsp, 0x00, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
@@ -1110,8 +1137,8 @@ GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtstdcsp, 0x14, 0x1A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
 static void gen_xxbrd(DisasContext *ctx)
 {
-- 
2.11.0


