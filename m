Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA407C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA9520737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Lr0Iw6Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA9520737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2tk-0005aS-EK
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k6-0008P0-VA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:49511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k1-0002V0-VJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476431;
 bh=i8X1Kfb349zYfYM6YQnilalygM6Nx1dtlvg6TYGBTk8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lr0Iw6Qf4YqNHkfBHl4RQhR48iTcCGR9KY4Fp6dBoWpDq9dweAUYtubYXx5RfrZR1
 tQwi6p1maDsDrU3HFVfrlKSnLMVEFXx6HVMc3t7KTh5b8IHdIzJ6IcK8FJis9snUEQ
 aA7nO44GTVwCCRjgF+xqEEvUG4FOq6ONAypTkbdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1kC9jP2oDk-003Lhn; Wed, 26
 Aug 2020 23:13:51 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 11/12] hw/display/artist: Fix invalidation of lines in
 artist_draw_line()
Date: Wed, 26 Aug 2020 23:13:44 +0200
Message-Id: <20200826211345.14295-12-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7EnfV1gXuxolmwFD4lmWf9YewBUCiA2wbpxCrDfm/kKmF247RH6
 y6HUSKcdU6oY5aBha2d8ucAhXOoH+ZG1tUNHgk1YuQLUeSsq5k2yOuqq1jWMZPsBVAFUA6H
 YCIrmj7Qo1ScHHeNKv8XqO+y2ELEE9DnohcmHePx/Ay+trY+BzYh2e/KualWqhlAkZ96P38
 ljORvgFFwL7HgNtJk+B/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rpRH7AQrrdE=:/QASs5NmEOHSyzQLYtAaI8
 I+7jOHgx7xk3Wi8kZMT5st4V1VHgwmLHcXcC9wLZJSx8y5p6pO0Jl5+Gfgd5DTTLspysP8dGE
 oIzgk5uimbGdJiqUEXm1ttR6pX0HzJdjvj3PFWK/xnzNDc7QlHbkuaRlR7vsIrhZxh8AEmAQs
 kaeLsw4cd6kB9QzncZPQP3EV/chw2iEsJIE5gFTgTqw2uNiDNITIAo4LD5mM1LM98NysnfCaY
 j41xVs4kvJ53bwZ7UAh20KKwP8OyXCA09AOBgMlwylbhpJ8fIPeDmk9iYrZbAG8LjCP/8qVX8
 /FKRQkNMPZuSKhi4GO/5+JXxyrotoGETz3vozv0k2vAR6b57FKjd1KCtVpZvPg+vhQ5yeq2Ws
 kj5HY6sLm402H1BWHy3b78GTwk6hjnbaE/Rg5X4quZY8yS7YXBZgwUxjcZIQXpVA+S5RONUdq
 bOaZn/u6XicMcsAPqRbHyT3LlEv/KkE1yVcj29W6goEXA6ANXZ1CwEIKVDj3uv6q5e8RPTLHS
 +Sl1aXQMerGd8IiWI0pwbThdolCbvmuBQhzCTdYroXAqKF83qSMAGrrn5meqj/DBApXyv5QIu
 Ak2WV+W1Fv1L0lojG6zgYxC9uMrFSSz+8299Cyf7th5odH2CxDq3G/MRH0sYbEsxtJx4bjUks
 1DU9Sp+WEIvXr1HbkhS0cBWO7FehNvlEY+hLAZ9/awVgsSHFBJq4VskY21HqpiDZTQk9MeI+k
 y10F61PX2N2X3Ei4+43tB9VLULB4+iES/Dt+GHnBi5IfgmrXlOC3qeynTXYxFLoUmzf6scrFM
 3+7qLubNNoZNIBDLOPuTwxnGTPFCPXSF06krEVOvC97JGa3flMKKldCttnIiW68IVWGj8OUxo
 NXqTDWDKNfr8yDmFFvsSMLa3Rk4IDcEIwDnhGKAYSATBeYYjOnhMr9+ieiMEooEF1bNSEfRpD
 LN5NBNMvf7m/hJiTPIR7tLk02JODwlbOAYk+vv6VbVDc+ED8BTm+FveuX1uLcKv9kHLwXT5zG
 YoP2B5y/lLuXZYN+UDGWRqg8oXEy7IBV/4ajn4touiDp656DyTerBbo5K1PXZnTI5IbF9agGs
 mVKUIDNActUyEhXYRswyMLDIQ8g2nSGEfjsuP86rfvBYaX8w7yD6cNSplbu6YxQdp4oZOp2N3
 5ES/Gi7xIdsDetZ4maNay+oPrzKgwW5kCyATCCvGdArNjsxUSSPaAt28GANEDkIiCka6aEoR6
 knN3/zDzbC2jLrwzA
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
index 44bb67bbc3..a959b2c158 100644
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


