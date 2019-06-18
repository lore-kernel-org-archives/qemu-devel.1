Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90828C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BC321479
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BC321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHnp-0003MJ-MZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHNb-0000hj-Uv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHNa-0004sS-Uv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:43 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:56096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHNa-0004qU-NK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:42 -0400
Received: from player157.ha.ovh.net (unknown [10.108.35.210])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id DF6F313288E
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:54:40 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 543166EB538B;
 Tue, 18 Jun 2019 16:54:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:53:01 +0200
Message-Id: <20190618165311.27066-12-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1679842663082658577
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.219
Subject: [Qemu-devel] [PATCH v2 11/21] aspeed/timer: Ensure positive muldiv
 delta
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
index 6501fa0768e7..1f0f1886fb2a 100644
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
2.21.0


