Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C075C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389A02184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3/CHfOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389A02184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2LEi-0001GL-5T
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8x-0004sx-JH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8w-0000kk-L3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:11 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:46053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2L8w-0000ka-HM
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:10 -0400
Received: by mail-qk1-x741.google.com with SMTP id m2so15095708qki.12
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZOgPcO45w+lAd8b5mAaLnclR6mwgfXcXmo8jMMQhxfA=;
 b=L3/CHfOt8zgMPb93Ex2QfdJ+MiVLU1UxfH1qqA8z8C5/5Xr706RvoY1w9e3CHQhqk1
 IBjlvsz2DioOTBoJAKR+zRuQ/X8ytfPXtsYttyvHVqXIQhXjW5cLWrCvKZLym5XsnrVA
 mljtVPCDwFdpuRH0uVU1X/AeabGzXbon4RDEqEMeX14JELYquNGCgi4nUlu8o9kwKbO9
 o4X+km2YgW/stjnYXVoEF7BC1MZuavY25ghc2/+64nq/gsiUQfwMp/uZBaqjexCcWlSL
 XEpyrt9kY2I/R1YLVOFLHPs7M+G8jhxTCjeHLby2rifoR2Bsn4bppL63lPhi4XmXIR74
 4Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZOgPcO45w+lAd8b5mAaLnclR6mwgfXcXmo8jMMQhxfA=;
 b=troovqYq+9LD7T1LIQmJmcWq2poSKl0oTj3Sf2xJHVcBPJDbOu3VCwF8jyD5iZhtz3
 FYXUHym5O0dUtOaavNEV4Rr1ZcLCE0tcfoHkHYMQzuejHpqwvvRR8z7TFXschr51c8G4
 SzBFuUY2/aV/FnOcrLRwYEgQ0lARvoSEW+T1AXeLV/Sun8CuHtWnph87pBeNO2Fq5SnV
 uy/Wcb3txsp+l4rSS9fdbWqjneWwf0GUfK0kHU0vOa8SPh+diT4omI3Zbh70cj+keD7j
 npynCIH+dttodsaZxr0iYuZNGlCKIhBezC3Iiz+lxY1NqcfJUKEQfwXEe+rWlRU/Dh28
 Wu+w==
X-Gm-Message-State: APjAAAXW/mJ738QzApWl0diZPEnn1fMW7Z+GyF+Nd0oW5xs+/vmLhr6U
 ojt4nEpQpmV2t8r6hvXXttrSz1RQTx0=
X-Google-Smtp-Source: APXvYqyKXFCAch8fa4tAO5RdzHHmb1+iSHa6/gwPpvaP2/ZoSVBzXUx8EOMRxKdjkza1F3HfiPhSOw==
X-Received: by 2002:a05:620a:7c8:: with SMTP id
 8mr17335619qkb.424.1566849550046; 
 Mon, 26 Aug 2019 12:59:10 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id v7sm6795459qte.86.2019.08.26.12.59.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 12:59:09 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 21:59:03 +0200
Message-Id: <f7c0fa20f3ee3c10409bde0d474fc2a47177838d.1566847960.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v2 3/4] audio: paaudio: fix client name
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pa_context_new expects a client name, not a server socket path.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 audio/paaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index bfef9acaad..777b8e4718 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -866,7 +866,7 @@ static void *qpa_conn_init(const char *server)
     }
 
     c->context = pa_context_new(pa_threaded_mainloop_get_api(c->mainloop),
-                                server);
+                                "qemu");
     if (!c->context) {
         goto fail;
     }
-- 
2.22.0


