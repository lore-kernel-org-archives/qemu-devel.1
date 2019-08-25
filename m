Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C912E206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdkt+ve2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C912E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xg7-0002wi-OI
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXJ-0001Fb-Dl
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXI-0004pE-33
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:45 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXH-0004p8-VR
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:44 -0400
Received: by mail-qt1-x842.google.com with SMTP id y26so15975598qto.4
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rlmiv/v6jZGZODzJ/3foNb57kjc17VAa1kyVUGhmSF4=;
 b=Mdkt+ve2qoQHXuC2VvmsV+a6+SYVwPZvqk2Q/H+G3+UwklURnscL0QeNGIeLX6IjVp
 Nzr/Z0pcPlGcFeDQnr81Zo0UpOE61tqys8/L5waAzwgHldPXMRgf1jMEFqqq6pG0S39t
 O94KU7PXe8cVBthX3d+mQk7DMvKCLqMPifmQud/sCAzL0wXNJ7FZ2ENG51ErrRo9VH2t
 IVCFNExdpqlAbv+jQ9tiLXKRrHanCUb5OdzdpFIER66S2Rjs2GmFuVtOZoONvVWfpvaF
 bVlyNBcHVz6yLlEVJgcrowYJoLfylQE0ayi/PQ8iZODlfK1kgeALZr1LNkFPkJkkzPno
 PiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rlmiv/v6jZGZODzJ/3foNb57kjc17VAa1kyVUGhmSF4=;
 b=QgxypgfKMTDqiF5Fv7nipGJGleoChbizMdJ1Ipw0fAqKJZdc4tMC3uNNcjDVvqScrh
 CRZ7dI5bUnnscI3NM9Tg95GM0Ptz/wmngAXeWr16xC8/s/uhuxrpQPdWwIDAfBSe34py
 I8Z4Ifiobcp9N3KyR34XtJf2I+M4az4TDZ8mct8yY+yIpNBLKEoSbI6dl83paUJJeHlF
 FtkQVRm/BJxAkJAUXEzIVWHrFwbsXceh7nxSa1P24hf1nk1oEVPZK6n3wIlUVStLgYRk
 UJ1ajBSTNh7VTlJUMktji78SEp9+DvuWNixntG+qNuY0FIMC5kdemyxKoDRGyhXV/gQ0
 vHUg==
X-Gm-Message-State: APjAAAWpp6kh1XXHRXHTj9U1tA7HugIitAxK30SaHe99dFJPrFh/M8Ho
 +EoNNdTHBjVfSSSHSWN6X/63GFm2Zkg=
X-Google-Smtp-Source: APXvYqwQlkVqzUOXK54fsN/59ZL8IFrjAuUNXU5Z3FYHK0DIPHvVWWZ7MNQjVgw44RUVM0bMIq141Q==
X-Received: by 2002:ac8:6997:: with SMTP id o23mr7665580qtq.279.1566758803471; 
 Sun, 25 Aug 2019 11:46:43 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:43 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:13 +0200
Message-Id: <a5c48b48f5effe765cef8c748cc332c8a77926f5.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH 11/25] audio: remove remains of the old backend
 api
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
 audio/audio_int.h |  7 -------
 audio/audio.c     | 42 ++++++------------------------------------
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8fb1ca8a8d..c76d7c39e8 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -153,7 +153,6 @@ struct audio_driver {
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
-    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
@@ -171,7 +170,6 @@ struct audio_pcm_ops {
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
-    size_t (*run_in)(HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
@@ -237,11 +235,6 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
-
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending);
-
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
diff --git a/audio/audio.c b/audio/audio.c
index 0dfcfeaf06..d1c9ce855f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -541,7 +541,7 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
+static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
     if (audio_bug(__func__, live > hw->samples)) {
@@ -551,29 +551,7 @@ size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
     return live;
 }
 
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending)
-{
-    size_t left = hw->samples - pending;
-    size_t len = MIN (left, live);
-    size_t clipped = 0;
-
-    while (len) {
-        struct st_sample *src = hw->mix_buf + hw->rpos;
-        uint8_t *dst = advance (pcm_buf, hw->rpos << hw->info.shift);
-        size_t samples_till_end_of_buf = hw->samples - hw->rpos;
-        size_t samples_to_clip = MIN (len, samples_till_end_of_buf);
-
-        hw->clip (dst, src, samples_to_clip);
-
-        hw->rpos = (hw->rpos + samples_to_clip) % hw->samples;
-        len -= samples_to_clip;
-        clipped += samples_to_clip;
-    }
-    return clipped;
-}
-
-static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t len)
+static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 {
     size_t clipped = 0;
     size_t pos = hw->rpos;
@@ -1078,7 +1056,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
         void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
 
         decr = MIN(size >> hw->info.shift, live);
-        audio_pcm_hw_clip_out2(hw, buf, decr);
+        audio_pcm_hw_clip_out(hw, buf, decr);
         proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
             hw->info.shift;
 
@@ -1141,11 +1119,7 @@ static void audio_run_out (AudioState *s)
         }
 
         prev_rpos = hw->rpos;
-        if (hw->pcm_ops->run_out) {
-            played = hw->pcm_ops->run_out(hw, live);
-        } else {
-            played = audio_pcm_hw_run_out(hw, live);
-        }
+        played = audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
             dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
@@ -1242,12 +1216,8 @@ static void audio_run_in (AudioState *s)
         size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
-            if (hw->pcm_ops->run_in) {
-                captured = hw->pcm_ops->run_in(hw);
-            } else {
-                captured = audio_pcm_hw_run_in(
-                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
-            }
+            captured = audio_pcm_hw_run_in(
+                hw, hw->samples - audio_pcm_hw_get_live_in(hw));
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
 
-- 
2.22.0


