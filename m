Received: from eggs.gnu.org ([208.118.235.92]:52688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkJ-0008Sg-U1
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkJ-0003qO-5H
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAkI-0003gk-Ll
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:10 -0500
Received: by mail-wr1-x444.google.com with SMTP id s12so10091412wrt.4
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:53:09 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:24 +0100
Message-Id: <62b2383050d51d0901322a10ea70eda298d60a5a.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 48/52] audio: basic support for multichannel
 audio
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

Which currently only means removing some checks.  Old code won't require
more than two channels, but new code will need it.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c | 7 -------
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 418b888a57..063531b743 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -498,13 +498,6 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         goto err;
     }
 
-    if (nchannels != 1 && nchannels != 2) {
-        alsa_logerr2 (err, typ,
-                      "Can not handle obtained number of channels %d\n",
-                      nchannels);
-        goto err;
-    }
-
     if (pdo->buffer_count) {
         if (pdo->buffer_len) {
             int64_t req = pdo->buffer_len * pdo->buffer_count;
diff --git a/audio/audio.c b/audio/audio.c
index ee508c1f15..782e4ed1c7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -241,7 +241,7 @@ static int audio_validate_settings (struct audsettings *as)
 {
     int invalid;
 
-    invalid = as->nchannels != 1 && as->nchannels != 2;
+    invalid = as->nchannels < 1;
     invalid |= as->endianness != 0 && as->endianness != 1;
 
     switch (as->fmt) {
-- 
2.20.1
