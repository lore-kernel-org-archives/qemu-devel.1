Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qd-0006ZT-EG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qa-0005VR-Co
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qa-0005UN-1Y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30A7734CD
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:13:07 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:27 +0000
Message-Id: <20171218191228.31018-13-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 12/13] ui: add trace events related to VNC
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The VNC client throttling is quite subtle so will benefit from having trace
points available for live debugging.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/trace-events |  7 +++++++
 ui/vnc.c        | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/ui/trace-events b/ui/trace-events
index 1a9f126330..85f74f948b 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -35,6 +35,13 @@ vnc_client_connect(void *state, void *ioc) "VNC client connect state=%p ioc=%p"
 vnc_client_disconnect_start(void *state, void *ioc) "VNC client disconnect start state=%p ioc=%p"
 vnc_client_disconnect_finish(void *state, void *ioc) "VNC client disconnect finish state=%p ioc=%p"
 vnc_client_io_wrap(void *state, void *ioc, const char *type) "VNC client I/O wrap state=%p ioc=%p type=%s"
+vnc_client_throttle_threshold(void *state, void *ioc, size_t oldoffset, size_t offset, int client_width, int client_height, int bytes_per_pixel, void *audio_cap) "VNC client throttle threshold state=%p ioc=%p oldoffset=%zu newoffset=%zu width=%d height=%d bpp=%d audio=%p"
+vnc_client_throttle_incremental(void *state, void *ioc, int job_update, size_t offset) "VNC client throttle incremental state=%p ioc=%p job-update=%d offset=%zu"
+vnc_client_throttle_forced(void *state, void *ioc, int job_update, size_t offset) "VNC client throttle forced state=%p ioc=%p job-update=%d offset=%zu"
+vnc_client_throttle_audio(void *state, void *ioc, size_t offset) "VNC client throttle audio state=%p ioc=%p offset=%zu"
+vnc_client_unthrottle_forced(void *state, void *ioc) "VNC client unthrottle forced offset state=%p ioc=%p"
+vnc_client_unthrottle_incremental(void *state, void *ioc, size_t offset) "VNC client unthrottle incremental state=%p ioc=%p offset=%zu"
+vnc_client_output_limit(void *state, void *ioc, size_t offset, size_t threshold) "VNC client output limit state=%p ioc=%p offset=%zu threshold=%zu"
 vnc_auth_init(void *display, int websock, int auth, int subauth) "VNC auth init state=%p websock=%d auth=%d subauth=%d"
 vnc_auth_start(void *state, int method) "VNC client auth start state=%p method=%d"
 vnc_auth_pass(void *state, int method) "VNC client auth passed state=%p method=%d"
diff --git a/ui/vnc.c b/ui/vnc.c
index a4f0279cdc..1b5a399dc0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1011,6 +1011,12 @@ static void vnc_update_throttle_offset(VncState *vs)
      */
     offset = MAX(offset, 1024 * 1024);
 
+    if (vs->throttle_output_offset != offset) {
+        trace_vnc_client_throttle_threshold(
+            vs, vs->ioc, vs->throttle_output_offset, offset, vs->client_width,
+            vs->client_height, vs->client_pf.bytes_per_pixel, vs->audio_cap);
+    }
+
     vs->throttle_output_offset = offset;
 }
 
@@ -1028,6 +1034,8 @@ static bool vnc_should_update(VncState *vs)
             vs->job_update == VNC_STATE_UPDATE_NONE) {
             return true;
         }
+        trace_vnc_client_throttle_incremental(
+            vs, vs->ioc, vs->job_update, vs->output.offset);
         break;
     case VNC_STATE_UPDATE_FORCE:
         /* Only allow forced updates if the pending send queue
@@ -1042,6 +1050,8 @@ static bool vnc_should_update(VncState *vs)
             vs->job_update == VNC_STATE_UPDATE_NONE) {
             return true;
         }
+        trace_vnc_client_throttle_forced(
+            vs, vs->ioc, vs->job_update, vs->force_update_offset);
         break;
     }
     return false;
@@ -1158,6 +1168,8 @@ static void audio_capture(void *opaque, void *buf, int size)
         vnc_write_u16(vs, VNC_MSG_SERVER_QEMU_AUDIO_DATA);
         vnc_write_u32(vs, size);
         vnc_write(vs, buf, size);
+    } else {
+        trace_vnc_client_throttle_audio(vs, vs->ioc, vs->output.offset);
     }
     vnc_unlock_output(vs);
     vnc_flush(vs);
@@ -1328,6 +1340,7 @@ ssize_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
  */
 static ssize_t vnc_client_write_plain(VncState *vs)
 {
+    size_t offset;
     ssize_t ret;
 
 #ifdef CONFIG_VNC_SASL
@@ -1348,11 +1361,19 @@ static ssize_t vnc_client_write_plain(VncState *vs)
         return 0;
 
     if (ret >= vs->force_update_offset) {
+        if (vs->force_update_offset != 0) {
+            trace_vnc_client_unthrottle_forced(vs, vs->ioc);
+        }
         vs->force_update_offset = 0;
     } else {
         vs->force_update_offset -= ret;
     }
+    offset = vs->output.offset;
     buffer_advance(&vs->output, ret);
+    if (offset >= vs->throttle_output_offset &&
+        vs->output.offset < vs->throttle_output_offset) {
+        trace_vnc_client_unthrottle_incremental(vs, vs->ioc, vs->output.offset);
+    }
 
     if (vs->output.offset == 0) {
         if (vs->ioc_tag) {
@@ -1549,6 +1570,8 @@ void vnc_write(VncState *vs, const void *data, size_t len)
     if (vs->throttle_output_offset != 0 &&
         vs->output.offset > (vs->throttle_output_offset *
                              VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
+        trace_vnc_client_output_limit(vs, vs->ioc, vs->output.offset,
+                                      vs->throttle_output_offset);
         vnc_disconnect_start(vs);
         return;
     }
-- 
2.14.3
