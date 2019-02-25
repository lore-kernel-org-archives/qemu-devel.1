Received: from eggs.gnu.org ([209.51.188.92]:45586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gyIX7-0007ZG-C0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gyIX6-0006YQ-7c
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:51:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gyIX5-0006LJ-Sr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:51:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8111730014CC
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 15:43:44 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
Date: Mon, 25 Feb 2019 15:43:35 +0000
Message-Id: <20190225154335.11397-2-fziglio@redhat.com>
In-Reply-To: <20190225154335.11397-1-fziglio@redhat.com>
References: <20190225154335.11397-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] audio: Do not check for audio_calloc
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

audio_calloc uses g_malloc0 which never returns in case of
memory failure.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 audio/audio.c | 48 ++++++------------------------------------------
 1 file changed, 6 insertions(+), 42 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 472721a7a9..909c817103 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -811,12 +811,7 @@ static int audio_attach_capture (HWVoiceOut *hw)
         SWVoiceOut *sw;
         HWVoiceOut *hw_cap =3D &cap->hw;
=20
-        sc =3D audio_calloc(__func__, 1, sizeof(*sc));
-        if (!sc) {
-            dolog ("Could not allocate soft capture voice (%zu bytes)\n"=
,
-                   sizeof (*sc));
-            return -1;
-        }
+        sc =3D g_malloc0(sizeof(*sc));
=20
         sc->cap =3D cap;
         sw =3D &sc->sw;
@@ -1960,15 +1955,10 @@ CaptureVoiceOut *AUD_add_capture (
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\=
n");
         audio_print_settings (as);
-        goto err0;
+        return NULL;
     }
=20
-    cb =3D audio_calloc(__func__, 1, sizeof(*cb));
-    if (!cb) {
-        dolog ("Could not allocate capture callback information, size %z=
u\n",
-               sizeof (*cb));
-        goto err0;
-    }
+    cb =3D g_malloc0(sizeof(*cb));
     cb->ops =3D *ops;
     cb->opaque =3D cb_opaque;
=20
@@ -1981,12 +1971,7 @@ CaptureVoiceOut *AUD_add_capture (
         HWVoiceOut *hw;
         CaptureVoiceOut *cap;
=20
-        cap =3D audio_calloc(__func__, 1, sizeof(*cap));
-        if (!cap) {
-            dolog ("Could not allocate capture voice, size %zu\n",
-                   sizeof (*cap));
-            goto err1;
-        }
+        cap =3D g_malloc0(sizeof(*cap));
=20
         hw =3D &cap->hw;
         QLIST_INIT (&hw->sw_head);
@@ -1994,23 +1979,11 @@ CaptureVoiceOut *AUD_add_capture (
=20
         /* XXX find a more elegant way */
         hw->samples =3D 4096 * 4;
-        hw->mix_buf =3D audio_calloc(__func__, hw->samples,
-                                   sizeof(struct st_sample));
-        if (!hw->mix_buf) {
-            dolog ("Could not allocate capture mix buffer (%d samples)\n=
",
-                   hw->samples);
-            goto err2;
-        }
+        hw->mix_buf =3D g_new0(struct st_sample, hw->samples);
=20
         audio_pcm_init_info (&hw->info, as);
=20
-        cap->buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
-        if (!cap->buf) {
-            dolog ("Could not allocate capture buffer "
-                   "(%d samples, each %d bytes)\n",
-                   hw->samples, 1 << hw->info.shift);
-            goto err3;
-        }
+        cap->buf =3D g_malloc0_n(hw->samples, 1 << hw->info.shift);
=20
         hw->clip =3D mixeng_clip
             [hw->info.nchannels =3D=3D 2]
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
=20
--=20
2.20.1
