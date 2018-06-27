Received: from eggs.gnu.org ([2001:4830:134:3::10]:54446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY8UF-0001CK-Lv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY8U9-0004LJ-6Q
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY8U9-0004L2-0u
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A081CF68BC
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 11:19:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Jun 2018 13:19:36 +0200
Message-Id: <20180627111936.31019-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] audio/hda: drop atomics
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

Doesn't build on 32bit clang.  And because we run under qemu mutex
anyway they are not needed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 8a8214de74..a4e24b919d 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/atomic.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "intel-hda.h"
@@ -212,7 +211,7 @@ static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
     }
 
     trace_hda_audio_adjust(st->node->name, target_pos);
-    atomic_fetch_add(&st->buft_start, corr);
+    st->buft_start += corr;
 }
 
 static void hda_audio_input_timer(void *opaque)
@@ -221,9 +220,9 @@ static void hda_audio_input_timer(void *opaque)
 
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
-    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
-    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+    int64_t buft_start = st->buft_start;
+    int64_t wpos = st->wpos;
+    int64_t rpos = st->rpos;
 
     int64_t wanted_rpos = hda_bytes_per_second(st) * (now - buft_start)
                           / NANOSECONDS_PER_SECOND;
@@ -245,7 +244,7 @@ static void hda_audio_input_timer(void *opaque)
         }
         rpos += chunk;
         to_transfer -= chunk;
-        atomic_fetch_add(&st->rpos, chunk);
+        st->rpos += chunk;
     }
 
 out_timer:
@@ -259,8 +258,8 @@ static void hda_audio_input_cb(void *opaque, int avail)
 {
     HDAAudioStream *st = opaque;
 
-    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
-    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+    int64_t wpos = st->wpos;
+    int64_t rpos = st->rpos;
 
     int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), avail);
 
@@ -272,7 +271,7 @@ static void hda_audio_input_cb(void *opaque, int avail)
         uint32_t read = AUD_read(st->voice.in, st->buf + start, chunk);
         wpos += read;
         to_transfer -= read;
-        atomic_fetch_add(&st->wpos, read);
+        st->wpos += read;
         if (chunk != read) {
             break;
         }
@@ -285,9 +284,9 @@ static void hda_audio_output_timer(void *opaque)
 
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
-    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
-    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+    int64_t buft_start = st->buft_start;
+    int64_t wpos = st->wpos;
+    int64_t rpos = st->rpos;
 
     int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
                           / NANOSECONDS_PER_SECOND;
@@ -309,7 +308,7 @@ static void hda_audio_output_timer(void *opaque)
         }
         wpos += chunk;
         to_transfer -= chunk;
-        atomic_fetch_add(&st->wpos, chunk);
+        st->wpos += chunk;
     }
 
 out_timer:
@@ -323,8 +322,8 @@ static void hda_audio_output_cb(void *opaque, int avail)
 {
     HDAAudioStream *st = opaque;
 
-    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
-    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+    int64_t wpos = st->wpos;
+    int64_t rpos = st->rpos;
 
     int64_t to_transfer = audio_MIN(wpos - rpos, avail);
 
@@ -345,7 +344,7 @@ static void hda_audio_output_cb(void *opaque, int avail)
         uint32_t written = AUD_write(st->voice.out, st->buf + start, chunk);
         rpos += written;
         to_transfer -= written;
-        atomic_fetch_add(&st->rpos, written);
+        st->rpos += written;
         if (chunk != written) {
             break;
         }
-- 
2.9.3
