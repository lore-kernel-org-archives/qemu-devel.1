Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA0EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F3F222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F3F222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZOg-00056p-6S
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iDYz3-0000mr-Kz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iDYz2-00080U-0k
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:59:21 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:40400
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iDYz1-0007KV-P6; Thu, 26 Sep 2019 14:59:19 -0400
Received: from host86-138-245-63.range86-138.btcentralplus.com
 ([86.138.245.63] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iDYyJ-0001em-Kf; Thu, 26 Sep 2019 19:58:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pc@us.ibm.com,
 david@gibson.dropbear.id.au
Date: Thu, 26 Sep 2019 19:58:01 +0100
Message-Id: <20190926185801.11176-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926185801.11176-1-mark.cave-ayland@ilande.co.uk>
References: <20190926185801.11176-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.138.245.63
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 7/7] target/ppc: remove unnecessary if() around calls to
 set_dfp{64, 128}() in DFP macros
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

Now that the parameters to both set_dfp64() and set_dfp128() are exactly the
same, there is no need for an explicit if() statement to determine which
function should be called based upon size. Instead we can simply use the
preprocessor to generate the call to set_dfp##size() directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/dfp_helper.c | 60 +++++++----------------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index b801acbedc..88919afbcf 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -427,11 +427,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,               \
     dnop(&dfp.t, &dfp.a, &dfp.b, &dfp.context);                                \
     dfp_finalize_decimal##size(&dfp);                                          \
     postprocs(&dfp);                                                           \
-    if (size == 64) {                                                          \
-        set_dfp64(t, &dfp.vt);                                                 \
-    } else if (size == 128) {                                                  \
-        set_dfp128(t, &dfp.vt);                                                \
-    }                                                                          \
+    set_dfp##size(t, &dfp.vt);                                                 \
 }
 
 static void ADD_PPs(struct PPC_DFP *dfp)
@@ -747,11 +743,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,        \
     dfp_finalize_decimal##size(&dfp);                                   \
     QUA_PPs(&dfp);                                                      \
                                                                         \
-    if (size == 64) {                                                   \
-        set_dfp64(t, &dfp.vt);                                          \
-    } else if (size == 128) {                                           \
-        set_dfp128(t, &dfp.vt);                                         \
-    }                                                                   \
+    set_dfp##size(t, &dfp.vt);                                          \
 }
 
 DFP_HELPER_QUAI(dquai, 64)
@@ -769,11 +761,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,        \
     dfp_finalize_decimal##size(&dfp);                                   \
     QUA_PPs(&dfp);                                                      \
                                                                         \
-    if (size == 64) {                                                   \
-        set_dfp64(t, &dfp.vt);                                          \
-    } else if (size == 128) {                                           \
-        set_dfp128(t, &dfp.vt);                                         \
-    }                                                                   \
+    set_dfp##size(t, &dfp.vt);                                          \
 }
 
 DFP_HELPER_QUA(dqua, 64)
@@ -851,11 +839,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,        \
     dfp_finalize_decimal##size(&dfp);                                   \
     QUA_PPs(&dfp);                                                      \
                                                                         \
-    if (size == 64) {                                                   \
-        set_dfp64(t, &dfp.vt);                                          \
-    } else if (size == 128) {                                           \
-        set_dfp128(t, &dfp.vt);                                         \
-    }                                                                   \
+    set_dfp##size(t, &dfp.vt);                                          \
 }
 
 DFP_HELPER_RRND(drrnd, 64)
@@ -874,11 +858,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,               \
     dfp_finalize_decimal##size(&dfp);                                          \
     postprocs(&dfp);                                                           \
                                                                                \
-    if (size == 64) {                                                          \
-        set_dfp64(t, &dfp.vt);                                                 \
-    } else if (size == 128) {                                                  \
-        set_dfp128(t, &dfp.vt);                                                \
-    }                                                                          \
+    set_dfp##size(t, &dfp.vt);                                                 \
 }
 
 static void RINTX_PPs(struct PPC_DFP *dfp)
@@ -978,11 +958,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)               \
     dfp_finalize_decimal##size(&dfp);                                          \
     CFFIX_PPs(&dfp);                                                           \
                                                                                \
-    if (size == 64) {                                                          \
-        set_dfp64(t, &dfp.vt);                                                 \
-    } else if (size == 128) {                                                  \
-        set_dfp128(t, &dfp.vt);                                                \
-    }                                                                          \
+    set_dfp##size(t, &dfp.vt);                                                 \
 }
 
 static void CFFIX_PPs(struct PPC_DFP *dfp)
@@ -1088,11 +1064,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,          \
         dfp_set_sign_##size(&dfp.vt, sgn);                                \
     }                                                                     \
                                                                           \
-    if (size == 64) {                                                     \
-        set_dfp64(t, &dfp.vt);                                            \
-    } else if (size == 128) {                                             \
-        set_dfp128(t, &dfp.vt);                                           \
-    }                                                                     \
+    set_dfp##size(t, &dfp.vt);                                            \
 }
 
 DFP_HELPER_DEDPD(ddedpd, 64)
@@ -1160,11 +1132,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,             \
     }                                                                        \
     dfp_finalize_decimal##size(&dfp);                                        \
     dfp_set_FPRF_from_FRT(&dfp);                                             \
-    if ((size) == 64) {                                                      \
-        set_dfp64(t, &dfp.vt);                                               \
-    } else if ((size) == 128) {                                              \
-        set_dfp128(t, &dfp.vt);                                              \
-    }                                                                        \
+    set_dfp##size(t, &dfp.vt);                                               \
 }
 
 DFP_HELPER_ENBCD(denbcd, 64)
@@ -1264,11 +1232,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,          \
         dfp.t.exponent = exp - bias;                                      \
         dfp_finalize_decimal##size(&dfp);                                 \
     }                                                                     \
-    if (size == 64) {                                                     \
-        set_dfp64(t, &dfp.vt);                                            \
-    } else if (size == 128) {                                             \
-        set_dfp128(t, &dfp.vt);                                           \
-    }                                                                     \
+    set_dfp##size(t, &dfp.vt);                                            \
 }
 
 DFP_HELPER_IEX(diex, 64)
@@ -1356,11 +1320,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,    \
         }                                                           \
     }                                                               \
                                                                     \
-    if ((size) == 64) {                                             \
-        set_dfp64(t, &dfp.vt);                                      \
-    } else {                                                        \
-        set_dfp128(t, &dfp.vt);                                     \
-    }                                                               \
+    set_dfp##size(t, &dfp.vt);                                      \
 }
 
 DFP_HELPER_SHIFT(dscli, 64, 1)
-- 
2.20.1


