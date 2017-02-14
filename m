Received: from eggs.gnu.org ([2001:4830:134:3::10]:55399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cdXKX-0006Sd-IZ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cdXKU-0007T0-9m
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:15:17 -0500
Received: from mail.ispras.ru ([83.149.199.45]:49986)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cdXKU-0007QC-1k
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:15:14 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 14 Feb 2017 10:15:10 +0300
Message-ID: <20170214071510.6112.76764.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zyy@google.com, dovgaluk@ispras.ru, kraxel@redhat.com, marcandre.lureau@gmail.com

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
---
 audio/audio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index c845a44..beadf7b 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1112,7 +1112,7 @@ static int audio_is_timer_needed (void)
 static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
-        timer_mod (s->ts,
+        timer_mod_anticipate_ns(s->ts,
             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
     }
     else {
