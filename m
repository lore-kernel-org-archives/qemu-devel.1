Received: from eggs.gnu.org ([2001:4830:134:3::10]:34044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cj6N9-0000N5-1z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cj6N5-0000C5-BE
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cj6N4-0000Bl-T0
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:55 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  1 Mar 2017 16:40:49 +0100
Message-Id: <1488382850-19252-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
References: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v3 2/3] audio: make audio poll timer
 deterministic
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
