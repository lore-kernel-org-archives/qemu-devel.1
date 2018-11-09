Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL7eL-00063q-P1
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL7eI-0005J1-H3
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gL7eI-0005Ic-Av
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:20:38 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  9 Nov 2018 15:20:32 +0100
Message-Id: <20181109142032.1628-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] pulseaudio: process audio data in smaller
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
Buglink: https://bugs.launchpad.net/bugs/1795527
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
