Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIh-0008Qc-QI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIf-0001aN-0a
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXRIe-0001ZA-Qp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74C5B7B4A7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:12:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 25 Jun 2018 15:12:49 +0200
Message-Id: <20180625131253.11218-3-kraxel@redhat.com>
In-Reply-To: <20180625131253.11218-1-kraxel@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] audio/hda: turn some dprintfs into trace
 points
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180622111200.30561-3-kraxel@redhat.com
---
 hw/audio/hda-codec.c  | 9 ++++-----
 hw/audio/trace-events | 4 ++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c62e78c859..a08516cbf8 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -24,6 +24,7 @@
 #include "intel-hda.h"
 #include "intel-hda-defs.h"
 #include "audio/audio.h"
+#include "trace.h"
=20
 /* ---------------------------------------------------------------------=
----- */
=20
@@ -394,8 +395,7 @@ static void hda_audio_set_running(HDAAudioStream *st,=
 bool running)
         return;
     }
     st->running =3D running;
-    dprint(st->state, 1, "%s: %s (stream %d)\n", st->node->name,
-           st->running ? "on" : "off", st->stream);
+    trace_hda_audio_running(st->node->name, st->stream, st->running);
     if (st->state->use_timer) {
         if (running) {
             int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -449,9 +449,8 @@ static void hda_audio_setup(HDAAudioStream *st)
         return;
     }
=20
-    dprint(st->state, 1, "%s: format: %d x %s @ %d Hz\n",
-           st->node->name, st->as.nchannels,
-           fmt2name[st->as.fmt], st->as.freq);
+    trace_hda_audio_format(st->node->name, st->as.nchannels,
+                           fmt2name[st->as.fmt], st->as.freq);
=20
     if (st->output) {
         if (use_timer) {
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index fa1646d169..03340b9359 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -17,3 +17,7 @@ milkymist_ac97_in_cb(int avail, uint32_t remaining) "av=
ail %d remaining %u"
 milkymist_ac97_in_cb_transferred(int transferred) "transferred %d"
 milkymist_ac97_out_cb(int free, uint32_t remaining) "free %d remaining %=
u"
 milkymist_ac97_out_cb_transferred(int transferred) "transferred %d"
+
+# hw/audio/hda-codec.c
+hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %=
d, run %d"
+hda_audio_format(const char *stream, int chan, const char *fmt, int freq=
) "st %s, %d x %s @ %d Hz"
--=20
2.9.3
