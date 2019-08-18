Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD717C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DB121852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWd9oHb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DB121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUSU-0003K5-Tx
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGV-0006YV-9E
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGU-0005KR-Bo
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGU-0005Jn-5m
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id o4so9534wmh.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KkJvtrc3QrV2I7WYyibxflgUNfu3hfn3RhzurnFS0ws=;
 b=aWd9oHb04kGXvRv0eC4j08jUkl3cS6T1vdY8J0+fuwXtGChWBgkua53TJJZtE9EET0
 gh6joL6CGg9zEq2ZROo0pb5F2TbVtgl9v9ndUaYqM4qwRcWvtfVCxgLXPYpyFTU3P2Qt
 j3LMuePYHOjMhl2rWn2s869qH2gETGonCJTTFiExGr7VMvFGVajYeRrwwZqQlrxy8V3Q
 jYZaNPUboYHW4p8J++4TUaNSUiiMbeXcuXFFmnR4f9r1IcmQGOQI0Bz+rL7ZRh9MiiVk
 3i5vIp5AX7oYlTbbk3D0bvcaEwTSYML5U4HXesthFw3edCho652qQ75gtQLgoBGC0Z9J
 jUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkJvtrc3QrV2I7WYyibxflgUNfu3hfn3RhzurnFS0ws=;
 b=EpEF1/ZBH0Qf57C7KBdxN4nFivuoeDZcUGgNiTBH4iu6WRoCk4IDw1UJSN5LjS8I6+
 NFE4jdL/k0NdL/EZ83d/vcHjExInl8uSRguLJHoHIw3upMCuEf/GLC//VDHwVNZWPiJ9
 wcO7yEHAenrw54k5CWnV0dPdjWJlkts/WfwMMXgMFw6HCXs80Dt0ljn3sFG/l8Gk1XKW
 gPiziw/bJ3s162sfQ1n2D24E2BFx6D11uYzqRyY6HDndDYh3PpGuN3qOGdzxtkcJ4IlP
 RWIJu6W39iLVlAr1hmKorbijUVrL30z34rWs+7ILPcGuYScyr3kLszQGDLPoAKYL8JMo
 Z5sQ==
X-Gm-Message-State: APjAAAV9e9s3HNW7nqMRf6n6d+yHDbCVYzM1PYBW29tuXf9GVbkWQbdL
 kCgDAVNYp6AU10NJfJB73Rhl+Wny
X-Google-Smtp-Source: APXvYqzpAOWQga7jlikjWTMZupVMJGq5vHtRuRwHl/dpb+FzyxTO3WZEywT408LIKgX+Eoms4iP4Mw==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr16099005wmg.160.1566169629108; 
 Sun, 18 Aug 2019 16:07:09 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.07.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:08 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:56 +0200
Message-Id: <aa4e3613122ccbaa62b1feb4e427260731f7477c.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 11/14] paaudio: fix playback glitches
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
index f3864e1d50..c8ae1a6eca 100644
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


