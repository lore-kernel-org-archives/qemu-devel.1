Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF1EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 20:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71613208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 20:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71613208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDaee-0001zz-IO
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 16:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iDadS-0000s1-Bd
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iDadQ-0007Zi-T2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:45:10 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:40654
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iDadQ-0007XG-Mv; Thu, 26 Sep 2019 16:45:08 -0400
Received: from host86-138-245-63.range86-138.btcentralplus.com
 ([86.138.245.63] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iDadf-0002BU-Bs; Thu, 26 Sep 2019 21:45:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pc@us.ibm.com,
 david@gibson.dropbear.id.au
Date: Thu, 26 Sep 2019 21:44:53 +0100
Message-Id: <20190926204453.31837-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.138.245.63
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] target/ppc: use Vsr macros in BCD helpers
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

This allows us to remove more endian-specific defines from int_helper.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/int_helper.c | 72 ++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 46deb57a34..6d238b989d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2052,15 +2052,11 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 #define NATIONAL_PLUS   0x2B
 #define NATIONAL_NEG    0x2D
 
-#if defined(HOST_WORDS_BIGENDIAN)
 #define BCD_DIG_BYTE(n) (15 - ((n) / 2))
-#else
-#define BCD_DIG_BYTE(n) ((n) / 2)
-#endif
 
 static int bcd_get_sgn(ppc_avr_t *bcd)
 {
-    switch (bcd->u8[BCD_DIG_BYTE(0)] & 0xF) {
+    switch (bcd->VsrB(BCD_DIG_BYTE(0)) & 0xF) {
     case BCD_PLUS_PREF_1:
     case BCD_PLUS_PREF_2:
     case BCD_PLUS_ALT_1:
@@ -2095,9 +2091,9 @@ static uint8_t bcd_get_digit(ppc_avr_t *bcd, int n, int *invalid)
 {
     uint8_t result;
     if (n & 1) {
-        result = bcd->u8[BCD_DIG_BYTE(n)] >> 4;
+        result = bcd->VsrB(BCD_DIG_BYTE(n)) >> 4;
     } else {
-       result = bcd->u8[BCD_DIG_BYTE(n)] & 0xF;
+       result = bcd->VsrB(BCD_DIG_BYTE(n)) & 0xF;
     }
 
     if (unlikely(result > 9)) {
@@ -2109,11 +2105,11 @@ static uint8_t bcd_get_digit(ppc_avr_t *bcd, int n, int *invalid)
 static void bcd_put_digit(ppc_avr_t *bcd, uint8_t digit, int n)
 {
     if (n & 1) {
-        bcd->u8[BCD_DIG_BYTE(n)] &= 0x0F;
-        bcd->u8[BCD_DIG_BYTE(n)] |= (digit << 4);
+        bcd->VsrB(BCD_DIG_BYTE(n)) &= 0x0F;
+        bcd->VsrB(BCD_DIG_BYTE(n)) |= (digit << 4);
     } else {
-        bcd->u8[BCD_DIG_BYTE(n)] &= 0xF0;
-        bcd->u8[BCD_DIG_BYTE(n)] |= digit;
+        bcd->VsrB(BCD_DIG_BYTE(n)) &= 0xF0;
+        bcd->VsrB(BCD_DIG_BYTE(n)) |= digit;
     }
 }
 
@@ -2228,21 +2224,21 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 
     if (!invalid) {
         if (sgna == sgnb) {
-            result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
+            result.VsrB(BCD_DIG_BYTE(0)) = bcd_preferred_sgn(sgna, ps);
             bcd_add_mag(&result, a, b, &invalid, &overflow);
             cr = bcd_cmp_zero(&result);
         } else {
             int magnitude = bcd_cmp_mag(a, b);
             if (magnitude > 0) {
-                result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
+                result.VsrB(BCD_DIG_BYTE(0)) = bcd_preferred_sgn(sgna, ps);
                 bcd_sub_mag(&result, a, b, &invalid, &overflow);
                 cr = (sgna > 0) ? CRF_GT : CRF_LT;
             } else if (magnitude < 0) {
-                result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
+                result.VsrB(BCD_DIG_BYTE(0)) = bcd_preferred_sgn(sgnb, ps);
                 bcd_sub_mag(&result, b, a, &invalid, &overflow);
                 cr = (sgnb > 0) ? CRF_GT : CRF_LT;
             } else {
-                result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(0, ps);
+                result.VsrB(BCD_DIG_BYTE(0)) = bcd_preferred_sgn(0, ps);
                 cr = CRF_EQ;
             }
         }
@@ -2353,15 +2349,15 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     int zone_lead = ps ? 0xF : 0x3;
     int digit = 0;
     ppc_avr_t ret = { .u64 = { 0, 0 } };
-    int sgnb = b->u8[BCD_DIG_BYTE(0)] >> 4;
+    int sgnb = b->VsrB(BCD_DIG_BYTE(0)) >> 4;
 
     if (unlikely((sgnb < 0xA) && ps)) {
         invalid = 1;
     }
 
     for (i = 0; i < 16; i++) {
-        zone_digit = i ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
-        digit = b->u8[BCD_DIG_BYTE(i * 2)] & 0xF;
+        zone_digit = i ? b->VsrB(BCD_DIG_BYTE(i * 2)) >> 4 : zone_lead;
+        digit = b->VsrB(BCD_DIG_BYTE(i * 2)) & 0xF;
         if (unlikely(zone_digit != zone_lead || digit > 0x9)) {
             invalid = 1;
             break;
@@ -2407,7 +2403,7 @@ uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
             break;
         }
 
-        ret.u8[BCD_DIG_BYTE(i * 2)] = zone_lead + digit;
+        ret.VsrB(BCD_DIG_BYTE(i * 2)) = zone_lead + digit;
     }
 
     if (ps) {
@@ -2519,7 +2515,7 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     }
 
     *r = *a;
-    bcd_put_digit(r, b->u8[BCD_DIG_BYTE(0)] & 0xF, 0);
+    bcd_put_digit(r, b->VsrB(BCD_DIG_BYTE(0)) & 0xF, 0);
 
     for (i = 1; i < 32; i++) {
         bcd_get_digit(a, i, &invalid);
@@ -2549,11 +2545,7 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int cr;
-#if defined(HOST_WORDS_BIGENDIAN)
-    int i = a->s8[7];
-#else
-    int i = a->s8[8];
-#endif
+    int i = a->VsrSB(7);
     bool ox_flag = false;
     int sgnb = bcd_get_sgn(b);
     ppc_avr_t ret = *b;
@@ -2602,11 +2594,7 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
         }
     }
 
-#if defined(HOST_WORDS_BIGENDIAN)
-    i = a->s8[7];
-#else
-    i = a->s8[8];
-#endif
+    i = a->VsrSB(7);
     if (i >= 32) {
         ox_flag = true;
         ret.VsrD(1) = ret.VsrD(0) = 0;
@@ -2637,13 +2625,11 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     ppc_avr_t ret = *b;
     ret.VsrD(1) &= ~0xf;
 
-#if defined(HOST_WORDS_BIGENDIAN)
-    int i = a->s8[7];
-    ppc_avr_t bcd_one = { .u64 = { 0, 0x10 } };
-#else
-    int i = a->s8[8];
-    ppc_avr_t bcd_one = { .u64 = { 0x10, 0 } };
-#endif
+    int i = a->VsrSB(7);
+    ppc_avr_t bcd_one;
+
+    bcd_one.VsrD(0) = 0;
+    bcd_one.VsrD(1) = 0x10;
 
     if (bcd_is_valid(b) == false) {
         return CRF_SO;
@@ -2679,11 +2665,7 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     uint64_t mask;
     uint32_t ox_flag = 0;
-#if defined(HOST_WORDS_BIGENDIAN)
-    int i = a->s16[3] + 1;
-#else
-    int i = a->s16[4] + 1;
-#endif
+    int i = a->VsrSH(3) + 1;
     ppc_avr_t ret = *b;
 
     if (bcd_is_valid(b) == false) {
@@ -2728,11 +2710,7 @@ uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
         }
     }
 
-#if defined(HOST_WORDS_BIGENDIAN)
-    i = a->s16[3];
-#else
-    i = a->s16[4];
-#endif
+    i = a->VsrSH(3);
     if (i > 16 && i < 33) {
         mask = (uint64_t)-1 >> (128 - i * 4);
         if (ret.VsrD(0) & ~mask) {
-- 
2.20.1


