Received: from eggs.gnu.org ([209.51.188.92]:56247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNjm-0003ao-7g
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNji-0003eO-JW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNji-0003da-7r
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so17891224wrs.11
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Wed, 24 Apr 2019 22:38:39 +0300
Message-Id: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/21] gdbstub: Add infrastructure to parse
 cmd packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc..3308279fa8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1268,6 +1268,206 @@ out:
     return res;
 }
 
+typedef union GdbCmdVariant {
+    const char *data;
+    uint8_t opcode;
+    unsigned long val_ul;
+    unsigned long long val_ull;
+    struct {
+        GDBThreadIdKind kind;
+        uint32_t pid;
+        uint32_t tid;
+    } thread_id;
+} GdbCmdVariant;
+
+static const char *cmd_next_param(const char *param, const char delimiter)
+{
+    static const char all_delimiters[] = ",;:=";
+    char curr_delimiters[2] = {0};
+    const char *delimiters;
+
+    if (delimiter == '?') {
+        delimiters = all_delimiters;
+    } else if (delimiter == '0') {
+        return strchr(param, '\0');
+    } else if (delimiter == '.' && *param) {
+        return param + 1;
+    } else {
+        curr_delimiters[0] = delimiter;
+        delimiters = curr_delimiters;
+    }
+
+    param += strcspn(param, delimiters);
+    if (*param) {
+        param++;
+    }
+    return param;
+}
+
+static int cmd_parse_params(const char *data, const char *schema,
+                            GdbCmdVariant *params, int *num_params)
+{
+    int curr_param;
+    const char *curr_schema, *curr_data;
+
+    *num_params = 0;
+
+    if (!schema) {
+        return 0;
+    }
+
+    curr_schema = schema;
+    curr_param = 0;
+    curr_data = data;
+    while (curr_schema[0] && curr_schema[1] && *curr_data) {
+        switch (curr_schema[0]) {
+        case 'l':
+            if (qemu_strtoul(curr_data, &curr_data, 16,
+                             &params[curr_param].val_ul)) {
+                return -EINVAL;
+            }
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 'L':
+            if (qemu_strtou64(curr_data, &curr_data, 16,
+                              (uint64_t *)&params[curr_param].val_ull)) {
+                return -EINVAL;
+            }
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 's':
+            params[curr_param].data = curr_data;
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 'o':
+            params[curr_param].opcode = *(uint8_t *)curr_data;
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 't':
+            params[curr_param].thread_id.kind =
+                read_thread_id(curr_data, &curr_data,
+                               &params[curr_param].thread_id.pid,
+                               &params[curr_param].thread_id.tid);
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case '?':
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        default:
+            return -EINVAL;
+        }
+        curr_schema += 2;
+    }
+
+    *num_params = curr_param;
+    return 0;
+}
+
+typedef struct GdbCmdContext {
+    GDBState *s;
+    GdbCmdVariant *params;
+    int num_params;
+    uint8_t mem_buf[MAX_PACKET_LENGTH];
+    char str_buf[MAX_PACKET_LENGTH + 1];
+} GdbCmdContext;
+
+typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
+
+/*
+ * cmd_startswith -> cmd is compared using startswith
+ * cmd_full_match -> cmd is compared using strcmp
+ *
+ *
+ * schema definitions:
+ * Each schema parameter entry consists of 2 chars,
+ * the first char represents the parameter type handling
+ * the second char represents the delimiter for the next parameter
+ *
+ * Currently supported schema types:
+ * 'l' -> unsigned long (stored in .val_ul)
+ * 'L' -> unsigned long long (stored in .val_ull)
+ * 's' -> string (stored in .data)
+ * 'o' -> single char (stored in .opcode)
+ * 't' -> thread id (stored in .thread_id)
+ * '?' -> skip according to delimiter
+ *
+ * Currently supported delimiters:
+ * '?' -> Stop at any delimiter (",;:=\0")
+ * '0' -> Stop at "\0"
+ * '.' -> Skip 1 char unless reached "\0"
+ * Any other value is treated as the delimiter value itself
+ */
+typedef struct GdbCmdParseEntry {
+    GdbCmdHandler handler;
+    const char *cmd;
+    union {
+        int flags;
+        struct {
+            int cmd_startswith:1;
+            int cmd_full_match:1;
+        };
+    };
+    const char *schema;
+} GdbCmdParseEntry;
+
+static inline int startswith(const char *string, const char *pattern)
+{
+  return !strncmp(string, pattern, strlen(pattern));
+}
+
+__attribute__((unused)) static int process_string_cmd(
+        GDBState *s, void *user_ctx, const char *data,
+        const GdbCmdParseEntry *cmds, int num_cmds);
+
+static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
+                              const GdbCmdParseEntry *cmds, int num_cmds)
+{
+    int i, schema_len, max_num_params;
+    GdbCmdContext gdb_ctx;
+
+    if (!cmds) {
+        return -1;
+    }
+
+    for (i = 0; i < num_cmds; i++) {
+        if (!cmds[i].handler || !cmds[i].cmd ||
+            (cmds[i].cmd_startswith && !startswith(data, cmds[i].cmd)) ||
+            (cmds[i].cmd_full_match && strcmp(data, cmds[i].cmd))) {
+            continue;
+        }
+
+        max_num_params = 0;
+        if (cmds[i].schema) {
+            schema_len = strlen(cmds[i].schema);
+            if (schema_len % 2) {
+                return -2;
+            }
+
+            max_num_params = schema_len / 2;
+        }
+
+        gdb_ctx.params =
+            (GdbCmdVariant *)alloca(sizeof(*gdb_ctx.params) * max_num_params);
+        memset(gdb_ctx.params, 0, sizeof(*gdb_ctx.params) * max_num_params);
+
+        if (cmd_parse_params(&data[strlen(cmds[i].cmd)], cmds[i].schema,
+                             gdb_ctx.params, &gdb_ctx.num_params)) {
+            return -1;
+        }
+
+        gdb_ctx.s = s;
+        cmds[i].handler(&gdb_ctx, user_ctx);
+        return 0;
+    }
+
+    return -1;
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
-- 
2.20.1
