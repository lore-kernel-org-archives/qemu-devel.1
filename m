Received: from eggs.gnu.org ([2001:4830:134:3::10]:43224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faKHO-0000NP-LB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faKHL-0006x8-Fa
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:19:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faKHL-0006wh-9L
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:19:31 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 14:19:24 +0200
Message-Id: <20180703121924.11411-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] pulseaudio: process audio data in smaller
 chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Max Ehrlich <maxehr@umiacs.umd.edu>, Martin Schrodt <martin@schrodt.org>

The rate of pulseaudio absorbing the audio stream is used to control the
the rate of the guests audio stream.  When the emulated hardware uses
small chunks (like intel-hda does) we need small chunks on the audio
backend side too, otherwise that feedback loop doesn't work very well.

Cc: Max Ehrlich <maxehr@umiacs.umd.edu>
Cc: Martin Schrodt <martin@schrodt.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 949769774d..4c100bc318 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -227,7 +227,7 @@ static void *qpa_thread_out (void *arg)
             }
         }
 
-        decr = to_mix = audio_MIN (pa->live, pa->g->conf.samples >> 2);
+        decr = to_mix = audio_MIN(pa->live, pa->g->conf.samples >> 5);
         rpos = pa->rpos;
 
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -319,7 +319,7 @@ static void *qpa_thread_in (void *arg)
             }
         }
 
-        incr = to_grab = audio_MIN (pa->dead, pa->g->conf.samples >> 2);
+        incr = to_grab = audio_MIN(pa->dead, pa->g->conf.samples >> 5);
         wpos = pa->wpos;
 
         if (audio_pt_unlock(&pa->pt, __func__)) {
-- 
2.9.3
