Received: from eggs.gnu.org ([208.118.235.92]:52368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAk1-0007v7-As
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAk0-0002e9-C4
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:53 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAk0-0002b5-4I
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:52 -0500
Received: by mail-wm1-x341.google.com with SMTP id y139so9809490wmc.5
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:52 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:01 +0100
Message-Id: <69db519bda51135da1fe3e379586c98756be3a1c.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 25/52] paaudio: fix playback glitches
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

Pulseaudio normally assumes that when the server wants it, the client
can generate the audio samples and send it right away.  Unfortunately
this is not the case with QEMU -- it's up to the emulated system when
does it generate the samples.  Buffering the samples and sending them
from a background thread is just a workaround, that doesn't work too
well.  Instead enable pa's compatibility support and let pa worry about
the details.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 6ed12851c0..9331e630d1 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -511,10 +511,8 @@ static pa_stream *qpa_simple_new (
 
     flags =
         PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-        |PA_STREAM_ADJUST_LATENCY
-#endif
-        |PA_STREAM_AUTO_TIMING_UPDATE;
+        |PA_STREAM_AUTO_TIMING_UPDATE
+        |PA_STREAM_EARLY_REQUESTS;
 
     if (dev) {
         /* don't move the stream if the user specified a sink/source */
-- 
2.20.1
