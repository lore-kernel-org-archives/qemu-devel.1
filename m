Received: from eggs.gnu.org ([209.51.188.92]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tg-0003YA-WE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00083W-Cz
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6ta-0007Ul-C7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id e28so2044715wra.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:29 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 11:15:40 +0300
Message-Id: <20190502081554.5521-14-arilou@gmail.com>
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 13/27] gdbstub: Implement write all
 registers (G pkt) with new infra
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index daa602edc3..adfe39b3a3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1734,6 +1734,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+    uint8_t *registers;
+    int reg_size;
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    registers = gdb_ctx->mem_buf;
+    len = strlen(gdb_ctx->params[0].data) / 2;
+    hextomem(registers, gdb_ctx->params[0].data, len);
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs && len > 0;
+         addr++) {
+        reg_size = gdb_write_register(gdb_ctx->s->g_cpu, registers, addr);
+        len -= reg_size;
+        registers += reg_size;
+    }
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1745,7 +1768,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
@@ -1911,16 +1933,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, buf);
         break;
     case 'G':
-        cpu_synchronize_state(s->g_cpu);
-        registers = mem_buf;
-        len = strlen(p) / 2;
-        hextomem((uint8_t *)registers, p, len);
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs && len > 0; addr++) {
-            reg_size = gdb_write_register(s->g_cpu, registers, addr);
-            len -= reg_size;
-            registers += reg_size;
+        {
+            static const GdbCmdParseEntry write_all_regs_cmd_desc = {
+                .handler = handle_write_all_regs,
+                .cmd = "G",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &write_all_regs_cmd_desc;
         }
-        put_packet(s, "OK");
         break;
     case 'm':
         {
-- 
2.20.1
