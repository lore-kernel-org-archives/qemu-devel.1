Received: from eggs.gnu.org ([2001:4830:134:3::10]:48458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvS-0003YP-3q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvQ-00034j-M9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvQ-00034C-DI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 667B72D1EC7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:06 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:50 +0100
Message-Id: <20180112125854.18261-11-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] ui: fix VNC client throttling when audio
 capture is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The VNC server must throttle data sent to the client to prevent the 'outp=
ut'
buffer size growing without bound, if the client stops reading data off t=
he
socket (either maliciously or due to stalled/slow network connection).

The current throttling is very crude because it simply checks whether the
output buffer offset is zero. This check must be disabled if audio captur=
e is
enabled, because when streaming audio the output buffer offset will rarel=
y be
zero due to queued audio data, and so this would starve framebuffer updat=
es.

As a result, the VNC client can cause QEMU to allocate arbitrary amounts =
of RAM.
They can first start something in the guest that triggers lots of framebu=
ffer
updates eg play a youtube video. Then enable audio capture, and simply ne=
ver
read data back from the server. This can easily make QEMU's VNC server se=
nd
buffer consume 100MB of RAM per second, until the OOM killer starts reapi=
ng
processes (hopefully the rogue QEMU process, but it might pick others...)=
.

To address this we make the throttling more intelligent, so we can thrott=
le
when audio capture is active too. To determine how to throttle incrementa=
l
updates or audio data, we calculate a size threshold. Normally the thresh=
old is
the approximate number of bytes associated with a single complete framebu=
ffer
update. ie width * height * bytes per pixel. We'll send incremental updat=
es
until we hit this threshold, at which point we'll stop sending updates un=
til
data has been written to the wire, causing the output buffer offset to fa=
ll
back below the threshold.

If audio capture is enabled, we increase the size of the threshold to als=
o
allow for upto 1 seconds worth of audio data samples. ie nchannels * byte=
s
per sample * frequency. This allows the output buffer to have a mixture o=
f
incremental framebuffer updates and audio data queued, but once the thres=
hold
is exceeded, audio data will be dropped and incremental updates will be
throttled.

This unbounded memory growth affects all VNC server configurations suppor=
ted by
QEMU, with no workaround possible. The mitigating factor is that it can o=
nly be
triggered by a client that has authenticated with the VNC server, and who=
 is
able to trigger a large quantity of framebuffer updates or audio samples =
from
the guest OS. Mostly they'll just succeed in getting the OOM killer to ki=
ll
their own QEMU process, but its possible other processes can get taken ou=
t as
collateral damage.

This is a more general variant of the similar unbounded memory usage flaw=
 in
the websockets server, that was previously assigned CVE-2017-15268, and f=
ixed
in 2.11 by:

  commit a7b20a8efa28e5f22c26c06cd06c2f12bc863493
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Mon Oct 9 14:43:42 2017 +0100

    io: monitor encoutput buffer size from websocket GSource

This new general memory usage flaw has been assigned CVE-2017-15124, and =
is
partially fixed by this patch.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-10-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h |  6 ++++++
 ui/vnc.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
------
 2 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index b9d310e640..8fe69595c6 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -298,6 +298,12 @@ struct VncState
=20
     VncClientInfo *info;
=20
+    /* We allow multiple incremental updates or audio capture
+     * samples to be queued in output buffer, provided the
+     * buffer size doesn't exceed this threshold. The value
+     * is calculating dynamically based on framebuffer size
+     * and audio sample settings in vnc_update_throttle_offset() */
+    size_t throttle_output_offset;
     Buffer output;
     Buffer input;
     /* current output mode information */
diff --git a/ui/vnc.c b/ui/vnc.c
index 4ba7fc076a..9e03cc7c01 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -60,6 +60,7 @@ static QTAILQ_HEAD(, VncDisplay) vnc_displays =3D
=20
 static int vnc_cursor_define(VncState *vs);
 static void vnc_release_modifiers(VncState *vs);
+static void vnc_update_throttle_offset(VncState *vs);
=20
 static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
 {
@@ -766,6 +767,7 @@ static void vnc_dpy_switch(DisplayChangeListener *dcl=
,
         vnc_set_area_dirty(vs->dirty, vd, 0, 0,
                            vnc_width(vd),
                            vnc_height(vd));
+        vnc_update_throttle_offset(vs);
     }
 }
=20
@@ -961,16 +963,67 @@ static int find_and_clear_dirty_height(VncState *vs=
,
     return h;
 }
=20
+/*
+ * Figure out how much pending data we should allow in the output
+ * buffer before we throttle incremental display updates, and/or
+ * drop audio samples.
+ *
+ * We allow for equiv of 1 full display's worth of FB updates,
+ * and 1 second of audio samples. If audio backlog was larger
+ * than that the client would already suffering awful audio
+ * glitches, so dropping samples is no worse really).
+ */
+static void vnc_update_throttle_offset(VncState *vs)
+{
+    size_t offset =3D
+        vs->client_width * vs->client_height * vs->client_pf.bytes_per_p=
ixel;
+
+    if (vs->audio_cap) {
+        int freq =3D vs->as.freq;
+        /* We don't limit freq when reading settings from client, so
+         * it could be upto MAX_INT in size. 48khz is a sensible
+         * upper bound for trustworthy clients */
+        int bps;
+        if (freq > 48000) {
+            freq =3D 48000;
+        }
+        switch (vs->as.fmt) {
+        default:
+        case  AUD_FMT_U8:
+        case  AUD_FMT_S8:
+            bps =3D 1;
+            break;
+        case  AUD_FMT_U16:
+        case  AUD_FMT_S16:
+            bps =3D 2;
+            break;
+        case  AUD_FMT_U32:
+        case  AUD_FMT_S32:
+            bps =3D 4;
+            break;
+        }
+        offset +=3D freq * bps * vs->as.nchannels;
+    }
+
+    /* Put a floor of 1MB on offset, so that if we have a large pending
+     * buffer and the display is resized to a small size & back again
+     * we don't suddenly apply a tiny send limit
+     */
+    offset =3D MAX(offset, 1024 * 1024);
+
+    vs->throttle_output_offset =3D offset;
+}
+
 static bool vnc_should_update(VncState *vs)
 {
     switch (vs->update) {
     case VNC_STATE_UPDATE_NONE:
         break;
     case VNC_STATE_UPDATE_INCREMENTAL:
-        /* Only allow incremental updates if the output buffer
-         * is empty, or if audio capture is enabled.
+        /* Only allow incremental updates if the pending send queue
+         * is less than the permitted threshold
          */
-        if (!vs->output.offset || vs->audio_cap) {
+        if (vs->output.offset < vs->throttle_output_offset) {
             return true;
         }
         break;
@@ -1084,11 +1137,13 @@ static void audio_capture(void *opaque, void *buf=
, int size)
     VncState *vs =3D opaque;
=20
     vnc_lock_output(vs);
-    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
-    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_AUDIO);
-    vnc_write_u16(vs, VNC_MSG_SERVER_QEMU_AUDIO_DATA);
-    vnc_write_u32(vs, size);
-    vnc_write(vs, buf, size);
+    if (vs->output.offset < vs->throttle_output_offset) {
+        vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
+        vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_AUDIO);
+        vnc_write_u16(vs, VNC_MSG_SERVER_QEMU_AUDIO_DATA);
+        vnc_write_u32(vs, size);
+        vnc_write(vs, buf, size);
+    }
     vnc_unlock_output(vs);
     vnc_flush(vs);
 }
@@ -2288,6 +2343,7 @@ static int protocol_client_msg(VncState *vs, uint8_=
t *data, size_t len)
         break;
     }
=20
+    vnc_update_throttle_offset(vs);
     vnc_read_when(vs, protocol_client_msg, 1);
     return 0;
 }
--=20
2.9.3
