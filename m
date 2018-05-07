Received: from eggs.gnu.org ([2001:4830:134:3::10]:43144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcjF-0003nk-Qw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcjF-00065Q-1R
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:46:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFcjE-000659-Sn
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:46:44 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:46:42 +0200
Message-Id: <20180507094642.5909-5-kraxel@redhat.com>
In-Reply-To: <20180507094642.5909-1-kraxel@redhat.com>
References: <20180507094642.5909-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/4] audio/hda: detect output buffer overruns
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
adjust isn't able to recover.  Use a buffer overruns as indicator for
that.  Reset timer adjust logic in case we detected one.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c  | 9 +++++++++
 hw/audio/trace-events | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index f6fb1d0fa0..fc4945086b 100644
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
