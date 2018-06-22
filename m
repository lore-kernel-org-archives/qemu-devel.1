Received: from eggs.gnu.org ([2001:4830:134:3::10]:55770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz4-0005vv-Uy
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz2-0001fP-KA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fWJz2-0001f1-H9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:04 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Jun 2018 13:11:59 +0200
Message-Id: <20180622111200.30561-5-kraxel@redhat.com>
In-Reply-To: <20180622111200.30561-1-kraxel@redhat.com>
References: <20180622111200.30561-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/5] audio/hda: detect output buffer overruns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: martin@schrodt.org, maxehr@umiacs.umd.edu, Gerd Hoffmann <kraxel@redhat.com>

If some event caused some larger playback hickup the fine-grained timer
adjust isn't able to recover.  Use a buffer overruns as indicator for
that.  Reset timer adjust logic in case we detected one.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c  | 9 +++++++++
 hw/audio/trace-events | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 870448a687..ac67b9aada 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -325,6 +325,15 @@ static void hda_audio_output_cb(void *opaque, int avail)
 
     int64_t to_transfer = audio_MIN(wpos - rpos, avail);
 
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
index 30112d97c4..5891b4e2b9 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -22,3 +22,4 @@ milkymist_ac97_out_cb_transferred(int transferred) "transferred %d"
 hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %d, run %d"
 hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s, %d x %s @ %d Hz"
 hda_audio_adjust(const char *stream, int pos) "st %s, pos %d"
+hda_audio_overrun(const char *stream) "st %s"
-- 
2.9.3
