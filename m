Received: from eggs.gnu.org ([2001:4830:134:3::10]:50529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qb-0006Wq-7U
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qZ-0005Tz-0y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qY-0005Sk-Mw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC0E32D6A28
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:13:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:26 +0000
Message-Id: <20171218191228.31018-12-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 11/13] ui: place a hard cap on VNC server
 output buffer size
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

The previous patches fix problems with throttling of forced framebuffer updates
and audio data capture that would cause the QEMU output buffer size to grow
without bound. Those fixes are graceful in that once the client catches up with
reading data from the server, everything continues operating normally.

There is some data which the server sends to the client that is impractical to
throttle. Specifically there are various pseudo framebuffer update encodings to
inform the client of things like desktop resizes, pointer changes, audio
playback start/stop, LED state and so on. These generally only involve sending
a very small amount of data to the client, but a malicious guest might be able
to do things that trigger these changes at a very high rate. Throttling them is
not practical as missed or delayed events would cause broken behaviour for the
client.

This patch thus takes a more forceful approach of setting an absolute upper
bound on the amount of data we permit to be present in the output buffer at
any time. The previous patch set a threshold for throttling the output buffer
by allowing an amount of data equivalent to one complete framebuffer update and
one seconds worth of audio data. On top of this it allowed for one further
forced framebuffer update to be queued.

To be conservative, we thus take that throttling threshold and multiply it by
5 to form an absolute upper bound. If this bound is hit during vnc_write() we
forceably disconnect the client, refusing to queue further data. This limit is
high enough that it should never be hit unless a malicious client is trying to
exploit the sever, or the network is completely saturated preventing any sending
of data on the socket.

This completes the fix for CVE-2017-15124 started in the previous patches.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4021c0118c..a4f0279cdc 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1521,8 +1521,37 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
 }
 
 
+/*
+ * Scale factor to apply to vs->throttle_output_offset when checking for
+ * hard limit. Worst case normal usage could be x2, if we have a complete
+ * incremental update and complete forced update in the output buffer.
+ * So x3 should be good enough, but we pick x5 to be conservative and thus
+ * (hopefully) never trigger incorrectly.
+ */
+#define VNC_THROTTLE_OUTPUT_LIMIT_SCALE 5
+
 void vnc_write(VncState *vs, const void *data, size_t len)
 {
+    if (vs->disconnecting) {
+        return;
+    }
+    /* Protection against malicious client/guest to prevent our output
+     * buffer growing without bound if client stops reading data. This
+     * should rarely trigger, because we have earlier throttling code
+     * which stops issuing framebuffer updates and drops audio data
+     * if the throttle_output_offset value is exceeded. So we only reach
+     * this higher level if a huge number of pseudo-encodings get
+     * triggered while data can't be sent on the socket.
+     *
+     * NB throttle_output_offset can be zero during early protocol
+     * handshake, or from the job thread's VncState clone
+     */
+    if (vs->throttle_output_offset != 0 &&
+        vs->output.offset > (vs->throttle_output_offset *
+                             VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
+        vnc_disconnect_start(vs);
+        return;
+    }
     buffer_reserve(&vs->output, len);
 
     if (vs->ioc != NULL && buffer_empty(&vs->output)) {
-- 
2.14.3
