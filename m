Received: from eggs.gnu.org ([209.51.188.92]:58062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukt-000495-Nj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukk-0002ua-3I
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:54 -0500
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:35 +0100
Message-Id: <3fef4dae7ac1e3ac346ffaaff51ae64eebd8ab24.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/50] audio: use qapi AudioFormat instead
 of audfmt_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

I had to include an enum for audio sampling formats into qapi, but that
meant duplicating the audfmt_e enum.  This patch replaces audfmt_e and
associated values with the qapi generated AudioFormat enum.

This patch is mostly a search-and-replace, except for switches where the
qapi generated AUDIO_FORMAT_MAX caused problems.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.h             | 12 +----
 audio/alsaaudio.c         | 53 +++++++++++----------
 audio/audio.c             | 97 +++++++++++++++++++++------------------
 audio/audio_win_int.c     | 18 ++++----
 audio/ossaudio.c          | 30 ++++++------
 audio/paaudio.c           | 28 +++++------
 audio/sdlaudio.c          | 26 +++++------
 audio/spiceaudio.c        |  4 +-
 audio/wavaudio.c          | 17 ++++---
 audio/wavcapture.c        |  2 +-
 hw/arm/omap2.c            |  2 +-
 hw/audio/ac97.c           |  2 +-
 hw/audio/adlib.c          |  2 +-
 hw/audio/cs4231a.c        |  6 +--
 hw/audio/es1370.c         |  4 +-
 hw/audio/gus.c            |  2 +-
 hw/audio/hda-codec.c      | 18 ++++----
 hw/audio/lm4549.c         |  6 +--
 hw/audio/milkymist-ac97.c |  2 +-
 hw/audio/pcspk.c          |  2 +-
 hw/audio/sb16.c           | 14 +++---
 hw/audio/wm8750.c         |  6 +--
 hw/display/xlnx_dp.c      |  2 +-
 hw/input/tsc210x.c        |  2 +-
 hw/usb/dev-audio.c        |  2 +-
 ui/vnc.c                  | 26 +++++------
 26 files changed, 196 insertions(+), 189 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index f4339a185e..02f29a3b3e 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -26,18 +26,10 @@
 #define QEMU_AUDIO_H
 
 #include "qemu/queue.h"
+#include "qapi/qapi-types-audio.h"
 
 typedef void (*audio_callback_fn) (void *opaque, int avail);
 
-typedef enum {
-    AUD_FMT_U8,
-    AUD_FMT_S8,
-    AUD_FMT_U16,
-    AUD_FMT_S16,
-    AUD_FMT_U32,
-    AUD_FMT_S32
-} audfmt_e;
-
 #ifdef HOST_WORDS_BIGENDIAN
 #define AUDIO_HOST_ENDIANNESS 1
 #else
@@ -47,7 +39,7 @@ typedef enum {
 struct audsettings {
     int freq;
     int nchannels;
-    audfmt_e fmt;
+    AudioFormat fmt;
     int endianness;
 };
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 635be73bf4..5bd034267f 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -87,7 +87,7 @@ struct alsa_params_req {
 
 struct alsa_params_obt {
     int freq;
-    audfmt_e fmt;
+    AudioFormat fmt;
     int endianness;
     int nchannels;
     snd_pcm_uframes_t samples;
@@ -294,16 +294,16 @@ static int alsa_write (SWVoiceOut *sw, void *buf, int len)
     return audio_pcm_sw_write (sw, buf, len);
 }
 
-static snd_pcm_format_t aud_to_alsafmt (audfmt_e fmt, int endianness)
+static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
 {
     switch (fmt) {
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         return SND_PCM_FORMAT_S8;
 
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         return SND_PCM_FORMAT_U8;
 
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         if (endianness) {
             return SND_PCM_FORMAT_S16_BE;
         }
@@ -311,7 +311,7 @@ static snd_pcm_format_t aud_to_alsafmt (audfmt_e fmt, int endianness)
             return SND_PCM_FORMAT_S16_LE;
         }
 
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         if (endianness) {
             return SND_PCM_FORMAT_U16_BE;
         }
@@ -319,7 +319,7 @@ static snd_pcm_format_t aud_to_alsafmt (audfmt_e fmt, int endianness)
             return SND_PCM_FORMAT_U16_LE;
         }
 
-    case AUD_FMT_S32:
+    case AUDIO_FORMAT_S32:
         if (endianness) {
             return SND_PCM_FORMAT_S32_BE;
         }
@@ -327,7 +327,7 @@ static snd_pcm_format_t aud_to_alsafmt (audfmt_e fmt, int endianness)
             return SND_PCM_FORMAT_S32_LE;
         }
 
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_U32:
         if (endianness) {
             return SND_PCM_FORMAT_U32_BE;
         }
@@ -344,58 +344,58 @@ static snd_pcm_format_t aud_to_alsafmt (audfmt_e fmt, int endianness)
     }
 }
 
-static int alsa_to_audfmt (snd_pcm_format_t alsafmt, audfmt_e *fmt,
+static int alsa_to_audfmt (snd_pcm_format_t alsafmt, AudioFormat *fmt,
                            int *endianness)
 {
     switch (alsafmt) {
     case SND_PCM_FORMAT_S8:
         *endianness = 0;
-        *fmt = AUD_FMT_S8;
+        *fmt = AUDIO_FORMAT_S8;
         break;
 
     case SND_PCM_FORMAT_U8:
         *endianness = 0;
-        *fmt = AUD_FMT_U8;
+        *fmt = AUDIO_FORMAT_U8;
         break;
 
     case SND_PCM_FORMAT_S16_LE:
         *endianness = 0;
-        *fmt = AUD_FMT_S16;
+        *fmt = AUDIO_FORMAT_S16;
         break;
 
     case SND_PCM_FORMAT_U16_LE:
         *endianness = 0;
-        *fmt = AUD_FMT_U16;
+        *fmt = AUDIO_FORMAT_U16;
         break;
 
     case SND_PCM_FORMAT_S16_BE:
         *endianness = 1;
-        *fmt = AUD_FMT_S16;
+        *fmt = AUDIO_FORMAT_S16;
         break;
 
     case SND_PCM_FORMAT_U16_BE:
         *endianness = 1;
-        *fmt = AUD_FMT_U16;
+        *fmt = AUDIO_FORMAT_U16;
         break;
 
     case SND_PCM_FORMAT_S32_LE:
         *endianness = 0;
-        *fmt = AUD_FMT_S32;
+        *fmt = AUDIO_FORMAT_S32;
         break;
 
     case SND_PCM_FORMAT_U32_LE:
         *endianness = 0;
-        *fmt = AUD_FMT_U32;
+        *fmt = AUDIO_FORMAT_U32;
         break;
 
     case SND_PCM_FORMAT_S32_BE:
         *endianness = 1;
-        *fmt = AUD_FMT_S32;
+        *fmt = AUDIO_FORMAT_S32;
         break;
 
     case SND_PCM_FORMAT_U32_BE:
         *endianness = 1;
-        *fmt = AUD_FMT_U32;
+        *fmt = AUDIO_FORMAT_U32;
         break;
 
     default:
@@ -638,19 +638,22 @@ static int alsa_open (int in, struct alsa_params_req *req,
         bytes_per_sec = freq << (nchannels == 2);
 
         switch (obt->fmt) {
-        case AUD_FMT_S8:
-        case AUD_FMT_U8:
+        case AUDIO_FORMAT_S8:
+        case AUDIO_FORMAT_U8:
             break;
 
-        case AUD_FMT_S16:
-        case AUD_FMT_U16:
+        case AUDIO_FORMAT_S16:
+        case AUDIO_FORMAT_U16:
             bytes_per_sec <<= 1;
             break;
 
-        case AUD_FMT_S32:
-        case AUD_FMT_U32:
+        case AUDIO_FORMAT_S32:
+        case AUDIO_FORMAT_U32:
             bytes_per_sec <<= 2;
             break;
+
+        default:
+            abort();
         }
 
         threshold = (conf->threshold * bytes_per_sec) / 1000;
diff --git a/audio/audio.c b/audio/audio.c
index 1ace47f510..96cbd57c37 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -113,7 +113,7 @@ static struct {
         .settings = {
             .freq = 44100,
             .nchannels = 2,
-            .fmt = AUD_FMT_S16,
+            .fmt = AUDIO_FORMAT_S16,
             .endianness =  AUDIO_HOST_ENDIANNESS,
         }
     },
@@ -125,7 +125,7 @@ static struct {
         .settings = {
             .freq = 44100,
             .nchannels = 2,
-            .fmt = AUD_FMT_S16,
+            .fmt = AUDIO_FORMAT_S16,
             .endianness = AUDIO_HOST_ENDIANNESS,
         }
     },
@@ -257,58 +257,61 @@ static char *audio_alloc_prefix (const char *s)
     return r;
 }
 
-static const char *audio_audfmt_to_string (audfmt_e fmt)
+static const char *audio_audfmt_to_string (AudioFormat fmt)
 {
     switch (fmt) {
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         return "U8";
 
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         return "U16";
 
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         return "S8";
 
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         return "S16";
 
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_U32:
         return "U32";
 
-    case AUD_FMT_S32:
+    case AUDIO_FORMAT_S32:
         return "S32";
+
+    default:
+        abort();
     }
 
     dolog ("Bogus audfmt %d returning S16\n", fmt);
     return "S16";
 }
 
-static audfmt_e audio_string_to_audfmt (const char *s, audfmt_e defval,
+static AudioFormat audio_string_to_audfmt (const char *s, AudioFormat defval,
                                         int *defaultp)
 {
     if (!strcasecmp (s, "u8")) {
         *defaultp = 0;
-        return AUD_FMT_U8;
+        return AUDIO_FORMAT_U8;
     }
     else if (!strcasecmp (s, "u16")) {
         *defaultp = 0;
-        return AUD_FMT_U16;
+        return AUDIO_FORMAT_U16;
     }
     else if (!strcasecmp (s, "u32")) {
         *defaultp = 0;
-        return AUD_FMT_U32;
+        return AUDIO_FORMAT_U32;
     }
     else if (!strcasecmp (s, "s8")) {
         *defaultp = 0;
-        return AUD_FMT_S8;
+        return AUDIO_FORMAT_S8;
     }
     else if (!strcasecmp (s, "s16")) {
         *defaultp = 0;
-        return AUD_FMT_S16;
+        return AUDIO_FORMAT_S16;
     }
     else if (!strcasecmp (s, "s32")) {
         *defaultp = 0;
-        return AUD_FMT_S32;
+        return AUDIO_FORMAT_S32;
     }
     else {
         dolog ("Bogus audio format `%s' using %s\n",
@@ -318,8 +321,8 @@ static audfmt_e audio_string_to_audfmt (const char *s, audfmt_e defval,
     }
 }
 
-static audfmt_e audio_get_conf_fmt (const char *envname,
-                                    audfmt_e defval,
+static AudioFormat audio_get_conf_fmt (const char *envname,
+                                    AudioFormat defval,
                                     int *defaultp)
 {
     const char *var = getenv (envname);
@@ -421,7 +424,7 @@ static void audio_print_options (const char *prefix,
 
         case AUD_OPT_FMT:
             {
-                audfmt_e *fmtp = opt->valp;
+                AudioFormat *fmtp = opt->valp;
                 printf (
                     "format, %s = %s, (one of: U8 S8 U16 S16 U32 S32)\n",
                     state,
@@ -508,7 +511,7 @@ static void audio_process_options (const char *prefix,
 
         case AUD_OPT_FMT:
             {
-                audfmt_e *fmtp = opt->valp;
+                AudioFormat *fmtp = opt->valp;
                 *fmtp = audio_get_conf_fmt (optname, *fmtp, &def);
             }
             break;
@@ -539,22 +542,22 @@ static void audio_print_settings (struct audsettings *as)
     dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
 
     switch (as->fmt) {
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         AUD_log (NULL, "S8");
         break;
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         AUD_log (NULL, "U8");
         break;
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         AUD_log (NULL, "S16");
         break;
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         AUD_log (NULL, "U16");
         break;
-    case AUD_FMT_S32:
+    case AUDIO_FORMAT_S32:
         AUD_log (NULL, "S32");
         break;
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_U32:
         AUD_log (NULL, "U32");
         break;
     default:
@@ -585,12 +588,12 @@ static int audio_validate_settings (struct audsettings *as)
     invalid |= as->endianness != 0 && as->endianness != 1;
 
     switch (as->fmt) {
-    case AUD_FMT_S8:
-    case AUD_FMT_U8:
-    case AUD_FMT_S16:
-    case AUD_FMT_U16:
-    case AUD_FMT_S32:
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_S8:
+    case AUDIO_FORMAT_U8:
+    case AUDIO_FORMAT_S16:
+    case AUDIO_FORMAT_U16:
+    case AUDIO_FORMAT_S32:
+    case AUDIO_FORMAT_U32:
         break;
     default:
         invalid = 1;
@@ -606,25 +609,28 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
     int bits = 8, sign = 0;
 
     switch (as->fmt) {
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         sign = 1;
         /* fall through */
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         break;
 
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         sign = 1;
         /* fall through */
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         bits = 16;
         break;
 
-    case AUD_FMT_S32:
+    case AUDIO_FORMAT_S32:
         sign = 1;
         /* fall through */
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_U32:
         bits = 32;
         break;
+
+    default:
+        abort();
     }
     return info->freq == as->freq
         && info->nchannels == as->nchannels
@@ -638,24 +644,27 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
     int bits = 8, sign = 0, shift = 0;
 
     switch (as->fmt) {
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         sign = 1;
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         break;
 
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         sign = 1;
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         bits = 16;
         shift = 1;
         break;
 
-    case AUD_FMT_S32:
+    case AUDIO_FORMAT_S32:
         sign = 1;
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_U32:
         bits = 32;
         shift = 2;
         break;
+
+    default:
+        abort();
     }
 
     info->freq = as->freq;
diff --git a/audio/audio_win_int.c b/audio/audio_win_int.c
index 6900008d0c..b938fd667b 100644
--- a/audio/audio_win_int.c
+++ b/audio/audio_win_int.c
@@ -24,20 +24,20 @@ int waveformat_from_audio_settings (WAVEFORMATEX *wfx,
     wfx->cbSize = 0;
 
     switch (as->fmt) {
-    case AUD_FMT_S8:
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_S8:
+    case AUDIO_FORMAT_U8:
         wfx->wBitsPerSample = 8;
         break;
 
-    case AUD_FMT_S16:
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_S16:
+    case AUDIO_FORMAT_U16:
         wfx->wBitsPerSample = 16;
         wfx->nAvgBytesPerSec <<= 1;
         wfx->nBlockAlign <<= 1;
         break;
 
-    case AUD_FMT_S32:
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_S32:
+    case AUDIO_FORMAT_U32:
         wfx->wBitsPerSample = 32;
         wfx->nAvgBytesPerSec <<= 2;
         wfx->nBlockAlign <<= 2;
@@ -85,15 +85,15 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
 
     switch (wfx->wBitsPerSample) {
     case 8:
-        as->fmt = AUD_FMT_U8;
+        as->fmt = AUDIO_FORMAT_U8;
         break;
 
     case 16:
-        as->fmt = AUD_FMT_S16;
+        as->fmt = AUDIO_FORMAT_S16;
         break;
 
     case 32:
-        as->fmt = AUD_FMT_S32;
+        as->fmt = AUDIO_FORMAT_S32;
         break;
 
     default:
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 6c69622b4c..355e8fbda5 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -70,7 +70,7 @@ typedef struct OSSVoiceIn {
 
 struct oss_params {
     int freq;
-    audfmt_e fmt;
+    AudioFormat fmt;
     int nchannels;
     int nfrags;
     int fragsize;
@@ -148,16 +148,16 @@ static int oss_write (SWVoiceOut *sw, void *buf, int len)
     return audio_pcm_sw_write (sw, buf, len);
 }
 
-static int aud_to_ossfmt (audfmt_e fmt, int endianness)
+static int aud_to_ossfmt (AudioFormat fmt, int endianness)
 {
     switch (fmt) {
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         return AFMT_S8;
 
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         return AFMT_U8;
 
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         if (endianness) {
             return AFMT_S16_BE;
         }
@@ -165,7 +165,7 @@ static int aud_to_ossfmt (audfmt_e fmt, int endianness)
             return AFMT_S16_LE;
         }
 
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         if (endianness) {
             return AFMT_U16_BE;
         }
@@ -182,37 +182,37 @@ static int aud_to_ossfmt (audfmt_e fmt, int endianness)
     }
 }
 
-static int oss_to_audfmt (int ossfmt, audfmt_e *fmt, int *endianness)
+static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, int *endianness)
 {
     switch (ossfmt) {
     case AFMT_S8:
         *endianness = 0;
-        *fmt = AUD_FMT_S8;
+        *fmt = AUDIO_FORMAT_S8;
         break;
 
     case AFMT_U8:
         *endianness = 0;
-        *fmt = AUD_FMT_U8;
+        *fmt = AUDIO_FORMAT_U8;
         break;
 
     case AFMT_S16_LE:
         *endianness = 0;
-        *fmt = AUD_FMT_S16;
+        *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AFMT_U16_LE:
         *endianness = 0;
-        *fmt = AUD_FMT_U16;
+        *fmt = AUDIO_FORMAT_U16;
         break;
 
     case AFMT_S16_BE:
         *endianness = 1;
-        *fmt = AUD_FMT_S16;
+        *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AFMT_U16_BE:
         *endianness = 1;
-        *fmt = AUD_FMT_U16;
+        *fmt = AUDIO_FORMAT_U16;
         break;
 
     default:
@@ -500,7 +500,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     int endianness;
     int err;
     int fd;
-    audfmt_e effective_fmt;
+    AudioFormat effective_fmt;
     struct audsettings obt_as;
     OSSConf *conf = drv_opaque;
 
@@ -667,7 +667,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     int endianness;
     int err;
     int fd;
-    audfmt_e effective_fmt;
+    AudioFormat effective_fmt;
     struct audsettings obt_as;
     OSSConf *conf = drv_opaque;
 
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 4c100bc318..f1f9a741ac 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -385,21 +385,21 @@ static int qpa_read (SWVoiceIn *sw, void *buf, int len)
     return audio_pcm_sw_read (sw, buf, len);
 }
 
-static pa_sample_format_t audfmt_to_pa (audfmt_e afmt, int endianness)
+static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
 {
     int format;
 
     switch (afmt) {
-    case AUD_FMT_S8:
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_S8:
+    case AUDIO_FORMAT_U8:
         format = PA_SAMPLE_U8;
         break;
-    case AUD_FMT_S16:
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_S16:
+    case AUDIO_FORMAT_U16:
         format = endianness ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
         break;
-    case AUD_FMT_S32:
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_S32:
+    case AUDIO_FORMAT_U32:
         format = endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
         break;
     default:
@@ -410,26 +410,26 @@ static pa_sample_format_t audfmt_to_pa (audfmt_e afmt, int endianness)
     return format;
 }
 
-static audfmt_e pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
+static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
 {
     switch (fmt) {
     case PA_SAMPLE_U8:
-        return AUD_FMT_U8;
+        return AUDIO_FORMAT_U8;
     case PA_SAMPLE_S16BE:
         *endianness = 1;
-        return AUD_FMT_S16;
+        return AUDIO_FORMAT_S16;
     case PA_SAMPLE_S16LE:
         *endianness = 0;
-        return AUD_FMT_S16;
+        return AUDIO_FORMAT_S16;
     case PA_SAMPLE_S32BE:
         *endianness = 1;
-        return AUD_FMT_S32;
+        return AUDIO_FORMAT_S32;
     case PA_SAMPLE_S32LE:
         *endianness = 0;
-        return AUD_FMT_S32;
+        return AUDIO_FORMAT_S32;
     default:
         dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
-        return AUD_FMT_U8;
+        return AUDIO_FORMAT_U8;
     }
 }
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 9db5ac92bc..aa42ea26bf 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -137,19 +137,19 @@ static int sdl_unlock_and_post (SDLAudioState *s, const char *forfn)
     return sdl_post (s, forfn);
 }
 
-static int aud_to_sdlfmt (audfmt_e fmt)
+static int aud_to_sdlfmt (AudioFormat fmt)
 {
     switch (fmt) {
-    case AUD_FMT_S8:
+    case AUDIO_FORMAT_S8:
         return AUDIO_S8;
 
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_U8:
         return AUDIO_U8;
 
-    case AUD_FMT_S16:
+    case AUDIO_FORMAT_S16:
         return AUDIO_S16LSB;
 
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_U16:
         return AUDIO_U16LSB;
 
     default:
@@ -161,37 +161,37 @@ static int aud_to_sdlfmt (audfmt_e fmt)
     }
 }
 
-static int sdl_to_audfmt(int sdlfmt, audfmt_e *fmt, int *endianness)
+static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, int *endianness)
 {
     switch (sdlfmt) {
     case AUDIO_S8:
         *endianness = 0;
-        *fmt = AUD_FMT_S8;
+        *fmt = AUDIO_FORMAT_S8;
         break;
 
     case AUDIO_U8:
         *endianness = 0;
-        *fmt = AUD_FMT_U8;
+        *fmt = AUDIO_FORMAT_U8;
         break;
 
     case AUDIO_S16LSB:
         *endianness = 0;
-        *fmt = AUD_FMT_S16;
+        *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AUDIO_U16LSB:
         *endianness = 0;
-        *fmt = AUD_FMT_U16;
+        *fmt = AUDIO_FORMAT_U16;
         break;
 
     case AUDIO_S16MSB:
         *endianness = 1;
-        *fmt = AUD_FMT_S16;
+        *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AUDIO_U16MSB:
         *endianness = 1;
-        *fmt = AUD_FMT_U16;
+        *fmt = AUDIO_FORMAT_U16;
         break;
 
     default:
@@ -386,7 +386,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     SDL_AudioSpec req, obt;
     int endianness;
     int err;
-    audfmt_e effective_fmt;
+    AudioFormat effective_fmt;
     struct audsettings obt_as;
 
     req.freq = as->freq;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 6ad0eafbc6..3aeb0cb357 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -130,7 +130,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
     settings.freq       = SPICE_INTERFACE_PLAYBACK_FREQ;
 #endif
     settings.nchannels  = SPICE_INTERFACE_PLAYBACK_CHAN;
-    settings.fmt        = AUD_FMT_S16;
+    settings.fmt        = AUDIO_FORMAT_S16;
     settings.endianness = AUDIO_HOST_ENDIANNESS;
 
     audio_pcm_init_info (&hw->info, &settings);
@@ -258,7 +258,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     settings.freq       = SPICE_INTERFACE_RECORD_FREQ;
 #endif
     settings.nchannels  = SPICE_INTERFACE_RECORD_CHAN;
-    settings.fmt        = AUD_FMT_S16;
+    settings.fmt        = AUDIO_FORMAT_S16;
     settings.endianness = AUDIO_HOST_ENDIANNESS;
 
     audio_pcm_init_info (&hw->info, &settings);
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 40adfa30c3..35a614785e 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -117,20 +117,23 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     stereo = wav_as.nchannels == 2;
     switch (wav_as.fmt) {
-    case AUD_FMT_S8:
-    case AUD_FMT_U8:
+    case AUDIO_FORMAT_S8:
+    case AUDIO_FORMAT_U8:
         bits16 = 0;
         break;
 
-    case AUD_FMT_S16:
-    case AUD_FMT_U16:
+    case AUDIO_FORMAT_S16:
+    case AUDIO_FORMAT_U16:
         bits16 = 1;
         break;
 
-    case AUD_FMT_S32:
-    case AUD_FMT_U32:
+    case AUDIO_FORMAT_S32:
+    case AUDIO_FORMAT_U32:
         dolog ("WAVE files can not handle 32bit formats\n");
         return -1;
+
+    default:
+        abort();
     }
 
     hdr[34] = bits16 ? 0x10 : 0x08;
@@ -225,7 +228,7 @@ static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
 static WAVConf glob_conf = {
     .settings.freq      = 44100,
     .settings.nchannels = 2,
-    .settings.fmt       = AUD_FMT_S16,
+    .settings.fmt       = AUDIO_FORMAT_S16,
     .wav_path           = "qemu.wav"
 };
 
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index cf31ed652c..e943565210 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -139,7 +139,7 @@ int wav_start_capture (CaptureState *s, const char *path, int freq,
 
     as.freq = freq;
     as.nchannels = 1 << stereo;
-    as.fmt = bits16 ? AUD_FMT_S16 : AUD_FMT_U8;
+    as.fmt = bits16 ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8;
     as.endianness = 0;
 
     ops.notify = wav_notify;
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 3c7d1364a9..96e84f6e7e 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -273,7 +273,7 @@ static void omap_eac_format_update(struct omap_eac_s *s)
      * does I2S specify it?  */
     /* All register writes are 16 bits so we we store 16-bit samples
      * in the buffers regardless of AGCFR[B8_16] value.  */
-    fmt.fmt = AUD_FMT_U16;
+    fmt.fmt = AUDIO_FORMAT_U16;
 
     s->codec.in_voice = AUD_open_in(&s->codec.card, s->codec.in_voice,
                     "eac.codec.in", s, omap_eac_in_cb, &fmt);
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index d799533aa9..2265622d44 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -365,7 +365,7 @@ static void open_voice (AC97LinkState *s, int index, int freq)
 
     as.freq = freq;
     as.nchannels = 2;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
     if (freq > 0) {
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 97b876c7e0..0957780a3d 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -269,7 +269,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
 
     as.freq = s->freq;
     as.nchannels = SHIFT;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = AUDIO_HOST_ENDIANNESS;
 
     AUD_register_card ("adlib", &s->card);
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 9089dcb47e..62da75eefe 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -288,7 +288,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
 
     switch ((val >> 5) & ((s->dregs[MODE_And_ID] & MODE2) ? 7 : 3)) {
     case 0:
-        as.fmt = AUD_FMT_U8;
+        as.fmt = AUDIO_FORMAT_U8;
         s->shift = as.nchannels == 2;
         break;
 
@@ -298,7 +298,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     case 3:
         s->tab = ALawDecompressTable;
     x_law:
-        as.fmt = AUD_FMT_S16;
+        as.fmt = AUDIO_FORMAT_S16;
         as.endianness = AUDIO_HOST_ENDIANNESS;
         s->shift = as.nchannels == 2;
         break;
@@ -307,7 +307,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
         as.endianness = 1;
         /* fall through */
     case 2:
-        as.fmt = AUD_FMT_S16;
+        as.fmt = AUDIO_FORMAT_S16;
         s->shift = as.nchannels;
         break;
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 97789a0771..a5314d66fd 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -414,14 +414,14 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                     i,
                     new_freq,
                     1 << (new_fmt & 1),
-                    (new_fmt & 2) ? AUD_FMT_S16 : AUD_FMT_U8,
+                    (new_fmt & 2) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8,
                     d->shift);
             if (new_freq) {
                 struct audsettings as;
 
                 as.freq = new_freq;
                 as.nchannels = 1 << (new_fmt & 1);
-                as.fmt = (new_fmt & 2) ? AUD_FMT_S16 : AUD_FMT_U8;
+                as.fmt = (new_fmt & 2) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8;
                 as.endianness = 0;
 
                 if (i == ADC_CHANNEL) {
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 8e0b27e0f2..b3e2a7fdd5 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -251,7 +251,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
 
     as.freq = s->freq;
     as.nchannels = 2;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = GUS_ENDIANNESS;
 
     s->voice = AUD_open_out (
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 617a1c1016..c25bfa38b1 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -99,9 +99,9 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
     }
 
     switch (format & AC_FMT_BITS_MASK) {
-    case AC_FMT_BITS_8:  as->fmt = AUD_FMT_S8;  break;
-    case AC_FMT_BITS_16: as->fmt = AUD_FMT_S16; break;
-    case AC_FMT_BITS_32: as->fmt = AUD_FMT_S32; break;
+    case AC_FMT_BITS_8:  as->fmt = AUDIO_FORMAT_S8;  break;
+    case AC_FMT_BITS_16: as->fmt = AUDIO_FORMAT_S16; break;
+    case AC_FMT_BITS_32: as->fmt = AUDIO_FORMAT_S32; break;
     }
 
     as->nchannels = ((format & AC_FMT_CHAN_MASK) >> AC_FMT_CHAN_SHIFT) + 1;
@@ -134,12 +134,12 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
 /* -------------------------------------------------------------------------- */
 
 static const char *fmt2name[] = {
-    [ AUD_FMT_U8  ] = "PCM-U8",
-    [ AUD_FMT_S8  ] = "PCM-S8",
-    [ AUD_FMT_U16 ] = "PCM-U16",
-    [ AUD_FMT_S16 ] = "PCM-S16",
-    [ AUD_FMT_U32 ] = "PCM-U32",
-    [ AUD_FMT_S32 ] = "PCM-S32",
+    [ AUDIO_FORMAT_U8  ] = "PCM-U8",
+    [ AUDIO_FORMAT_S8  ] = "PCM-S8",
+    [ AUDIO_FORMAT_U16 ] = "PCM-U16",
+    [ AUDIO_FORMAT_S16 ] = "PCM-S16",
+    [ AUDIO_FORMAT_U32 ] = "PCM-U32",
+    [ AUDIO_FORMAT_S32 ] = "PCM-S32",
 };
 
 typedef struct HDAAudioState HDAAudioState;
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index a46f2301af..af8b22b541 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -185,7 +185,7 @@ void lm4549_write(lm4549_state *s,
         struct audsettings as;
         as.freq = value;
         as.nchannels = 2;
-        as.fmt = AUD_FMT_S16;
+        as.fmt = AUDIO_FORMAT_S16;
         as.endianness = 0;
 
         s->voice = AUD_open_out(
@@ -255,7 +255,7 @@ static int lm4549_post_load(void *opaque, int version_id)
     struct audsettings as;
     as.freq = freq;
     as.nchannels = 2;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
     s->voice = AUD_open_out(
@@ -292,7 +292,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque)
     /* Open a default voice */
     as.freq = 48000;
     as.nchannels = 2;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
     s->voice = AUD_open_out(
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index bc8db71ae0..90cce1e6ed 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -308,7 +308,7 @@ static void milkymist_ac97_realize(DeviceState *dev, Error **errp)
 
     as.freq = 48000;
     as.nchannels = 2;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 1;
 
     s->voice_in = AUD_open_in(&s->card, s->voice_in,
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 908696d483..4a7386a689 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -114,7 +114,7 @@ static void pcspk_callback(void *opaque, int free)
 static int pcspk_audio_init(ISABus *bus)
 {
     PCSpkState *s = pcspk_state;
-    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
+    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUDIO_FORMAT_U8, 0};
 
     AUD_register_card(s_spk, &s->card);
 
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index c5b9bf79e8..65ea0cd938 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -66,7 +66,7 @@ typedef struct SB16State {
     int fmt_stereo;
     int fmt_signed;
     int fmt_bits;
-    audfmt_e fmt;
+    AudioFormat fmt;
     int dma_auto;
     int block_size;
     int fifo;
@@ -224,7 +224,7 @@ static void continue_dma8 (SB16State *s)
 
 static void dma_cmd8 (SB16State *s, int mask, int dma_len)
 {
-    s->fmt = AUD_FMT_U8;
+    s->fmt = AUDIO_FORMAT_U8;
     s->use_hdma = 0;
     s->fmt_bits = 8;
     s->fmt_signed = 0;
@@ -319,18 +319,18 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
 
     if (16 == s->fmt_bits) {
         if (s->fmt_signed) {
-            s->fmt = AUD_FMT_S16;
+            s->fmt = AUDIO_FORMAT_S16;
         }
         else {
-            s->fmt = AUD_FMT_U16;
+            s->fmt = AUDIO_FORMAT_U16;
         }
     }
     else {
         if (s->fmt_signed) {
-            s->fmt = AUD_FMT_S8;
+            s->fmt = AUDIO_FORMAT_S8;
         }
         else {
-            s->fmt = AUD_FMT_U8;
+            s->fmt = AUDIO_FORMAT_U8;
         }
     }
 
@@ -852,7 +852,7 @@ static void legacy_reset (SB16State *s)
 
     as.freq = s->freq;
     as.nchannels = 1;
-    as.fmt = AUD_FMT_U8;
+    as.fmt = AUDIO_FORMAT_U8;
     as.endianness = 0;
 
     s->voice = AUD_open_out (
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index f4aa838f62..d563f31e7c 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -201,7 +201,7 @@ static void wm8750_set_format(WM8750State *s)
     in_fmt.endianness = 0;
     in_fmt.nchannels = 2;
     in_fmt.freq = s->adc_hz;
-    in_fmt.fmt = AUD_FMT_S16;
+    in_fmt.fmt = AUDIO_FORMAT_S16;
 
     s->adc_voice[0] = AUD_open_in(&s->card, s->adc_voice[0],
                     CODEC ".input1", s, wm8750_audio_in_cb, &in_fmt);
@@ -214,7 +214,7 @@ static void wm8750_set_format(WM8750State *s)
     out_fmt.endianness = 0;
     out_fmt.nchannels = 2;
     out_fmt.freq = s->dac_hz;
-    out_fmt.fmt = AUD_FMT_S16;
+    out_fmt.fmt = AUDIO_FORMAT_S16;
 
     s->dac_voice[0] = AUD_open_out(&s->card, s->dac_voice[0],
                     CODEC ".speaker", s, wm8750_audio_out_cb, &out_fmt);
@@ -681,7 +681,7 @@ uint32_t wm8750_adc_dat(void *opaque)
     if (s->idx_in >= sizeof(s->data_in)) {
         wm8750_in_load(s);
         if (s->idx_in >= sizeof(s->data_in)) {
-            return 0x80008000; /* silence in AUD_FMT_S16 sample format */
+            return 0x80008000; /* silence in AUDIO_FORMAT_S16 sample format */
         }
     }
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index cc0f9bc9cc..11b09bd18c 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1260,7 +1260,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
 
     as.freq = 44100;
     as.nchannels = 2;
-    as.fmt = AUD_FMT_S16;
+    as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
     AUD_register_card("xlnx_dp.audio", &s->aud_card);
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index ded0db9351..885f71366c 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -318,7 +318,7 @@ static void tsc2102_audio_output_update(TSC210xState *s)
     fmt.endianness = 0;
     fmt.nchannels = 2;
     fmt.freq = s->codec.tx_rate;
-    fmt.fmt = AUD_FMT_S16;
+    fmt.fmt = AUDIO_FORMAT_S16;
 
     s->dac_voice[0] = AUD_open_out(&s->card, s->dac_voice[0],
                     "tsc2102.sink", s, (void *) tsc210x_audio_out_cb, &fmt);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 28ac7c5165..c46d5eeb79 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -650,7 +650,7 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
     s->out.vol[1]        = 240; /* 0 dB */
     s->out.as.freq       = USBAUDIO_SAMPLE_RATE;
     s->out.as.nchannels  = 2;
-    s->out.as.fmt        = AUD_FMT_S16;
+    s->out.as.fmt        = AUDIO_FORMAT_S16;
     s->out.as.endianness = 0;
     streambuf_init(&s->out.buf, s->buffer);
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 9e4b2beb71..48c1b95aae 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -994,16 +994,16 @@ static void vnc_update_throttle_offset(VncState *vs)
         int bps;
         switch (vs->as.fmt) {
         default:
-        case  AUD_FMT_U8:
-        case  AUD_FMT_S8:
+        case  AUDIO_FORMAT_U8:
+        case  AUDIO_FORMAT_S8:
             bps = 1;
             break;
-        case  AUD_FMT_U16:
-        case  AUD_FMT_S16:
+        case  AUDIO_FORMAT_U16:
+        case  AUDIO_FORMAT_S16:
             bps = 2;
             break;
-        case  AUD_FMT_U32:
-        case  AUD_FMT_S32:
+        case  AUDIO_FORMAT_U32:
+        case  AUDIO_FORMAT_S32:
             bps = 4;
             break;
         }
@@ -2409,12 +2409,12 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 if (len == 4)
                     return 10;
                 switch (read_u8(data, 4)) {
-                case 0: vs->as.fmt = AUD_FMT_U8; break;
-                case 1: vs->as.fmt = AUD_FMT_S8; break;
-                case 2: vs->as.fmt = AUD_FMT_U16; break;
-                case 3: vs->as.fmt = AUD_FMT_S16; break;
-                case 4: vs->as.fmt = AUD_FMT_U32; break;
-                case 5: vs->as.fmt = AUD_FMT_S32; break;
+                case 0: vs->as.fmt = AUDIO_FORMAT_U8; break;
+                case 1: vs->as.fmt = AUDIO_FORMAT_S8; break;
+                case 2: vs->as.fmt = AUDIO_FORMAT_U16; break;
+                case 3: vs->as.fmt = AUDIO_FORMAT_S16; break;
+                case 4: vs->as.fmt = AUDIO_FORMAT_U32; break;
+                case 5: vs->as.fmt = AUDIO_FORMAT_S32; break;
                 default:
                     VNC_DEBUG("Invalid audio format %d\n", read_u8(data, 4));
                     vnc_client_error(vs);
@@ -3145,7 +3145,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 
     vs->as.freq = 44100;
     vs->as.nchannels = 2;
-    vs->as.fmt = AUD_FMT_S16;
+    vs->as.fmt = AUDIO_FORMAT_S16;
     vs->as.endianness = 0;
 
     qemu_mutex_init(&vs->output_mutex);
-- 
2.20.1
