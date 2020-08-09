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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD8920729
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JDvvBBKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8920729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4e3X-00005W-JS
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4doz-0006KF-6n
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:52385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dox-0002qk-H2
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950647;
 bh=4cu5DCwNBFInqID3CJQEwuqMV1flM13s9w/a+nvBy40=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JDvvBBKISbdA/b4fcLdlBQ3wQRydPJbmviJolbL4NgsAnhbjtAKD7tmF6KqybHB5m
 8lb+knknuaiEcJ7U19VPufFHUd0mVRD60U7700HC0gAPIfVm7I7Y4y4q+PDw8gfkXv
 Xl56VOiyscigyolnwJKJY0uxT5ZKrfCxfD3kPRcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1kLDG72gNQ-00IhZg; Sun, 09
 Aug 2020 07:24:07 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 12/12] hw/display/artist: Fix invalidation of lines near
 screen border
Date: Sun,  9 Aug 2020 07:24:02 +0200
Message-Id: <20200809052402.31641-13-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8b8NIzhwhK2ClhEX1a4Un/JILwhcE/qe+SZXLGcu3NZWpph449
 PuFfnMjMd4oLftQKH6Ig1+DL/v/8acUGmhZUuzWxvBdh2FQfhvN+mQZFw8CrBftqd7eZ8kU
 hJ2dqLweg1ZGZFDewGCqApK3RVh8bU/LOIZmcoIhBfxt6hLwj/AJaBOXR3RQT4dhS9zsNGK
 VolL7xKJvJi1+QIm9DNhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z44uQtOgeqM=:NqSdmBZw9TMClOGlEhFBVU
 iiGYf89nr4+ILnCto1tLGlzqp+rrG3R01K56lOKLbB3I3b5HWAkEbfNzGxtP2YWCvnl0PC9Js
 250PZAu6Ld9k8ZEMOP7eDkmEwby57fne+DfXmRiFJo87XYbWNKaBZljJWiujSAJF+C3k58wkQ
 D/9XAchXta4lWQMk1SGCTRBL7rr8pRRQgnmyxH+ZLWL55yGmbMfPEu0NGNvRExRydlrOUBhHZ
 SVJLNOKC2NHXIqlZmoQWfDQV7xHk4YT2Qqy1w2Y9oUrn51usj6m1epfZ9h62Gyg5CuriQg7DL
 gjP1rW+BvvLRSjzMzfc7zdP2Fx5QXdJjtZN865JU2LXG/mUVo6Z73vGQQyNS0SP3E8INZl2d7
 AwaLN+YF9U4QztuOOuUJRpU+eAV77G2+GNIviCI8+63WvOUREH+DHek0/vJXfhJAuD5f+9+Dy
 ZKlo2e4ovOo5RJjzgFJHl4x7rs3IYoCG+vy4K+iRxIahaiGQHhXGuzHtyJGw9akN+DvDmCwBx
 kEkbNb3/fTTwWwJjNNLJoANtPLrcvWDCHS8P0tW/CkHDHBCmY6kyWgqUfHegqQIpa82QeRswq
 M9HEnhjs7EHSqPMbc8x94YnDs+n8ttCYdto52MDet+oRWf11LJp9QUchN+dq1k6DIKpT/f9ba
 oTfhhQpNVF9KpsNpy8TM9Bpdi2DlIyObIgNyAND4XXlk3ye+MmooGlwkSTdLOgyGcyBJpKhlJ
 yE9TG7VuXpLRncXTb3FDLNu5rLXP2hL+MOBzA95fNzZSgezh56rCefkmD7GC7t9bSRJ+OmHGo
 r9XpbMdIDpoPJHCitYwZ9rLRD66QiAP0QxZzXS6wOkgwhaCOUj5m8VpnfC3C6Wn8XcOBBE7+P
 DnhyjIad6Xy49i000bwQPZSp0MEIscO473+yvRpsifj79sCtrXOpQ5hjkbyjttXUnJATv8wC6
 5HQylE5BNLjdVR5oXwvta1j+iFdihhdS11W2kzv1v5Y+Sc7w1ZCel3ak6DdWK8CalRmz0qfrj
 oQ/Y2J+fqCbPFjY//KFUa5II7GDf2PWGDTueTIm2SrSjsDROy73yUG6Px2hCAB19BcMn8y1l+
 oQVfP9r8nIfl1QTy75y8QHZG9swO3VCqiIlPixXoKmVSL1URvCDjDED6bDcOzLHKZ3x5qUIvS
 xwYESTNSjKJVSoVdMzBVaTnP+EuMpgNodJ4PVufj9MdAy0bwdnBYB/ZCPTrvkhNEgfoDekU1m
 KfMlK6c8Jqrzbh3i+
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:17:21
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

If parts of the invalidated screen lines are outside of the VRAM buffer,
the code skips the whole invalidate. This is incorrect when only parts
of the buffer are invisble - which is the case when the mouse cursor is
located near the screen border.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 09d8b541f5..720db179ab 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -206,7 +206,12 @@ static void artist_invalidate_lines(struct vram_buffe=
r *buf,
                                     int starty, int height)
 {
     int start =3D starty * buf->width;
-    int size =3D height * buf->width;
+    int size;
+
+    if (starty + height > buf->height)
+        height =3D buf->height - starty;
+
+    size =3D height * buf->width;

     if (start + size <=3D buf->size) {
         memory_region_set_dirty(&buf->mr, start, size);
=2D-
2.21.3


