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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27054C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3098216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y44vKvtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3098216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74kD-0002Ic-F3
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dt-0005Rw-Lg
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dr-0005oB-9Y
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:41 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dq-0005mt-4I
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:38 -0400
Received: by mail-qt1-x844.google.com with SMTP id v11so13752102qto.13
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DqChsnZIXAGMvroXVL0MQvbI8g2z6bOPhBgHC6Jjg7E=;
 b=Y44vKvtKU2mgLemYMAQ4uc++tShUwkLhJ3jxo7YZv4QpytQaQwTt+J7ZCK7VENOfxm
 qBHTWKUArB7lJiNnWfbHBlZN03RUZncHmpEehgjNkNA6qe47DH5iwChGHzZGYENjp8bz
 WpcIqk5H1VwYKwiZXsjH8s6TnYoMgZ+NaKdLkNTddhSTetCxXD6zbWL6R11FpcuwAYcH
 SGxrXJJMtYG0rUHftK5EQ95q76GSUHNs7sKc4PrS3P63GMWsZTU4KtcGS3exrhkgJSAb
 Utl/F9qD/UgOzEwzBNQqI4rgCu5Xcb5iCKGeOIaviYf4D00F/DK7j7AcA6AKNHUt/w7L
 amhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DqChsnZIXAGMvroXVL0MQvbI8g2z6bOPhBgHC6Jjg7E=;
 b=kwcgHE+W9p6GdiUwyZuRaw0++EkU6Fen/pU1+ZWuWxDqCe2J6SWY0QLh9VWb1MMim9
 zOd6JNBR2vDMObG7mfxQkCpLKWqSbWC7RVZum7Ywh2P81U0WxZFAxKJCw5OHdIi2OaIr
 efjybhEce3CrOQJ+YEOz+2YzXuPhc937qXPYr2KwErVaR8HsnJD6ffHdKWD+kKhgjCjq
 2VGs/AWLDBQqVmvlywQJfa7xndpZZd17pX/MGrvxRnz01p/1rqakbs1hAOWgBJKpC+hG
 95v7xQM/nLEXmtkgXNjgqAF/QFcrf2E50EnArmcr2tgBNcDT8Bt7dE2FVVTSvyv6YPxU
 1a1g==
X-Gm-Message-State: APjAAAVeAjgnLo0Fv/6hmb8pckvjrzzbb8cLLxFH7NieTyQqnBrsTUes
 sIqRzROz+gdtd+5GRrlW2VIOJ83g
X-Google-Smtp-Source: APXvYqz3XPzj6vsjUbatiR4awQAz+eoNhnT3mFrW+LcsK+mPMWs5385ITsi79n3+tUDdQPolmmVxeg==
X-Received: by 2002:ac8:7101:: with SMTP id z1mr7800315qto.367.1567977756480; 
 Sun, 08 Sep 2019 14:22:36 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:36 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:08 +0200
Message-Id: <0fb21a31b645b0d84fa7979f770aaecd60ccca3c.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v2 08/24] sdlaudio: port to the new audio
 backend api
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/sdlaudio.c | 87 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 14b11f0335..f7ac8cd101 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -41,8 +41,6 @@
 
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
-    size_t live;
-    size_t decr;
 } SDLVoiceOut;
 
 static struct SDLAudioState {
@@ -184,62 +182,59 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     SDLVoiceOut *sdl = opaque;
     SDLAudioState *s = &glob_sdl;
     HWVoiceOut *hw = &sdl->hw;
-    size_t samples = len >> hw->info.shift;
-    size_t to_mix, decr;
 
-    if (s->exit || !sdl->live) {
+    if (s->exit) {
         return;
     }
 
     /* dolog ("in callback samples=%zu live=%zu\n", samples, sdl->live); */
 
-    to_mix = MIN(samples, sdl->live);
-    decr = to_mix;
-    while (to_mix) {
-        size_t chunk = MIN(to_mix, hw->samples - hw->rpos);
-        struct st_sample *src = hw->mix_buf + hw->rpos;
-
-        /* dolog ("in callback to_mix %zu, chunk %zu\n", to_mix, chunk); */
-        hw->clip(buf, src, chunk);
-        hw->rpos = (hw->rpos + chunk) % hw->samples;
-        to_mix -= chunk;
-        buf += chunk << hw->info.shift;
+    while (hw->pending_emul && len) {
+        size_t write_len;
+        ssize_t start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+        if (start < 0) {
+            start += hw->size_emul;
+        }
+        assert(start >= 0 && start < hw->size_emul);
+
+        write_len = MIN(MIN(hw->pending_emul, len),
+                        hw->size_emul - start);
+
+        memcpy(buf, hw->buf_emul + start, write_len);
+        hw->pending_emul -= write_len;
+        len -= write_len;
+        buf += write_len;
     }
-    samples -= decr;
-    sdl->live -= decr;
-    sdl->decr += decr;
 
-    /* dolog ("done len=%zu\n", len); */
-
-    /* SDL2 does not clear the remaining buffer for us, so do it on our own */
-    if (samples) {
-        memset(buf, 0, samples << hw->info.shift);
+    /* clear remaining buffer that we couldn't fill with data */
+    if (len) {
+        memset(buf, 0, len);
     }
 }
 
-static size_t sdl_run_out(HWVoiceOut *hw, size_t live)
-{
-    size_t decr;
-    SDLVoiceOut *sdl = (SDLVoiceOut *) hw;
-
-    SDL_LockAudio();
-
-    if (sdl->decr > live) {
-        ldebug ("sdl->decr %d live %d sdl->live %d\n",
-                sdl->decr,
-                live,
-                sdl->live);
+#define SDL_WRAPPER_FUNC(name, ret_type, args_decl, args, fail, unlock) \
+    static ret_type glue(sdl_, name)args_decl                           \
+    {                                                                   \
+        ret_type ret;                                                   \
+                                                                        \
+        SDL_LockAudio();                                                \
+                                                                        \
+        ret = glue(audio_generic_, name)args;                           \
+                                                                        \
+        SDL_UnlockAudio();                                              \
+        return ret;                                                     \
     }
 
-    decr = MIN (sdl->decr, live);
-    sdl->decr -= decr;
-
-    sdl->live = live;
+SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
+                 (hw, size), *size = 0, sdl_unlock)
+SDL_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size),
+                 /*nothing*/, sdl_unlock_and_post)
+SDL_WRAPPER_FUNC(write, size_t,
+                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size),
+                 /*nothing*/, sdl_unlock_and_post)
 
-    SDL_UnlockAudio();
-
-    return decr;
-}
+#undef SDL_WRAPPER_FUNC
 
 static void sdl_fini_out (HWVoiceOut *hw)
 {
@@ -336,7 +331,9 @@ static void sdl_audio_fini (void *opaque)
 static struct audio_pcm_ops sdl_pcm_ops = {
     .init_out = sdl_init_out,
     .fini_out = sdl_fini_out,
-    .run_out  = sdl_run_out,
+    .write    = sdl_write,
+    .get_buffer_out = sdl_get_buffer_out,
+    .put_buffer_out = sdl_put_buffer_out_nowrite,
     .ctl_out  = sdl_ctl_out,
 };
 
-- 
2.23.0


