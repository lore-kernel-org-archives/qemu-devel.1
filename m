Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD7C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0BF206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0BF206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKlOG-0002ZS-Md
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 11:06:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlMh-0001PO-92
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlMf-0008Qa-9t
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:05:15 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:53068
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKlMZ-0008Nf-2U; Sun, 28 Apr 2019 11:05:09 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxL-0005tp-Nd; Sun, 28 Apr 2019 15:39:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:44 +0100
Message-Id: <20190428143845.11810-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 13/14] target/ppc: improve VSX_TEST_DC with new
 generator macros
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
Message-ID: <20190428143844.C9dZ7I66aywfolBxc3Pigw6BxagirqLMNkU5HIXTM0k@z>

The source and destination registers can now be decoded in the generator
function using the new GEN_VSX_HELPER_X2 and GEN_VSX_HELPER_R2 macros.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             | 16 +++++++---------
 target/ppc/helper.h                 |  8 ++++----
 target/ppc/translate/vsx-impl.inc.c |  8 ++++----
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 370b1d2c46..357be25867 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3158,18 +3158,16 @@ void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode,
  * VSX_TEST_DC - VSX floating point test data class
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
- *   xbn   - VSR register number
  *   tp    - type (float32 or float64)
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  *   tfld   - target vsr_t field (VsrD(*) or VsrW(*))
  *   fld_max - target field max
  *   scrf - set result in CR and FPCC
  */
-#define VSX_TEST_DC(op, nels, xbn, tp, fld, tfld, fld_max, scrf)  \
-void helper_##op(CPUPPCState *env, uint32_t opcode)         \
+#define VSX_TEST_DC(op, nels, tp, fld, tfld, fld_max, scrf)  \
+void helper_##op(CPUPPCState *env, uint32_t opcode,         \
+                 ppc_vsr_t *xt, ppc_vsr_t *xb)              \
 {                                                           \
-    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                  \
-    ppc_vsr_t *xb = &env->vsr[xbn];                         \
     ppc_vsr_t r;                                            \
     uint32_t i, sign, dcmx;                                 \
     uint32_t cc, match = 0;                                 \
@@ -3208,10 +3206,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)         \
     }                                                       \
 }
 
-VSX_TEST_DC(xvtstdcdp, 2, xB(opcode), float64, VsrD(i), VsrD(i), UINT64_MAX, 0)
-VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW(i), VsrW(i), UINT32_MAX, 0)
-VSX_TEST_DC(xststdcdp, 1, xB(opcode), float64, VsrD(0), VsrD(0), 0, 1)
-VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), float128, f128, VsrD(0), 0, 1)
+VSX_TEST_DC(xvtstdcdp, 2, float64, VsrD(i), VsrD(i), UINT64_MAX, 0)
+VSX_TEST_DC(xvtstdcsp, 4, float32, VsrW(i), VsrW(i), UINT32_MAX, 0)
+VSX_TEST_DC(xststdcdp, 1, float64, VsrD(0), VsrD(0), 0, 1)
+VSX_TEST_DC(xststdcqp, 1, float128, f128, VsrD(0), 0, 1)
 
 void helper_xststdcsp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)
 {
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 81630a5f23..cd97fae438 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -436,8 +436,8 @@ DEF_HELPER_4(xscvsxdsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscvudqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscvuxddp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xststdcsp, void, env, i32, vsr)
-DEF_HELPER_2(xststdcdp, void, env, i32)
-DEF_HELPER_2(xststdcqp, void, env, i32)
+DEF_HELPER_4(xststdcdp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xststdcqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrdpi, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrdpic, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrdpim, void, env, i32, vsr, vsr)
@@ -537,8 +537,8 @@ DEF_HELPER_4(xvcvsxdsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvcvuxdsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvcvsxwsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvcvuxwsp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtstdcsp, void, env, i32)
-DEF_HELPER_2(xvtstdcdp, void, env, i32)
+DEF_HELPER_4(xvtstdcsp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xvtstdcdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrspi, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrspic, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrspim, void, env, i32, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index b8f24b7462..03b342a2fb 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1164,8 +1164,8 @@ GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X1(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
 
 GEN_VSX_HELPER_X3(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
@@ -1244,8 +1244,8 @@ GEN_VSX_HELPER_X2(xvrspic, 0x16, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrspim, 0x12, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtstdcsp, 0x14, 0x1A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvtstdcsp, 0x14, 0x1A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
-- 
2.11.0


