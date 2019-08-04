Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CEEC19759
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7160D2070D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJhPaJVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7160D2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJy3-00075r-OZ
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw4-0002OB-T0
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw3-00048x-4C
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJw2-00040Z-OX
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so70821580wmg.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQdS/4gPbCHrpQ6QHLwZkQ1izi38pwhpM703vz5qgTE=;
 b=vJhPaJVw/LYCI9NfigX3ZG5cAFJRO7H6M0yGyBEULkZfq6F/x4sa7zSEW2S1XxOHds
 xvqUY+/KZ0nxHF0F7wE6CNe5Deus7FlIdAd+dPGFYZwNlZ6HY9MZwxU3Eh4Xydmy13qS
 rUZ2Q+Aa6gecBfCeJs8l9lTj0U0/7ExiQlFnUo2l4dIrHUDjGXEuBxi04C/z6s9/JR6j
 /KbgwxfUXgWit/O2c8c+1wmK8K7pMurJ+d4GrMPbu80jIOsWhIGptphyCpb+EiFGOw7s
 pjUQn0Da7dGyMzs9+t+uwjLLsOkpOtMGgli0GI6ETP22dqSm6VjQuN6Lsyi6a4D5AFUG
 KVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQdS/4gPbCHrpQ6QHLwZkQ1izi38pwhpM703vz5qgTE=;
 b=fUU8RBmMNsb7rBZ4ol9mCHwULjInnoUZgBNo33BHFCVzhlSny7hGhek/5BjP9m8b/k
 5kf9dI+vHxqkpJs4ZJQG95/qKaqktYZAfzQti9gceJ9Z1tfpvl/i66fuNwxDq3HtakBT
 JDEVL4DEdAuxzfjWssDTBCTinvHXOqR87+qE7jEXIbp39Hi22Ln9+wvm8X9gj7Kx6fNt
 Is+0kQALRYvBePe486jMCV8lKjVgYkSzRGrGvPCtEiTKMU4KmKVZGzNEjFpB8AKQya49
 XRs+qzJWQUK3gx23hu9ThfdCOzC5QuDbbXak85yN4PpHebNy6sPEXlgPgOaY9+sVuoUI
 dn/A==
X-Gm-Message-State: APjAAAV4leRiSVZ+6c7KOR+f6JIG7Tp1zcsr6L8tlNmYJGypfYISISMf
 G03OGMMcv1gUasdeD58tHaTT5Lof4YA=
X-Google-Smtp-Source: APXvYqxnK43iyZGF7PJmAXJnV0bQTR9Z4+jZWclnoOZsCVy6/02Fsk7ruavBHxv+730JjNZDF17LoQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr14163129wmg.155.1564938274823; 
 Sun, 04 Aug 2019 10:04:34 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:34 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:19 +0200
Message-Id: <274fc4ecc9125605a210b737c7fd927c51ff08ce.1564925486.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 07/14] paaudio: do not move stream when
 sink/source name is specified
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unless we disable stream moving, pulseaudio can easily move the stream
on connect, effectively ignoring the source/sink specified by the user.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/paaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index cc3a34c2ea..24d98b344a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -517,6 +517,11 @@ static pa_stream *qpa_simple_new (
 #endif
         | PA_STREAM_AUTO_TIMING_UPDATE;
 
+    if (dev) {
+        /* don't move the stream if the user specified a sink/source */
+        flags |= PA_STREAM_DONT_MOVE;
+    }
+
     if (dir == PA_STREAM_PLAYBACK) {
         r = pa_stream_connect_playback(stream, dev, attr, flags, NULL, NULL);
     } else {
-- 
2.22.0


