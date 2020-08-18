Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B29BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D68207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nbl4BbmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D68207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tCo-0003EA-Bs
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t68-0007NF-KC; Tue, 18 Aug 2020 00:19:44 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50697 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t66-0006LT-CC; Tue, 18 Aug 2020 00:19:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNZ74jjz9sVB; Tue, 18 Aug 2020 14:19:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724367;
 bh=uAsKhdoLP4l9Yj1dZs/XZzS9+pfhR/PHECSVprBFvGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nbl4BbmDuXj0VCbg/xrSyuQs1XaXMxoxfWxNXOQsvQ0VJqF1vYijsiJpo28uHCqiF
 e+0QxxqfXMgH89XSpqBBpscHdOBeAlLAJm5F2tcxJE9h/TQ5YOLdLGSLyAWGU9IjdF
 LBRTlZzzR5KuaDgXAsmmafKj9YazmJbdAk/bP/Gg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 12/40] target/ppc: add vmulld to INDEX_op_mul_vec case
Date: Tue, 18 Aug 2020 14:18:54 +1000
Message-Id: <20200818041922.251708-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Lijun Pan <ljp@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lijun Pan <ljp@linux.ibm.com>

Group vmuluwm and vmulld. Make vmulld-specific
changes since it belongs to new ISA 3.1.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
Message-Id: <20200724045845.89976-3-ljp@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tcg/ppc/tcg-target.h     |  2 ++
 tcg/ppc/tcg-target.inc.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index be5b2901c3..aee38157a2 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -63,6 +63,7 @@ typedef enum {
     tcg_isa_2_06,
     tcg_isa_2_07,
     tcg_isa_3_00,
+    tcg_isa_3_10,
 } TCGPowerISA;
 
 extern TCGPowerISA have_isa;
@@ -72,6 +73,7 @@ extern bool have_vsx;
 #define have_isa_2_06  (have_isa >= tcg_isa_2_06)
 #define have_isa_2_07  (have_isa >= tcg_isa_2_07)
 #define have_isa_3_00  (have_isa >= tcg_isa_3_00)
+#define have_isa_3_10  (have_isa >= tcg_isa_3_10)
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c8d1e765d9..0e78260e60 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -564,6 +564,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VMULOUH    VX4(72)
 #define VMULOUW    VX4(136)       /* v2.07 */
 #define VMULUWM    VX4(137)       /* v2.07 */
+#define VMULLD     VX4(457)       /* v3.10 */
 #define VMSUMUHM   VX4(38)
 
 #define VMRGHB     VX4(12)
@@ -3022,6 +3023,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
             return -1;
         case MO_32:
             return have_isa_2_07 ? 1 : -1;
+        case MO_64:
+            return have_isa_3_10;
         }
         return 0;
     case INDEX_op_bitsel_vec:
@@ -3158,6 +3161,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        mul_op[4] = { 0, 0, VMULUWM, VMULLD },
         neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
         ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
@@ -3208,8 +3212,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         a1 = 0;
         break;
     case INDEX_op_mul_vec:
-        tcg_debug_assert(vece == MO_32 && have_isa_2_07);
-        insn = VMULUWM;
+        insn = mul_op[vece];
         break;
     case INDEX_op_ssadd_vec:
         insn = ssadd_op[vece];
@@ -3729,6 +3732,11 @@ static void tcg_target_init(TCGContext *s)
         have_isa = tcg_isa_3_00;
     }
 #endif
+#ifdef PPC_FEATURE2_ARCH_3_10
+    if (hwcap2 & PPC_FEATURE2_ARCH_3_10) {
+        have_isa = tcg_isa_3_10;
+    }
+#endif
 
 #ifdef PPC_FEATURE2_HAS_ISEL
     /* Prefer explicit instruction from the kernel. */
-- 
2.26.2


