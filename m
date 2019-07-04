Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E11BC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1F8218AD
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1F8218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiufz-0004Uu-J4
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 01:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36569)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hiufB-0003xY-2z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hiuf9-0004WJ-OB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:52:09 -0400
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:39593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hiuf9-0004VH-Ei
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:52:07 -0400
Received: from player789.ha.ovh.net (unknown [10.108.42.102])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3D3891D4DCC
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 07:52:03 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 691267826938;
 Thu,  4 Jul 2019 05:51:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  4 Jul 2019 07:51:50 +0200
Message-Id: <20190704055150.4899-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 10665368344897751825
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrfedugddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.26
Subject: [Qemu-devel] [PATCH for 4.1] aspeed/timer: Provide back-pressure
 information for short periods
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

From: Andrew Jeffery <andrew@aj.id.au>

First up: This is not the way the hardware behaves.

However, it helps resolve real-world problems with short periods being
used under Linux. Commit 4451d3f59f2a ("clocksource/drivers/fttmr010:
Fix set_next_event handler") in Linux fixed the timer driver to
correctly schedule the next event for the Aspeed controller, and in
combination with 5daa8212c08e ("ARM: dts: aspeed: Describe random number
device") Linux will now set a timer with a period as low as 1us.

Configuring a qemu timer with such a short period results in spending
time handling the interrupt in the model rather than executing guest
code, leading to noticeable "sticky" behaviour in the guest.

The behaviour of Linux is correct with respect to the hardware, so we
need to improve our handling under emulation. The approach chosen is to
provide back-pressure information by calculating an acceptable minimum
number of ticks to be set on the model. Under Linux an additional read
is added in the timer configuration path to detect back-pressure, which
will never occur on hardware. However if back-pressure is observed, the
driver alerts the clock event subsystem, which then performs its own
next event dilation via a config option - d1748302f70b ("clockevents:
Make minimum delay adjustments configurable")

A minimum period of 5us was experimentally determined on a Lenovo
T480s, which I've increased to 20us for "safety".

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
[clg: - changed the computation of min_ticks to be done each time the
        timer value is reloaded. It removes the ordering issue of the
        timer and scu reset handlers but is slightly slower ]
      - introduced TIMER_MIN_NS
      - introduced calculate_min_ticks() ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 This is fixing a serious slowdown issue with recent Linux.=20

 hw/timer/aspeed_timer.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 29cc5e807081..217d59fa7885 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -42,6 +42,13 @@ enum timer_ctrl_op {
     op_pulse_enable
 };
=20
+/*
+ * Minimum value of the reload register to filter out short period
+ * timers which have a noticeable impact in emulation. 5us should be
+ * enough, use 20us for "safety".
+ */
+#define TIMER_MIN_NS (20 * SCALE_US)
+
 /**
  * Avoid mutual references between AspeedTimerCtrlState and AspeedTimer
  * structs, as it's a waste of memory. The ptimer BH callback needs to k=
now
@@ -96,6 +103,14 @@ static inline uint32_t calculate_ticks(struct AspeedT=
imer *t, uint64_t now_ns)
     return t->reload - MIN(t->reload, ticks);
 }
=20
+static uint32_t calculate_min_ticks(AspeedTimer *t, uint32_t value)
+{
+    uint32_t rate =3D calculate_rate(t);
+    uint32_t min_ticks =3D muldiv64(TIMER_MIN_NS, rate, NANOSECONDS_PER_=
SECOND);
+
+    return  value < min_ticks ? min_ticks : value;
+}
+
 static inline uint64_t calculate_time(struct AspeedTimer *t, uint32_t ti=
cks)
 {
     uint64_t delta_ns;
@@ -259,7 +274,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlSta=
te *s, int timer, int reg,
     switch (reg) {
     case TIMER_REG_RELOAD:
         old_reload =3D t->reload;
-        t->reload =3D value;
+        t->reload =3D calculate_min_ticks(t, value);
=20
         /* If the reload value was not previously set, or zero, and
          * the current value is valid, try to start the timer if it is
--=20
2.21.0


