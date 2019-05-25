Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FE9C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC272133D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC272133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYWF-0004wX-TZ
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:23:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYN3-000677-1s
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYN2-000202-6a
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:05 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:55045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYN2-0001zO-0v
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:04 -0400
Received: from player698.ha.ovh.net (unknown [10.109.143.249])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2CF4C107F84
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:14:03 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id B45E8625A7DB;
	Sat, 25 May 2019 15:13:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:32 +0200
Message-Id: <20190525151241.5017-11-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6609876878724664081
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.46.122
Subject: [Qemu-devel] [PATCH 10/19] aspeed/timer: Fix match calculations
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

If the match value exceeds reload then we don't want to include it in
calculations for the next event.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/timer/aspeed_timer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 2f8522a597d3..6c184572ea04 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -107,6 +107,11 @@ static inline uint64_t calculate_time(struct AspeedT=
imer *t, uint32_t ticks)
     return t->start + delta_ns;
 }
=20
+static inline uint32_t calculate_match(struct AspeedTimer *t, int i)
+{
+    return t->match[i] < t->reload ? t->match[i] : 0;
+}
+
 static uint64_t calculate_next(struct AspeedTimer *t)
 {
     uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -118,12 +123,12 @@ static uint64_t calculate_next(struct AspeedTimer *=
t)
      * the timer counts down to zero.
      */
=20
-    next =3D calculate_time(t, MAX(t->match[0], t->match[1]));
+    next =3D calculate_time(t, MAX(calculate_match(t, 0), calculate_matc=
h(t, 1)));
     if (now < next) {
         return next;
     }
=20
-    next =3D calculate_time(t, MIN(t->match[0], t->match[1]));
+    next =3D calculate_time(t, MIN(calculate_match(t, 0), calculate_matc=
h(t, 1)));
     if (now < next) {
         return next;
     }
@@ -141,8 +146,10 @@ static uint64_t calculate_next(struct AspeedTimer *t=
)
         qemu_set_irq(t->irq, t->level);
     }
=20
+    next =3D MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
     t->start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));
+
+    return calculate_time(t, next);
 }
=20
 static void aspeed_timer_mod(AspeedTimer *t)
--=20
2.20.1


