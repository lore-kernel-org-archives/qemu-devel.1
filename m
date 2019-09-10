Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C5FC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC65E21A4C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOZqGd3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC65E21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7pYk-0007DB-Tv
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 19:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWl-00052W-AT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWk-000511-Cl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:27 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:41159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i7pWk-00050h-93
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:26 -0400
Received: by mail-qt1-x843.google.com with SMTP id j10so22904831qtp.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8xjLznpUdjiS3wFXti0oZrmHBPX6ZNgdzcIw0ChVDDk=;
 b=ZOZqGd3oi/gIr+vNH4dut0PKGvIQHkcWj2uJQwQif/AvIdOE2MHMq5gyEa/8RER9d6
 eDYws+7yKrIT+Jw+2OLV57L5Rm0JWN29J1NI9qHR5chTK6Ec/Uomv6IzNskdxM8KhZCz
 QVH2ZP9WSjJY1MlwYv3Ikx/wq4bQ083nusnmKng/kVba7tkcQkoqXsdNgrxECSdiR90O
 TkH2Uv0YwULeGj0QjNIzfXUDZ1xGtK8AIZkNvC/tZHCvlFOmSkaUtoQNnE9UIIKfdYjQ
 f1Dc3Sho4eU+VDEvmpDo2pH30rd9i0k50roIe+BMAUmMeQBwClj3xmPF0kao+/YISEY2
 BEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8xjLznpUdjiS3wFXti0oZrmHBPX6ZNgdzcIw0ChVDDk=;
 b=W+IodYOs7+EH7NTXSQBXUooSO3JdcUXgVfrOADeOSvBVmD8oQ2UmUF92sOBYOchDDo
 GMZOHQcs5sOVigNYCIUJoqhS6UJqdTKVE/KKVf3uzWfQyF+J2FKiptjlP19Ck2aMpWDU
 FRKvATuaF//XGW9BfAgvtqgoLtmTofiZF8y/bASEsbrcxJ/8884Mz/txOC98xqdSJcSA
 6LHPvXjHVpQ1+hV9aW6AHkYqY7taFnPlsAMwg5MzNCrwsiwN6RCp/7op8gdlLbRdf3EW
 hwcINh8bxE/gIYpuEeK6+i6PosDQU0CTJH2L5WJi2Br5S7FeZWEQtOBNNt04YQdKPl8L
 wKSQ==
X-Gm-Message-State: APjAAAXNweQ+PZh3BUAq8C0zGNfZNQIe0SK3EH8sDE1k4rjI8vqJTAY/
 xrJ86z/Gn7bq9iAnnvuQVF0DkiSZ
X-Google-Smtp-Source: APXvYqxEH5X+fSHvuKwo33CsQAawDcb4zlR9MxmhFTuTeWR3T20SKJbtHvARSO9swlmUT2YN3PnI5w==
X-Received: by 2002:ac8:7504:: with SMTP id u4mr31682384qtq.81.1568157985570; 
 Tue, 10 Sep 2019 16:26:25 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:6ea8:1::d3])
 by smtp.gmail.com with ESMTPSA id z5sm8804535qki.55.2019.09.10.16.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 16:26:25 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 01:26:18 +0200
Message-Id: <0eadcc88b8421bb86ce2d68ac70517f920c3ad6c.1568157545.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH 1/3] audio: fix parameter dereference before
 NULL check
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

This should fix Coverity issues CID 1405305 and 1405301.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_template.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 2562bf5f00..cc4b53b5d7 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -428,8 +428,8 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioState *s = card->state;
-    AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
+    AudioState *s;
+    AudiodevPerDirectionOptions *pdo;
 
     if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
         dolog ("card=%p name=%p callback_fn=%p as=%p\n",
@@ -437,6 +437,9 @@ SW *glue (AUD_open_, TYPE) (
         goto fail;
     }
 
+    s = card->state;
+    pdo = glue(audio_get_pdo_, TYPE)(s->dev);
+
     ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
             name, as->freq, as->nchannels, as->fmt);
 
-- 
2.23.0


