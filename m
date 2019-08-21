Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB82AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FF422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FF422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MJX-0005WZ-Dq
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0MBJ-0003qS-R5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0MBH-00055W-Ro
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0MBH-00054v-Ha
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D185E2A09B7;
 Wed, 21 Aug 2019 08:41:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 816826B49A;
 Wed, 21 Aug 2019 08:41:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8C4D55EFA; Wed, 21 Aug 2019 10:41:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:41:01 +0200
Message-Id: <20190821084113.1840-4-kraxel@redhat.com>
In-Reply-To: <20190821084113.1840-1-kraxel@redhat.com>
References: <20190821084113.1840-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 21 Aug 2019 08:41:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/15] audio: basic support for multi backend
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Audio functions no longer access glob_audio_state, instead they get an
AudioState as a parameter.  This is required in order to support
multiple backends.

glob_audio_state is also gone, and replaced with a tailq so we can store
more than one states.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 67aef54f9e729a7160fe95c465351115e392164b.1566168923.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.h          |  12 +++--
 audio/audio_int.h      |   2 +
 audio/audio_template.h |   2 +-
 audio/audio.c          | 102 +++++++++++++++++++++++++++++++----------
 audio/wavcapture.c     |   6 +--
 monitor/misc.c         |   2 +-
 ui/vnc.c               |   2 +-
 7 files changed, 95 insertions(+), 33 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 64b0f761bcaa..ad2457f4de95 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -78,8 +78,10 @@ typedef struct SWVoiceOut SWVoiceOut;
 typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
=20
+typedef struct AudioState AudioState;
 typedef struct QEMUSoundCard {
     char *name;
+    AudioState *state;
     QLIST_ENTRY (QEMUSoundCard) entries;
 } QEMUSoundCard;
=20
@@ -92,7 +94,8 @@ void AUD_log (const char *cap, const char *fmt, ...) GC=
C_FMT_ATTR(2, 3);
=20
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
=20
-int wav_start_capture (CaptureState *s, const char *path, int freq,
-                       int bits, int nchannels);
+int wav_start_capture(AudioState *state, CaptureState *s, const char *pa=
th,
+                      int freq, int bits, int nchannels);
=20
 bool audio_is_cleaning_up(void);
 void audio_cleanup(void);
@@ -175,4 +178,7 @@ void audio_parse_option(const char *opt);
 void audio_init_audiodevs(void);
 void audio_legacy_help(void);
=20
+AudioState *audio_state_by_name(const char *name);
+const char *audio_get_id(QEMUSoundCard *card);
+
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8164696b2c4a..9f01f6ad002c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -196,6 +196,8 @@ typedef struct AudioState {
=20
     bool timer_running;
     uint64_t timer_last;
+
+    QTAILQ_ENTRY(AudioState) list;
 } AudioState;
=20
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index c721fed75d7d..54f07338e76f 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -428,7 +428,7 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioState *s =3D &glob_audio_state;
+    AudioState *s =3D card->state;
     AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(s->d=
ev);
=20
     if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
diff --git a/audio/audio.c b/audio/audio.c
index 5aee54500e8e..17ef4f498fcd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -87,7 +87,8 @@ audio_driver *audio_driver_lookup(const char *name)
     return NULL;
 }
=20
-static AudioState glob_audio_state;
+static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =3D
+    QTAILQ_HEAD_INITIALIZER(audio_states);
=20
 const struct mixeng_volume nominal_volume =3D {
     .mute =3D 0,
@@ -1238,11 +1239,14 @@ static void audio_run_capture (AudioState *s)
=20
 void audio_run (const char *msg)
 {
-    AudioState *s =3D &glob_audio_state;
+    AudioState *s;
+
+    QTAILQ_FOREACH(s, &audio_states, list) {
+        audio_run_out(s);
+        audio_run_in(s);
+        audio_run_capture(s);
+    }
=20
-    audio_run_out (s);
-    audio_run_in (s);
-    audio_run_capture (s);
 #ifdef DEBUG_POLL
     {
         static double prevtime;
@@ -1306,13 +1310,11 @@ bool audio_is_cleaning_up(void)
     return is_cleaning_up;
 }
=20
-void audio_cleanup(void)
+static void free_audio_state(AudioState *s)
 {
-    AudioState *s =3D &glob_audio_state;
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
=20
-    is_cleaning_up =3D true;
     QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
=20
@@ -1349,6 +1351,17 @@ void audio_cleanup(void)
         qapi_free_Audiodev(s->dev);
         s->dev =3D NULL;
     }
+    g_free(s);
+}
+
+void audio_cleanup(void)
+{
+    is_cleaning_up =3D true;
+    while (!QTAILQ_EMPTY(&audio_states)) {
+        AudioState *s =3D QTAILQ_FIRST(&audio_states);
+        QTAILQ_REMOVE(&audio_states, s, list);
+        free_audio_state(s);
+    }
 }
=20
 static const VMStateDescription vmstate_audio =3D {
@@ -1375,28 +1388,33 @@ static AudiodevListEntry *audiodev_find(
     return NULL;
 }
=20
-static int audio_init(Audiodev *dev)
+/*
+ * if we have dev, this function was called because of an -audiodev argu=
ment =3D>
+ *   initialize a new state with it
+ * if dev =3D=3D NULL =3D> legacy implicit initialization, return the al=
ready created
+ *   state or create a new one
+ */
+static AudioState *audio_init(Audiodev *dev)
 {
+    static bool atexit_registered;
     size_t i;
     int done =3D 0;
     const char *drvname =3D NULL;
     VMChangeStateEntry *e;
-    AudioState *s =3D &glob_audio_state;
+    AudioState *s;
     struct audio_driver *driver;
     /* silence gcc warning about uninitialized variable */
     AudiodevListHead head =3D QSIMPLEQ_HEAD_INITIALIZER(head);
=20
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
         drvname =3D AudiodevDriver_str(dev->driver);
+    } else if (!QTAILQ_EMPTY(&audio_states)) {
+        /*
+         * todo: check for -audiodev once we have normal audiodev select=
ion
+         * support
+         */
+        return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
         head =3D audio_handle_legacy_opts();
@@ -1410,12 +1428,18 @@ static int audio_init(Audiodev *dev)
         dev =3D QSIMPLEQ_FIRST(&head)->dev;
         audio_validate_opts(dev, &error_abort);
     }
+
+    s =3D g_malloc0(sizeof(AudioState));
     s->dev =3D dev;
=20
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
-    atexit(audio_cleanup);
+    if (!atexit_registered) {
+        atexit(audio_cleanup);
+        atexit_registered =3D true;
+    }
+    QTAILQ_INSERT_TAIL(&audio_states, s, list);
=20
     s->ts =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
=20
@@ -1480,7 +1504,7 @@ static int audio_init(Audiodev *dev)
=20
     QLIST_INIT (&s->card_head);
     vmstate_register (NULL, 0, &vmstate_audio, s);
-    return 0;
+    return s;
 }
=20
 void audio_free_audiodev_list(AudiodevListHead *head)
@@ -1495,10 +1519,13 @@ void audio_free_audiodev_list(AudiodevListHead *h=
ead)
=20
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
-    audio_init(NULL);
+    if (!card->state) {
+        card->state =3D audio_init(NULL);
+    }
+
     card->name =3D g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD (&glob_audio_state.card_head, card, entries);
+    QLIST_INSERT_HEAD(&card->state->card_head, card, entries);
 }
=20
 void AUD_remove_card (QEMUSoundCard *card)
@@ -1508,16 +1535,21 @@ void AUD_remove_card (QEMUSoundCard *card)
 }
=20
=20
-CaptureVoiceOut *AUD_add_capture (
+CaptureVoiceOut *AUD_add_capture(
+    AudioState *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *cb_opaque
     )
 {
-    AudioState *s =3D &glob_audio_state;
     CaptureVoiceOut *cap;
     struct capture_callback *cb;
=20
+    if (!s) {
+        /* todo: remove when we have normal audiodev selection support *=
/
+        s =3D audio_init(NULL);
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\=
n");
         audio_print_settings (as);
@@ -1807,3 +1839,25 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions=
 *pdo,
     return audio_buffer_samples(pdo, as, def_usecs) *
         audioformat_bytes_per_sample(as->fmt);
 }
+
+AudioState *audio_state_by_name(const char *name)
+{
+    AudioState *s;
+    QTAILQ_FOREACH(s, &audio_states, list) {
+        assert(s->dev);
+        if (strcmp(name, s->dev->id) =3D=3D 0) {
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
index 493edc60e455..8d7ce2eda145 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -104,8 +104,8 @@ static struct capture_ops wav_capture_ops =3D {
     .info =3D wav_capture_info
 };
=20
-int wav_start_capture (CaptureState *s, const char *path, int freq,
-                       int bits, int nchannels)
+int wav_start_capture(AudioState *state, CaptureState *s, const char *pa=
th,
+                      int freq, int bits, int nchannels)
 {
     WAVState *wav;
     uint8_t hdr[] =3D {
@@ -170,7 +170,7 @@ int wav_start_capture (CaptureState *s, const char *p=
ath, int freq,
         goto error_free;
     }
=20
-    cap =3D AUD_add_capture (&as, &ops, wav);
+    cap =3D AUD_add_capture(state, &as, &ops, wav);
     if (!cap) {
         error_report("Failed to add audio capture");
         goto error_free;
diff --git a/monitor/misc.c b/monitor/misc.c
index d229e6545021..6b710597394d 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1156,7 +1156,7 @@ static void hmp_wavcapture(Monitor *mon, const QDic=
t *qdict)
     bits =3D has_bits ? bits : 16;
     nchannels =3D has_channels ? nchannels : 2;
=20
-    if (wav_start_capture (s, path, freq, bits, nchannels)) {
+    if (wav_start_capture(NULL, s, path, freq, bits, nchannels)) {
         monitor_printf(mon, "Failed to add wave capture\n");
         g_free (s);
         return;
diff --git a/ui/vnc.c b/ui/vnc.c
index 4812ed29d0fa..ed5e8aa5f824 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1224,7 +1224,7 @@ static void audio_add(VncState *vs)
     ops.destroy =3D audio_capture_destroy;
     ops.capture =3D audio_capture;
=20
-    vs->audio_cap =3D AUD_add_capture(&vs->as, &ops, vs);
+    vs->audio_cap =3D AUD_add_capture(NULL, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
--=20
2.18.1


