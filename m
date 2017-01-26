Received: from eggs.gnu.org ([2001:4830:134:3::10]:49793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGQ-0003aJ-A4
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGP-00055J-J5
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:54 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42590)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGP-000551-Cm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:53 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 26 Jan 2017 15:34:57 +0300
Message-ID: <20170126123457.5412.12442.stgit@PASHA-ISP>
In-Reply-To: <20170126123411.5412.44769.stgit@PASHA-ISP>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 8/9] audio: make audio poll timer
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch changes resetting strategy of the audio polling timer.
It does not change expiration time if the timer is already set.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 audio/audio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index c845a44..1ee95a5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1112,8 +1112,10 @@ static int audio_is_timer_needed (void)
 static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
-        timer_mod (s->ts,
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
+        if (!timer_pending(s->ts)) {
+            timer_mod (s->ts,
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
+        }
     }
     else {
         timer_del (s->ts);
