Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C36C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B903D2080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/aEUY13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B903D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvBa-0002E8-M6
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 14:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyK-00049o-Ma
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyJ-0003d1-Kx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyH-0003Wk-IQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so10938166wrf.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NFsbZz+vSV0dR/VsuT/cDCHXS4Tsui+1Dr2/Nb0Mgqg=;
 b=C/aEUY13tH+RUJjvY1OOH0juF7fjzi46PDZvZUDdmMSbBkXGcpszvl3SQDzLeAFvor
 E8oOhbadbXuXb67BcWoxqtrlxypfrnhOAUco+/QRfvrFaf2iZDElFbQgtzHo1wRaTgbM
 dce613cTwQaGOaRDeOt2pR4P6vWxIUnbgrVdu+PBnIatCjABVxfGMAP1Kcj2CRLmQu30
 TtYM0nYg7p8fI/D/KNy9wmjLskmpxud62rrOd48C8cJJU/y1IQpt7ssNJLQbWN4z7Vxw
 J10UuUHIXtXyV/jQKIxWnQXUkB92DkKatF9xrU0Vs9iJQwmDsfqylbx6qluV9rkls+6S
 gamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NFsbZz+vSV0dR/VsuT/cDCHXS4Tsui+1Dr2/Nb0Mgqg=;
 b=sKm/3T0Lvi9robNfyg1ZnYs/D9834ZIrZkzHCDgiJQNFNnuXlonXjwP6fjnyW6txR0
 j/hW3jH/jvf+eRLOr7oEOEcijvsU9p4ch82nscvwwLGEjXlRMLu13ns/nh4IJ+IquSCG
 09Kh12ODwJTqbBBSQ5wUSSyrvr97kRY5xVvr7Xn1kc6Nb1Z5gBaRLS5bkzZ/IIm16Ane
 zbM03QWCVl9NjN5RoU02nk/NxzeFEAESEKLfEuEl8KzmjRnmFead5nDfcpJN79rLmqBP
 /OzMfWyTzIgDvoTW5/JyZ3Oozff6qMMI9ZlBVCKG4sPJ8x40jUptY2Ch6DpIUcLXK+ae
 96nQ==
X-Gm-Message-State: APjAAAUB4juCYxjr8wSR3xdqIABjBz132nmb1zhx3zf9qNFTPFLDxgGe
 3Yi0m5mP4BhKbmFREljMcy2zwC/l
X-Google-Smtp-Source: APXvYqyzAgmhCSkroi/9G7/n7wu5cPR3XjyX7+JdZ1HraYMYlvbV4zekMdCOYkoiPbAUMAKmRbhVjw==
X-Received: by 2002:adf:f98a:: with SMTP id f10mr1281434wrr.250.1562697359785; 
 Tue, 09 Jul 2019 11:35:59 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:59 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:49 +0200
Message-Id: <090ab2fb6a10d601e68012b4152c2dba7a902ca4.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 09/11] paaudio: fix playback glitches
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

Pulseaudio normally assumes that when the server wants it, the client
can generate the audio samples and send it right away.  Unfortunately
this is not the case with QEMU -- it's up to the emulated system when
does it generate the samples.  Buffering the samples and sending them
from a background thread is just a workaround, that doesn't work too
well.  Instead enable pa's compatibility support and let pa worry about
the details.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 9d46f11b0a..d320d2e453 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -512,10 +512,8 @@ static pa_stream *qpa_simple_new (
 
     flags =
         PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-        | PA_STREAM_ADJUST_LATENCY
-#endif
-        | PA_STREAM_AUTO_TIMING_UPDATE;
+        | PA_STREAM_AUTO_TIMING_UPDATE
+        | PA_STREAM_EARLY_REQUESTS;
 
     if (dev) {
         /* don't move the stream if the user specified a sink/source */
-- 
2.22.0


