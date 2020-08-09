Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0252C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F70220729
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cj6HmNnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F70220729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4e29-0007TP-JX
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp5-0006Mp-M8
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:51419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp0-0002r1-Uj
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950647;
 bh=2UbG+VuR+383yBth20KOm93Ei+XhQ6gmt03UBV3WNTE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cj6HmNnq92Cc1+1DXRWM3NjFK1IrxrCMLpp/jrZ9+5qH/qWJPKP8T2qfrB93vrfEo
 Vy5yr6A9IY+6bFAZALm3j8MwY+FLkechPiXFc5ykybLsKqD2kb74L44L9Dvc3H3TTV
 Hjh3gR97m1Zux2MWbK5pYeqvwA4P14UmV74uy5q8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1kbmhk1vNP-00bKOB; Sun, 09
 Aug 2020 07:24:07 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 11/12] hw/display/artist: Fix invalidation of lines in
 artist_draw_line()
Date: Sun,  9 Aug 2020 07:24:01 +0200
Message-Id: <20200809052402.31641-12-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d710uOpSrkoxnvA7TvEy5MlTwHnvPdHfc0ZZD702QewNqQSSYB6
 1BveSfPPZ1dRWH9/nXPEzCxLMeqv5Q9UyMwBdA8B4qomNOmk/HhU053iMkQuAS2CWD5bWuB
 K9P+uiBmKX4DjemFIVrU0gCawuUFx3JWnpGIyvQfjQOUL0PGh+NFp2220Pi83R/tJJjPgY+
 yHm1SIoNkPaZVCpcOVGvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PKA8nSDEMFI=:ZxBYZ/Frjahz7YQCJVRTbD
 /dH+hveLJuuoJHb6xGGOP9aDQUl+VI46lP5xRtOG9KO7zRA9HIxplDVGkIanvzmwaCGIcbMOM
 p6uucBkwZpSaqVWrx3se5WKPV6Kb7yIQbboJhYMAN7xOPvaJCFO0t2uoTiSOqi+MegEfbcDQ1
 3WiWRfg57oVAJNn29E3KMre5XEZvcJ3B0NpCuvyen2H0gXzyOucduHnq85mCeYZeiSYYxYkXg
 /b2plUMtnQTtd6PN8djH3VyEJFabbBYMF6pBbUIO/anF4TZdUh54e681vuRePZ+B7kG00NLC0
 xtpzeK+2nwyrsmh3W94k4liv9miKM2u4wcHJRDZJtTtgDMCN/UMIilmP50/M1+7gbst+ZdqHy
 Ia1m0wsnqajlB12YH5yO3Rj8KLA3laQbTdZQHPJsizH96G0r7nxELgVJXUSvpRKhk6IXIqLPs
 c5SECN1oJ41n4XxR+UbTtrhPxslq8XormRahCbuZNB0gzE0n3LTyXrACf0JUGZlBLVBuYccJ3
 /4RNuGwk346pQGYhzbGNm2+KnVNCC9P0/2bdut1E11xCCLQzx5krzQqrepPTcYO1/MnwGIQqu
 nhunLTkBEidr+/g84KeNvbrIyY9lvqcQBCZ4sQIh4HbHdkHiibb8v0JLcFO1VIQD/BEFg6HnK
 iqCzIiVXaIgk9bE+cyHoB6j4atKG55K5obeuULK30G9+GOG6IRMkeakPhVMXTruG+EdlRG79I
 mqVlDvGCu+Q3dJi7wkwxZ4cf5FZedwq/WGRtNmdfD6wAI3fTvrfxH6moRzsJl+5bTx/3SCAEo
 Cnfj1AwkEMSbMGgf1vD7QIRgsxgG3fvHSLYyPmAHbgoP2IhYhWdW2OhJ/gfMn8voC3gKLelaB
 RmdGbIfsIC7raCKFXNVn/CdJh1IECshMQvHAKdiEGdJaK1wXD0jow3AEbEBRx3rco+oUu73i8
 9ge2MreonAwRErB7XnYoxi+nxQstzvtDAMlKPwnU9f7+Slkk++xcaHX70LyQwxGyKILhAJV6I
 gCoSJRAjpNkPzgiWHK3gv37TRouWzQw0/lwD6Dm3JxDOLtf6j1BCGo2Bxjhc9P5wUkKKvH6rJ
 Qg2No1r42NgEGA+8fDLePwrQIHHxJP6nE7d4hOTC2axu4vNrszT6aKQPndXF1fHNw3p4ppoFB
 Qh+vXbes7evuXDY3NqXhEnQAtnztweQXze3Oy4VDoWs0JYMn4owBqUdcYGnrNFTQUIGnxmJ3C
 /ZuVus63saAciFnad
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

The old code didn't invalidate correctly when vertical lines were drawn.
Fix this and move the invalidation out of the loop.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index e7452623f9..09d8b541f5 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -662,7 +662,6 @@ static void draw_line(ARTISTState *s,
         }

         if (e > 0) {
-            artist_invalidate_lines(buf, y, 1);
             y  +=3D incy;
             e  +=3D diago;
         } else {
@@ -670,6 +669,10 @@ static void draw_line(ARTISTState *s,
         }
         x++;
     } while (x <=3D x2 && (max_pix =3D=3D -1 || --max_pix > 0));
+    if (c1)
+        artist_invalidate_lines(buf, x, dy+1);
+    else
+        artist_invalidate_lines(buf, y, dx+1);
 }

 static void draw_line_pattern_start(ARTISTState *s)
=2D-
2.21.3


