Received: from eggs.gnu.org ([2001:4830:134:3::10]:41591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99LA-0004zX-EA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99L4-0000ZN-63
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:11:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f99L4-0000Xh-0u
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:11:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Apr 2018 15:10:51 +0200
Message-Id: <20180419131051.11249-5-kraxel@redhat.com>
In-Reply-To: <20180419131051.11249-1-kraxel@redhat.com>
References: <20180419131051.11249-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] audio/hda: detect output buffer overruns
 and underruns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: martin@schrodt.org, Gerd Hoffmann <kraxel@redhat.com>

If some event caused some larger playback hickup the fine-grained timer
adjust isn't able to recover.  Use a buffer overruns and underruns as
indicator for that.  Reset timer adjust logic in case we detected one.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c  | 22 ++++++++++++++++++++++
 hw/audio/trace-events |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index f6fb1d0fa0..623021b7c7 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -261,6 +261,13 @@ static void hda_audio_input_cb(void *opaque, int avail)
 
     int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), avail);
 
+    if (to_transfer == 0) {
+        /* reset timer adjust */
+        st->buft_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        trace_hda_audio_underrun(st->node->name);
+        return;
+    }
+
     hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE >> 1)));
 
     while (to_transfer) {
@@ -325,6 +332,21 @@ static void hda_audio_output_cb(void *opaque, int avail)
 
     int64_t to_transfer = audio_MIN(wpos - rpos, avail);
 
+    if (to_transfer == 0) {
+        /* reset timer adjust */
+        st->buft_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        trace_hda_audio_underrun(st->node->name);
+        return;
+    }
+    if (wpos - rpos == B_SIZE) {
+        /* drop buffer, reset timer adjust */
+        st->rpos = 0;
+        st->wpos = 0;
+        st->buft_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        trace_hda_audio_overrun(st->node->name);
+        return;
+    }
+
     hda_timer_sync_adjust(st, (wpos - rpos) - to_transfer - (B_SIZE >> 1));
 
     while (to_transfer) {
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 30112d97c4..3b2ea2727b 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -22,3 +22,5 @@ milkymist_ac97_out_cb_transferred(int transferred) "transferred %d"
 hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %d, run %d"
 hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s, %d x %s @ %d Hz"
 hda_audio_adjust(const char *stream, int pos) "st %s, pos %d"
+hda_audio_overrun(const char *stream) "st %s"
+hda_audio_underrun(const char *stream) "st %s"
-- 
2.9.3
