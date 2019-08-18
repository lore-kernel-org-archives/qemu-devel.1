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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBAC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D1021852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxVJfMC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D1021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUPS-0000CL-G6
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGS-0006T5-73
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGR-0005Ic-9j
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGR-0005I3-46
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id b16so6742968wrq.9
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQdS/4gPbCHrpQ6QHLwZkQ1izi38pwhpM703vz5qgTE=;
 b=cxVJfMC9RkViOeSspi0t2cLErhyX4bF5K0o4zTH5wyZaZCU1ErfY7sjmLetrXVEuDj
 V6bzFbQOLyn/I8I4pC8KG/XM+UWqjoZ1VBPAb8rX2OIJ0lB4drHqPGaektfOW5odUXJd
 D3s50Hv71PJ8tM1EWX327r2j/n0GfXSu+z2sH0/c8DrpyCLN/I1QQH9Y1JAXekmAKO8z
 AvCqmk0ySXwnAF2I7kBJ2JMAnu72DH10HtdICKsglj6BvCQlAeVxtMAtbMHoqMWFy0U/
 /xDmVk7iG5vFA+0hD649ebenvn+0i5H4qySb/koD6RIWWNHb1IxjrDyyceZ066j45TND
 +PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQdS/4gPbCHrpQ6QHLwZkQ1izi38pwhpM703vz5qgTE=;
 b=Q5+vq1FHXcRXYm+iP/B9cIlelnuomtdxEhMTyHjC6zhiiMFWM/k2ClXJUY4VK3J38T
 pjx3Pjv72l+SDt1fyYSebSAmNAXaFQmV5PJdipChPX6LNvZCniZ7shUCct15oAslAeRZ
 8wGrrPvSikqiEq6A8z8os8bVgb9UVzg8R8SCDJm2NNoo8/y8QVGnJBrokoWA6fewyIVJ
 keE5auLu+FaKwiYlqzVbgPDfbdBNE6z5PyVN89b7Lad0xpqsLVzeXDZU4a+UwZKkU8qZ
 5fkS3TPmpPw5Z/f2mciFU7dUB80UPjc0UC7fdreOQ7Shp3zbJ3Ww3isw2JuiSoS8DqcV
 PZ/Q==
X-Gm-Message-State: APjAAAUQ8QknozB5XL1t/3kAzdx+Nd1B5I+C2IiBSqr65+SNVSRAE3a2
 Nls4GyQ7Ofu9DyO3a2V8vcHNKQkfH+A=
X-Google-Smtp-Source: APXvYqwoUEOu8sNGvRKwXEBvmfKbykIcQFuUM1fjwz9hC8jh3eUzQqJbuz8jWLJ7YHIXXFQrTwGK1A==
X-Received: by 2002:adf:8004:: with SMTP id 4mr15528970wrk.341.1566169625986; 
 Sun, 18 Aug 2019 16:07:05 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.07.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:05 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:52 +0200
Message-Id: <c245929463e6e46a48b2875a150815e2ccba11b4.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 07/14] paaudio: do not move stream when
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


