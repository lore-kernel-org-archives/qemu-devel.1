Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436BDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2F4208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktJAOxZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2F4208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4SV-0005lH-Os
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uv-0002tS-EG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ut-0000jq-BR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3ut-0000is-2u
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id o18so4579870wrv.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yGxCQiMWd3+h7OUolo7+j9DrxcBH9Yz1dYvYs0gOXqo=;
 b=ktJAOxZT0NTQZfY4adOCjCLRlTRu745Q4ye3K1mJeic1SKuOrcXvZPszIl10UylYeV
 Wrn4CxbipRsBv55ISjiG2/eUKkAqC+ftZlZ+4GR5RNRCZnnpI+5/vAsttJl2gqzMHxtk
 Wl7CyVoaqymiIFFaB304cZBaNDXKPEiRRkI4DFrhDLHZsVA886wWSmnYJbDgRI0Ol1eT
 vJ4GehOVZUCWl1JIU8rtTDCujdTA66FZyuS1zJkiftBQmPErevaQn5MoFcUWdBZj1OaC
 +zo3Nu3WLpXEh0IkZ+OX50j8+Jj2hd+CEv0Fnmb2Gxt1nRWn8xMWBCx5ExiyjVgr3GfF
 EQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yGxCQiMWd3+h7OUolo7+j9DrxcBH9Yz1dYvYs0gOXqo=;
 b=V56OtbV8lpu/0XM1b4z0fcNeYvovKELfnRNvE9YuqxKvyVuPWeCIrwpyuB/rifgESh
 jZ4s0Sk+icJyrYEsHYjlTHqzGnD0v4NSm9KAiaYIAmtsjh3kVMzDGHqioKKmIjJ85dnn
 cN2zPjk9jyoE791DK3Zxo9SrwBWW6Et6T9SWY2/L1PMQcTrKIP+giJO5ZClKOLCqTPZb
 BieTtKDsCxxjYO4HlnZjki1cQgmDr6FgT6wFy6q5X2nAxeYImrBaUv1qbPLkaIHneOyc
 HhAPFjFvDIJ0NX5YG4EJA4dIFCb9UzKzdXbCu9/iy6guDzSlcroK3RAXtROcI3KjXV3g
 pqOA==
X-Gm-Message-State: APjAAAXz6oKSiBfGs//TXfzVOP+7aDWLG4/JYos2KRh6OZRmJSm/Rah6
 9Iwdwvy1PFIjuo7vgtrUCJGyZDsE
X-Google-Smtp-Source: APXvYqzT4zBmE9z9FSGlCKtuFMbF6jyyuB6ES6nDmks+9wBgGQ4wbDXhWurNYtT9cM+D02goIPv/sg==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr8973719wru.286.1568928281692; 
 Thu, 19 Sep 2019 14:24:41 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:41 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/24] paaudio: channel-map option
Date: Thu, 19 Sep 2019 23:24:29 +0200
Message-Id: <8f650662fd6cc50baaede260581aeb560eed44fb.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
index 395427422a..f3bc342f98 100644
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


