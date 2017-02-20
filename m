Received: from eggs.gnu.org ([2001:4830:134:3::10]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfohY-0000l0-MZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfohT-00052P-QR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:12:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfohT-000522-Kh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:12:23 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 15:12:18 +0100
Message-Id: <1487599939-4776-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487599939-4776-1-git-send-email-kraxel@redhat.com>
References: <1487599939-4776-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Gerd Hoffmann <kraxel@redhat.com>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch changes resetting strategy of the audio polling timer.
It does not change expiration time if the timer is already set.
This patch is needed to make this timer deterministic and to use execution
record/replay for audio devices.

audio_reset_timer is used in the function audio_vm_change_state_handler.
Therefore every time VM is stopped or restarted the timer will be reset
to new timeout. Virtual clock does not proceed while VM is stopped.
Therefore there is no need in resetting the timeout when VM restarts.

v2: updated commit message
v3: now using timer_mod_anticipate function (as suggested by Yurii Zubrytskyi)

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-id: 20170214071510.6112.76764.stgit@PASHA-ISP
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 21f7b0b..c8898d8 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1113,7 +1113,7 @@ static int audio_is_timer_needed (void)
 static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
-        timer_mod (s->ts,
+        timer_mod_anticipate_ns(s->ts,
             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
     }
     else {
-- 
1.8.3.1
