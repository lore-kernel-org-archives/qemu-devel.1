Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF78FC28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C49C206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C49C206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpWs-0006Vu-C2
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:21:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRx-0002aZ-Jx
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRw-0001zY-BO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41533 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1hYpRv-0001tc-VI
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id B91911A1DC6;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
	[10.10.13.132])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 997641A20CD;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 12:15:28 +0200
Message-Id: <1559816130-17113-7-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 6/8] target/ppc: Optimize emulation of vclzw
 instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Optimize Altivec instruction vclzw (Vector Count Leading Zeros Word).
This instruction counts the number of leading zeros of each word element
in source register and places result in the appropriate word element of
destination register.

We perform counting in two iterations of for loop(one for each
doubleword element of source register vB). First thing we do in
loop is placing appropriate doubleword element of vB in variable
avr. Then we perform counting using tcg-s count leading zeros
function. Since it counts leading zeros on 64 bit lenght, we have to
move ith word element to highest 32 bits of variable tmp, or it with
mask(so we get all ones in lowest 32 bits), then perform
tcg_gen_clzi_i64 and move it's result in appropriate word element of
variable result. In the end of each loop iteration we save variable
result to appropriate doubleword element of destination register vD.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 57 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 1c34908..7689739 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -878,6 +878,61 @@ static void trans_vgbbd(DisasContext *ctx)
 }
 
 /*
+ * vclzw VRT,VRB - Vector Count Leading Zeros Word
+ *
+ * Counting the number of leading zero bits of each word element in source
+ * register and placing result in appropriate word element of destination
+ * register.
+ */
+static void trans_vclzw(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 avr = tcg_temp_new_i64();
+    TCGv_i64 result = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 mask = tcg_const_i64(0xffffffffULL);
+    int i;
+
+    for (i = 0; i < 2; i++) {
+        if (i == 0) {
+            /* Get high doubleword element of vB in avr. */
+            get_avr64(avr, VB, true);
+        } else {
+            /* Get low doubleword element of vB in avr. */
+            get_avr64(avr, VB, false);
+        }
+        /*
+         * Perform count for every word element using tcg_gen_clzi_i64.
+         * Since it counts leading zeros on 64 bit lenght, we have to move
+         * ith word element to highest 32 bits of tmp, or it with mask(so we get
+         * all ones in lowest 32 bits), then perform tcg_gen_clzi_i64 and move
+         * it's result in appropriate word element of result.
+         */
+        tcg_gen_shli_i64(tmp, avr, 32);
+        tcg_gen_or_i64(tmp, tmp, mask);
+        tcg_gen_clzi_i64(result, tmp, 64);
+
+        tcg_gen_or_i64(tmp, avr, mask);
+        tcg_gen_clzi_i64(tmp, tmp, 64);
+        tcg_gen_deposit_i64(result, result, tmp, 32, 32);
+
+        if (i == 0) {
+            /* Place result in high doubleword element of vD. */
+            set_avr64(VT, result, true);
+        } else {
+            /* Place result in low doubleword element of vD. */
+            set_avr64(VT, result, false);
+        }
+    }
+
+    tcg_temp_free_i64(avr);
+    tcg_temp_free_i64(result);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(mask);
+}
+
+/*
  * vclzd VRT,VRB - Vector Count Leading Zeros Doubleword
  *
  * Counting the number of leading zero bits of each doubleword element in source
@@ -1413,7 +1468,7 @@ GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)
 
 GEN_VXFORM_NOA(vclzb, 1, 28)
 GEN_VXFORM_NOA(vclzh, 1, 29)
-GEN_VXFORM_NOA(vclzw, 1, 30)
+GEN_VXFORM_TRANS(vclzw, 1, 30)
 GEN_VXFORM_TRANS(vclzd, 1, 31)
 GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)
 GEN_VXFORM_NOA_2(vnegd, 1, 24, 7)
-- 
2.7.4


