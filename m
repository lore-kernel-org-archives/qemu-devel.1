Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E9C4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B761218AE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqAYunpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B761218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74ws-0006cP-Ey
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dy-0005X8-1z
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74du-0005qF-PU
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:45 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74du-0005pb-BI
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:42 -0400
Received: by mail-qk1-x744.google.com with SMTP id 4so11104599qki.6
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jjly12yWVoVoUzxyna5Waq62iPaZmGGKH6QVXhm6hwQ=;
 b=SqAYunpgXBQ4nuOAzFkPyHYqD/E4tce7otCT8GHK3oZk3bKzftTW+K/L8KW3IqxmVs
 Fq7g3F2QeQgAdHueQ+d7ebLEiANNEbeSxP/26PNx45qYCQGvoa+kAyS/wkqhNbVyIlD7
 sDgtPDb+oCVyQ9Xb1jdkMV7mN3cYLhJk4QATOCy6qb4vAfXGZ7i8scpypqIbC+GuthxB
 tVerQw+RqicIOT5OFl1szT6zpjkADeXDNoIvKwqd71PE16qzr5sdUkPow+wG2AaiHall
 6E3Qxq2h2DJ9U/T91OmpckNjHPl3IgeEEcDygmlDID6KUFpokPj0RJ6IZCm4a5UWYtCL
 D4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jjly12yWVoVoUzxyna5Waq62iPaZmGGKH6QVXhm6hwQ=;
 b=CZIQOpS5s5Fi46CoE9qHnhthd2Yl4MwpNQ9ribTguXGn4xfulGyi4NmgtXKFjW/0pg
 5Ilx3w2jKIGxoT7lfOrhoL9Qp7wnn4Um4SXN6dsdQSggFHXDUNCJkO3jjjFFgwLGtBMx
 0/0nybEyusH3i2cmD7tYLwsdEWIq1qY5yLBzKjxudZe3JxME/HB70c1ivK1kGbETxHnI
 TpjB7rZesbQDzKeNZXk1kCaMLOnH+I3Miy/H7miFBjsx0Z0CDoYIDsS4kJhA/hZSc/9u
 +cJ9YpXxVY1XC2gXaMAcvtqh2ZZNNC0gvuo6lKmCOMWAG6F63q4DR55McJHJxNpN3nXe
 l7/Q==
X-Gm-Message-State: APjAAAW+07GndCtlGWvC3pD7eIm1FKTj7RHkmDmUan9hgHHrXDqWFLOO
 /X0/po4vxjQwqMmooqKKRcWuPGz+
X-Google-Smtp-Source: APXvYqxdA1YdBvVU+YUWvAc0mtUfbdmKFIV7VwEfaZLkXJjHqz7i+j+gSQTvHNSy2JE8XN+C5DVPnQ==
X-Received: by 2002:ae9:e88a:: with SMTP id
 a132mr20337409qkg.120.1567977761482; 
 Sun, 08 Sep 2019 14:22:41 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:41 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:13 +0200
Message-Id: <1a8eec4d805294567261cb43bb867d94ddea6708.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH v2 13/24] audio: common rate control code for
 timer based outputs
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

This commit removes the ad-hoc rate-limiting code from noaudio and
wavaudio, and replaces them with a (slightly modified) code from
spiceaudio.  This way multiple write calls (for example when the
circular buffer wraps around) do not cause problems.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c      | 30 ++++++++++++++++++++++++++++
 audio/audio_int.h  |  9 +++++++++
 audio/noaudio.c    | 49 +++++++++++++++++++++-------------------------
 audio/spiceaudio.c | 49 +++++++---------------------------------------
 audio/wavaudio.c   | 21 ++++++++++----------
 5 files changed, 78 insertions(+), 80 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 0c3909087d..abecd1b771 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2046,3 +2046,33 @@ const char *audio_get_id(QEMUSoundCard *card)
         return "";
     }
 }
+
+void audio_rate_start(RateCtl *rate)
+{
+    memset(rate, 0, sizeof(RateCtl));
+    rate->start_ticks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
+                            size_t bytes_avail)
+{
+    int64_t now;
+    int64_t ticks;
+    int64_t bytes;
+    int64_t samples;
+    size_t ret;
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    ticks = now - rate->start_ticks;
+    bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
+    samples = (bytes - rate->bytes_sent) >> info->shift;
+    if (samples < 0 || samples > 65536) {
+        AUD_log(NULL, "Resetting rate control (%" PRId64 " samples)", samples);
+        audio_rate_start(rate);
+        samples = 0;
+    }
+
+    ret = MIN(samples << info->shift, bytes_avail);
+    rate->bytes_sent += ret;
+    return ret;
+}
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 20021df9e8..778615ccaf 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -242,6 +242,15 @@ void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
 void audio_run(AudioState *s, const char *msg);
 
+typedef struct RateCtl {
+    int64_t start_ticks;
+    int64_t bytes_sent;
+} RateCtl;
+
+void audio_rate_start(RateCtl *rate);
+size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
+                            size_t bytes_avail);
+
 #define VOICE_ENABLE 1
 #define VOICE_DISABLE 2
 #define VOICE_VOLUME 3
diff --git a/audio/noaudio.c b/audio/noaudio.c
index b054fd225b..9f1cc67df9 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -33,33 +33,27 @@
 
 typedef struct NoVoiceOut {
     HWVoiceOut hw;
-    int64_t old_ticks;
+    RateCtl rate;
 } NoVoiceOut;
 
 typedef struct NoVoiceIn {
     HWVoiceIn hw;
-    int64_t old_ticks;
+    RateCtl rate;
 } NoVoiceIn;
 
 static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
-    int64_t now;
-    int64_t ticks;
-    int64_t bytes;
-
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    ticks = now - no->old_ticks;
-    bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-    no->old_ticks = now;
-    return MIN(len, bytes);
+    return audio_rate_get_bytes(&hw->info, &no->rate, len);
 }
 
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 {
+    NoVoiceOut *no = (NoVoiceOut *) hw;
+
     audio_pcm_init_info (&hw->info, as);
     hw->samples = 1024;
+    audio_rate_start(&no->rate);
     return 0;
 }
 
@@ -70,15 +64,21 @@ static void no_fini_out (HWVoiceOut *hw)
 
 static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    NoVoiceOut *no = (NoVoiceOut *) hw;
+
+    if (cmd == VOICE_ENABLE) {
+        audio_rate_start(&no->rate);
+    }
     return 0;
 }
 
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
+    NoVoiceIn *no = (NoVoiceIn *) hw;
+
     audio_pcm_init_info (&hw->info, as);
     hw->samples = 1024;
+    audio_rate_start(&no->rate);
     return 0;
 }
 
@@ -89,25 +89,20 @@ static void no_fini_in (HWVoiceIn *hw)
 
 static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    size_t to_clear;
     NoVoiceIn *no = (NoVoiceIn *) hw;
+    int64_t bytes = audio_rate_get_bytes(&hw->info, &no->rate, size);
 
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int64_t ticks = now - no->old_ticks;
-    int64_t bytes =
-        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-    no->old_ticks = now;
-    to_clear = MIN(bytes, size);
-
-    audio_pcm_info_clear_buf(&hw->info, buf, to_clear >> hw->info.shift);
-    return to_clear;
+    audio_pcm_info_clear_buf(&hw->info, buf, bytes >> hw->info.shift);
+    return bytes;
 }
 
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    NoVoiceIn *no = (NoVoiceIn *) hw;
+
+    if (cmd == VOICE_ENABLE) {
+        audio_rate_start(&no->rate);
+    }
     return 0;
 }
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 092ad27e20..ea0cb3fa2e 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -40,15 +40,10 @@
 #define LINE_IN_SAMPLES (256 * 4)
 #endif
 
-typedef struct SpiceRateCtl {
-    int64_t               start_ticks;
-    int64_t               bytes_sent;
-} SpiceRateCtl;
-
 typedef struct SpiceVoiceOut {
     HWVoiceOut            hw;
     SpicePlaybackInstance sin;
-    SpiceRateCtl          rate;
+    RateCtl               rate;
     int                   active;
     uint32_t              *frame;
     uint32_t              fpos;
@@ -58,7 +53,7 @@ typedef struct SpiceVoiceOut {
 typedef struct SpiceVoiceIn {
     HWVoiceIn             hw;
     SpiceRecordInstance   sin;
-    SpiceRateCtl          rate;
+    RateCtl               rate;
     int                   active;
 } SpiceVoiceIn;
 
@@ -89,32 +84,6 @@ static void spice_audio_fini (void *opaque)
     /* nothing */
 }
 
-static void rate_start (SpiceRateCtl *rate)
-{
-    memset (rate, 0, sizeof (*rate));
-    rate->start_ticks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-}
-
-static int rate_get_samples (struct audio_pcm_info *info, SpiceRateCtl *rate)
-{
-    int64_t now;
-    int64_t ticks;
-    int64_t bytes;
-    int64_t samples;
-
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    ticks = now - rate->start_ticks;
-    bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
-    samples = (bytes - rate->bytes_sent) >> info->shift;
-    if (samples < 0 || samples > 65536) {
-        error_report("Resetting rate control (%" PRId64 " samples)", samples);
-        rate_start(rate);
-        samples = 0;
-    }
-    rate->bytes_sent += samples << info->shift;
-    return samples;
-}
-
 /* playback */
 
 static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
@@ -154,17 +123,14 @@ static void line_out_fini (HWVoiceOut *hw)
 static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
-    size_t decr;
 
     if (!out->frame) {
         spice_server_playback_get_buffer(&out->sin, &out->frame, &out->fsize);
         out->fpos = 0;
     }
 
-    decr = rate_get_samples(&hw->info, &out->rate);
-    decr = MIN(out->fsize - out->fpos, decr);
-
-    *size = decr << hw->info.shift;
+    *size = audio_rate_get_bytes(&hw->info, &out->rate,
+                                 (out->fsize - out->fpos) << hw->info.shift);
     return out->frame + out->fpos;
 }
 
@@ -193,7 +159,7 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
             break;
         }
         out->active = 1;
-        rate_start (&out->rate);
+        audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
         break;
     case VOICE_DISABLE:
@@ -269,8 +235,7 @@ static void line_in_fini (HWVoiceIn *hw)
 static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
-    uint64_t delta_samp = rate_get_samples(&hw->info, &in->rate);
-    uint64_t to_read = MIN(len >> 2, delta_samp);
+    uint64_t to_read = audio_rate_get_bytes(&hw->info, &in->rate, len) >> 2;
     size_t ready = spice_server_record_get_samples(&in->sin, buf, to_read);
 
     /* XXX: do we need this? */
@@ -292,7 +257,7 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
             break;
         }
         in->active = 1;
-        rate_start (&in->rate);
+        audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
         break;
     case VOICE_DISABLE:
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 7816097db8..cb2783e82a 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -35,21 +35,15 @@
 typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
-    int64_t old_ticks;
+    RateCtl rate;
     int total_samples;
 } WAVVoiceOut;
 
 static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int64_t ticks = now - wav->old_ticks;
-    int64_t bytes =
-        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-    bytes = MIN(bytes, len);
-    bytes = bytes >> hw->info.shift << hw->info.shift;
-    wav->old_ticks = now;
+    int64_t bytes = audio_rate_get_bytes(&hw->info, &wav->rate, len);
+    assert(bytes >> hw->info.shift << hw->info.shift == bytes);
 
     if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
         dolog("wav_write_out: fwrite of %zu bytes failed\nReaons: %s\n",
@@ -130,6 +124,8 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
                strerror(errno));
         return -1;
     }
+
+    audio_rate_start(&wav->rate);
     return 0;
 }
 
@@ -179,8 +175,11 @@ static void wav_fini_out (HWVoiceOut *hw)
 
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    WAVVoiceOut *wav = (WAVVoiceOut *) hw;
+
+    if (cmd == VOICE_ENABLE) {
+        audio_rate_start(&wav->rate);
+    }
     return 0;
 }
 
-- 
2.23.0


