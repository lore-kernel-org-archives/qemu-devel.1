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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE1C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF8B206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA1XtM/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2LCi-0007ck-Dg
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8v-0004qH-C5
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8u-0000jK-C3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:09 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2L8u-0000iv-8D
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:08 -0400
Received: by mail-qt1-x842.google.com with SMTP id l9so19143524qtu.6
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yftoTHEZncMaes6MKHaraCxxOc0UbFsAz6f8Z9AKcbY=;
 b=gA1XtM/JyQge0lffTmzAl5AVbGjBGarmtMs/JqCH3gFv/Onxp5aTN2UxFn/3IuTzo7
 B7qndKdJOrAb7aghNkEoXiq+Wtuff4aaNbsh5O0sLOF7IrApeDyGo0VYmVk2Rz3dSF0r
 bQi8O9eXUVFz0a6ZhDlhGWAdhF7ak8k6zGVWk3xcK8a/hw9jSFclfl+6Dv8SGJVByXDG
 fZtD4i25XHIKE7tuvVAPeKKexNjQccJWJFA7uE35ByFpaRybxxItWWAEmw3wp1luXZ8i
 efCfXWNFF2ceHlS+HNgHVokTF6JnykbQYs8E4VbatTWWym6fUhge0GMoZb0Tjo/iWm+m
 DeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yftoTHEZncMaes6MKHaraCxxOc0UbFsAz6f8Z9AKcbY=;
 b=UjLQFoyNdN7WuY3vYzvWsY53EklEGtfxxCA7Tayxe996mIgPd+KYyOmWKY9eQWJBjX
 NvO1CcSzh5hQNiyk+xABlC6UaIcMxgNBrmBc86iqAOzvucQQxkmLEI2xSUUOMq7Cl7EW
 rZErQi7F0xLIa/pZy/U0P4XAFR00gISigtE+AdJBLHJ0efxu7C9f36EgPyih76BHBLHS
 C2Jr8/4rVyNLoxNOTZNSAnaz43U92qsNM92YPeFZ1HIkkPY8ngQfun4n69AoSebtojfo
 x7jF6+kmZq1GDD6qGdKsix7No8EmuFj8lIzJj8BznEdV4O/SIR3Rv6dBKJchgz5F2lSU
 xgJg==
X-Gm-Message-State: APjAAAUs0SVM831noobWxVL/MHKh432Uc55ijKYwxRCO4jgEfTL9Otdw
 yNIyRSD5SileEojC3j6kVndh4VhxbAQ=
X-Google-Smtp-Source: APXvYqzq156ZtY69l0bAfOcoVoDskG/sNLBCo8Q3K/TNH0DeIjWXHS5Kaol2CkRzXlsQ3ul25LgNKQ==
X-Received: by 2002:aed:2fe6:: with SMTP id m93mr19492384qtd.114.1566849547548; 
 Mon, 26 Aug 2019 12:59:07 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id v7sm6795459qte.86.2019.08.26.12.59.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 12:59:07 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 21:59:01 +0200
Message-Id: <7808bc816ba7da8b8de8a214713444d85f7af3c6.1566847960.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v2 1/4] audio: fix invalid malloc size in
 audio_create_pdos
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

The code used sizeof(AudiodevAlsaPerDirectionOptions) instead of the
appropriate per direction options for the audio backend.  If the size of
the actual audiodev's per direction options are larger than alsa's, it
could cause a buffer overflow.

However, alsa has three fields in per direction options: a string, an
uint32 and a bool.  Oss has the same fields, coreaudio has a single
uint32, paaudio has a string and an uint32, all other backends only use
the common options, so currently no per direction options struct should
be larger than alsa's.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7d715332c9..ae335dbebb 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1685,7 +1685,7 @@ void audio_create_pdos(Audiodev *dev)
         }                                                           \
         if (!dev->u.driver.has_out) {                               \
             dev->u.driver.out = g_malloc0(                          \
-                sizeof(AudiodevAlsaPerDirectionOptions));           \
+                sizeof(Audiodev##pdo_name##PerDirectionOptions));   \
             dev->u.driver.has_out = true;                           \
         }                                                           \
         break
-- 
2.22.0


