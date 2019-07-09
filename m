Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E6C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054632082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBZ/ZEaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054632082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvRk-0008IW-TL
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyP-0004L1-FH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyK-0003f0-C4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyJ-0003Ua-P0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so4280649wma.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yEw1lXf6KF00BmxTMCjGr7FoL6nKQ6cuLcyNA5vjh7c=;
 b=FBZ/ZEaVWC4KDK19YoWNTR2+WaRjkBSYzyAHhEOjqzdmwz3Rc1HqFWOyEK4bbm/ceL
 92epDlCIeCaHC9lPKEGt2mC/6uXJUUgJXoWxrl2ywM1GZ8PCjcuLq85j/JrCBIfF9WU2
 3kJdCo26FxxEyfBELs/WlMxuCHvp86a12fLDsWdA6wZroxDNpvMopwUS539q2422nflf
 WWwaUdlb0DGKAKm2OjgerV2kjgh6vQ2XFdcTpk2RzWqOry60uN/xMUVMLKsu+AlmJRoE
 RTzwNyn71TNonHK8y1XBg/PenhaoK+4lbE3o0biXCfYdZxX/N8h/oRbr+3zfe498hgfK
 eaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yEw1lXf6KF00BmxTMCjGr7FoL6nKQ6cuLcyNA5vjh7c=;
 b=WzYNk/0nJ1SBvRgiG8zKFPdgGtU1jgbv26DdXex1P3M+AKuu/ocaFqF+f/elIwFsaS
 B8aIQBphil5yvdQI3ow7zsUxdfrkg+ocielBkVQyKkVePVbC6S8d1lueDGzo+ieahvSD
 6RhdZGftpW2QsKQnQ8Vvq7ZaDv3JsH97m0GYe0S0x5MeZnYI1DWkboXeSlz+ydOdKHRt
 uoBsFnN/Tk9u6nI1rT4gLXp3TH/5Qe27leoWJZoimONwErdOSs6ycOZnZjrvK3hhtSTM
 lUJGOc91tFMWhP7t69ZSrC5zAXJM/JtUmQqN9Uq+XgLyuTFD8VPb5/XHhmgAhirHsVmh
 0Xyg==
X-Gm-Message-State: APjAAAVtIy3tv6cKUMiUO77u3Ry6q/hMVvI5oifuko6Lu5P5yeyf5SBS
 2HtYk3qGlc9H/WfxiOUhvQHxphu4
X-Google-Smtp-Source: APXvYqxGz45ivc57xoLsqEsVZA29eGZ2hwwtfuvpjkM9paSb2N8Yc5cCsqOcLoe1P54zHWejjtj1nw==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr984680wmf.35.1562697354443;
 Tue, 09 Jul 2019 11:35:54 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:54 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:42 +0200
Message-Id: <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 02/11] audio: basic support for multi backend
 audio
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Audio functions no longer access glob_audio_state, instead they get an
AudioState as a parameter.  This is required in order to support
multiple backends.

glob_audio_state is also gone, and replaced with a tailq so we can store
more than one states.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.h          |  12 +++--
 audio/audio_int.h      |   2 +
 audio/audio_template.h |   2 +-
 ui/vnc.h               |   2 +
 audio/audio.c          | 102 +++++++++++++++++++++++++++++++----------
 audio/wavcapture.c     |   6 +--
 monitor/misc.c         |  12 ++++-
 ui/vnc.c               |  15 +++++-
 hmp-commands.hx        |  11 +++--
 qemu-options.hx        |   5 ++
 10 files changed, 131 insertions(+), 38 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 64b0f761bc..ad2457f4de 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -78,8 +78,10 @@ typedef struct SWVoiceOut SWVoiceOut;
 typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
+typedef struct AudioState AudioState;
 typedef struct QEMUSoundCard {
     char *name;
+    AudioState *state;
     QLIST_ENTRY (QEMUSoundCard) entries;
 } QEMUSoundCard;
 
@@ -92,7 +94,8 @@ void AUD_log (const char *cap, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 void AUD_register_card (const char *name, QEMUSoundCard *card);
 void AUD_remove_card (QEMUSoundCard *card);
-CaptureVoiceOut *AUD_add_capture (
+CaptureVoiceOut *AUD_add_capture(
+    AudioState *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *opaque
@@ -160,8 +163,8 @@ static inline void *advance (void *p, int incr)
 #define audio_MAX(a, b) ((a)<(b)?(b):(a))
 #endif
 
-int wav_start_capture (CaptureState *s, const char *path, int freq,
-                       int bits, int nchannels);
+int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+                      int freq, int bits, int nchannels);
 
 bool audio_is_cleaning_up(void);
 void audio_cleanup(void);
@@ -175,4 +178,7 @@ void audio_parse_option(const char *opt);
 void audio_init_audiodevs(void);
 void audio_legacy_help(void);
 
+AudioState *audio_state_by_name(const char *name);
+const char *audio_get_id(QEMUSoundCard *card);
+
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8164696b2c..9f01f6ad00 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -196,6 +196,8 @@ typedef struct AudioState {
 
     bool timer_running;
     uint64_t timer_last;
+
+    QTAILQ_ENTRY(AudioState) list;
 } AudioState;
 
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index c721fed75d..54f07338e7 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -428,7 +428,7 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioState *s = &glob_audio_state;
+    AudioState *s = card->state;
     AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
 
     if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
diff --git a/ui/vnc.h b/ui/vnc.h
index 2f84db3142..6f54653455 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -183,6 +183,8 @@ struct VncDisplay
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
 #endif
+
+    AudioState *audio_state;
 };
 
 typedef struct VncTight {
diff --git a/audio/audio.c b/audio/audio.c
index 8d2f580788..e9dd7c8b32 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -87,7 +87,8 @@ audio_driver *audio_driver_lookup(const char *name)
     return NULL;
 }
 
-static AudioState glob_audio_state;
+static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =
+    QTAILQ_HEAD_INITIALIZER(audio_states);
 
 const struct mixeng_volume nominal_volume = {
     .mute = 0,
@@ -1236,11 +1237,14 @@ static void audio_run_capture (AudioState *s)
 
 void audio_run (const char *msg)
 {
-    AudioState *s = &glob_audio_state;
+    AudioState *s;
+
+    QTAILQ_FOREACH(s, &audio_states, list) {
+        audio_run_out(s);
+        audio_run_in(s);
+        audio_run_capture(s);
+    }
 
-    audio_run_out (s);
-    audio_run_in (s);
-    audio_run_capture (s);
 #ifdef DEBUG_POLL
     {
         static double prevtime;
@@ -1304,13 +1308,11 @@ bool audio_is_cleaning_up(void)
     return is_cleaning_up;
 }
 
-void audio_cleanup(void)
+static void free_audio_state(AudioState *s)
 {
-    AudioState *s = &glob_audio_state;
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
-    is_cleaning_up = true;
     QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
 
@@ -1347,6 +1349,17 @@ void audio_cleanup(void)
         qapi_free_Audiodev(s->dev);
         s->dev = NULL;
     }
+    g_free(s);
+}
+
+void audio_cleanup(void)
+{
+    is_cleaning_up = true;
+    while (!QTAILQ_EMPTY(&audio_states)) {
+        AudioState *s = QTAILQ_FIRST(&audio_states);
+        QTAILQ_REMOVE(&audio_states, s, list);
+        free_audio_state(s);
+    }
 }
 
 static const VMStateDescription vmstate_audio = {
@@ -1373,28 +1386,33 @@ static AudiodevListEntry *audiodev_find(
     return NULL;
 }
 
-static int audio_init(Audiodev *dev)
+/*
+ * if we have dev, this function was called because of an -audiodev argument =>
+ *   initialize a new state with it
+ * if dev == NULL => legacy implicit initialization, return the already created
+ *   state or create a new one
+ */
+static AudioState *audio_init(Audiodev *dev)
 {
+    static bool atexit_registered;
     size_t i;
     int done = 0;
     const char *drvname = NULL;
     VMChangeStateEntry *e;
-    AudioState *s = &glob_audio_state;
+    AudioState *s;
     struct audio_driver *driver;
     /* silence gcc warning about uninitialized variable */
     AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
 
-    if (s->drv) {
-        if (dev) {
-            dolog("Cannot create more than one audio backend, sorry\n");
-            qapi_free_Audiodev(dev);
-        }
-        return -1;
-    }
-
     if (dev) {
         /* -audiodev option */
         drvname = AudiodevDriver_str(dev->driver);
+    } else if (!QTAILQ_EMPTY(&audio_states)) {
+        /*
+         * todo: check for -audiodev once we have normal audiodev selection
+         * support
+         */
+        return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
         head = audio_handle_legacy_opts();
@@ -1408,12 +1426,18 @@ static int audio_init(Audiodev *dev)
         dev = QSIMPLEQ_FIRST(&head)->dev;
         audio_validate_opts(dev, &error_abort);
     }
+
+    s = g_malloc0(sizeof(AudioState));
     s->dev = dev;
 
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
-    atexit(audio_cleanup);
+    if (!atexit_registered) {
+        atexit(audio_cleanup);
+        atexit_registered = true;
+    }
+    QTAILQ_INSERT_TAIL(&audio_states, s, list);
 
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
@@ -1478,7 +1502,7 @@ static int audio_init(Audiodev *dev)
 
     QLIST_INIT (&s->card_head);
     vmstate_register (NULL, 0, &vmstate_audio, s);
-    return 0;
+    return s;
 }
 
 void audio_free_audiodev_list(AudiodevListHead *head)
@@ -1493,10 +1517,13 @@ void audio_free_audiodev_list(AudiodevListHead *head)
 
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
-    audio_init(NULL);
+    if (!card->state) {
+        card->state = audio_init(NULL);
+    }
+
     card->name = g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD (&glob_audio_state.card_head, card, entries);
+    QLIST_INSERT_HEAD (&card->state->card_head, card, entries);
 }
 
 void AUD_remove_card (QEMUSoundCard *card)
@@ -1506,16 +1533,21 @@ void AUD_remove_card (QEMUSoundCard *card)
 }
 
 
-CaptureVoiceOut *AUD_add_capture (
+CaptureVoiceOut *AUD_add_capture(
+    AudioState *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *cb_opaque
     )
 {
-    AudioState *s = &glob_audio_state;
     CaptureVoiceOut *cap;
     struct capture_callback *cb;
 
+    if (!s) {
+        /* todo: remove when we have normal audiodev selection support */
+        s = audio_init(NULL);
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\n");
         audio_print_settings (as);
@@ -1805,3 +1837,25 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
     return audio_buffer_samples(pdo, as, def_usecs) *
         audioformat_bytes_per_sample(as->fmt);
 }
+
+AudioState *audio_state_by_name(const char *name)
+{
+    AudioState *s;
+    QTAILQ_FOREACH(s, &audio_states, list) {
+        assert(s->dev);
+        if (strcmp(name, s->dev->id) == 0) {
+            return s;
+        }
+    }
+    return NULL;
+}
+
+const char *audio_get_id(QEMUSoundCard *card)
+{
+    if (card->state) {
+        assert(card->state->dev);
+        return card->state->dev->id;
+    } else {
+        return "";
+    }
+}
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 74320dfecc..81c5c19032 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -105,8 +105,8 @@ static struct capture_ops wav_capture_ops = {
     .info = wav_capture_info
 };
 
-int wav_start_capture (CaptureState *s, const char *path, int freq,
-                       int bits, int nchannels)
+int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+                      int freq, int bits, int nchannels)
 {
     WAVState *wav;
     uint8_t hdr[] = {
@@ -171,7 +171,7 @@ int wav_start_capture (CaptureState *s, const char *path, int freq,
         goto error_free;
     }
 
-    cap = AUD_add_capture (&as, &ops, wav);
+    cap = AUD_add_capture(state, &as, &ops, wav);
     if (!cap) {
         error_report("Failed to add audio capture");
         goto error_free;
diff --git a/monitor/misc.c b/monitor/misc.c
index 00338c002a..f97810d370 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1148,7 +1148,17 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     int bits = qdict_get_try_int(qdict, "bits", -1);
     int has_channels = qdict_haskey(qdict, "nchannels");
     int nchannels = qdict_get_try_int(qdict, "nchannels", -1);
+    const char *audiodev = qdict_get_try_str(qdict, "audiodev");
     CaptureState *s;
+    AudioState *as = NULL;
+
+    if (audiodev) {
+        as = audio_state_by_name(audiodev);
+        if (!as) {
+            monitor_printf(mon, "Invalid audiodev specified\n");
+            return;
+        }
+    }
 
     s = g_malloc0 (sizeof (*s));
 
@@ -1156,7 +1166,7 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     bits = has_bits ? bits : 16;
     nchannels = has_channels ? nchannels : 2;
 
-    if (wav_start_capture (s, path, freq, bits, nchannels)) {
+    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
         monitor_printf(mon, "Failed to add wave capture\n");
         g_free (s);
         return;
diff --git a/ui/vnc.c b/ui/vnc.c
index 38f92bfca3..24f9be5b5d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
     ops.destroy = audio_capture_destroy;
     ops.capture = audio_capture;
 
-    vs->audio_cap = AUD_add_capture(&vs->as, &ops, vs);
+    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "non-adaptive",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "audiodev",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **errp)
     const char *saslauthz;
     int lock_key_sync = 1;
     int key_delay_ms;
+    const char *audiodev;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **errp)
     }
     vd->ledstate = 0;
 
+    audiodev = qemu_opt_get(opts, "audiodev");
+    if (audiodev) {
+        vd->audio_state = audio_state_by_name(audiodev);
+        if (!vd->audio_state) {
+            error_setg(errp, "Audiodev '%s' not found", audiodev);
+            goto fail;
+        }
+    }
+
     device_id = qemu_opt_get(opts, "display");
     if (device_id) {
         int head = qemu_opt_get_number(opts, "head", 0);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index bfa5681dd2..23196da3fe 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -819,16 +819,17 @@ ETEXI
 
     {
         .name       = "wavcapture",
-        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?",
-        .params     = "path [frequency [bits [channels]]]",
+        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?",
+        .params     = "path [frequency [bits [channels [audiodev]]]]",
         .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
         .cmd        = hmp_wavcapture,
     },
 STEXI
-@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels}]]]
+@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels} [@var{audiodev}]]]]
 @findex wavcapture
-Capture audio into @var{filename}. Using sample rate @var{frequency}
-bits per sample @var{bits} and number of channels @var{channels}.
+Capture audio into @var{filename} from @var{audiodev}. Using sample rate
+@var{frequency} bits per sample @var{bits} and number of channels
+@var{channels}.
 
 Defaults:
 @itemize @minus
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0..0111055aa4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1978,6 +1978,11 @@ can help the device and guest to keep up and not lose events in case
 events are arriving in bulk.  Possible causes for the latter are flaky
 network connections, or scripts for automated testing.
 
+@item audiodev=@var{audiodev}
+
+Use the specified @var{audiodev} when the VNC client requests audio
+transmission.
+
 @end table
 ETEXI
 
-- 
2.22.0


