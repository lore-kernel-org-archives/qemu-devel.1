Received: from eggs.gnu.org ([2001:4830:134:3::10]:50614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qd-0006ZS-De
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qb-0005Wg-HG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qb-0005Vj-9j
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FBEC7EA81
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:13:08 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:28 +0000
Message-Id: <20171218191228.31018-14-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 13/13] ui: mix misleading comments & return
 types of VNC I/O helper methods
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

While the QIOChannel APIs for reading/writing data return ssize_t, with negative
value indicating an error, the VNC code passes this return value through the
vnc_client_io_error() method. This detects the error condition, disconnects the
client and returns 0 to indicate error. Thus all the VNC helper methods should
return size_t (unsigned), and misleading comments which refer to the possibility
of negative return values need fixing.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c |  8 ++++----
 ui/vnc-auth-sasl.h |  4 ++--
 ui/vnc.c           | 29 +++++++++++++++--------------
 ui/vnc.h           |  6 +++---
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 8c1cdde3db..74a5f513f2 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -48,9 +48,9 @@ void vnc_sasl_client_cleanup(VncState *vs)
 }
 
 
-long vnc_client_write_sasl(VncState *vs)
+size_t vnc_client_write_sasl(VncState *vs)
 {
-    long ret;
+    size_t ret;
 
     VNC_DEBUG("Write SASL: Pending output %p size %zd offset %zd "
               "Encoded: %p size %d offset %d\n",
@@ -106,9 +106,9 @@ long vnc_client_write_sasl(VncState *vs)
 }
 
 
-long vnc_client_read_sasl(VncState *vs)
+size_t vnc_client_read_sasl(VncState *vs)
 {
-    long ret;
+    size_t ret;
     uint8_t encoded[4096];
     const char *decoded;
     unsigned int decodedLen;
diff --git a/ui/vnc-auth-sasl.h b/ui/vnc-auth-sasl.h
index b9d8de1c10..2ae224ee3a 100644
--- a/ui/vnc-auth-sasl.h
+++ b/ui/vnc-auth-sasl.h
@@ -65,8 +65,8 @@ struct VncDisplaySASL {
 
 void vnc_sasl_client_cleanup(VncState *vs);
 
-long vnc_client_read_sasl(VncState *vs);
-long vnc_client_write_sasl(VncState *vs);
+size_t vnc_client_read_sasl(VncState *vs);
+size_t vnc_client_write_sasl(VncState *vs);
 
 void start_auth_sasl(VncState *vs);
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 1b5a399dc0..b0e12ca4dd 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1272,7 +1272,7 @@ void vnc_disconnect_finish(VncState *vs)
     g_free(vs);
 }
 
-ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
+size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
 {
     if (ret <= 0) {
         if (ret == 0) {
@@ -1315,9 +1315,9 @@ void vnc_client_error(VncState *vs)
  *
  * Returns the number of bytes written, which may be less than
  * the requested 'datalen' if the socket would block. Returns
- * -1 on error, and disconnects the client socket.
+ * 0 on I/O error, and disconnects the client socket.
  */
-ssize_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
+size_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
 {
     Error *err = NULL;
     ssize_t ret;
@@ -1335,13 +1335,13 @@ ssize_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
  * will switch the FD poll() handler back to read monitoring.
  *
  * Returns the number of bytes written, which may be less than
- * the buffered output data if the socket would block. Returns
- * -1 on error, and disconnects the client socket.
+ * the buffered output data if the socket would block.  Returns
+ * 0 on I/O error, and disconnects the client socket.
  */
-static ssize_t vnc_client_write_plain(VncState *vs)
+static size_t vnc_client_write_plain(VncState *vs)
 {
     size_t offset;
-    ssize_t ret;
+    size_t ret;
 
 #ifdef CONFIG_VNC_SASL
     VNC_DEBUG("Write Plain: Pending output %p size %zd offset %zd. Wait SSF %d\n",
@@ -1442,9 +1442,9 @@ void vnc_read_when(VncState *vs, VncReadEvent *func, size_t expecting)
  *
  * Returns the number of bytes read, which may be less than
  * the requested 'datalen' if the socket would block. Returns
- * -1 on error, and disconnects the client socket.
+ * 0 on I/O error or EOF, and disconnects the client socket.
  */
-ssize_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
+size_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
 {
     ssize_t ret;
     Error *err = NULL;
@@ -1460,12 +1460,13 @@ ssize_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
  * when not using any SASL SSF encryption layers. Will read as much
  * data as possible without blocking.
  *
- * Returns the number of bytes read. Returns -1 on error, and
- * disconnects the client socket.
+ * Returns the number of bytes read, which may be less than
+ * the requested 'datalen' if the socket would block. Returns
+ * 0 on I/O error or EOF, and disconnects the client socket.
  */
-static ssize_t vnc_client_read_plain(VncState *vs)
+static size_t vnc_client_read_plain(VncState *vs)
 {
-    ssize_t ret;
+    size_t ret;
     VNC_DEBUG("Read plain %p size %zd offset %zd\n",
               vs->input.buffer, vs->input.capacity, vs->input.offset);
     buffer_reserve(&vs->input, 4096);
@@ -1491,7 +1492,7 @@ static void vnc_jobs_bh(void *opaque)
  */
 static int vnc_client_read(VncState *vs)
 {
-    ssize_t ret;
+    size_t ret;
 
 #ifdef CONFIG_VNC_SASL
     if (vs->sasl.conn && vs->sasl.runSSF)
diff --git a/ui/vnc.h b/ui/vnc.h
index 3f4cd4d93d..0c33a5f7fe 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -524,8 +524,8 @@ gboolean vnc_client_io(QIOChannel *ioc,
                        GIOCondition condition,
                        void *opaque);
 
-ssize_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen);
-ssize_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen);
+size_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen);
+size_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen);
 
 /* Protocol I/O functions */
 void vnc_write(VncState *vs, const void *data, size_t len);
@@ -544,7 +544,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
 
 /* Protocol stage functions */
 void vnc_client_error(VncState *vs);
-ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
+size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
 
 void start_client_init(VncState *vs);
 void start_auth_vnc(VncState *vs);
-- 
2.14.3
