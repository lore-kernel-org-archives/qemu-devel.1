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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24FCC19759
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C179E2070D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF4r1FDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C179E2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJy5-00078w-2O
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56685)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw4-0002O7-P5
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw3-00049G-7G
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJw2-000478-VL
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so82085279wrm.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N/mwlriTgvMl6h8mnLx3KY4L68sc0uS+YQp6dXqnv9w=;
 b=MF4r1FDwikQNNKRSMiiVeJgr3g2uk0LxGNy5owgz+yRbPtFVg+lwmHepKJ4EKKSZJr
 /gure/jV0U5r9zuUiyOiE/LbozXesoWkRGAPoG9cQeiLB6P6xxU0GKwWMk+VLhxL4Lov
 M/zDT4ApfbEk2ken8GThaNgcCh3FwZe6TQjcI+a+6vnCPxWCyu1hh91hpIijRrXmkRWG
 riRd/JwSxj1ixVLMQyiYtGx/NTzT13FzDuGIQ8dXJUSOaE81zx9yQXokYRRlc31FLMpO
 p7UCfhF+7tpkuVIMmW9cu2FDczOk7yKqTl774tA22NYd/N2AQwxcvrIpPyqPDEtQJbNy
 Uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N/mwlriTgvMl6h8mnLx3KY4L68sc0uS+YQp6dXqnv9w=;
 b=onGyN5HzuXKOSWn5Wp0x2QdmMYSJOjwklqtHQIs6zjjHr0uuy/iZ9UYpzAWel4rW7Y
 AimCKFDgpQbYj4AWquBNuARDqlr11iV0nGPnfxj+GAmJRFu9ak64Yo5MkmITajT8JVX2
 3Hgso10qT7MhUKcvOXd/gWYoF894cBdYuTVLKjEuJa+XAgYZTVmgWvyrvi8a87PXbbUi
 VhLbUpADJfvcvQe7HnE+hcyX1QdIY0oLSUyJoFWWM4MiP0+f4Z0s3CjY2/1/qb5eDxo5
 5l3jaMovcDPaapLH2l4vO2KdSytr++eAl0TXRYwwJVONtRcm6fAL4g2z1/EgPL02L/R0
 srjw==
X-Gm-Message-State: APjAAAUEs78yE/91M9oX+3c3tvlGJ9vrnf2HsnxT1ddKWwb+TvyzwoLS
 fD0hYLFywmrO70lbYkH0F2tUB1qw6Qc=
X-Google-Smtp-Source: APXvYqyYJsNb2fUTvMX1aey9HiS2nq+j7H5a1ZDY46xljzHqE5l+jm4qwsIoC2J8Xc3I1lA+yV88oA==
X-Received: by 2002:adf:e790:: with SMTP id
 n16mr138639602wrm.120.1564938280652; 
 Sun, 04 Aug 2019 10:04:40 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:40 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:26 +0200
Message-Id: <752d0beb8a35abc89cbe0618a21e496c072a317e.1564925487.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 14/14] audio: fix memory leak reported by
 ASAN
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index d3c639211d..ebe49f3ca1 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1343,6 +1343,12 @@ static void free_audio_state(AudioState *s)
         qapi_free_Audiodev(s->dev);
         s->dev = NULL;
     }
+
+    if (s->ts) {
+        timer_free(s->ts);
+        s->ts = NULL;
+    }
+
     g_free(s);
 }
 
-- 
2.22.0


