Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63247CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B9121726
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B9121726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQx3q-000284-Di
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 13:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQwzm-0000E5-81
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQwzk-0006cB-39
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:15:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQwzj-0006QD-Pz
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:15:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmUYD-1hiVM53MtF-00iQSI; Sat, 02 Nov 2019 18:15:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] dp8393x: fix receiving buffer exhaustion
Date: Sat,  2 Nov 2019 18:15:11 +0100
Message-Id: <20191102171511.31881-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191102171511.31881-1-laurent@vivier.eu>
References: <20191102171511.31881-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2+Q/LLiZQMsFCgNF8FNud9WOQXe5kt/AosFCbbUgXKQMrIlkoWT
 zzOaCKpnb/imqapBn9I4WCVFRCWczze/PHg/beJHA/YtR44wykZ1OEzx56Vqd+bSF5ca8l0
 DxgdpY+FVPhWKQ7eNbh1xAMiSEsGM3c/ByyIgghrbH8SNo6BadpGOzAidcds2qQRFP2CO2d
 Zh+H4IELQenIcjA8RMYFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Js1mI23s/IM=:f3KLetL4cbJY8ac24WBoos
 BRo5op4UwYn0Q2t73tzro6dxNjEbyQNaW+bL1lVB+D5tIwjJXzChd9z9Rf0g6uwYUwRANcGis
 p89bwQoaRIgSvF3AwRqKSK/JZrIj2rnzkxdJdFbfigau16mRN/JDZUSY38OEHYnLi+VRSfvXs
 99U2TsBLqnoWIB8N7Sjv+RXCoUGNU5Ww9VqpllDaTa+UT4Yk/jYVSp3fO3rArpdrxJKkaOmY9
 9Qo9T6gbk9Mo0wIUq5YpUmY0oCL5NHbEnSw8x+la1k2yqNboGJXQG/4eM7wAFUtJTXOw+NM7I
 /q6jdWrrM1+yywXjhuAFErljVALn1He7MzAI1hBy+z5yz1orv2i/WJh+SVVLrttWDqMdPUZaC
 Ui2+NCQcDC0Tod0zX5+V1tZbMA4BSwXEVi0Wg72cc0pQ4neUOniHm7m0FdjKMBjo7FwE3yQlp
 JBh6Yb6tKV4y52P8sNcDKeOb+pWNXGX+VqahjC6T78eR+UrTTwAJBvCCbubiCqSb1+eLNEwIp
 7pMZhlklirF39YUFPI6tmSJDm53ThxoXjsf/CauF6uY7TO2YzVJEPwBTEMIJucmLhlmnyUaTK
 m0YEUVr2osRiKkZXYTu/32Vky2SC0VIpZlJCn1jXEqdkt0xf2rdRdQgv5j9QtAdELvpApQw0l
 R2TEmNmzx6xURpj652Mb6Vg4jddK8KkQBIAo7+Ptgfuc9sMk8+6XUIuTIquzzJqv1LsbopVfm
 865tM87Q9Xg1HxJnlSezdz/k2dnJygC1rAebBstRMyijR0pxcWj3WsZ03cLy+fH+KA+TWsYwc
 aHcbd6d7cYnhTyHMYeKgCk1o9dranDe4NYzJ/s2yVpD1bL8eObIhLYcVHXbz6klObVqWavWrf
 +NzhOZAH7jUS/uEFkn5A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The card is not able to exit from exhaustion state, because
while the drive consumes the buffers, the RRP is incremented
(when the driver clears the ISR RBE bit), so it stays equal
to RWP, and while RRP == RWP, the card thinks it is always
in exhaustion state. So the driver consumes all the buffers,
but the card cannot receive new ones.

This patch fixes the problem by not incrementing RRP when
the driver clears the ISR RBE bit.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b8c4473f99..21deb32456 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -304,7 +304,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     dp8393x_update_irq(s);
 }
 
-static void dp8393x_do_read_rra(dp8393xState *s)
+static void dp8393x_do_read_rra(dp8393xState *s, int next)
 {
     int width, size;
 
@@ -323,19 +323,20 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
 
-    /* Go to next entry */
-    s->regs[SONIC_RRP] += size;
+    if (next) {
+        /* Go to next entry */
+        s->regs[SONIC_RRP] += size;
 
-    /* Handle wrap */
-    if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
-        s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
-    }
+        /* Handle wrap */
+        if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
+            s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
+        }
 
-    /* Check resource exhaustion */
-    if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP])
-    {
-        s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
-        dp8393x_update_irq(s);
+        /* Check resource exhaustion */
+        if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP]) {
+            s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
+            dp8393x_update_irq(s);
+        }
     }
 
     /* Done */
@@ -549,7 +550,7 @@ static void dp8393x_do_command(dp8393xState *s, uint16_t command)
     if (command & SONIC_CR_RST)
         dp8393x_do_software_reset(s);
     if (command & SONIC_CR_RRRA)
-        dp8393x_do_read_rra(s);
+        dp8393x_do_read_rra(s, 1);
     if (command & SONIC_CR_LCAM)
         dp8393x_do_load_cam(s);
 }
@@ -640,7 +641,7 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
             data &= s->regs[reg];
             s->regs[reg] &= ~data;
             if (data & SONIC_ISR_RBE) {
-                dp8393x_do_read_rra(s);
+                dp8393x_do_read_rra(s, 0);
             }
             dp8393x_update_irq(s);
             if (dp8393x_can_receive(s->nic->ncs)) {
@@ -840,7 +841,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
         if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
             /* Read next RRA */
-            dp8393x_do_read_rra(s);
+            dp8393x_do_read_rra(s, 1);
         }
     }
 
-- 
2.21.0


