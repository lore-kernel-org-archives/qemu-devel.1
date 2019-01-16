Received: from eggs.gnu.org ([209.51.188.92]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukz-0004IF-KA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukv-0003DO-TY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:59 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukt-000388-Nb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:56 -0500
Received: by mail-wr1-x444.google.com with SMTP id j2so9012949wrw.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:53 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:03 +0100
Message-Id: <d30a5f6db52adaf426bc5ee189274084edf533cc.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 30/50] noaudio: port to the new audio
 backend api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/noaudio.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index 59e680db6f..647558f54c 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -40,10 +40,9 @@ typedef struct NoVoiceIn {
     int64_t old_ticks;
 } NoVoiceIn;
 
-static size_t no_run_out(HWVoiceOut *hw, size_t live)
+static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
-    size_t decr, samples;
     int64_t now;
     int64_t ticks;
     int64_t bytes;
@@ -51,13 +50,9 @@ static size_t no_run_out(HWVoiceOut *hw, size_t live)
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks = now - no->old_ticks;
     bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-    bytes = MIN(bytes, SIZE_MAX);
-    samples = bytes >> hw->info.shift;
 
     no->old_ticks = now;
-    decr = MIN (live, samples);
-    hw->rpos = (hw->rpos + decr) % hw->samples;
-    return decr;
+    return MIN(len, bytes);
 }
 
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
@@ -91,25 +86,21 @@ static void no_fini_in (HWVoiceIn *hw)
     (void) hw;
 }
 
-static size_t no_run_in(HWVoiceIn *hw)
+static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
 {
+    size_t to_clear;
     NoVoiceIn *no = (NoVoiceIn *) hw;
-    size_t live = audio_pcm_hw_get_live_in(hw);
-    size_t dead = hw->samples - live;
-    size_t samples = 0;
 
-    if (dead) {
-        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        int64_t ticks = now - no->old_ticks;
-        int64_t bytes =
-            muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t ticks = now - no->old_ticks;
+    int64_t bytes =
+        muldiv64 (ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
-        no->old_ticks = now;
-        bytes = MIN (bytes, SIZE_MAX);
-        samples = bytes >> hw->info.shift;
-        samples = MIN (samples, dead);
-    }
-    return samples;
+    no->old_ticks = now;
+    to_clear = MIN(bytes, size);
+
+    audio_pcm_info_clear_buf(&hw->info, buf, to_clear >> hw->info.shift);
+    return to_clear;
 }
 
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -132,12 +123,12 @@ static void no_audio_fini (void *opaque)
 static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
-    .run_out  = no_run_out,
+    .write    = no_write,
     .ctl_out  = no_ctl_out,
 
     .init_in  = no_init_in,
     .fini_in  = no_fini_in,
-    .run_in   = no_run_in,
+    .read     = no_read,
     .ctl_in   = no_ctl_in
 };
 
-- 
2.20.1
