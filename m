Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5EC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC575205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC575205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHyJ-0006am-6F
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHNL-0000GV-2L
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHNJ-0004WW-Dh
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:26 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:36949)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHNH-0004Ip-D5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:25 -0400
Received: from player157.ha.ovh.net (unknown [10.109.159.132])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 21AF217F201
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:54:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 2E4ED6EB527C;
 Tue, 18 Jun 2019 16:54:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:52:57 +0200
Message-Id: <20190618165311.27066-8-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1672242837034666769
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.205
Subject: [Qemu-devel] [PATCH v2 07/21] aspeed/timer: Fix behaviour running
 Linux
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

From: Joel Stanley <joel@jms.id.au>

The Linux kernel driver was updated in commit 4451d3f59f2a
("clocksource/drivers/fttmr010: Fix set_next_event handler) to fix an
issue observed on hardware:

 > RELOAD register is loaded into COUNT register when the aspeed timer
 > is enabled, which means the next event may be delayed because timer
 > interrupt won't be generated until <0xFFFFFFFF - current_count +
 > cycles>.

When running under Qemu, the system appeared "laggy". The guest is now
scheduling timer events too regularly, starving the host of CPU time.

This patch modifies the timer model to attempt to schedule the timer
expiry as the guest requests, but if we have missed the deadline we
re interrupt and try again, which allows the guest to catch up.

Provides expected behaviour with old and new guest code.

Fixes: c04bd47db6b9 ("hw/timer: Add ASPEED timer device model")
Signed-off-by: Joel Stanley <joel@jms.id.au>
[clg: - merged a fix from Andrew Jeffery <andrew@aj.id.au>
        "Fire interrupt on failure to meet deadline"
        https://lists.ozlabs.org/pipermail/openbmc/2019-January/014641.ht=
ml
      - adapted commit log
      - checkpatch fixes ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/timer/aspeed_timer.c | 59 ++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 2c3a4d0fe770..537f072cf87f 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -109,37 +109,40 @@ static inline uint64_t calculate_time(struct Aspeed=
Timer *t, uint32_t ticks)
=20
 static uint64_t calculate_next(struct AspeedTimer *t)
 {
-    uint64_t next =3D 0;
-    uint32_t rate =3D calculate_rate(t);
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t next;
=20
-    while (!next) {
-        /* We don't know the relationship between the values in the matc=
h
-         * registers, so sort using MAX/MIN/zero. We sort in that order =
as the
-         * timer counts down to zero. */
-        uint64_t seq[] =3D {
-            calculate_time(t, MAX(t->match[0], t->match[1])),
-            calculate_time(t, MIN(t->match[0], t->match[1])),
-            calculate_time(t, 0),
-        };
-        uint64_t reload_ns;
-        uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        if (now < seq[0]) {
-            next =3D seq[0];
-        } else if (now < seq[1]) {
-            next =3D seq[1];
-        } else if (now < seq[2]) {
-            next =3D seq[2];
-        } else if (t->reload) {
-            reload_ns =3D muldiv64(t->reload, NANOSECONDS_PER_SECOND, ra=
te);
-            t->start =3D now - ((now - t->start) % reload_ns);
-        } else {
-            /* no reload value, return 0 */
-            break;
-        }
+    /*
+     * We don't know the relationship between the values in the match
+     * registers, so sort using MAX/MIN/zero. We sort in that order as
+     * the timer counts down to zero.
+     */
+
+    next =3D calculate_time(t, MAX(t->match[0], t->match[1]));
+    if (now < next) {
+        return next;
+    }
+
+    next =3D calculate_time(t, MIN(t->match[0], t->match[1]));
+    if (now < next) {
+        return next;
+    }
+
+    next =3D calculate_time(t, 0);
+    if (now < next) {
+        return next;
+    }
+
+    /* We've missed all deadlines, fire interrupt and try again */
+    timer_del(&t->timer);
+
+    if (timer_overflow_interrupt(t)) {
+        t->level =3D !t->level;
+        qemu_set_irq(t->irq, t->level);
     }
=20
-    return next;
+    t->start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));
 }
=20
 static void aspeed_timer_mod(AspeedTimer *t)
--=20
2.21.0


