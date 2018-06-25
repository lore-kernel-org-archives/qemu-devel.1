Received: from eggs.gnu.org ([2001:4830:134:3::10]:34147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIh-0008QB-NE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIe-0001a7-W3
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXRIe-0001ZN-RQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8152E401C9AA
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:12:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 25 Jun 2018 15:12:50 +0200
Message-Id: <20180625131253.11218-4-kraxel@redhat.com>
In-Reply-To: <20180625131253.11218-1-kraxel@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] audio/hda: tweak timer adjust logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

We have some jitter in the audio timer call frequency and buffer sizes.
So it is rather pointless trying to be very exact, effect is a constant
up+down adjustment.  So adjust only in case we are off too much.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180622111200.30561-4-kraxel@redhat.com
---
 hw/audio/hda-codec.c  | 20 +++++++++++++-------
 hw/audio/trace-events |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index a08516cbf8..870448a687 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -129,7 +129,6 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
 #include  "hda-codec-common.h"
 
 #define HDA_TIMER_TICKS (SCALE_MS)
-#define MAX_CORR (SCALE_US * 100)
 #define B_SIZE sizeof(st->buf)
 #define B_MASK (sizeof(st->buf) - 1)
 
@@ -196,13 +195,20 @@ static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
 
 static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
 {
-    int64_t corr =
-        NANOSECONDS_PER_SECOND * target_pos / hda_bytes_per_second(st);
-    if (corr > MAX_CORR) {
-        corr = MAX_CORR;
-    } else if (corr < -MAX_CORR) {
-        corr = -MAX_CORR;
+    int64_t limit = B_SIZE / 8;
+    int64_t corr = 0;
+
+    if (target_pos > limit) {
+        corr = HDA_TIMER_TICKS;
     }
+    if (target_pos < -limit) {
+        corr = -HDA_TIMER_TICKS;
+    }
+    if (corr == 0) {
+        return;
+    }
+
+    trace_hda_audio_adjust(st->node->name, target_pos);
     atomic_fetch_add(&st->buft_start, corr);
 }
 
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 03340b9359..30112d97c4 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -21,3 +21,4 @@ milkymist_ac97_out_cb_transferred(int transferred) "transferred %d"
 # hw/audio/hda-codec.c
 hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %d, run %d"
 hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s, %d x %s @ %d Hz"
+hda_audio_adjust(const char *stream, int pos) "st %s, pos %d"
-- 
2.9.3
