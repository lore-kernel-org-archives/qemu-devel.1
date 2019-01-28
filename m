Received: from eggs.gnu.org ([209.51.188.92]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdF-0007ty-Ig
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdB-0003UU-Ik
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFdB-0003Tr-7C
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:53 -0500
Received: by mail-wr1-x42b.google.com with SMTP id v13so19926568wrw.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:53 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:37 +0100
Message-Id: <7f6d8de296ebe22195aa2ad44d6de6eaecb4bc95.1548714862.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/14] audio: -audiodev command line option:
 cleanup
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

Remove no longer needed code.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_int.h |  17 ----
 audio/audio.c     | 201 +---------------------------------------------
 2 files changed, 4 insertions(+), 214 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index cee46c4809..51963ccff8 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -33,22 +33,6 @@
 
 struct audio_pcm_ops;
 
-typedef enum {
-    AUD_OPT_INT,
-    AUD_OPT_FMT,
-    AUD_OPT_STR,
-    AUD_OPT_BOOL
-} audio_option_tag_e;
-
-struct audio_option {
-    const char *name;
-    audio_option_tag_e tag;
-    void *valp;
-    const char *descr;
-    int *overriddenp;
-    int overridden;
-};
-
 struct audio_callback {
     void *opaque;
     audio_callback_fn fn;
@@ -145,7 +129,6 @@ typedef struct audio_driver audio_driver;
 struct audio_driver {
     const char *name;
     const char *descr;
-    struct audio_option *options;
     void *(*init) (Audiodev *);
     void (*fini) (void *);
     struct audio_pcm_ops *pcm_ops;
diff --git a/audio/audio.c b/audio/audio.c
index b37c245a8a..fd6e54998a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -172,113 +172,6 @@ void *audio_calloc (const char *funcname, int nmemb, size_t size)
     return g_malloc0 (len);
 }
 
-static const char *audio_audfmt_to_string (AudioFormat fmt)
-{
-    switch (fmt) {
-    case AUDIO_FORMAT_U8:
-        return "U8";
-
-    case AUDIO_FORMAT_U16:
-        return "U16";
-
-    case AUDIO_FORMAT_S8:
-        return "S8";
-
-    case AUDIO_FORMAT_S16:
-        return "S16";
-
-    case AUDIO_FORMAT_U32:
-        return "U32";
-
-    case AUDIO_FORMAT_S32:
-        return "S32";
-
-    default:
-        abort();
-    }
-
-    dolog ("Bogus audfmt %d returning S16\n", fmt);
-    return "S16";
-}
-
-static AudioFormat audio_string_to_audfmt (const char *s, AudioFormat defval,
-                                        int *defaultp)
-{
-    if (!strcasecmp (s, "u8")) {
-        *defaultp = 0;
-        return AUDIO_FORMAT_U8;
-    }
-    else if (!strcasecmp (s, "u16")) {
-        *defaultp = 0;
-        return AUDIO_FORMAT_U16;
-    }
-    else if (!strcasecmp (s, "u32")) {
-        *defaultp = 0;
-        return AUDIO_FORMAT_U32;
-    }
-    else if (!strcasecmp (s, "s8")) {
-        *defaultp = 0;
-        return AUDIO_FORMAT_S8;
-    }
-    else if (!strcasecmp (s, "s16")) {
-        *defaultp = 0;
-        return AUDIO_FORMAT_S16;
-    }
-    else if (!strcasecmp (s, "s32")) {
-        *defaultp = 0;
-        return AUDIO_FORMAT_S32;
-    }
-    else {
-        dolog ("Bogus audio format `%s' using %s\n",
-               s, audio_audfmt_to_string (defval));
-        *defaultp = 1;
-        return defval;
-    }
-}
-
-static AudioFormat audio_get_conf_fmt (const char *envname,
-                                    AudioFormat defval,
-                                    int *defaultp)
-{
-    const char *var = getenv (envname);
-    if (!var) {
-        *defaultp = 1;
-        return defval;
-    }
-    return audio_string_to_audfmt (var, defval, defaultp);
-}
-
-static int audio_get_conf_int (const char *key, int defval, int *defaultp)
-{
-    int val;
-    char *strval;
-
-    strval = getenv (key);
-    if (strval && !qemu_strtoi(strval, NULL, 10, &val)) {
-        *defaultp = 0;
-        return val;
-    }
-    else {
-        *defaultp = 1;
-        return defval;
-    }
-}
-
-static const char *audio_get_conf_str (const char *key,
-                                       const char *defval,
-                                       int *defaultp)
-{
-    const char *val = getenv (key);
-    if (!val) {
-        *defaultp = 1;
-        return defval;
-    }
-    else {
-        *defaultp = 0;
-        return val;
-    }
-}
-
 void AUD_vlog (const char *cap, const char *fmt, va_list ap)
 {
     if (cap) {
@@ -297,89 +190,6 @@ void AUD_log (const char *cap, const char *fmt, ...)
     va_end (ap);
 }
 
-static void audio_process_options (const char *prefix,
-                                   struct audio_option *opt)
-{
-    char *optname;
-    const char qemu_prefix[] = "QEMU_";
-    size_t preflen, optlen;
-
-    if (audio_bug(__func__, !prefix)) {
-        dolog ("prefix = NULL\n");
-        return;
-    }
-
-    if (audio_bug(__func__, !opt)) {
-        dolog ("opt = NULL\n");
-        return;
-    }
-
-    preflen = strlen (prefix);
-
-    for (; opt->name; opt++) {
-        size_t len, i;
-        int def;
-
-        if (!opt->valp) {
-            dolog ("Option value pointer for `%s' is not set\n",
-                   opt->name);
-            continue;
-        }
-
-        len = strlen (opt->name);
-        /* len of opt->name + len of prefix + size of qemu_prefix
-         * (includes trailing zero) + zero + underscore (on behalf of
-         * sizeof) */
-        optlen = len + preflen + sizeof (qemu_prefix) + 1;
-        optname = g_malloc (optlen);
-
-        pstrcpy (optname, optlen, qemu_prefix);
-
-        /* copy while upper-casing, including trailing zero */
-        for (i = 0; i <= preflen; ++i) {
-            optname[i + sizeof (qemu_prefix) - 1] = qemu_toupper(prefix[i]);
-        }
-        pstrcat (optname, optlen, "_");
-        pstrcat (optname, optlen, opt->name);
-
-        def = 1;
-        switch (opt->tag) {
-        case AUD_OPT_BOOL:
-        case AUD_OPT_INT:
-            {
-                int *intp = opt->valp;
-                *intp = audio_get_conf_int (optname, *intp, &def);
-            }
-            break;
-
-        case AUD_OPT_FMT:
-            {
-                AudioFormat *fmtp = opt->valp;
-                *fmtp = audio_get_conf_fmt (optname, *fmtp, &def);
-            }
-            break;
-
-        case AUD_OPT_STR:
-            {
-                const char **strp = opt->valp;
-                *strp = audio_get_conf_str (optname, *strp, &def);
-            }
-            break;
-
-        default:
-            dolog ("Bad value tag for option `%s' - %d\n",
-                   optname, opt->tag);
-            break;
-        }
-
-        if (!opt->overriddenp) {
-            opt->overriddenp = &opt->overridden;
-        }
-        *opt->overriddenp = !def;
-        g_free (optname);
-    }
-}
-
 static void audio_print_settings (struct audsettings *as)
 {
     dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
@@ -1092,7 +902,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_out(hw, VOICE_ENABLE, true);
+                    hw->pcm_ops->ctl_out(hw, VOICE_ENABLE);
                     audio_reset_timer (s);
                 }
             }
@@ -1137,7 +947,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_in(hw, VOICE_ENABLE, true);
+                    hw->pcm_ops->ctl_in(hw, VOICE_ENABLE);
                     audio_reset_timer (s);
                 }
             }
@@ -1461,9 +1271,6 @@ void audio_run (const char *msg)
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              bool msg, Audiodev *dev)
 {
-    if (drv->options) {
-        audio_process_options (drv->name, drv->options);
-    }
     s->drv_opaque = drv->init(dev);
 
     if (s->drv_opaque) {
@@ -1490,11 +1297,11 @@ static void audio_vm_change_state_handler (void *opaque, int running,
 
     s->vm_running = running;
     while ((hwo = audio_pcm_hw_find_any_enabled_out (hwo))) {
-        hwo->pcm_ops->ctl_out(hwo, op, true);
+        hwo->pcm_ops->ctl_out(hwo, op);
     }
 
     while ((hwi = audio_pcm_hw_find_any_enabled_in (hwi))) {
-        hwi->pcm_ops->ctl_in(hwi, op, true);
+        hwi->pcm_ops->ctl_in(hwi, op);
     }
     audio_reset_timer (s);
 }
-- 
2.20.1
