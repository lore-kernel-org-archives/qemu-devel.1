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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9F1C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF0021A4C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afSA5kaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF0021A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7pZh-0008OP-2W
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 19:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWo-00054m-PD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWn-00053A-S1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:30 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i7pWn-00052y-OE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:29 -0400
Received: by mail-qt1-x843.google.com with SMTP id r15so22922300qtn.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 16:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uwyGdjJlG7jF1gyRPno8QuHyS6nZmBhawgXlLsE85NM=;
 b=afSA5kaJoc7EBZHMHQ3prQDBdLdjfcNDk3m89wnw858t8SZS/aGcm6unqkd9ubuE78
 uc+fJfRQMYmgAeYnK8y9lDLTsayzXsS181Lufa/p+R3fAr5NLqPYgdxTq0L0UzHwcRxD
 r00MvbeOMAHKnZnipaH7N+ejawo+Em5ZC0WxJW2+xeOj7rjPqaqqGF6oT6VznrCCbDRD
 1MulHlFhESvgoY1vfP595ccw30YEYeJ8T7pSb8pIW5Frrlecr/QhbaMn7CWZ9g4kNzi/
 55tJuSj87AOCodwCvh5zWzJh+1kXNhEmQfz/zfu5kl9tI5eO5SnZztO4XO+6MiZ2EFAF
 gjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uwyGdjJlG7jF1gyRPno8QuHyS6nZmBhawgXlLsE85NM=;
 b=rwWNBDyx274ClDDs7m3pfe4oEKEpB2eomLVTjO7tLKsXVmido/LF5BRw+UEH/GsrF7
 epBrjW9JmQqHEP1US4styi3wI9CC8vTHQRgi5r8YEzeZRI54IkBQujRoWHQ9KYTT/i4c
 btZN/+i0cu4IvC1D23V9Q/PeG0oKw3FLb/sb9xOhxumJuU83zCu85K2ORTCDEppBNHZg
 T9ChAwiV44qs3BzOEPyA5rRR8zhTng9I3teC0duAv0Ih+U7wWrEM0bDpEuGujZFjvf2K
 Zuo3LR2phdw3jIJNdV8cqlc1HBZYwkNGgw8hXoCVXskH9a+7vEgxfFc6b4fWzqomtpzK
 d7Gw==
X-Gm-Message-State: APjAAAW5BYpX7dlLVZfXOYjpWWbzClGs4L96t2tF9nj4JhbbO0vhQxYe
 W8XwbPOoNEDTV59SSkk54iWzUGhl
X-Google-Smtp-Source: APXvYqynxefTpNIKyL4VutnTiZvduSvsA0k2Dko3LUJu7Lt2cjhecFqfBZdFTtAjCA5/JIpntbAqUg==
X-Received: by 2002:a0c:e946:: with SMTP id n6mr20483055qvo.214.1568157989212; 
 Tue, 10 Sep 2019 16:26:29 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:6ea8:1::d3])
 by smtp.gmail.com with ESMTPSA id z5sm8804535qki.55.2019.09.10.16.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 16:26:28 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 01:26:20 +0200
Message-Id: <2d6e337c474ac84172d0809e6959c26b21d48120.1568157545.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH 3/3] audio: paaudio: ability to specify stream
 name
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can be used to identify stream in tools like pavucontrol when one
creates multiple -audiodevs or runs multiple qemu instances.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 4 ++--
 qapi/audio.json | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 19b7e39092..d9cff9a2be 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -563,7 +563,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     pa->stream = qpa_simple_new (
         c,
-        g->dev->id,
+        ppdo->has_stream_name ? ppdo->stream_name : g->dev->id,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -631,7 +631,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     pa->stream = qpa_simple_new (
         c,
-        g->dev->id,
+        ppdo->has_stream_name ? ppdo->stream_name : g->dev->id,
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
diff --git a/qapi/audio.json b/qapi/audio.json
index 9fefdf5186..e45218f081 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -206,6 +206,11 @@
 #
 # @name: name of the sink/source to use
 #
+# @stream-name: name of the PulseAudio stream created by qemu.  Can be
+#               used to identify the stream in PulseAudio when you
+#               create multiple PulseAudio devices or run multiple qemu
+#               instances (default: audiodev's id, since 4.2)
+#
 # @latency: latency you want PulseAudio to achieve in microseconds
 #           (default 15000)
 #
@@ -215,6 +220,7 @@
   'base': 'AudiodevPerDirectionOptions',
   'data': {
     '*name': 'str',
+    '*stream-name': 'str',
     '*latency': 'uint32' } }
 
 ##
-- 
2.23.0


