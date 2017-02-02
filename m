Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cZAaG-0002IA-Fb
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 01:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cZAaB-00032e-G1
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 01:09:28 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39698)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cZAaB-00031w-99
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 01:09:23 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 02 Feb 2017 09:09:24 +0300
Message-ID: <20170202060924.7440.78149.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, marcandre.lureau@gmail.com

This patch changes resetting strategy of the audio polling timer.
It does not change expiration time if the timer is already set.
This patch is needed to make this timer deterministic and to use execution
record/replay for audio devices.

audio_reset_timer is used in the function audio_vm_change_state_handler.
Therefore every time VM is stopped or restarted the timer will be reset
to new timeout. Virtual clock does not proceed while VM is stopped.
Therefore there is no need in resetting the timeout when VM restarts.

v2: updated commit message

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 audio/audio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index c845a44..834d433 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1112,8 +1112,10 @@ static int audio_is_timer_needed (void)
 static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
-        timer_mod (s->ts,
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
+        if (!timer_pending(s->ts)) {
+            timer_mod(s->ts,
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
+        }
     }
     else {
         timer_del (s->ts);
