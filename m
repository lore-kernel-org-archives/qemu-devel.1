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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7F8206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="P5vxtJly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7F8206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57wM-0006Ki-7L
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nU-0000xp-Ot
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:45295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nS-0008Fg-4l
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065887;
 bh=i8X1Kfb349zYfYM6YQnilalygM6Nx1dtlvg6TYGBTk8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P5vxtJlygegxBqT5KzyKTSfI5zmtrdevQWkHP459Hi6JEtcxuEhlxqLZ8NxSGjwTt
 YukCkW8+d9wYEGFvMbXAFBejWmQwL0pe6fZN3qfGetYQV18GPJVSV4YYvMVRyGMBIz
 pETNCVKIysn6yepl0fXQylVTQBdp70WgRyU3jtVs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1kfZ0N2kOC-00aR3M; Mon, 10
 Aug 2020 15:24:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 11/12] hw/display/artist: Fix invalidation of lines in
 artist_draw_line()
Date: Mon, 10 Aug 2020 15:24:40 +0200
Message-Id: <20200810132441.16551-12-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dcHP7yH2hHqU11PJnlpDcYWEJfdFAsRuShYQ1GQEr//nrfNpVHk
 3t+STgVb/5bqhQ1MR3Njn0GWdBeQLfWJ9EzUZIMHOoISm/2fLr7uNI6xDZCOFdYtxB2qUzb
 HhrRge9i0b4oTYm7ltRIyRY2I+jcKhNQSzE0oyNeVnqV/0V12AE7fSn5FzhqDqfEExGaGCC
 OcXxkZEiR7Pbi9P8tDVGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J1ved9nUtB0=:B6349nolbFqRUlgHvm9ByH
 UebvY7kOVYA3e0cxzSWAKmITP9pE6vLidTDs9xEJxaw2jm7+DaOZpg/MRN5npqM59QC6jWt9X
 DypGPdsBgOvtzvodAy84N6tEhu92F7SDpKCWTuTSr+qsDcXAEELiafMHU6clB+FmL3/VVo/2n
 Sv7PTx/nmnKyOXSwZFDePV/7hmaHf1HqVmRvW1FNs9yI8aedkBA4zno5LfySi4Jo5ZEMSrbkj
 HsFXliAkmyiQyYyjEoXVjz8G3a/nQ3QXnNXW026UtGeqDs+qUbu3sOuegqP0+6YFcmCY7X6hD
 IOKcdvdOkOBHmDPCAzlaNN1/TmVeypY6YsbbPRkVFXMmdtleEU50Ln5Dl1mVuK6vE7Mx9tCxn
 TTjBlEAe6z93PlFKR9zSEsbVvbVfcQ9AioFluys9BEoXrSQDqdhwXu4kVL5N8eLIZPNrYfmrx
 zQfC3wocVe3c07R6j1rKu+bYGWeMfTCK58e1s42cOK2NnhC1GaSiiaLAnlC7dHzQbwu2V8zAL
 Xls9Kbxu+pjzS8pvrvqCFPzPxUIYACpgpT4R4sCJpFdGpl2U6ZyKX7u1bUnx5Gq6JOaGvlF7O
 vvo6TUJej+h8Wd0H9LqFo/qfJ+iPw9ZyCRJYNUQ5KqD0xFLxOtUZqN8o9tvIB/pSpco6FZhi1
 tbrgJI+6lMMLVwntMi9Fur5BXRkU4KzXJV433emThowIDGN8oPmrwF9y5MpTRyV00xaKk0xB7
 i5GG35hFtxhqBH8Zt8rJ8RTm2WLexwvTjzlz8z0LMaouj/HLxq+G7lDhWBrkutnNm74pjs1AT
 JhelBG8Wi7vyAqSFxOd9/pbgczB4I5a8jJ6BTMW6YyQ3B5K/Qm3ldmSybRR7h0Ec6YUiugvCp
 9G64DWd7qBH7HcRG8k7OrjfsSTobwRUUBlwPRcp8mt9m6T8bUbvUELumL34kEBOLfRfLtfcZv
 gVaBX/hH70FgbYpupA+Gv2zJS87GXzfT4KztnbdezxQKv85a7vmYrVVfuatSA4vyxVuF0jjP/
 w/XAGgtN572q1GMoCeyLd0/3WCbO+4u1EvBpIOXj4ujEot+m4ZShkHTpWHZxtFU3cimJb3Rr8
 n5o3mNttnxsvrCBu4BqPVmOcoI3ab5DLiyOtxfh/glZwYO+/TtJFy+OLa01IQFZI6/wLqITNI
 tJsYlulfVr8EEQtPw1/zwkJjnNExRT8PXieZSOgkh762O8QmmDek7WfxFptllX2OjO+D/ObAP
 G9ZcbO3Hl6y/W/bsO
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:25:00
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


