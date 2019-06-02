Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDCC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480E1278F8
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 11:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480E1278F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXOYz-00025M-Jj
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 07:22:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPf-0003Ld-Gz
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hXOPe-0003ZS-2K
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 07:12:31 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:51406
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOPd-0002kX-RA; Sun, 02 Jun 2019 07:12:29 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hXOLd-0008A4-0L; Sun, 02 Jun 2019 12:08:21 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun,  2 Jun 2019 12:08:51 +0100
Message-Id: <20190602110903.3431-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v2 03/15] target/ppc: remove getVSR()/putVSR()
 from int_helper.c
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

Now that there are now no more users of getVSR()/putVSR() these functions can
be completely removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/int_helper.c | 22 ++++++++++------------
 target/ppc/internal.h   | 12 ------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 8ce89f2ad9..3b8939edcc 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1902,38 +1902,36 @@ VEXTRACT(d, u64)
 void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
                         target_ulong xbn, uint32_t index)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt = &env->vsr[xtn];
+    ppc_vsr_t *xb = &env->vsr[xbn];
+    ppc_vsr_t t = { };
     size_t es = sizeof(uint32_t);
     uint32_t ext_index;
     int i;
 
-    getVSR(xbn, &xb, env);
-    memset(&xt, 0, sizeof(xt));
-
     ext_index = index;
     for (i = 0; i < es; i++, ext_index++) {
-        xt.VsrB(8 - es + i) = xb.VsrB(ext_index % 16);
+        t.VsrB(8 - es + i) = xb->VsrB(ext_index % 16);
     }
 
-    putVSR(xtn, &xt, env);
+    *xt = t;
 }
 
 void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
                       target_ulong xbn, uint32_t index)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt = &env->vsr[xtn];
+    ppc_vsr_t *xb = &env->vsr[xbn];
+    ppc_vsr_t t = *xt;
     size_t es = sizeof(uint32_t);
     int ins_index, i = 0;
 
-    getVSR(xbn, &xb, env);
-    getVSR(xtn, &xt, env);
-
     ins_index = index;
     for (i = 0; i < es && ins_index < 16; i++, ins_index++) {
-        xt.VsrB(ins_index) = xb.VsrB(8 - es + i);
+        t.VsrB(ins_index) = xb->VsrB(8 - es + i);
     }
 
-    putVSR(xtn, &xt, env);
+    *xt = t;
 }
 
 #define VEXT_SIGNED(name, element, cast)                            \
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index fb6f64ed1e..d3d327e548 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -204,18 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
-static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    vsr->VsrD(0) = env->vsr[n].VsrD(0);
-    vsr->VsrD(1) = env->vsr[n].VsrD(1);
-}
-
-static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    env->vsr[n].VsrD(0) = vsr->VsrD(0);
-    env->vsr[n].VsrD(1) = vsr->VsrD(1);
-}
-
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
-- 
2.11.0


