Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE981C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 21:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAAC120665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 21:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1/zjX+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAC120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn8Ep-0007MV-4O
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 17:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hn8D2-0008Tc-Qz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hn8D1-0004oL-UU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hn8D1-0004nh-O6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id g67so12440895wme.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N/mwlriTgvMl6h8mnLx3KY4L68sc0uS+YQp6dXqnv9w=;
 b=l1/zjX+6cHo71kRGfu8M1KZ0nMsUq1Pk3E5d8uE2DJ28bdCgIQCTnY1t2c1fjDwj9P
 AgL+5DCrKnqtT3oXMXVqMo8RnJ3oNKnm0fqjf66dEkMxvfQUNxh3/3MjukRTDSTPJNF5
 7jSI7fD9eNWSGZURbEwBB4V6UG6zvQRzgk/uT6U/DEGCb3lXxEJe526NActVIZBh/QhZ
 2saMwP13ojZZJm+U0lppQC3MaBvGunSyA4jm1Lmw2g8FY/dZAFWt+X4pku6F8RT0R3WX
 QBcynRDnEJSCFaPHcbO+AUUmBWdPPaWYE44NUOuoIpUUfk5D0bkPru/4knu5HeGLVv9g
 oLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N/mwlriTgvMl6h8mnLx3KY4L68sc0uS+YQp6dXqnv9w=;
 b=ZUm55xIJiYNq4MrDsKoYTNG1HTMrgIasmj4vCP8sgPmedS4zWisl/cE2fPTEX8ckZr
 hAr+Cx+YC6Qbpp+N08gktq84ymVxI8X3XGZ/u+2OF07shkKYeqF6rgNhFcwkatI1nzuO
 iG8HLbtXk1RxeXxvKY3C76yDPWUQf718eYKsDrxPf/YkZ4oynjS1XndZgDH/ZxerpFze
 m7yPhrv4Qyc4OR6H09gT+6/6x41ixkxwo7YAgLBVXP16OlHGySoqy717Xsa/l9Lm5zvO
 6iBeSLyWyL1m5n6IQOFYgCE9qDjmNbjrA9kwaAk6cIQpXmtH2g4F5U2MlIuDJUmNoiPH
 JSAA==
X-Gm-Message-State: APjAAAUSBrYAjOc5iiwfFGc/yW/gbhlesgxvCOtVc0D/837aNsb5RHAB
 d2WqvjM2hEBtIsqazi/RtvytoAWf
X-Google-Smtp-Source: APXvYqw5exBddtJb8LVPsBqTMA8+h83tBDwceNuwsF3KuR5SuXsnMjIeY4VUviaQ0G4tAGD0uNKHAg==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr25209377wmc.118.1563224910646; 
 Mon, 15 Jul 2019 14:08:30 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-31ca-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:31ca::5])
 by smtp.gmail.com with ESMTPSA id n8sm11513447wro.89.2019.07.15.14.08.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 14:08:30 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:08:16 +0200
Message-Id: <f359619430318036f1a9e687af00d2bd9ef1d384.1563224628.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 14/14] audio: fix memory leak reported by
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


