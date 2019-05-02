Received: from eggs.gnu.org ([209.51.188.92]:42829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0003YP-6G
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00085x-O9
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-0007ot-F5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id h11so1376514wmb.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:44 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 11:15:50 +0300
Message-Id: <20190502081554.5521-24-arilou@gmail.com>
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 23/27] gdbstub: Implement qemu physical
 memory mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>

Add a new query/set which changes the memory GDB sees to physical memory
only.

gdb> maint packet qqemu.PhyMemMode
will reply the current phy_mem_mode state (1 for enabled, 0 for disabled)
gdb> maint packet Qqemu.PhyMemMode:1
Will make GDB read/write only to physical memory, set to 0 to disable

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 00c07d6ec0..88ff6224e6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -46,11 +46,23 @@
 #define GDB_ATTACHED "1"
 #endif
 
+static int phy_memory_mode;
+
 static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
                                          uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUClass *cc;
 
+    if (phy_memory_mode) {
+        if (is_write) {
+            cpu_physical_memory_write(addr, buf, len);
+        } else {
+            cpu_physical_memory_read(addr, buf, len);
+        }
+        return 0;
+    }
+
+    cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
@@ -2129,7 +2141,29 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, "sstepbits;sstep");
+    put_packet(gdb_ctx->s, "sstepbits;sstep;PhyMemMode");
+}
+
+static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
+                                           void *user_ctx)
+{
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "%d", phy_memory_mode);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (!gdb_ctx->params[0].val_ul) {
+        phy_memory_mode = 0;
+    } else {
+        phy_memory_mode = 1;
+    }
+    put_packet(gdb_ctx->s, "OK");
 }
 
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
@@ -2212,6 +2246,20 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_supported,
         .cmd = "qemu.Supported",
     },
+    {
+        .handler = handle_query_qemu_phy_mem_mode,
+        .cmd = "qemu.PhyMemMode",
+    },
+};
+
+static GdbCmdParseEntry gdb_gen_set_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_set_qemu_phy_mem_mode,
+        .cmd = "qemu.PhyMemMode:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2245,7 +2293,11 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    put_packet(gdb_ctx->s, "");
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_gen_set_table,
+                           ARRAY_SIZE(gdb_gen_set_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
 }
 
 static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1
