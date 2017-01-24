Received: from eggs.gnu.org ([2001:4830:134:3::10]:35454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMr-0006me-4E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMm-00066f-4m
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:18:13 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38712)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMl-00066K-Ri
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:18:08 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:18:09 +0300
Message-ID: <20170124071809.4572.55786.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 13/14] audio: make audio poll timer
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
