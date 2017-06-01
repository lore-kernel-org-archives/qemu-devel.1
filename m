Received: from eggs.gnu.org ([2001:4830:134:3::10]:43967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGRPM-0004Y9-JT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGRPK-0002Vc-Ny
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:04 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGRPK-0002VC-EE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:02 -0400
Received: by mail-wm0-x234.google.com with SMTP id b84so161718946wmh.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:49:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  1 Jun 2017 15:49:12 +0100
Message-Id: <20170601144915.20778-2-alex.bennee@linaro.org>
In-Reply-To: <20170601144915.20778-1-alex.bennee@linaro.org>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] gdbstub: modernise DEBUG_GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Convert the a gdb_debug helper which compiles away to nothing when not
used but still ensures the format strings are checked. There is some
minor code motion for the incorrect checksum message to report it
before we attempt to send the reply.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 gdbstub.c | 77 +++++++++++++++++++++++++++------------------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 86eed4f97c..a249846954 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -271,7 +271,20 @@ static int gdb_signal_to_target (int sig)
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
@@ -547,9 +560,7 @@ static int put_packet_binary(GDBState *s, const char *buf, int len)
 /* return -1 if error, 0 if OK */
 static int put_packet(GDBState *s, const char *buf)
 {
-#ifdef DEBUG_GDB
-    printf("reply='%s'\n", buf);
-#endif
+    gdb_debug("reply='%s'\n", buf);
 
     return put_packet_binary(s, buf, strlen(buf));
 }
@@ -955,9 +966,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -1518,17 +1529,14 @@ static void gdb_read_byte(GDBState *s, int ch)
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
@@ -1549,9 +1557,7 @@ static void gdb_read_byte(GDBState *s, int ch)
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
@@ -1567,9 +1573,7 @@ static void gdb_read_byte(GDBState *s, int ch)
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
@@ -1583,9 +1587,7 @@ static void gdb_read_byte(GDBState *s, int ch)
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
@@ -1597,25 +1599,18 @@ static void gdb_read_byte(GDBState *s, int ch)
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
@@ -1630,9 +1625,7 @@ static void gdb_read_byte(GDBState *s, int ch)
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
@@ -1643,21 +1636,17 @@ static void gdb_read_byte(GDBState *s, int ch)
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
2.13.0
