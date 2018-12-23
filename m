Received: from eggs.gnu.org ([208.118.235.92]:52297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjy-0007lm-2i
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjx-0002SI-8g
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjw-0002PN-UV
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id d15so9848809wmb.3
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:48 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:57 +0100
Message-Id: <4fbca2b5d360379e9a0134c585d1f72e512d4199.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 21/52] paaudio: do not move stream when
 sink/source name is specified
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

Unless we disable stream moving, pulseaudio can easily move the stream
on connect, effectively ignoring the source/sink specified by the user.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 24b75ca503..21ffbf7f6e 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -516,6 +516,11 @@ static pa_stream *qpa_simple_new (
 #endif
         |PA_STREAM_AUTO_TIMING_UPDATE;
 
+    if (dev) {
+        /* don't move the stream if the user specified a sink/source */
+        flags |= PA_STREAM_DONT_MOVE;
+    }
+
     if (dir == PA_STREAM_PLAYBACK) {
         r = pa_stream_connect_playback(stream, dev, attr, flags, NULL, NULL);
     } else {
-- 
2.20.1
