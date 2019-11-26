Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9CD20656
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SBQwqCNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9CD20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUDs-0004jw-OH
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 01:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZU8y-0007Ll-PF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZTvJ-0004PX-4u
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:02:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59837 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZTvI-0004Nd-PT; Tue, 26 Nov 2019 01:02:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MYFd4rHCz9sRK; Tue, 26 Nov 2019 17:01:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574748117;
 bh=Yad6EHt74mRLNq20SFLUJExdglivkS35/7wuW+BoRaQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SBQwqCNqSEHYYC3avOx751ogCk94YLb6q4hqLWmAZlJty6Vktx5Ez3nmexu3sATP3
 XTjxgp51yBlnW+UOHsc7tTAhVvlww023g55YXDq3Jktl+57FD+9GuYrouAksuAyA8i
 K+XBYkex+bY4opS6ZSJR+Uc/e/QMnbIkoejiCgIw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 7/8] mos6522: update counters when timer interrupts are off
Date: Tue, 26 Nov 2019 17:01:50 +1100
Message-Id: <20191126060151.729845-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126060151.729845-1-david@gibson.dropbear.id.au>
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

Even if the interrupts are off, counters must be updated because
they are running anyway and kernel can try to read them
(it's the case with g3beige kernel).

Reported-by: Andrew Randrianasulu <randrianasulu@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191125141414.5015-1-laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/mos6522.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index aa3bfe1afd..cecf0be59e 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -113,6 +113,10 @@ static int64_t get_next_irq_time(MOS6522State *s, MO=
S6522Timer *ti,
     int64_t d, next_time;
     unsigned int counter;
=20
+    if (ti->frequency =3D=3D 0) {
+        return INT64_MAX;
+    }
+
     /* current counter value */
     d =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time=
,
                  ti->frequency, NANOSECONDS_PER_SECOND);
@@ -149,10 +153,10 @@ static void mos6522_timer1_update(MOS6522State *s, =
MOS6522Timer *ti,
     if (!ti->timer) {
         return;
     }
+    ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
     if ((s->ier & T1_INT) =3D=3D 0 || (s->acr & T1MODE) !=3D T1MODE_CONT=
) {
         timer_del(ti->timer);
     } else {
-        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
         timer_mod(ti->timer, ti->next_irq_time);
     }
 }
@@ -163,10 +167,10 @@ static void mos6522_timer2_update(MOS6522State *s, =
MOS6522Timer *ti,
     if (!ti->timer) {
         return;
     }
+    ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
     if ((s->ier & T2_INT) =3D=3D 0) {
         timer_del(ti->timer);
     } else {
-        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
         timer_mod(ti->timer, ti->next_irq_time);
     }
 }
--=20
2.23.0


