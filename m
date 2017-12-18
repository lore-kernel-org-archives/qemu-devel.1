Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiP-0000Vs-Mw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwiN-00082b-PN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwiN-000824-Ex
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:48:00 +0000
Message-Id: <20171218144800.27337-5-stefanha@redhat.com>
In-Reply-To: <20171218144800.27337-1-stefanha@redhat.com>
References: <20171218144800.27337-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] gdbstub: add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Doug Gale <doug16k@gmail.com>

Signed-off-by: Doug Gale <doug16k@gmail.com>
Message-id: 20171203013037.31978-1-doug16k@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 gdbstub.c    | 113 +++++++++++++++++++++++++++++++++++++++++------------------
 trace-events |  28 +++++++++++++++
 2 files changed, 106 insertions(+), 35 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 2a94030d3b..f1d51480f7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "cpu.h"
+#include "trace-root.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
@@ -287,21 +288,6 @@ static int gdb_signal_to_target (int sig)
         return -1;
 }
 
-/* #define DEBUG_GDB */
-
-#ifdef DEBUG_GDB
-# define DEBUG_GDB_GATE 1
-#else
-# define DEBUG_GDB_GATE 0
-#endif
-
-#define gdb_debug(fmt, ...) do { \
-    if (DEBUG_GDB_GATE) { \
-        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
-    } \
-} while (0)
-
-
 typedef struct GDBRegisterState {
     int base_reg;
     int num_regs;
@@ -410,10 +396,13 @@ int use_gdb_syscalls(void)
 /* Resume execution.  */
 static inline void gdb_continue(GDBState *s)
 {
+
 #ifdef CONFIG_USER_ONLY
     s->running_state = 1;
+    trace_gdbstub_op_continue();
 #else
     if (!runstate_needs_reset()) {
+        trace_gdbstub_op_continue();
         vm_start();
     }
 #endif
@@ -434,6 +423,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
      */
     CPU_FOREACH(cpu) {
         if (newstates[cpu->cpu_index] == 's') {
+            trace_gdbstub_op_stepping(cpu->cpu_index);
             cpu_single_step(cpu, sstep_flags);
         }
     }
@@ -452,11 +442,13 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
             case 1:
                 break; /* nothing to do here */
             case 's':
+                trace_gdbstub_op_stepping(cpu->cpu_index);
                 cpu_single_step(cpu, sstep_flags);
                 cpu_resume(cpu);
                 flag = 1;
                 break;
             case 'c':
+                trace_gdbstub_op_continue_cpu(cpu->cpu_index);
                 cpu_resume(cpu);
                 flag = 1;
                 break;
@@ -538,12 +530,49 @@ static void hextomem(uint8_t *mem, const char *buf, int len)
     }
 }
 
+static void hexdump(const char *buf, int len,
+                    void (*trace_fn)(size_t ofs, char const *text))
+{
+    char line_buffer[3 * 16 + 4 + 16 + 1];
+
+    size_t i;
+    for (i = 0; i < len || (i & 0xF); ++i) {
+        size_t byte_ofs = i & 15;
+
+        if (byte_ofs == 0) {
+            memset(line_buffer, ' ', 3 * 16 + 4 + 16);
+            line_buffer[3 * 16 + 4 + 16] = 0;
+        }
+
+        size_t col_group = (i >> 2) & 3;
+        size_t hex_col = byte_ofs * 3 + col_group;
+        size_t txt_col = 3 * 16 + 4 + byte_ofs;
+
+        if (i < len) {
+            char value = buf[i];
+
+            line_buffer[hex_col + 0] = tohex((value >> 4) & 0xF);
+            line_buffer[hex_col + 1] = tohex((value >> 0) & 0xF);
+            line_buffer[txt_col + 0] = (value >= ' ' && value < 127)
+                    ? value
+                    : '.';
+        }
+
+        if (byte_ofs == 0xF)
+            trace_fn(i & -16, line_buffer);
+    }
+}
+
 /* return -1 if error, 0 if OK */
-static int put_packet_binary(GDBState *s, const char *buf, int len)
+static int put_packet_binary(GDBState *s, const char *buf, int len, bool dump)
 {
     int csum, i;
     uint8_t *p;
 
+    if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY)) {
+        hexdump(buf, len, trace_gdbstub_io_binaryreply);
+    }
+
     for(;;) {
         p = s->last_packet;
         *(p++) = '$';
@@ -576,9 +605,9 @@ static int put_packet_binary(GDBState *s, const char *buf, int len)
 /* return -1 if error, 0 if OK */
 static int put_packet(GDBState *s, const char *buf)
 {
-    gdb_debug("reply='%s'\n", buf);
+    trace_gdbstub_io_reply(buf);
 
-    return put_packet_binary(s, buf, strlen(buf));
+    return put_packet_binary(s, buf, strlen(buf), false);
 }
 
 /* Encode data using the encoding for 'x' packets.  */
@@ -975,8 +1004,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t *registers;
     target_ulong addr, len;
 
-
-    gdb_debug("command='%s'\n", line_buf);
+    trace_gdbstub_io_command(line_buf);
 
     p = line_buf;
     ch = *p++;
@@ -999,7 +1027,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         s->signal = 0;
         gdb_continue(s);
-	return RS_IDLE;
+        return RS_IDLE;
     case 'C':
         s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
         if (s->signal == -1)
@@ -1045,7 +1073,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         cpu_single_step(s->c_cpu, sstep_flags);
         gdb_continue(s);
-	return RS_IDLE;
+        return RS_IDLE;
     case 'F':
         {
             target_ulong ret;
@@ -1267,6 +1295,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                 len = snprintf((char *)mem_buf, sizeof(buf) / 2,
                                "CPU#%d [%s]", cpu->cpu_index,
                                cpu->halted ? "halted " : "running");
+                trace_gdbstub_op_extra_info((char *)mem_buf);
                 memtohex(buf, mem_buf, len);
                 put_packet(s, buf);
             }
@@ -1350,7 +1379,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                 buf[0] = 'l';
                 len = memtox(buf + 1, xml + addr, total_len - addr);
             }
-            put_packet_binary(s, buf, len + 1);
+            put_packet_binary(s, buf, len + 1, true);
             break;
         }
         if (is_query_packet(p, "Attached", ':')) {
@@ -1407,29 +1436,38 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
                 type = "";
                 break;
             }
+            trace_gdbstub_hit_watchpoint(type, cpu_gdb_index(cpu),
+                    (target_ulong)cpu->watchpoint_hit->vaddr);
             snprintf(buf, sizeof(buf),
                      "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
                      GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
                      (target_ulong)cpu->watchpoint_hit->vaddr);
             cpu->watchpoint_hit = NULL;
             goto send_packet;
+        } else {
+            trace_gdbstub_hit_break();
         }
         tb_flush(cpu);
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
+        trace_gdbstub_hit_paused();
         ret = GDB_SIGNAL_INT;
         break;
     case RUN_STATE_SHUTDOWN:
+        trace_gdbstub_hit_shutdown();
         ret = GDB_SIGNAL_QUIT;
         break;
     case RUN_STATE_IO_ERROR:
+        trace_gdbstub_hit_io_error();
         ret = GDB_SIGNAL_IO;
         break;
     case RUN_STATE_WATCHDOG:
+        trace_gdbstub_hit_watchdog();
         ret = GDB_SIGNAL_ALRM;
         break;
     case RUN_STATE_INTERNAL_ERROR:
+        trace_gdbstub_hit_internal_error();
         ret = GDB_SIGNAL_ABRT;
         break;
     case RUN_STATE_SAVE_VM:
@@ -1439,6 +1477,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         ret = GDB_SIGNAL_XCPU;
         break;
     default:
+        trace_gdbstub_hit_unknown(state);
         ret = GDB_SIGNAL_UNKNOWN;
         break;
     }
@@ -1538,12 +1577,12 @@ static void gdb_read_byte(GDBState *s, int ch)
         /* Waiting for a response to the last packet.  If we see the start
            of a new command then abandon the previous response.  */
         if (ch == '-') {
-            gdb_debug("Got NACK, retransmitting\n");
+            trace_gdbstub_err_got_nack();
             put_buffer(s, (uint8_t *)s->last_packet, s->last_packet_len);
         } else if (ch == '+') {
-            gdb_debug("Got ACK\n");
+            trace_gdbstub_io_got_ack();
         } else {
-            gdb_debug("Got '%c' when expecting ACK/NACK\n", ch);
+            trace_gdbstub_io_got_unexpected((uint8_t)ch);
         }
 
         if (ch == '+' || ch == '$')
@@ -1566,7 +1605,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 s->line_sum = 0;
                 s->state = RS_GETLINE;
             } else {
-                gdb_debug("received garbage between packets: 0x%x\n", ch);
+                trace_gdbstub_err_garbage((uint8_t)ch);
             }
             break;
         case RS_GETLINE:
@@ -1582,7 +1621,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 /* end of command, start of checksum*/
                 s->state = RS_CHKSUM1;
             } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
-                gdb_debug("command buffer overrun, dropping command\n");
+                trace_gdbstub_err_overrun();
                 s->state = RS_IDLE;
             } else {
                 /* unescaped command character */
@@ -1596,7 +1635,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 s->state = RS_CHKSUM1;
             } else if (s->line_buf_index >= sizeof(s->line_buf) - 1) {
                 /* command buffer overrun */
-                gdb_debug("command buffer overrun, dropping command\n");
+                trace_gdbstub_err_overrun();
                 s->state = RS_IDLE;
             } else {
                 /* parse escaped character and leave escape state */
@@ -1608,18 +1647,18 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_GETLINE_RLE:
             if (ch < ' ') {
                 /* invalid RLE count encoding */
-                gdb_debug("got invalid RLE count: 0x%x\n", ch);
+                trace_gdbstub_err_invalid_repeat((uint8_t)ch);
                 s->state = RS_GETLINE;
             } else {
                 /* decode repeat length */
                 int repeat = (unsigned char)ch - ' ' + 3;
                 if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
                     /* that many repeats would overrun the command buffer */
-                    gdb_debug("command buffer overrun, dropping command\n");
+                    trace_gdbstub_err_overrun();
                     s->state = RS_IDLE;
                 } else if (s->line_buf_index < 1) {
                     /* got a repeat but we have nothing to repeat */
-                    gdb_debug("got invalid RLE sequence\n");
+                    trace_gdbstub_err_invalid_rle();
                     s->state = RS_GETLINE;
                 } else {
                     /* repeat the last character */
@@ -1634,7 +1673,7 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_CHKSUM1:
             /* get high hex digit of checksum */
             if (!isxdigit(ch)) {
-                gdb_debug("got invalid command checksum digit\n");
+                trace_gdbstub_err_checksum_invalid((uint8_t)ch);
                 s->state = RS_GETLINE;
                 break;
             }
@@ -1645,14 +1684,14 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_CHKSUM2:
             /* get low hex digit of checksum */
             if (!isxdigit(ch)) {
-                gdb_debug("got invalid command checksum digit\n");
+                trace_gdbstub_err_checksum_invalid((uint8_t)ch);
                 s->state = RS_GETLINE;
                 break;
             }
             s->line_csum |= fromhex(ch);
 
             if (s->line_csum != (s->line_sum & 0xff)) {
-                gdb_debug("got command packet with incorrect checksum\n");
+                trace_gdbstub_err_checksum_incorrect(s->line_sum, s->line_csum);
                 /* send NAK reply */
                 reply = '-';
                 put_buffer(s, &reply, 1);
@@ -1686,6 +1725,8 @@ void gdb_exit(CPUArchState *env, int code)
   }
 #endif
 
+  trace_gdbstub_op_exiting((uint8_t)code);
+
   snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
   put_packet(s, buf);
 
@@ -1944,6 +1985,8 @@ static const TypeInfo char_gdb_type_info = {
 
 int gdbserver_start(const char *device)
 {
+    trace_gdbstub_op_start(device);
+
     GDBState *s;
     char gdbstub_device_name[128];
     Chardev *chr = NULL;
diff --git a/trace-events b/trace-events
index 1d2eb5d3e4..3695959d0a 100644
--- a/trace-events
+++ b/trace-events
@@ -68,6 +68,34 @@ flatview_new(FlatView *view, MemoryRegion *root) "%p (root %p)"
 flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
 flatview_destroy_rcu(FlatView *view, MemoryRegion *root) "%p (root %p)"
 
+# gdbstub.c
+gdbstub_op_start(char const *device) "Starting gdbstub using device %s"
+gdbstub_op_exiting(uint8_t code) "notifying exit with code=0x%02x"
+gdbstub_op_continue(void) "Continuing all CPUs"
+gdbstub_op_continue_cpu(int cpu_index) "Continuing CPU %d"
+gdbstub_op_stepping(int cpu_index) "Stepping CPU %d"
+gdbstub_op_extra_info(char const *info) "Thread extra info: %s"
+gdbstub_hit_watchpoint(char const *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
+gdbstub_hit_internal_error(void) "RUN_STATE_INTERNAL_ERROR"
+gdbstub_hit_break(void) "RUN_STATE_DEBUG"
+gdbstub_hit_paused(void) "RUN_STATE_PAUSED"
+gdbstub_hit_shutdown(void) "RUN_STATE_SHUTDOWN"
+gdbstub_hit_io_error(void) "RUN_STATE_IO_ERROR"
+gdbstub_hit_watchdog(void) "RUN_STATE_WATCHDOG"
+gdbstub_hit_unknown(int state) "Unknown run state=0x%x"
+gdbstub_io_reply(char const *message) "Sent: %s"
+gdbstub_io_binaryreply(size_t ofs, char const *line) "0x%04zx: %s"
+gdbstub_io_command(char const *command) "Received: %s"
+gdbstub_io_got_ack(void) "Got ACK"
+gdbstub_io_got_unexpected(uint8_t ch) "Got 0x%02x when expecting ACK/NACK"
+gdbstub_err_got_nack(void) "Got NACK, retransmitting"
+gdbstub_err_garbage(uint8_t ch) "received garbage between packets: 0x%02x"
+gdbstub_err_overrun(void) "command buffer overrun, dropping command"
+gdbstub_err_invalid_repeat(uint8_t ch) "got invalid RLE count: 0x%02x"
+gdbstub_err_invalid_rle(void) "got invalid RLE sequence"
+gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x%02x"
+gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
+
 ### Guest events, keep at bottom
 
 
-- 
2.14.3
