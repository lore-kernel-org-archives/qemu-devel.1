Received: from eggs.gnu.org ([209.51.188.92]:52962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIco-00031o-N1
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIcm-0000xC-OC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIck-0000qG-MC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF696C075D75
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Feb 2019 11:08:55 +0100
Message-Id: <20190228100858.28397-3-kraxel@redhat.com>
In-Reply-To: <20190228100858.28397-1-kraxel@redhat.com>
References: <20190228100858.28397-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] audio: Do not check for audio_calloc failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

From: Frediano Ziglio <fziglio@redhat.com>

audio_calloc uses g_malloc0 which never returns in case of
memory failure.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Message-id: 20190225154335.11397-2-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 48 ++++++------------------------------------------
 1 file changed, 6 insertions(+), 42 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 472721a7a9f0..909c817103c8 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -811,12 +811,7 @@ static int audio_attach_capture (HWVoiceOut *hw)
         SWVoiceOut *sw;
         HWVoiceOut *hw_cap = &cap->hw;
 
-        sc = audio_calloc(__func__, 1, sizeof(*sc));
-        if (!sc) {
-            dolog ("Could not allocate soft capture voice (%zu bytes)\n",
-                   sizeof (*sc));
-            return -1;
-        }
+        sc = g_malloc0(sizeof(*sc));
 
         sc->cap = cap;
         sw = &sc->sw;
@@ -1960,15 +1955,10 @@ CaptureVoiceOut *AUD_add_capture (
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\n");
         audio_print_settings (as);
-        goto err0;
+        return NULL;
     }
 
-    cb = audio_calloc(__func__, 1, sizeof(*cb));
-    if (!cb) {
-        dolog ("Could not allocate capture callback information, size %zu\n",
-               sizeof (*cb));
-        goto err0;
-    }
+    cb = g_malloc0(sizeof(*cb));
     cb->ops = *ops;
     cb->opaque = cb_opaque;
 
@@ -1981,12 +1971,7 @@ CaptureVoiceOut *AUD_add_capture (
         HWVoiceOut *hw;
         CaptureVoiceOut *cap;
 
-        cap = audio_calloc(__func__, 1, sizeof(*cap));
-        if (!cap) {
-            dolog ("Could not allocate capture voice, size %zu\n",
-                   sizeof (*cap));
-            goto err1;
-        }
+        cap = g_malloc0(sizeof(*cap));
 
         hw = &cap->hw;
         QLIST_INIT (&hw->sw_head);
@@ -1994,23 +1979,11 @@ CaptureVoiceOut *AUD_add_capture (
 
         /* XXX find a more elegant way */
         hw->samples = 4096 * 4;
-        hw->mix_buf = audio_calloc(__func__, hw->samples,
-                                   sizeof(struct st_sample));
-        if (!hw->mix_buf) {
-            dolog ("Could not allocate capture mix buffer (%d samples)\n",
-                   hw->samples);
-            goto err2;
-        }
+        hw->mix_buf = g_new0(struct st_sample, hw->samples);
 
         audio_pcm_init_info (&hw->info, as);
 
-        cap->buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-        if (!cap->buf) {
-            dolog ("Could not allocate capture buffer "
-                   "(%d samples, each %d bytes)\n",
-                   hw->samples, 1 << hw->info.shift);
-            goto err3;
-        }
+        cap->buf = g_malloc0_n(hw->samples, 1 << hw->info.shift);
 
         hw->clip = mixeng_clip
             [hw->info.nchannels == 2]
@@ -2025,15 +1998,6 @@ CaptureVoiceOut *AUD_add_capture (
             audio_attach_capture (hw);
         }
         return cap;
-
-    err3:
-        g_free (cap->hw.mix_buf);
-    err2:
-        g_free (cap);
-    err1:
-        g_free (cb);
-    err0:
-        return NULL;
     }
 }
 
-- 
2.9.3
