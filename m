Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEBCC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7507620840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7507620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUrH-0006Mo-Ne
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUoy-0001DS-Cy
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUou-00056Z-Bg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUos-00053G-3k
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C695C05AA6F;
 Tue, 13 Aug 2019 11:18:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F01E03469E;
 Tue, 13 Aug 2019 11:18:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 21C059D00; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:17:55 +0200
Message-Id: <20190813111809.3141-2-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 13 Aug 2019 11:18:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/15] audio: reduce glob_audio_state usage
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Remove glob_audio_state from functions, where possible without breaking
the API.  This means that most static functions in audio.c now take an
AudioState pointer instead of implicitly using glob_audio_state.  Also
included a pointer in SWVoice*, HWVoice* structs, so that functions
dealing them can know the audio state without having to pass it around
separately.

This is required in order to support multiple simultaneous audio
backends (added in a later commit).

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 03e8aeba327355b64d55b2dd42e786c47e4b4667.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h      |  8 ++++++
 audio/audio_template.h | 46 ++++++++++++++++----------------
 audio/audio.c          | 59 +++++++++++++++++++-----------------------
 3 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 3f14842709bf..8164696b2c4a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -49,9 +49,11 @@ struct audio_pcm_info {
     int swap_endianness;
 };
=20
+typedef struct AudioState AudioState;
 typedef struct SWVoiceCap SWVoiceCap;
=20
 typedef struct HWVoiceOut {
+    AudioState *s;
     int enabled;
     int poll_mode;
     int pending_disable;
@@ -73,6 +75,7 @@ typedef struct HWVoiceOut {
 } HWVoiceOut;
=20
 typedef struct HWVoiceIn {
+    AudioState *s;
     int enabled;
     int poll_mode;
     struct audio_pcm_info info;
@@ -94,6 +97,7 @@ typedef struct HWVoiceIn {
=20
 struct SWVoiceOut {
     QEMUSoundCard *card;
+    AudioState *s;
     struct audio_pcm_info info;
     t_sample *conv;
     int64_t ratio;
@@ -111,6 +115,7 @@ struct SWVoiceOut {
=20
 struct SWVoiceIn {
     QEMUSoundCard *card;
+    AudioState *s;
     int active;
     struct audio_pcm_info info;
     int64_t ratio;
@@ -188,6 +193,9 @@ typedef struct AudioState {
     int nb_hw_voices_in;
     int vm_running;
     int64_t period_ticks;
+
+    bool timer_running;
+    uint64_t timer_last;
 } AudioState;
=20
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 1232bb54db0e..c721fed75d7d 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -36,9 +36,9 @@
 #define HWBUF hw->conv_buf
 #endif
=20
-static void glue (audio_init_nb_voices_, TYPE) (struct audio_driver *drv=
)
+static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
+                                              struct audio_driver *drv)
 {
-    AudioState *s =3D &glob_audio_state;
     int max_voices =3D glue (drv->max_voices_, TYPE);
     int voice_size =3D glue (drv->voice_size_, TYPE);
=20
@@ -183,8 +183,8 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw=
)
=20
 static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
 {
-    AudioState *s =3D &glob_audio_state;
     HW *hw =3D *hwp;
+    AudioState *s =3D hw->s;
=20
     if (!hw->sw_head.lh_first) {
 #ifdef DAC
@@ -199,15 +199,14 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp=
)
     }
 }
=20
-static HW *glue (audio_pcm_hw_find_any_, TYPE) (HW *hw)
+static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioState *s, HW *hw)
 {
-    AudioState *s =3D &glob_audio_state;
     return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
 }
=20
-static HW *glue (audio_pcm_hw_find_any_enabled_, TYPE) (HW *hw)
+static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, HW =
*hw)
 {
-    while ((hw =3D glue (audio_pcm_hw_find_any_, TYPE) (hw))) {
+    while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (hw->enabled) {
             return hw;
         }
@@ -215,12 +214,10 @@ static HW *glue (audio_pcm_hw_find_any_enabled_, TY=
PE) (HW *hw)
     return NULL;
 }
=20
-static HW *glue (audio_pcm_hw_find_specific_, TYPE) (
-    HW *hw,
-    struct audsettings *as
-    )
+static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *hw=
,
+                                                   struct audsettings *a=
s)
 {
-    while ((hw =3D glue (audio_pcm_hw_find_any_, TYPE) (hw))) {
+    while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (audio_pcm_info_eq (&hw->info, as)) {
             return hw;
         }
@@ -228,10 +225,10 @@ static HW *glue (audio_pcm_hw_find_specific_, TYPE)=
 (
     return NULL;
 }
=20
-static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
+                                             struct audsettings *as)
 {
     HW *hw;
-    AudioState *s =3D &glob_audio_state;
     struct audio_driver *drv =3D s->drv;
=20
     if (!glue (s->nb_hw_voices_, TYPE)) {
@@ -255,6 +252,7 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct=
 audsettings *as)
         return NULL;
     }
=20
+    hw->s =3D s;
     hw->pcm_ops =3D drv->pcm_ops;
     hw->ctl_caps =3D drv->ctl_caps;
=20
@@ -328,33 +326,33 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, T=
YPE)(Audiodev *dev)
     abort();
 }
=20
-static HW *glue (audio_pcm_hw_add_, TYPE) (struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsettin=
gs *as)
 {
     HW *hw;
-    AudioState *s =3D &glob_audio_state;
     AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(s->d=
ev);
=20
     if (pdo->fixed_settings) {
-        hw =3D glue (audio_pcm_hw_add_new_, TYPE) (as);
+        hw =3D glue(audio_pcm_hw_add_new_, TYPE)(s, as);
         if (hw) {
             return hw;
         }
     }
=20
-    hw =3D glue (audio_pcm_hw_find_specific_, TYPE) (NULL, as);
+    hw =3D glue(audio_pcm_hw_find_specific_, TYPE)(s, NULL, as);
     if (hw) {
         return hw;
     }
=20
-    hw =3D glue (audio_pcm_hw_add_new_, TYPE) (as);
+    hw =3D glue(audio_pcm_hw_add_new_, TYPE)(s, as);
     if (hw) {
         return hw;
     }
=20
-    return glue (audio_pcm_hw_find_any_, TYPE) (NULL);
+    return glue(audio_pcm_hw_find_any_, TYPE)(s, NULL);
 }
=20
-static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
+static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
+    AudioState *s,
     const char *sw_name,
     struct audsettings *as
     )
@@ -362,7 +360,6 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) =
(
     SW *sw;
     HW *hw;
     struct audsettings hw_as;
-    AudioState *s =3D &glob_audio_state;
     AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(s->d=
ev);
=20
     if (pdo->fixed_settings) {
@@ -378,8 +375,9 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) =
(
                sw_name ? sw_name : "unknown", sizeof (*sw));
         goto err1;
     }
+    sw->s =3D s;
=20
-    hw =3D glue (audio_pcm_hw_add_, TYPE) (&hw_as);
+    hw =3D glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
     if (!hw) {
         goto err2;
     }
@@ -476,7 +474,7 @@ SW *glue (AUD_open_, TYPE) (
         }
     }
     else {
-        sw =3D glue (audio_pcm_create_voice_pair_, TYPE) (name, as);
+        sw =3D glue(audio_pcm_create_voice_pair_, TYPE)(s, name, as);
         if (!sw) {
             dolog ("Failed to create voice `%s'\n", name);
             return NULL;
diff --git a/audio/audio.c b/audio/audio.c
index 05adf7ffebf1..8d2f5807884e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -399,12 +399,10 @@ static void noop_conv (struct st_sample *dst, const=
 void *src, int samples)
     (void) samples;
 }
=20
-static CaptureVoiceOut *audio_pcm_capture_find_specific (
-    struct audsettings *as
-    )
+static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioState *s,
+                                                        struct audsettin=
gs *as)
 {
     CaptureVoiceOut *cap;
-    AudioState *s =3D &glob_audio_state;
=20
     for (cap =3D s->cap_head.lh_first; cap; cap =3D cap->entries.le_next=
) {
         if (audio_pcm_info_eq (&cap->hw.info, as)) {
@@ -481,7 +479,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
=20
 static int audio_attach_capture (HWVoiceOut *hw)
 {
-    AudioState *s =3D &glob_audio_state;
+    AudioState *s =3D hw->s;
     CaptureVoiceOut *cap;
=20
     audio_detach_capture (hw);
@@ -789,19 +787,15 @@ static void audio_pcm_print_info (const char *cap, =
struct audio_pcm_info *info)
 /*
  * Timer
  */
-
-static bool audio_timer_running;
-static uint64_t audio_timer_last;
-
-static int audio_is_timer_needed (void)
+static int audio_is_timer_needed(AudioState *s)
 {
     HWVoiceIn *hwi =3D NULL;
     HWVoiceOut *hwo =3D NULL;
=20
-    while ((hwo =3D audio_pcm_hw_find_any_enabled_out (hwo))) {
+    while ((hwo =3D audio_pcm_hw_find_any_enabled_out(s, hwo))) {
         if (!hwo->poll_mode) return 1;
     }
-    while ((hwi =3D audio_pcm_hw_find_any_enabled_in (hwi))) {
+    while ((hwi =3D audio_pcm_hw_find_any_enabled_in(s, hwi))) {
         if (!hwi->poll_mode) return 1;
     }
     return 0;
@@ -809,18 +803,18 @@ static int audio_is_timer_needed (void)
=20
 static void audio_reset_timer (AudioState *s)
 {
-    if (audio_is_timer_needed ()) {
+    if (audio_is_timer_needed(s)) {
         timer_mod_anticipate_ns(s->ts,
             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->period_ticks);
-        if (!audio_timer_running) {
-            audio_timer_running =3D true;
-            audio_timer_last =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (!s->timer_running) {
+            s->timer_running =3D true;
+            s->timer_last =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
             trace_audio_timer_start(s->period_ticks / SCALE_MS);
         }
     } else {
         timer_del(s->ts);
-        if (audio_timer_running) {
-            audio_timer_running =3D false;
+        if (s->timer_running) {
+            s->timer_running =3D false;
             trace_audio_timer_stop();
         }
     }
@@ -832,11 +826,11 @@ static void audio_timer (void *opaque)
     AudioState *s =3D opaque;
=20
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    diff =3D now - audio_timer_last;
+    diff =3D now - s->timer_last;
     if (diff > s->period_ticks * 3 / 2) {
         trace_audio_timer_delayed(diff / SCALE_MS);
     }
-    audio_timer_last =3D now;
+    s->timer_last =3D now;
=20
     audio_run("timer");
     audio_reset_timer(s);
@@ -890,7 +884,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
=20
     hw =3D sw->hw;
     if (sw->active !=3D on) {
-        AudioState *s =3D &glob_audio_state;
+        AudioState *s =3D sw->s;
         SWVoiceOut *temp_sw;
         SWVoiceCap *sc;
=20
@@ -937,7 +931,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
=20
     hw =3D sw->hw;
     if (sw->active !=3D on) {
-        AudioState *s =3D &glob_audio_state;
+        AudioState *s =3D sw->s;
         SWVoiceIn *temp_sw;
=20
         if (on) {
@@ -1060,7 +1054,7 @@ static void audio_run_out (AudioState *s)
     HWVoiceOut *hw =3D NULL;
     SWVoiceOut *sw;
=20
-    while ((hw =3D audio_pcm_hw_find_any_enabled_out (hw))) {
+    while ((hw =3D audio_pcm_hw_find_any_enabled_out(s, hw))) {
         int played;
         int live, free, nb_live, cleanup_required, prev_rpos;
=20
@@ -1165,7 +1159,7 @@ static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw =3D NULL;
=20
-    while ((hw =3D audio_pcm_hw_find_any_enabled_in (hw))) {
+    while ((hw =3D audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
         int captured =3D 0, min;
=20
@@ -1271,8 +1265,8 @@ static int audio_driver_init(AudioState *s, struct =
audio_driver *drv,
     s->drv_opaque =3D drv->init(dev);
=20
     if (s->drv_opaque) {
-        audio_init_nb_voices_out (drv);
-        audio_init_nb_voices_in (drv);
+        audio_init_nb_voices_out(s, drv);
+        audio_init_nb_voices_in(s, drv);
         s->drv =3D drv;
         return 0;
     }
@@ -1293,11 +1287,11 @@ static void audio_vm_change_state_handler (void *=
opaque, int running,
     int op =3D running ? VOICE_ENABLE : VOICE_DISABLE;
=20
     s->vm_running =3D running;
-    while ((hwo =3D audio_pcm_hw_find_any_enabled_out (hwo))) {
+    while ((hwo =3D audio_pcm_hw_find_any_enabled_out(s, hwo))) {
         hwo->pcm_ops->ctl_out(hwo, op);
     }
=20
-    while ((hwi =3D audio_pcm_hw_find_any_enabled_in (hwi))) {
+    while ((hwi =3D audio_pcm_hw_find_any_enabled_in(s, hwi))) {
         hwi->pcm_ops->ctl_in(hwi, op);
     }
     audio_reset_timer (s);
@@ -1317,7 +1311,7 @@ void audio_cleanup(void)
     HWVoiceIn *hwi, *hwin;
=20
     is_cleaning_up =3D true;
-    QLIST_FOREACH_SAFE(hwo, &glob_audio_state.hw_head_out, entries, hwon=
) {
+    QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
=20
         if (hwo->enabled) {
@@ -1336,7 +1330,7 @@ void audio_cleanup(void)
         QLIST_REMOVE(hwo, entries);
     }
=20
-    QLIST_FOREACH_SAFE(hwi, &glob_audio_state.hw_head_in, entries, hwin)=
 {
+    QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
         if (hwi->enabled) {
             hwi->pcm_ops->ctl_in (hwi, VOICE_DISABLE);
         }
@@ -1532,7 +1526,7 @@ CaptureVoiceOut *AUD_add_capture (
     cb->ops =3D *ops;
     cb->opaque =3D cb_opaque;
=20
-    cap =3D audio_pcm_capture_find_specific (as);
+    cap =3D audio_pcm_capture_find_specific(s, as);
     if (cap) {
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
         return cap;
@@ -1544,6 +1538,7 @@ CaptureVoiceOut *AUD_add_capture (
         cap =3D g_malloc0(sizeof(*cap));
=20
         hw =3D &cap->hw;
+        hw->s =3D s;
         QLIST_INIT (&hw->sw_head);
         QLIST_INIT (&cap->cb_head);
=20
@@ -1564,7 +1559,7 @@ CaptureVoiceOut *AUD_add_capture (
         QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
=20
-        QLIST_FOREACH(hw, &glob_audio_state.hw_head_out, entries) {
+        QLIST_FOREACH(hw, &s->hw_head_out, entries) {
             audio_attach_capture (hw);
         }
         return cap;
--=20
2.18.1


