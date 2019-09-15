Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB3C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9809921479
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uggAw7Vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9809921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aSz-0004WK-Qy
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7r-0006GX-M3
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7q-000235-E7
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:59 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7q-00022q-6o
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:58 -0400
Received: by mail-ed1-x541.google.com with SMTP id y91so31230566ede.9
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F6I/soIJaEjYxfRI9EDWkY2N9iUGEIeYzLkqeKMKgzM=;
 b=uggAw7VyF5bomrgCYRcPQvEYvbRjxY0l/aET2ssc3qVreA0SUk2n7m+DhmO9G44eT3
 YXCFn1/6qhhY3MH2YQNFfNVrn04EJox2OmYjZn7SHdtIhsLYyAbGYV4N/yeoxCyJW6B7
 z4z5m5qj//wU6vx/1yN7+DTcOpfNlL7DXyzNx8HDRyEecmTZ711cw9Bt/rasn+zACpYB
 +3wDdK5kK+6VjGIOBxag62gvCRGcNQuciFiWOjmGioExuL5mhnPTHpntY0xhkHw/sDmR
 JYDrpFJDIzr12cBCXeWxdq8lmPwwZO2EGbM0QRpINpzhmrn7l5a3gTVZn/4fiHQwgQq2
 lA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F6I/soIJaEjYxfRI9EDWkY2N9iUGEIeYzLkqeKMKgzM=;
 b=lbhp3vJKLjhW+n3phQHF+uoEiagBbd9Z5skDKAN2vwqgrCBkIkI5pVm4KQN++QiOR/
 FmaSbUu8ZqhxIRTXrZcRi303v1reGQ0qWmeuaqrwVbCGxq9g1xIUlCwyAdTP+Bp5eE5v
 peSz8p0MaQTHQUa6KxozbcZr8+dsEgPEN1i/LMvaOsshHbXGoT6PE3iBfUOl4k/7QwO3
 mSQp/4oOdf7HmgHLauO5jX5+MlVti/W/JWpxdSzNslumepV2OdS5phRdLftrCzDWo/Az
 vJMbkHXeWL9Pv51N9HMyble3DGIt+K4ZHHFBzsdOOSyGBPQ4EkTDF7jWuIQxnCbmDNQn
 aTIQ==
X-Gm-Message-State: APjAAAXbLnmCGaHWvl1Hc5lpo/LZEKtWb7viq73iyB0yJ+snS0Z7DojK
 7oN0F+qYH5MM/QcXHdozKDB8mTQg
X-Google-Smtp-Source: APXvYqx8bEKfNQ7yDzi2XR4/PMTVT0tG2C7VVEtiZKDPmdwwlE7dlJ0EKqWr3B5JlydHGweY7QQi3w==
X-Received: by 2002:a50:e70c:: with SMTP id a12mr58020237edn.73.1568575437084; 
 Sun, 15 Sep 2019 12:23:57 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:56 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:37 +0200
Message-Id: <66670d43bd932be0919668cec6a8cd172bfb8383.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: [Qemu-devel] [PATCH v3 21/24] paaudio: channel-map option
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option to change the channel map used by pulseaudio.  If not
specified, falls back to an OSS compatible channel map.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 18 ++++++++++++++----
 qapi/audio.json |  7 +++++--
 qemu-options.hx |  9 +++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index d195b1caa8..20402b0718 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -338,17 +338,27 @@ static pa_stream *qpa_simple_new (
         pa_stream_direction_t dir,
         const char *dev,
         const pa_sample_spec *ss,
-        const pa_channel_map *map,
+        const char *map,
         const pa_buffer_attr *attr,
         int *rerror)
 {
     int r;
     pa_stream *stream;
     pa_stream_flags_t flags;
+    pa_channel_map pa_map;
 
     pa_threaded_mainloop_lock(c->mainloop);
 
-    stream = pa_stream_new(c->context, name, ss, map);
+    if (map && !pa_channel_map_parse(&pa_map, map)) {
+        dolog("Invalid channel map specified: '%s'\n", map);
+        map = NULL;
+    }
+    if (!map) {
+        pa_channel_map_init_extend(&pa_map, ss->channels,
+                                   PA_CHANNEL_MAP_OSS);
+    }
+
+    stream = pa_stream_new(c->context, name, ss, &pa_map);
     if (!stream) {
         goto fail;
     }
@@ -421,7 +431,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
+        ppdo->has_channel_map ? ppdo->channel_map : NULL,
         &ba,                    /* buffering attributes */
         &error
         );
@@ -470,7 +480,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
+        ppdo->has_channel_map ? ppdo->channel_map : NULL,
         &ba,                    /* buffering attributes */
         &error
         );
diff --git a/qapi/audio.json b/qapi/audio.json
index 0535eff794..07003808cb 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -214,13 +214,16 @@
 # @latency: latency you want PulseAudio to achieve in microseconds
 #           (default 15000)
 #
+# @channel-map: channel map to use (default: OSS compatible map, since: 4.2)
+#
 # Since: 4.0
 ##
 { 'struct': 'AudiodevPaPerDirectionOptions',
   'base': 'AudiodevPerDirectionOptions',
   'data': {
-    '*name': 'str',
-    '*latency': 'uint32' } }
+    '*name':        'str',
+    '*latency':     'uint32',
+    '*channel-map': 'str' } }
 
 ##
 # @AudiodevPaOptions:
diff --git a/qemu-options.hx b/qemu-options.hx
index 734a3b5d65..6aee778896 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -471,6 +471,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "-audiodev pa,id=id[,prop[=value][,...]]\n"
     "                server= PulseAudio server address\n"
     "                in|out.name= source/sink device name\n"
+    "                in|out.channel-map= channel map to use\n"
 #endif
 #ifdef CONFIG_AUDIO_SDL
     "-audiodev sdl,id=id[,prop[=value][,...]]\n"
@@ -636,6 +637,14 @@ Sets the PulseAudio @var{server} to connect to.
 @item in|out.name=@var{sink}
 Use the specified source/sink for recording/playback.
 
+@item in|out.channel-map=@var{map}
+Use the specified channel map.  The default is an OSS compatible
+channel map.  Do not forget to escape commas inside the map:
+
+@example
+-audiodev pa,id=example,sink.channel-map=front-left,,front-right
+@end example
+
 @end table
 
 @item -audiodev sdl,id=@var{id}[,@var{prop}[=@var{value}][,...]]
-- 
2.23.0


