Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83C3C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A006A2168B
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A006A2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYTK-0002SA-Qz
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:20:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYNA-0006DB-80
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYN9-000272-0F
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:12 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:50703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYN8-00025d-QW
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:10 -0400
Received: from player698.ha.ovh.net (unknown [10.108.57.178])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8391212D049
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:14:09 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id 2C724625A813;
	Sat, 25 May 2019 15:14:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:33 +0200
Message-Id: <20190525151241.5017-12-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6611565728465783569
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
Subject: [Qemu-devel] [PATCH 11/19] aspeed/timer: Provide back-pressure
 information for short periods
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
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
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/timer/aspeed_timer.h | 1 +
 hw/misc/aspeed_scu.c            | 6 ++++++
 hw/timer/aspeed_timer.c         | 6 +++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
index 1fb949e16710..10c851ebb6d7 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -41,6 +41,7 @@ typedef struct AspeedTimer {
      * interrupts, signalling with both the rising and falling edge.
      */
     int32_t level;
+    uint32_t min_ticks;
     uint32_t reload;
     uint32_t match[2];
     uint64_t start;
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index ab1e18ed4b0f..a7b37e5ece01 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -422,6 +422,12 @@ static void aspeed_scu_realize(DeviceState *dev, Err=
or **errp)
                           TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
=20
     sysbus_init_mmio(sbd, &s->iomem);
+
+    /*
+     * Reset on realize to ensure the APB clock value is calculated in t=
ime for
+     * use by the timer model, which is reset before the SCU.
+     */
+    aspeed_scu_reset(dev);
 }
=20
 static const VMStateDescription vmstate_aspeed_scu =3D {
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 6c184572ea04..9988b8fbbf17 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -259,7 +259,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlSta=
te *s, int timer, int reg,
     switch (reg) {
     case TIMER_REG_RELOAD:
         old_reload =3D t->reload;
-        t->reload =3D value;
+        t->reload =3D value < t->min_ticks ? t->min_ticks : value;
=20
         /* If the reload value was not previously set, or zero, and
          * the current value is valid, try to start the timer if it is
@@ -311,7 +311,11 @@ static void aspeed_timer_ctrl_enable(AspeedTimer *t,=
 bool enable)
=20
 static void aspeed_timer_ctrl_external_clock(AspeedTimer *t, bool enable=
)
 {
+    AspeedTimerCtrlState *s =3D timer_to_ctrl(t);
+    uint32_t rate =3D enable ? TIMER_CLOCK_EXT_HZ : s->scu->apb_freq;
+
     trace_aspeed_timer_ctrl_external_clock(t->id, enable);
+    t->min_ticks =3D muldiv64(20 * SCALE_US, rate, NANOSECONDS_PER_SECON=
D);
 }
=20
 static void aspeed_timer_ctrl_overflow_interrupt(AspeedTimer *t, bool en=
able)
--=20
2.20.1


