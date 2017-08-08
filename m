Received: from eggs.gnu.org ([2001:4830:134:3::10]:58160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Ji-00066G-OH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Jh-0002Um-D3
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:22 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 14:33:05 -0400
Message-Id: <20170808183306.27474-9-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-1-jsnow@redhat.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 8/9] AHCI: pretty-print FIS to buffer instead
 of stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

The current FIS printing routines dump the FIS to screen. adjust this
such that it dumps to buffer instead, then use this ability to have
FIS dump mechanisms via trace-events instead of compiled defines.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 54 +++++++++++++++++++++++++++++++++++++++++++----------
 hw/ide/trace-events |  3 +++
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c5a9b69..1a4d4db 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -644,20 +644,45 @@ static void ahci_reset_port(AHCIState *s, int port)
     ahci_init_d2h(d);
 }
 
-static void debug_print_fis(uint8_t *fis, int cmd_len)
+/* Buffer pretty output based on a raw FIS structure. */
+static void ahci_pretty_buffer_fis(uint8_t *fis, int cmd_len, char **out)
 {
-#if DEBUG_AHCI
+    size_t bufsize;
+    char *pbuf;
+    char *pptr;
+    size_t lines = DIV_ROUND_UP(cmd_len, 16);
+    const char *preamble = "FIS:";
     int i;
 
-    fprintf(stderr, "fis:");
+    /* Total amount of memory to store FISes in HBA memory */
+    g_assert_cmpint(cmd_len, <=, 0x100);
+    g_assert(out);
+
+    /* Printed like:
+     * FIS:\n
+     * 0x00: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee \n
+     * 0x10: ff \n
+     * \0
+     *
+     * Four bytes for the preamble, seven for each line prefix (including a
+     * newline to start a new line), three bytes for each source byte,
+     * a trailing newline and a terminal null byte.
+     */
+
+    bufsize = strlen(preamble) + ((6 + 1) * lines) + (3 * cmd_len) + 1 + 1;
+    pbuf = g_malloc(bufsize);
+    pptr = pbuf;
+    pptr += sprintf(pptr, "%s", preamble);
     for (i = 0; i < cmd_len; i++) {
         if ((i & 0xf) == 0) {
-            fprintf(stderr, "\n%02x:",i);
+            pptr += sprintf(pptr, "\n0x%02x: ", i);
         }
-        fprintf(stderr, "%02x ",fis[i]);
+        pptr += sprintf(pptr, "%02x ", fis[i]);
     }
-    fprintf(stderr, "\n");
-#endif
+    pptr += sprintf(pptr, "\n");
+    pptr += 1; /* \0 */
+    g_assert(pbuf + bufsize == pptr);
+    *out = pbuf;
 }
 
 static bool ahci_map_fis_address(AHCIDevice *ad)
@@ -1201,7 +1226,12 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
      * table to ide_state->io_buffer */
     if (opts & AHCI_CMD_ATAPI) {
         memcpy(ide_state->io_buffer, &cmd_fis[AHCI_COMMAND_TABLE_ACMD], 0x10);
-        debug_print_fis(ide_state->io_buffer, 0x10);
+        if (TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED) {
+            char *pretty_fis;
+            ahci_pretty_buffer_fis(ide_state->io_buffer, 0x10, &pretty_fis);
+            trace_handle_reg_h2d_fis_dump(s, port, pretty_fis);
+            g_free(pretty_fis);
+        }
         s->dev[port].done_atapi_packet = false;
         /* XXX send PIO setup FIS */
     }
@@ -1256,8 +1286,12 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
         trace_handle_cmd_badmap(s, port, cmd_len);
         goto out;
     }
-    debug_print_fis(cmd_fis, 0x80);
-
+    if (TRACE_HANDLE_CMD_FIS_DUMP_ENABLED) {
+        char *pretty_fis;
+        ahci_pretty_buffer_fis(cmd_fis, 0x80, &pretty_fis);
+        trace_handle_cmd_fis_dump(s, port, pretty_fis);
+        g_free(pretty_fis);
+    }
     switch (cmd_fis[0]) {
         case SATA_FIS_TYPE_REGISTER_H2D:
             handle_reg_h2d_fis(s, port, slot, cmd_fis);
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 5b321e1..082e804 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -103,3 +103,6 @@ ahci_reset(void *s) "ahci(%p): HBA reset"
 allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): read a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
 allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): write a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
 
+# Warning: Verbose
+handle_reg_h2d_fis_dump(void *s, int port, char *fis) "ahci(%p)[%d]: %s"
+handle_cmd_fis_dump(void *s, int port, char *fis) "ahci(%p)[%d]: %s"
-- 
2.9.4
