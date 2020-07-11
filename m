Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3225BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2501207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 15:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2501207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juHf8-0001oH-7e
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 11:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1juHeT-000151-U4
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 11:42:57 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:56435)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1juHeR-0005nl-Ri
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 11:42:57 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 84A4C101D15;
 Sun, 12 Jul 2020 00:42:49 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id E08381C0859;
 Sun, 12 Jul 2020 00:42:48 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/timer/renesas_tmr.c cleanup read operation.
Date: Sun, 12 Jul 2020 00:42:42 +0900
Message-Id: <20200711154242.41222-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 11:42:50
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup read operation.
This module different return of access size.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/timer/renesas_tmr.c | 106 ++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 446f2eacdd..d7b21edf39 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -187,59 +187,67 @@ static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
                       addr);
         return UINT64_MAX;
     }
-    switch (addr & 0x0e) {
-    case A_TCR:
-        ret = 0;
-        ret = FIELD_DP8(ret, TCR, CCLR,
-                        FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
-        ret = FIELD_DP8(ret, TCR, OVIE,
-                        FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
-        ret = FIELD_DP8(ret, TCR, CMIEA,
-                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
-        ret = FIELD_DP8(ret, TCR, CMIEB,
-                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
-        return ret;
-    case A_TCSR:
-        ret = 0;
-        ret = FIELD_DP8(ret, TCSR, OSA,
-                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
-        ret = FIELD_DP8(ret, TCSR, OSB,
-                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
-        switch (ch) {
-        case 0:
-            ret = FIELD_DP8(ret, TCSR, ADTE,
-                            FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
-            break;
-        case 1: /* CH1 ADTE unimplement always 1 */
-            ret = FIELD_DP8(ret, TCSR, ADTE, 1);
-            break;
-        }
-        return ret;
-    case A_TCORA:
-        if (size == 1) {
+    switch (size) {
+    case 1:
+        switch (addr & 0x0e) {
+        case A_TCR:
+            ret = 0;
+            ret = FIELD_DP8(ret, TCR, CCLR,
+                            FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
+            ret = FIELD_DP8(ret, TCR, OVIE,
+                            FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
+            ret = FIELD_DP8(ret, TCR, CMIEA,
+                            FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
+            ret = FIELD_DP8(ret, TCR, CMIEB,
+                            FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
+            return ret;
+        case A_TCSR:
+            ret = 0;
+            ret = FIELD_DP8(ret, TCSR, OSA,
+                            FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
+            ret = FIELD_DP8(ret, TCSR, OSB,
+                            FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
+            switch (ch) {
+            case 0:
+                ret = FIELD_DP8(ret, TCSR, ADTE,
+                                FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
+                break;
+            case 1: /* CH1 ADTE unimplement always 1 */
+                ret = FIELD_DP8(ret, TCSR, ADTE, 1);
+                break;
+            }
+            return ret;
+        case A_TCORA:
             return tmr->tcora[ch];
-        } else if (ch == 0) {
-            return concat_reg(tmr->tcora);
-        }
-    case A_TCORB:
-        if (size == 1) {
+        case A_TCORB:
             return tmr->tcorb[ch];
-        } else {
-            return concat_reg(tmr->tcorb);
-        }
-    case A_TCNT:
-        return read_tcnt(tmr, size, ch);
-    case A_TCCR:
-        if (size == 1) {
+        case A_TCNT:
+            return read_tcnt(tmr, size, ch);
+        case A_TCCR:
             return read_tccr(tmr->tccr[ch]);
-        } else {
-            return read_tccr(tmr->tccr[0]) << 8 | read_tccr(tmr->tccr[1]);
+        default:
+            qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                          " not implemented\n",
+                          addr);
+            break;
+        }
+    case 2:
+        switch (addr) {
+        case A_TCORA:
+            return concat_reg(tmr->tcora);
+        case A_TCORB:
+            return concat_reg(tmr->tcora);
+        case A_TCNT:
+            return read_tcnt(tmr, size, ch);
+        case A_TCCR:
+            return read_tccr(tmr->tccr[ch]) << 8 | read_tccr(tmr->tccr[1]);
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "renesas_tmr: Register 0x%" HWADDR_PRIX
+                          " invalid access size\n",
+                          addr);
+            break;
         }
-    default:
-        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
-                                 " not implemented\n",
-                      addr);
-        break;
     }
     return UINT64_MAX;
 }
-- 
2.20.1


