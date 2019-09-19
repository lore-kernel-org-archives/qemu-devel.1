Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC379217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsIbEQ06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC379217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Gl-0008VD-K6
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3us-0002q0-Mt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uq-0000hd-G2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3uo-0000ch-6r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id b9so4661328wrs.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y4hrO1Uu0paB0JQc174Zf7748JlB8HDxf5+LZFaxdz0=;
 b=rsIbEQ06TfwRVZ1wmzumLJutCNaRqM7GZS6WyrD7cDSY9lRviBEhur8G8wOnb0luzv
 e5MdNpKX5OfiyGafmVB6ji/YY2qq2Thwryim1oBMP449FUXZCcEk/pbozx77LyR3HKIT
 i5k5mg55HqDh5v5M+kxD9qGXySYkve2MN9FuaAe+luYUIl1oTbYqfjpKKObBhJqLX9yG
 aXgBMZhRYOtYyKNE4KxqqIL2DCNJiyPWguwGGhdhUx+B+2bGWQDKmavWhpQUKj2IPBMg
 nP+LL1IgQWwS3N5U3H4EDdK20psDPIKuhDOktwj0MygstxRL5HN3Jlb3F2529/MhYeP6
 VuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y4hrO1Uu0paB0JQc174Zf7748JlB8HDxf5+LZFaxdz0=;
 b=tw+6iNbZlaLrDBfAlBEqKn9ugCdc9XNUhBpc4C0vsQkJ3528oEW2GWqwVlY8/+zD6w
 rmNN9FEJR7rtgZsYJXOK7sQ9dZupRsx0Km0XBOSduVytOPnU+TTrsvKA0dvtdJ4Lnmgh
 60045Q4xpyaqc+l4fGYW84/ckstsuXNC3P7gavNMqJ7Xqtt6pfRcUSmv6/hnFAa9SwEZ
 7CBpYgio1oN/sF3NOo1Tl2L0cnlvrcT3fdljiT/SGnLuJbozsDrc/bARo3rcv7bGGLuM
 cKpdHKTTt4g1SeeIkQX3fPOknnBr83XRvtyYf8VN4V82/G8F+vr44JnDlZF2yU46PyjZ
 SC/Q==
X-Gm-Message-State: APjAAAVmhaynkD2GA9W59iCQoONTwQKbZZsfXaxm9Wogqk5U8b9abMHj
 nq6uHtZTkC43RdBTX0oC3jSqGbOu
X-Google-Smtp-Source: APXvYqw4MUzM4YotE+OPeAo10U1rk2AwxQ23giluPxjEsGevYJQ2SdMeLT179aDGK/ZJk2pM9hnXVA==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr8483626wrs.191.1568928275328; 
 Thu, 19 Sep 2019 14:24:35 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:35 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/24] audio: common rate control code for timer based
 outputs
Date: Thu, 19 Sep 2019 23:24:21 +0200
Message-Id: <fd0fe5b95b13fa26d09ae77a72f99d0ea411de14.1568927990.git.DirtY.iCE.hu@gmail.com>
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
 audio/audio.c      | 30 +++++++++++++++++++++++++++
 audio/audio_int.h  |  9 ++++++++
 audio/noaudio.c    | 49 ++++++++++++++++++++------------------------
 audio/spiceaudio.c | 51 ++++++++--------------------------------------
 audio/wavaudio.c   | 21 +++++++++----------
 5 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index ba07fb77dd..fab1e35718 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2051,3 +2051,33 @@ const char *audio_get_id(QEMUSoundCard *card)
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
+        AUD_log(NULL, "Resetting rate control (%" PRId64 " samples)\n", samples);
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
index ff4e4dcbb0..4ce4f94c6d 100644
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
@@ -154,7 +123,6 @@ static void line_out_fini (HWVoiceOut *hw)
 static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
-    size_t decr;
 
     if (!out->frame) {
         spice_server_playback_get_buffer(&out->sin, &out->frame, &out->fsize);
@@ -162,12 +130,10 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
     }
 
     if (out->frame) {
-        decr = rate_get_samples(&hw->info, &out->rate);
-        decr = MIN(out->fsize - out->fpos, decr);
-
-        *size = decr << hw->info.shift;
+        *size = audio_rate_get_bytes(
+            &hw->info, &out->rate, (out->fsize - out->fpos) << hw->info.shift);
     } else {
-        rate_start(&out->rate);
+        audio_rate_start(&out->rate);
     }
     return out->frame + out->fpos;
 }
@@ -197,7 +163,7 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
             break;
         }
         out->active = 1;
-        rate_start (&out->rate);
+        audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
         break;
     case VOICE_DISABLE:
@@ -273,8 +239,7 @@ static void line_in_fini (HWVoiceIn *hw)
 static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
-    uint64_t delta_samp = rate_get_samples(&hw->info, &in->rate);
-    uint64_t to_read = MIN(len >> 2, delta_samp);
+    uint64_t to_read = audio_rate_get_bytes(&hw->info, &in->rate, len) >> 2;
     size_t ready = spice_server_record_get_samples(&in->sin, buf, to_read);
 
     /* XXX: do we need this? */
@@ -296,7 +261,7 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
             break;
         }
         in->active = 1;
-        rate_start (&in->rate);
+        audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
         break;
     case VOICE_DISABLE:
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 78af2f1338..85f5ff9c28 100644
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
         dolog("wav_write_out: fwrite of %" PRId64 " bytes failed\nReason: %s\n",
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


