Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E0C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD57020862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD57020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYl4-0005ck-60
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:38:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYe4-0007m2-St
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYNG-0002Mm-Gp
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:19 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:44954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYNG-0002Ko-B6
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:18 -0400
Received: from player698.ha.ovh.net (unknown [10.109.160.143])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id ED4B612CE66
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:14:16 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id 77D03625A823;
	Sat, 25 May 2019 15:14:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:34 +0200
Message-Id: <20190525151241.5017-13-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6613536056988568337
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.52.162
Subject: [Qemu-devel] [PATCH 12/19] aspeed/timer: Ensure positive muldiv
 delta
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
Cc: Christian Svensson <bluecmd@google.com>, Andrew Jeffery <andrew@aj.id.au>,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Svensson <bluecmd@google.com>

If the host decrements the counter register that results in a negative
delta. This is then passed to muldiv64 which only handles unsigned
numbers resulting in bogus results.

This fix ensures the delta being operated on is positive.

Test case: kexec a kernel using aspeed_timer and it will freeze on the
second bootup when the kernel initializes the timer. With this patch
that no longer happens and the timer appears to run OK.

Signed-off-by: Christian Svensson <bluecmd@google.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/timer/aspeed_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 9988b8fbbf17..53b70f859c86 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -275,7 +275,11 @@ static void aspeed_timer_set_value(AspeedTimerCtrlSt=
ate *s, int timer, int reg,
             int64_t delta =3D (int64_t) value - (int64_t) calculate_tick=
s(t, now);
             uint32_t rate =3D calculate_rate(t);
=20
-            t->start +=3D muldiv64(delta, NANOSECONDS_PER_SECOND, rate);
+            if (delta >=3D 0) {
+                t->start +=3D muldiv64(delta, NANOSECONDS_PER_SECOND, ra=
te);
+            } else {
+                t->start -=3D muldiv64(-delta, NANOSECONDS_PER_SECOND, r=
ate);
+            }
             aspeed_timer_mod(t);
         }
         break;
--=20
2.20.1


