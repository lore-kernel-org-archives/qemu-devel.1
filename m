Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D0BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EF720729
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Rq9+bhyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EF720729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57r0-0002nS-PK
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nS-0000xD-Ck
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:36649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nQ-0008FZ-6K
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065888;
 bh=HXCvduzOIXsCQA5SfxLwuvEJdZ32wS45EDx3y1nQsa0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Rq9+bhyvKGbbdHADyvvjRfxtMqW5vzuiTmTBCS6rbVE0Kuj2faThpv/QS2N1icSUp
 R3BMfhzYOcXPgahxEYmMqjcPZe5SnUAV1QZ8Ql1sxIWtpmN6aA99ybrTJ5nhgr54nY
 cv2pGrUjryb5gvpQTF9U8wIhBONGFQx8Q1aUjd0A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1knE0F3Utk-00zqEi; Mon, 10
 Aug 2020 15:24:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 12/12] hw/display/artist: Fix invalidation of lines near
 screen border
Date: Mon, 10 Aug 2020 15:24:41 +0200
Message-Id: <20200810132441.16551-13-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xg+ggqxvj7w0xaJZpdOEYGPzqc83QiRRipaOh+iHR/ZtaOMo7aq
 fLlQQhija/vztpON4lh3trgXRYfQ0KRjMxZLFQLc4VIB+S815rN1gsyyADbOxOHPAa6RF5u
 Zfat9S5r/1PfpYLXRoWHKpotg1YS0OcESSujeb/ItC+2x8B14/eyUh5qCzI+JgoLjgAKMVx
 2PtEIvV+xFZSoAWga1JBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XAhJ/9YRwUA=:r+G/HnAN/CZLmRKd8gqooR
 rTqS5bHXVFOBBJH+RGYYxihMMQFpOBxxKSSnEls66cIdZk2HhEbp9f7oaBM37ifalYS8sovNM
 ENqaeUH2X7yUXgPcVZXmixo71eqnMLSFBp01c3bFdgd6xQB549gEqWOeoa8z8uCgszPQjQTaN
 0PIftfqC+FRdQXwWWOwvIQaP88eaX4zwapGNkm6sOIBiyBsgpKENcLhx31t7MkOTYTFMtxIzQ
 d2rOi+PnFum2leYMff4DhnieXErwtn6B+nVy8UZFEiaG4IoiXBAr+XByT85s5yKOnevoylgLS
 4pDEzEDgkQSekaRDPX+RMHHi5i3FQayCS8bsbYZYNf/tNXHwYdJwfvLuEZw4AIQvIw6+KaN3w
 yNEyrL7S3+cgzyQRD0crw2IhhmWF/pdU9yS7LsvYxXm9hHRfMSVrVqLAsR3wGNe/rJf+fgxeI
 /o6YqorOPCXwnbGmniM6yYH6TumVB+Vu/c4iKbAEfQe59wChw3Bm0JTNZQAT70K8C4U2XGupS
 kNfU+tJDjRJHzzQHYK6/l/NiB75+Evw25ypHaDc56L8tGaTwi02d0hj8oR7niQ27Z13zWZ4D3
 HaI//Qa1B+x7BE+acckUphCSNGggtuKgSRoEJlXvLu3oYHRW5YiQ/vj/EiMS40F1zy0SeZBK5
 gFuPpiDcz+EY2SnfBHEvvTdRh2dl/xfwPUcRySHcpFfdpp10ewkQkcdkFGnoiS6VfIJCA7Ubc
 OSADwKilVbCUHWuiXKBxFY0U2IW3xoOpch6mS1W6y3yuGI93x3mFL78V+KLxE7fE9LP7OKu9F
 ILJckClNwRYQdydUi2sMLmRxGeJtt+WBIoOcnOti7yRhRJBUpqtLwie6mux3YL1UBRWHwJoH8
 SpHPV+UPWgwnVsbHRLauWdEMFYJipCB+BHxIpAqnmZGa7EmOT5ksKGvc5z+iTJamqPXE2unu6
 JcQmHK04kEsnoLCpQQdAQsBbPlBdyCdgebtkLwWy4ov0s8QChFvAiHKuYnhN/j1svlqqtaJgY
 D7if05oH7mCZXuZi8lixKYk8OwbtjDjvSHU0aRCdFs+qBLMmfFHp3ZqbkBaWuqc0ZH4+Go7dk
 euuWidovckl0o4zNDKAHNYhGdwGAOio6MNY/0z4XpxY7rRgAjoNfoJhJhRG9o119/rMU89ruX
 cHtYGCHcJ32E/privOe37lc7ifJs6Q/BVhK5tT2Dg28h6jYI75HXa+0uzUGKfUZ9/eZ3nk5xr
 90a+Fy5SwUB3viRyn
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:24:50
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
index a959b2c158..71982559c6 100644
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


