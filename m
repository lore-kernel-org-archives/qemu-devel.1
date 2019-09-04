Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4602CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17037208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17037208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dA7-0000Q8-2U
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cBw-0000EF-IB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cBv-0001C5-53
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:48 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:52808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cBu-0001Ap-SV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:47 -0400
Received: from player691.ha.ovh.net (unknown [10.108.54.36])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 86560130AAC
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:47:45 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 1555398B282E;
 Wed,  4 Sep 2019 20:47:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:49 +0200
Message-Id: <20190904204659.13878-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2517793669831625489
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.173.157
Subject: [Qemu-devel] [RFC PATCH 05/15] aspeed/timer: Add support for IRQ
 status register on the AST2600
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2600 timer replaces control register 2 with a interrupt status
register. It is set by hardware when an IRQ occurs and cleared by
software.

Based on previous work from Joel Stanley.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/timer/aspeed_timer.h |  1 +
 hw/timer/aspeed_timer.c         | 32 ++++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
index 69b1377af01e..948329893c0b 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -60,6 +60,7 @@ typedef struct AspeedTimerCtrlState {
     uint32_t ctrl;
     uint32_t ctrl2;
     uint32_t ctrl3;
+    uint32_t irq_sts;
     AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
=20
     AspeedSCUState *scu;
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 7f73d0c75337..dbf8143f0457 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -160,7 +160,9 @@ static uint64_t calculate_next(struct AspeedTimer *t)
     timer_del(&t->timer);
=20
     if (timer_overflow_interrupt(t)) {
+        AspeedTimerCtrlState *s =3D timer_to_ctrl(t);
         t->level =3D !t->level;
+        s->irq_sts |=3D BIT(t->id);
         qemu_set_irq(t->irq, t->level);
     }
=20
@@ -199,7 +201,9 @@ static void aspeed_timer_expire(void *opaque)
     }
=20
     if (interrupt) {
+        AspeedTimerCtrlState *s =3D timer_to_ctrl(t);
         t->level =3D !t->level;
+        s->irq_sts |=3D BIT(t->id);
         qemu_set_irq(t->irq, t->level);
     }
=20
@@ -244,9 +248,6 @@ static uint64_t aspeed_timer_read(void *opaque, hwadd=
r offset, unsigned size)
     case 0x30: /* Control Register */
         value =3D s->ctrl;
         break;
-    case 0x34: /* Control Register 2 */
-        value =3D s->ctrl2;
-        break;
     case 0x00 ... 0x2c: /* Timers 1 - 4 */
         value =3D aspeed_timer_get_value(&s->timers[(offset >> 4)], reg)=
;
         break;
@@ -438,9 +439,6 @@ static void aspeed_timer_write(void *opaque, hwaddr o=
ffset, uint64_t value,
     case 0x30:
         aspeed_timer_set_ctrl(s, tv);
         break;
-    case 0x34:
-        aspeed_timer_set_ctrl2(s, tv);
-        break;
     /* Timer Registers */
     case 0x00 ... 0x2c:
         aspeed_timer_set_value(s, (offset >> TIMER_NR_REGS), reg, tv);
@@ -468,6 +466,9 @@ static uint64_t aspeed_2400_timer_read(AspeedTimerCtr=
lState *s, hwaddr offset)
     uint64_t value;
=20
     switch (offset) {
+    case 0x34:
+        value =3D s->ctrl2;
+        break;
     case 0x38:
     case 0x3C:
     default:
@@ -482,7 +483,12 @@ static uint64_t aspeed_2400_timer_read(AspeedTimerCt=
rlState *s, hwaddr offset)
 static void aspeed_2400_timer_write(AspeedTimerCtrlState *s, hwaddr offs=
et,
                                     uint64_t value)
 {
+    const uint32_t tv =3D (uint32_t)(value & 0xFFFFFFFF);
+
     switch (offset) {
+    case 0x34:
+        aspeed_timer_set_ctrl2(s, tv);
+        break;
     case 0x38:
     case 0x3C:
     default:
@@ -497,6 +503,9 @@ static uint64_t aspeed_2500_timer_read(AspeedTimerCtr=
lState *s, hwaddr offset)
     uint64_t value;
=20
     switch (offset) {
+    case 0x34:
+        value =3D s->ctrl2;
+        break;
     case 0x38:
         value =3D s->ctrl3 & BIT(0);
         break;
@@ -517,6 +526,9 @@ static void aspeed_2500_timer_write(AspeedTimerCtrlSt=
ate *s, hwaddr offset,
     uint8_t command;
=20
     switch (offset) {
+    case 0x34:
+        aspeed_timer_set_ctrl2(s, tv);
+        break;
     case 0x38:
         command =3D (value >> 1) & 0xFF;
         if (command =3D=3D 0xAE) {
@@ -543,6 +555,9 @@ static uint64_t aspeed_2600_timer_read(AspeedTimerCtr=
lState *s, hwaddr offset)
     uint64_t value;
=20
     switch (offset) {
+    case 0x34:
+        value =3D s->irq_sts;
+        break;
     case 0x38:
     case 0x3C:
     default:
@@ -560,6 +575,9 @@ static void aspeed_2600_timer_write(AspeedTimerCtrlSt=
ate *s, hwaddr offset,
     const uint32_t tv =3D (uint32_t)(value & 0xFFFFFFFF);
=20
     switch (offset) {
+    case 0x34:
+        s->irq_sts &=3D tv;
+        break;
     case 0x3C:
         aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
         break;
@@ -626,6 +644,7 @@ static void aspeed_timer_reset(DeviceState *dev)
     s->ctrl =3D 0;
     s->ctrl2 =3D 0;
     s->ctrl3 =3D 0;
+    s->irq_sts =3D 0;
 }
=20
 static const VMStateDescription vmstate_aspeed_timer =3D {
@@ -650,6 +669,7 @@ static const VMStateDescription vmstate_aspeed_timer_=
state =3D {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl3, AspeedTimerCtrlState),
+        VMSTATE_UINT32(irq_sts, AspeedTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
                              ASPEED_TIMER_NR_TIMERS, 1, vmstate_aspeed_t=
imer,
                              AspeedTimer),
--=20
2.21.0


