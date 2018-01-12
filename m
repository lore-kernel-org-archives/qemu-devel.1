Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvI-0003PL-6B
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0002sA-UY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvG-0002qE-Ln
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B35F3780CD
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:53 +0100
Message-Id: <20180112125854.18261-14-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/14] ui: add trace events related to VNC
 client throttling
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

The VNC client throttling is quite subtle so will benefit from having tra=
ce
points available for live debugging.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-13-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c        | 23 +++++++++++++++++++++++
 ui/trace-events |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index e53e84587a..0a5e629d5d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1011,6 +1011,12 @@ static void vnc_update_throttle_offset(VncState *v=
s)
      */
     offset =3D MAX(offset, 1024 * 1024);
=20
+    if (vs->throttle_output_offset !=3D offset) {
+        trace_vnc_client_throttle_threshold(
+            vs, vs->ioc, vs->throttle_output_offset, offset, vs->client_=
width,
+            vs->client_height, vs->client_pf.bytes_per_pixel, vs->audio_=
cap);
+    }
+
     vs->throttle_output_offset =3D offset;
 }
=20
@@ -1028,6 +1034,8 @@ static bool vnc_should_update(VncState *vs)
             vs->job_update =3D=3D VNC_STATE_UPDATE_NONE) {
             return true;
         }
+        trace_vnc_client_throttle_incremental(
+            vs, vs->ioc, vs->job_update, vs->output.offset);
         break;
     case VNC_STATE_UPDATE_FORCE:
         /* Only allow forced updates if the pending send queue
@@ -1042,6 +1050,8 @@ static bool vnc_should_update(VncState *vs)
             vs->job_update =3D=3D VNC_STATE_UPDATE_NONE) {
             return true;
         }
+        trace_vnc_client_throttle_forced(
+            vs, vs->ioc, vs->job_update, vs->force_update_offset);
         break;
     }
     return false;
@@ -1158,6 +1168,8 @@ static void audio_capture(void *opaque, void *buf, =
int size)
         vnc_write_u16(vs, VNC_MSG_SERVER_QEMU_AUDIO_DATA);
         vnc_write_u32(vs, size);
         vnc_write(vs, buf, size);
+    } else {
+        trace_vnc_client_throttle_audio(vs, vs->ioc, vs->output.offset);
     }
     vnc_unlock_output(vs);
     vnc_flush(vs);
@@ -1328,6 +1340,7 @@ ssize_t vnc_client_write_buf(VncState *vs, const ui=
nt8_t *data, size_t datalen)
  */
 static ssize_t vnc_client_write_plain(VncState *vs)
 {
+    size_t offset;
     ssize_t ret;
=20
 #ifdef CONFIG_VNC_SASL
@@ -1348,11 +1361,19 @@ static ssize_t vnc_client_write_plain(VncState *v=
s)
         return 0;
=20
     if (ret >=3D vs->force_update_offset) {
+        if (vs->force_update_offset !=3D 0) {
+            trace_vnc_client_unthrottle_forced(vs, vs->ioc);
+        }
         vs->force_update_offset =3D 0;
     } else {
         vs->force_update_offset -=3D ret;
     }
+    offset =3D vs->output.offset;
     buffer_advance(&vs->output, ret);
+    if (offset >=3D vs->throttle_output_offset &&
+        vs->output.offset < vs->throttle_output_offset) {
+        trace_vnc_client_unthrottle_incremental(vs, vs->ioc, vs->output.=
offset);
+    }
=20
     if (vs->output.offset =3D=3D 0) {
         if (vs->ioc_tag) {
@@ -1549,6 +1570,8 @@ void vnc_write(VncState *vs, const void *data, size=
_t len)
     if (vs->throttle_output_offset !=3D 0 &&
         vs->output.offset > (vs->throttle_output_offset *
                              VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
+        trace_vnc_client_output_limit(vs, vs->ioc, vs->output.offset,
+                                      vs->throttle_output_offset);
         vnc_disconnect_start(vs);
         return;
     }
diff --git a/ui/trace-events b/ui/trace-events
index 1a9f126330..85f74f948b 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -35,6 +35,13 @@ vnc_client_connect(void *state, void *ioc) "VNC client=
 connect state=3D%p ioc=3D%p"
 vnc_client_disconnect_start(void *state, void *ioc) "VNC client disconne=
ct start state=3D%p ioc=3D%p"
 vnc_client_disconnect_finish(void *state, void *ioc) "VNC client disconn=
ect finish state=3D%p ioc=3D%p"
 vnc_client_io_wrap(void *state, void *ioc, const char *type) "VNC client=
 I/O wrap state=3D%p ioc=3D%p type=3D%s"
+vnc_client_throttle_threshold(void *state, void *ioc, size_t oldoffset, =
size_t offset, int client_width, int client_height, int bytes_per_pixel, =
void *audio_cap) "VNC client throttle threshold state=3D%p ioc=3D%p oldof=
fset=3D%zu newoffset=3D%zu width=3D%d height=3D%d bpp=3D%d audio=3D%p"
+vnc_client_throttle_incremental(void *state, void *ioc, int job_update, =
size_t offset) "VNC client throttle incremental state=3D%p ioc=3D%p job-u=
pdate=3D%d offset=3D%zu"
+vnc_client_throttle_forced(void *state, void *ioc, int job_update, size_=
t offset) "VNC client throttle forced state=3D%p ioc=3D%p job-update=3D%d=
 offset=3D%zu"
+vnc_client_throttle_audio(void *state, void *ioc, size_t offset) "VNC cl=
ient throttle audio state=3D%p ioc=3D%p offset=3D%zu"
+vnc_client_unthrottle_forced(void *state, void *ioc) "VNC client unthrot=
tle forced offset state=3D%p ioc=3D%p"
+vnc_client_unthrottle_incremental(void *state, void *ioc, size_t offset)=
 "VNC client unthrottle incremental state=3D%p ioc=3D%p offset=3D%zu"
+vnc_client_output_limit(void *state, void *ioc, size_t offset, size_t th=
reshold) "VNC client output limit state=3D%p ioc=3D%p offset=3D%zu thresh=
old=3D%zu"
 vnc_auth_init(void *display, int websock, int auth, int subauth) "VNC au=
th init state=3D%p websock=3D%d auth=3D%d subauth=3D%d"
 vnc_auth_start(void *state, int method) "VNC client auth start state=3D%=
p method=3D%d"
 vnc_auth_pass(void *state, int method) "VNC client auth passed state=3D%=
p method=3D%d"
--=20
2.9.3
