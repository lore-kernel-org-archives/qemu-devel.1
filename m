Received: from eggs.gnu.org ([2001:4830:134:3::10]:51806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZco-0000Qa-Gv
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZcn-00050n-6t
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:15:54 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 Aug 2017 20:15:01 -0400
Message-Id: <20170901001502.29915-9-jsnow@redhat.com>
In-Reply-To: <20170901001502.29915-1-jsnow@redhat.com>
References: <20170901001502.29915-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 8/9] AHCI: pretty-print FIS to buffer
 instead of stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org, John Snow <jsnow@redhat.com>

The current FIS printing routines dump the FIS to screen. adjust this
such that it dumps to buffer instead, then use this ability to have
FIS dump mechanisms via trace-events instead of compiled defines.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 28 ++++++++++++++++++----------
 hw/ide/trace-events |  4 ++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 82cc196..6c98047 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -644,20 +644,21 @@ static void ahci_reset_port(AHCIState *s, int port)
     ahci_init_d2h(d);
 }
 
-static void debug_print_fis(uint8_t *fis, int cmd_len)
+/* Buffer pretty output based on a raw FIS structure. */
+static char *ahci_pretty_buffer_fis(uint8_t *fis, int cmd_len)
 {
-#if DEBUG_AHCI
     int i;
+    GString *s = g_string_new("FIS:");
 
-    fprintf(stderr, "fis:");
     for (i = 0; i < cmd_len; i++) {
         if ((i & 0xf) == 0) {
-            fprintf(stderr, "\n%02x:",i);
+            g_string_append_printf(s, "\n0x%02x: ", i);
         }
-        fprintf(stderr, "%02x ",fis[i]);
+        g_string_append_printf(s, "%02x ", fis[i]);
     }
-    fprintf(stderr, "\n");
-#endif
+    g_string_append_c(s, '\n');
+
+    return g_string_free(s, FALSE);
 }
 
 static bool ahci_map_fis_address(AHCIDevice *ad)
@@ -1201,7 +1202,11 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
      * table to ide_state->io_buffer */
     if (opts & AHCI_CMD_ATAPI) {
         memcpy(ide_state->io_buffer, &cmd_fis[AHCI_COMMAND_TABLE_ACMD], 0x10);
-        debug_print_fis(ide_state->io_buffer, 0x10);
+        if (trace_event_get_state_backends(TRACE_HANDLE_REG_H2D_FIS_DUMP)) {
+            char *pretty_fis = ahci_pretty_buffer_fis(ide_state->io_buffer, 0x10);
+            trace_handle_reg_h2d_fis_dump(s, port, pretty_fis);
+            g_free(pretty_fis);
+        }
         s->dev[port].done_atapi_packet = false;
         /* XXX send PIO setup FIS */
     }
@@ -1256,8 +1261,11 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
         trace_handle_cmd_badmap(s, port, cmd_len);
         goto out;
     }
-    debug_print_fis(cmd_fis, 0x80);
-
+    if (trace_event_get_state_backends(TRACE_HANDLE_CMD_FIS_DUMP)) {
+        char *pretty_fis = ahci_pretty_buffer_fis(cmd_fis, 0x80);
+        trace_handle_cmd_fis_dump(s, port, pretty_fis);
+        g_free(pretty_fis);
+    }
     switch (cmd_fis[0]) {
         case SATA_FIS_TYPE_REGISTER_H2D:
             handle_reg_h2d_fis(s, port, slot, cmd_fis);
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index e15fd77..601bd97 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -105,3 +105,7 @@ ahci_cmd_done(void *s, int port) "ahci(%p)[%d]: cmd done"
 ahci_reset(void *s) "ahci(%p): HBA reset"
 allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): read a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
 allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): write a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
+
+# Warning: Verbose
+handle_reg_h2d_fis_dump(void *s, int port, const char *fis) "ahci(%p)[%d]: %s"
+handle_cmd_fis_dump(void *s, int port, const char *fis) "ahci(%p)[%d]: %s"
-- 
2.9.5
