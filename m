Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D032C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B9C20673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQMcAN1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B9C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJk8L-0004Ou-7B
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0N-0005ST-9S
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0M-0003HY-8o
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iJk0M-0003GW-34
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id n14so17210568wrw.9
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=UQMcAN1saSM6BhMkpDnD/DLaxnxTqZ0i+JK64gPzjROixw9xZlODptRlTnZBWVG/dB
 kZIQjK8R8fRz4D7l3v3IBFyy+PiY10UPYd9xTx3QqGNcufL2HJ+Gl94o41LUBOsdh4bE
 Pycd8WRVDfPzecrfxCu4bBVTlyWPzsfQVVq0vjAIuv4h4pZFlAGormOhUblva1MQ6/ex
 EWHfF7OwMtF10EW1nVV3FfuUinE75d999AAe8mRWDJFjHB/10JPs126jsRytXvQZHllG
 3aC1iF9r2JcwWJMGisrSXL+uzM5YWrwL7OLd6uiRbZU2sSrYbDAHyYKjl7iMblWys1I1
 n4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=AgeuHzhGvuxhMSCx8SfKbFpUQmXz5Yd8MPs998ARVjMr4iJ5Q3aIIJmwnYTjxBaw8V
 god03ZcN8484FLBEbH5z+E8x+/qYq/izZPJxyx/OYosh6+M1qJpcpnmCkgpUMJ1qLfpY
 nddXPh3DUzHuKPgctMdyCFzHiIeMyqplT3BvMpdQ8byCpZN1eSVzGbyTb3DCvZXliLNV
 lhcQpbBl0+ODOsSfk+olPs0jcEuSrZpbwvBWZROpuNsrz6KK4t3W0Zkn8S2Hgaj0rQgm
 wtDFWXuum3Yld8S68461c+01h3ztngXAGQTs2MZ58Imy7lrR5EV+UbGzboHRnGePCwST
 QWyQ==
X-Gm-Message-State: APjAAAXaCLgD6PlpCE9qumlszhcLRe/Wsxx+glO1pV2AniNBwxkRJNeR
 VkPaoj98XuikeoQvWy2AJeDZ9IwU
X-Google-Smtp-Source: APXvYqws10uyMYDBwQV/MOgpbo80z1fsv80qiS3nKrFRPUczZ/oBC8Fy7qMuOC1ouCx/anudy0Ihmw==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr21261264wro.377.1570996692989; 
 Sun, 13 Oct 2019 12:58:12 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-0052-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:52::5])
 by smtp.gmail.com with ESMTPSA id x129sm29941857wmg.8.2019.10.13.12.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 12:58:12 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/10] audio: basic support for multichannel audio
Date: Sun, 13 Oct 2019 21:58:03 +0200
Message-Id: <7e53be1f97e939ed3bb729ef39e76b775643118a.1570996490.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
References: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Which currently only means removing some checks.  Old code won't require
more than two channels, but new code will need it.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c | 7 -------
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index eddf013a53..f37ce1ce85 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -493,13 +493,6 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         goto err;
     }
 
-    if (nchannels != 1 && nchannels != 2) {
-        alsa_logerr2 (err, typ,
-                      "Can not handle obtained number of channels %d\n",
-                      nchannels);
-        goto err;
-    }
-
     if (apdo->buffer_length) {
         int dir = 0;
         unsigned int btime = apdo->buffer_length;
diff --git a/audio/audio.c b/audio/audio.c
index c00f4deddd..7fc3aa9d16 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -242,7 +242,7 @@ static int audio_validate_settings (struct audsettings *as)
 {
     int invalid;
 
-    invalid = as->nchannels != 1 && as->nchannels != 2;
+    invalid = as->nchannels < 1;
     invalid |= as->endianness != 0 && as->endianness != 1;
 
     switch (as->fmt) {
-- 
2.23.0


