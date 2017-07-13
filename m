Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4R-0001tF-30
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4N-0004KI-2L
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4M-0004K0-PM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id y28so4891663wrd.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:17 +0200
Message-Id: <1499955874-10954-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/41] gdbstub: modernise DEBUG_GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

Convert the a gdb_debug helper which compiles away to nothing when not
used but still ensures the format strings are checked. There is some
minor code motion for the incorrect checksum message to report it
before we attempt to send the reply.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20170712105216.747-2-alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub.c | 77 +++++++++++++++++++++++++++------------------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index e561244..3965980 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -272,7 +272,20 @@ static int gdb_signal_to_target (int sig)
         return -1;
 }
 
-//#define DEBUG_GDB
+/* #define DEBUG_GDB */
+
+#ifdef DEBUG_GDB
+# define DEBUG_GDB_GATE 1
+#else
+# define DEBUG_GDB_GATE 0
+#endif
+
+#define gdb_debug(fmt, ...) do { \
+    if (DEBUG_GDB_GATE) { \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    } \
+} while (0)
+
 
 typedef struct GDBRegisterState {
     int base_reg;
@@ -548,9 +561,7 @@ static int put_packet_binary(GDBState *s, const char *buf, int len)
 /* return -1 if error, 0 if OK */
 static int put_packet(GDBState *s, const char *buf)
 {
-#ifdef DEBUG_GDB
-    printf("reply='%s'\n", buf);
-#endif
+    gdb_debug("reply='%s'\n", buf);
 
     return put_packet_binary(s, buf, strlen(buf));
 }
@@ -956,9 +967,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t *registers;
     target_ulong addr, len;
 
-#ifdef DEBUG_GDB
-    printf("command='%s'\n", line_buf);
-#endif
+
+    gdb_debug("command='%s'\n", line_buf);
+
     p = line_buf;
     ch = *p++;
     switch(ch) {
@@ -1519,17 +1530,14 @@ static void gdb_read_byte(GDBState *s, int ch)
         /* Waiting for a response to the last packet.  If we see the start
            of a new command then abandon the previous response.  */
         if (ch == '-') {
-#ifdef DEBUG_GDB
-            printf("Got NACK, retransmitting\n");
-#endif
+            gdb_debug("Got NACK, retransmitting\n");
             put_buffer(s, (uint8_t *)s->last_packet, s->last_packet_len);
+        } else if (ch == '+') {
+            gdb_debug("Got ACK\n");
+        } else {
+            gdb_debug("Got '%c' when expecting ACK/NACK\n", ch);
         }
-#ifdef DEBUG_GDB
-        else if (ch == '+')
-            printf("Got ACK\n");
-        else
-            printf("Got '%c' when expecting ACK/NACK\n", ch);
-#endif
+
         if (ch == '+' || ch == '$')
             s->last_packet_len = 0;
         if (ch != '$')
@@ -1550,9 +1558,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 s->line_sum = 0;
                 s->state = RS_GETLINE;
             } else {
-#ifdef DEBUG_GDB
-                printf("gdbstub received garbage between packets: 0x%x\n", ch);
-#endif
+                gdb_debug("received garbage between packets: 0x%x\n", ch);
             }
             break;
         case RS_GETLINE:
@@ -1568,9 +1574,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 /* end of command, start of checksum*/
                 s->state = RS_CHKSUM1;
             } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
-#ifdef DEBUG_GDB
-                printf("gdbstub command buffer overrun, dropping command\n");
-#endif
+                gdb_debug("command buffer overrun, dropping command\n");
                 s->state = RS_IDLE;
             } else {
                 /* unescaped command character */
@@ -1584,9 +1588,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 s->state = RS_CHKSUM1;
             } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
                 /* command buffer overrun */
-#ifdef DEBUG_GDB
-                printf("gdbstub command buffer overrun, dropping command\n");
-#endif
+                gdb_debug("command buffer overrun, dropping command\n");
                 s->state = RS_IDLE;
             } else {
                 /* parse escaped character and leave escape state */
@@ -1598,25 +1600,18 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_GETLINE_RLE:
             if (ch < ' ') {
                 /* invalid RLE count encoding */
-#ifdef DEBUG_GDB
-                printf("gdbstub got invalid RLE count: 0x%x\n", ch);
-#endif
+                gdb_debug("got invalid RLE count: 0x%x\n", ch);
                 s->state = RS_GETLINE;
             } else {
                 /* decode repeat length */
                 int repeat = (unsigned char)ch - ' ' + 3;
                 if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
                     /* that many repeats would overrun the command buffer */
-#ifdef DEBUG_GDB
-                    printf("gdbstub command buffer overrun,"
-                           " dropping command\n");
-#endif
+                    gdb_debug("command buffer overrun, dropping command\n");
                     s->state = RS_IDLE;
                 } else if (s->line_buf_index < 1) {
                     /* got a repeat but we have nothing to repeat */
-#ifdef DEBUG_GDB
-                    printf("gdbstub got invalid RLE sequence\n");
-#endif
+                    gdb_debug("got invalid RLE sequence\n");
                     s->state = RS_GETLINE;
                 } else {
                     /* repeat the last character */
@@ -1631,9 +1626,7 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_CHKSUM1:
             /* get high hex digit of checksum */
             if (!isxdigit(ch)) {
-#ifdef DEBUG_GDB
-                printf("gdbstub got invalid command checksum digit\n");
-#endif
+                gdb_debug("got invalid command checksum digit\n");
                 s->state = RS_GETLINE;
                 break;
             }
@@ -1644,21 +1637,17 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_CHKSUM2:
             /* get low hex digit of checksum */
             if (!isxdigit(ch)) {
-#ifdef DEBUG_GDB
-                printf("gdbstub got invalid command checksum digit\n");
-#endif
+                gdb_debug("got invalid command checksum digit\n");
                 s->state = RS_GETLINE;
                 break;
             }
             s->line_csum |= fromhex(ch);
 
             if (s->line_csum != (s->line_sum & 0xff)) {
+                gdb_debug("got command packet with incorrect checksum\n");
                 /* send NAK reply */
                 reply = '-';
                 put_buffer(s, &reply, 1);
-#ifdef DEBUG_GDB
-                printf("gdbstub got command packet with incorrect checksum\n");
-#endif
                 s->state = RS_IDLE;
             } else {
                 /* send ACK reply */
-- 
1.8.3.1
