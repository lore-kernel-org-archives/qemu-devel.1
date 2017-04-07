Received: from eggs.gnu.org ([2001:4830:134:3::10]:60789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cwRv8-0008CL-08
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cwRv3-0004Xy-Ur
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cwRv3-0004Xn-Kj
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v37BEOIw057303
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 07:19:08 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nsrb2wmp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:19:07 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 7 Apr 2017 12:19:05 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri,  7 Apr 2017 13:18:44 +0200
In-Reply-To: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
Message-Id: <20170407111851.20680-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 1/8] chardev: Basic support for
 TN3270
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, marcandre.lureau@redhat.com, Jing Liu <liujbjl@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Jing Liu <liujbjl@linux.vnet.ibm.com>

This introduces basic support for TN3270, which needs to negotiate
three Telnet options during handshake:
  - End of Record
  - Binary Transmission
  - Terminal-Type

As a basic implementation, this simply ignores NOP and Interrupt
Process(IP) commands. More work should be done for them later.

For more details, please refer to RFC 854 and 1576.

Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 chardev/char-socket.c | 76 +++++++++++++++++++++++++++++++++++++--------------
 chardev/char.c        | 11 ++++++--
 include/sysemu/char.h |  8 ++++++
 qapi-schema.json      |  3 ++
 4 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 36ab0d633a..175fb8c3ec 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -55,6 +55,7 @@ typedef struct {
     SocketAddress *addr;
     bool is_listen;
     bool is_telnet;
+    bool is_tn3270;
 
     guint reconnect_timer;
     int64_t reconnect_time;
@@ -141,19 +142,25 @@ static int tcp_chr_read_poll(void *opaque)
     return s->max_size;
 }
 
-#define IAC 255
-#define IAC_BREAK 243
 static void tcp_chr_process_IAC_bytes(Chardev *chr,
                                       SocketChardev *s,
                                       uint8_t *buf, int *size)
 {
-    /* Handle any telnet client's basic IAC options to satisfy char by
-     * char mode with no echo.  All IAC options will be removed from
-     * the buf and the do_telnetopt variable will be used to track the
-     * state of the width of the IAC information.
+    /* Handle any telnet or tn3270 client's basic IAC options.
+     * For telnet options, it satisfies char by char mode with no echo.
+     * For tn3270 options, it satisfies binary mode with EOR.
+     * All IAC options will be removed from the buf and the do_opt
+     * pointer will be used to track the state of the width of the
+     * IAC information.
      *
-     * IAC commands come in sets of 3 bytes with the exception of the
-     * "IAC BREAK" command and the double IAC.
+     * RFC854: "All TELNET commands consist of at least a two byte sequence.
+     * The commands dealing with option negotiation are three byte sequences,
+     * the third byte being the code for the option referenced."
+     * "IAC BREAK", "IAC IP", "IAC NOP" and the double IAC are two bytes.
+     * "IAC SB", "IAC SE" and "IAC EOR" are saved to split up data boundary
+     * for tn3270.
+     * NOP, Break and Interrupt Process(IP) might be encountered during a TN3270
+     * session, and NOP and IP need to be done later.
      */
 
     int i;
@@ -174,6 +181,18 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
                     /* Handle IAC break commands by sending a serial break */
                     qemu_chr_be_event(chr, CHR_EVENT_BREAK);
                     s->do_telnetopt++;
+                } else if (s->is_tn3270 && ((unsigned char)buf[i] == IAC_EOR
+                           || (unsigned char)buf[i] == IAC_SB
+                           || (unsigned char)buf[i] == IAC_SE)
+                           && s->do_telnetopt == 2) {
+                    buf[j++] = IAC;
+                    buf[j++] = buf[i];
+                    s->do_telnetopt++;
+                } else if (s->is_tn3270 && ((unsigned char)buf[i] == IAC_IP
+                           || (unsigned char)buf[i] == IAC_NOP)
+                           && s->do_telnetopt == 2) {
+                    /* TODO: IP and NOP need to be implemented later. */
+                    s->do_telnetopt++;
                 }
                 s->do_telnetopt++;
             }
@@ -512,7 +531,7 @@ static void tcp_chr_update_read_handler(Chardev *chr,
 
 typedef struct {
     Chardev *chr;
-    char buf[12];
+    char buf[21];
     size_t buflen;
 } TCPChardevTelnetInit;
 
@@ -550,9 +569,6 @@ static void tcp_chr_telnet_init(Chardev *chr)
     TCPChardevTelnetInit *init = g_new0(TCPChardevTelnetInit, 1);
     size_t n = 0;
 
-    init->chr = chr;
-    init->buflen = 12;
-
 #define IACSET(x, a, b, c)                      \
     do {                                        \
         x[n++] = a;                             \
@@ -560,12 +576,26 @@ static void tcp_chr_telnet_init(Chardev *chr)
         x[n++] = c;                             \
     } while (0)
 
-    /* Prep the telnet negotion to put telnet in binary,
-     * no echo, single char mode */
-    IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
-    IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
-    IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
-    IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
+    init->chr = chr;
+    if (!s->is_tn3270) {
+        init->buflen = 12;
+        /* Prep the telnet negotion to put telnet in binary,
+         * no echo, single char mode */
+        IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
+        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
+        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
+        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
+    } else {
+        init->buflen = 21;
+        /* Prep the TN3270 negotion based on RFC1576 */
+        IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
+        IACSET(init->buf, 0xff, 0xfb, 0x19);  /* IAC WILL EOR */
+        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO BINARY */
+        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL BINARY */
+        IACSET(init->buf, 0xff, 0xfd, 0x18);  /* IAC DO TERMINAL TYPE */
+        IACSET(init->buf, 0xff, 0xfa, 0x18);  /* IAC SB TERMINAL TYPE */
+        IACSET(init->buf, 0x01, 0xff, 0xf0);  /* SEND IAC SE */
+    }
 
 #undef IACSET
 
@@ -585,7 +615,8 @@ static void tcp_chr_tls_handshake(QIOTask *task,
     if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
     } else {
-        if (s->do_telnetopt) {
+        /* tn3270 does not support TLS yet */
+        if (s->do_telnetopt && !s->is_tn3270) {
             tcp_chr_telnet_init(chr);
         } else {
             tcp_chr_connect(chr);
@@ -824,12 +855,14 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
+    bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
     QIOChannelSocket *sioc = NULL;
 
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
+    s->is_tn3270 = is_tn3270;
     s->do_nodelay = do_nodelay;
     if (sock->tls_creds) {
         Object *creds;
@@ -879,7 +912,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                                          addr, is_listen, is_telnet);
 
     if (is_listen) {
-        if (is_telnet) {
+        if (is_telnet || is_tn3270) {
             s->do_telnetopt = 1;
         }
     } else if (reconnect > 0) {
@@ -933,6 +966,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     bool is_listen      = qemu_opt_get_bool(opts, "server", false);
     bool is_waitconnect = is_listen && qemu_opt_get_bool(opts, "wait", true);
     bool is_telnet      = qemu_opt_get_bool(opts, "telnet", false);
+    bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
     bool do_nodelay     = !qemu_opt_get_bool(opts, "delay", true);
     int64_t reconnect   = qemu_opt_get_number(opts, "reconnect", 0);
     const char *path = qemu_opt_get(opts, "path");
@@ -968,6 +1002,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->server = is_listen;
     sock->has_telnet = true;
     sock->telnet = is_telnet;
+    sock->has_tn3270 = true;
+    sock->tn3270 = is_tn3270;
     sock->has_wait = true;
     sock->wait = is_waitconnect;
     sock->has_reconnect = true;
diff --git a/chardev/char.c b/chardev/char.c
index 3df116350b..309734f2b7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -696,7 +696,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
         return opts;
     }
     if (strstart(filename, "tcp:", &p) ||
-        strstart(filename, "telnet:", &p)) {
+        strstart(filename, "telnet:", &p) ||
+        strstart(filename, "tn3270:", &p)) {
         if (sscanf(p, "%64[^:]:%32[^,]%n", host, port, &pos) < 2) {
             host[0] = 0;
             if (sscanf(p, ":%32[^,]%n", port, &pos) < 1)
@@ -712,8 +713,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
                 goto fail;
             }
         }
-        if (strstart(filename, "telnet:", &p))
+        if (strstart(filename, "telnet:", &p)) {
             qemu_opt_set(opts, "telnet", "on", &error_abort);
+        } else if (strstart(filename, "tn3270:", &p)) {
+            qemu_opt_set(opts, "tn3270", "on", &error_abort);
+        }
         return opts;
     }
     if (strstart(filename, "udp:", &p)) {
@@ -1177,6 +1181,9 @@ QemuOptsList qemu_chardev_opts = {
             .name = "telnet",
             .type = QEMU_OPT_BOOL,
         },{
+            .name = "tn3270",
+            .type = QEMU_OPT_BOOL,
+        },{
             .name = "tls-creds",
             .type = QEMU_OPT_STRING,
         },{
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 450881d42c..f6d5cd0c9b 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -7,6 +7,14 @@
 #include "qemu/bitmap.h"
 #include "qom/object.h"
 
+#define IAC_EOR 239
+#define IAC_SE 240
+#define IAC_NOP 241
+#define IAC_BREAK 243
+#define IAC_IP 244
+#define IAC_SB 250
+#define IAC 255
+
 /* character device */
 
 typedef enum {
diff --git a/qapi-schema.json b/qapi-schema.json
index 250e4dc49b..f0302958ce 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4874,6 +4874,8 @@
 # @nodelay: set TCP_NODELAY socket option (default: false)
 # @telnet: enable telnet protocol on server
 #          sockets (default: false)
+# @tn3270: enable tn3270 protocol on server
+#          sockets (default: false) (Since: 2.10)
 # @reconnect: For a client socket, if a socket is disconnected,
 #          then attempt a reconnect after the given number of seconds.
 #          Setting this to zero disables this function. (default: 0)
@@ -4887,6 +4889,7 @@
                                      '*wait'      : 'bool',
                                      '*nodelay'   : 'bool',
                                      '*telnet'    : 'bool',
+                                     '*tn3270'    : 'bool',
                                      '*reconnect' : 'int' },
   'base': 'ChardevCommon' }
 
-- 
2.11.0
