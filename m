Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98037C28CC5
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735D5278D7
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735D5278D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXORV-0004UM-IO
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 07:14:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPc-0003LN-VE
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPb-0003X4-SA
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:28 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:51382
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOPb-0002iF-M9; Sun, 02 Jun 2019 07:12:27 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOLb-0008A4-2A; Sun, 02 Jun 2019 12:08:20 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun,  2 Jun 2019 12:08:50 +0100
Message-Id: <20190602110903.3431-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v2 02/15] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
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

Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
registers are in host endian order" functions getVSR() and putVSR() which used
to convert the VSR registers into host endian order are no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/mem_helper.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 5b0f9ee50d..17a3c931a9 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -417,26 +417,27 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 void helper_##name(CPUPPCState *env, target_ulong addr,                 \
                    target_ulong xt_num, target_ulong rb)                \
 {                                                                       \
-    int i;                                                              \
-    ppc_vsr_t xt;                                                       \
+    ppc_vsr_t *xt = &env->vsr[xt_num];                                  \
+    ppc_vsr_t t;                                                        \
     uint64_t nb = GET_NB(rb);                                           \
+    int i;                                                              \
                                                                         \
-    xt.s128 = int128_zero();                                            \
+    t.s128 = int128_zero();                                             \
     if (nb) {                                                           \
         nb = (nb >= 16) ? 16 : nb;                                      \
         if (msr_le && !lj) {                                            \
             for (i = 16; i > 16 - nb; i--) {                            \
-                xt.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
+                t.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());   \
                 addr = addr_add(env, addr, 1);                          \
             }                                                           \
         } else {                                                        \
             for (i = 0; i < nb; i++) {                                  \
-                xt.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
+                t.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());       \
                 addr = addr_add(env, addr, 1);                          \
             }                                                           \
         }                                                               \
     }                                                                   \
-    putVSR(xt_num, &xt, env);                                           \
+    *xt = t;                                                            \
 }
 
 VSX_LXVL(lxvl, 0)
@@ -447,26 +448,28 @@ VSX_LXVL(lxvll, 1)
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
                    target_ulong xt_num, target_ulong rb)          \
 {                                                                 \
-    int i;                                                        \
-    ppc_vsr_t xt;                                                 \
+    ppc_vsr_t *xt = &env->vsr[xt_num];                            \
+    ppc_vsr_t t = *xt;                                            \
     target_ulong nb = GET_NB(rb);                                 \
+    int i;                                                        \
                                                                   \
     if (!nb) {                                                    \
         return;                                                   \
     }                                                             \
-    getVSR(xt_num, &xt, env);                                     \
+                                                                  \
     nb = (nb >= 16) ? 16 : nb;                                    \
     if (msr_le && !lj) {                                          \
         for (i = 16; i > 16 - nb; i--) {                          \
-            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
+            cpu_stb_data_ra(env, addr, t.VsrB(i - 1), GETPC());   \
             addr = addr_add(env, addr, 1);                        \
         }                                                         \
     } else {                                                      \
         for (i = 0; i < nb; i++) {                                \
-            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
+            cpu_stb_data_ra(env, addr, t.VsrB(i), GETPC())  ;     \
             addr = addr_add(env, addr, 1);                        \
         }                                                         \
     }                                                             \
+    *xt = t;                                                      \
 }
 
 VSX_STXVL(stxvl, 0)
-- 
2.11.0


