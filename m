Received: from eggs.gnu.org ([209.51.188.92]:48837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJHY5-0005Wo-10
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJHXq-0004rJ-99
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:02:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJHXp-0004qu-S0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:02:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id z24so4972041wmi.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:02:37 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Wed, 24 Apr 2019 16:02:22 +0300
Message-Id: <20190424130222.21537-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] gdbstub: Refactor gdb packets handler
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

Refactor the command packet handling code to ease the work of
adding and extending commands that are currently not implemented.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 1619 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 1128 insertions(+), 491 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc..1fc6183472 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1130,14 +1130,6 @@ static GDBThreadIdKind read_thread_id(const char *buf, const char **end_buf,
     return GDB_ONE_THREAD;
 }
 
-static int is_query_packet(const char *p, const char *query, char separator)
-{
-    unsigned int query_len = strlen(query);
-
-    return strncmp(p, query, query_len) == 0 &&
-        (p[query_len] == '\0' || p[query_len] == separator);
-}
-
 /**
  * gdb_handle_vcont - Parses and handles a vCont packet.
  * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if there is
@@ -1268,528 +1260,1173 @@ out:
     return res;
 }
 
-static int gdb_handle_packet(GDBState *s, const char *line_buf)
-{
-    CPUState *cpu;
-    GDBProcess *process;
-    CPUClass *cc;
-    const char *p;
-    uint32_t pid, tid;
-    int ch, reg_size, type, res;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
-    char thread_id[16];
-    uint8_t *registers;
-    target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
-
-    trace_gdbstub_io_command(line_buf);
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
+    const char *delim;
+    static char all_delimiters[] = ",;:=";
+    static char no_delimiter[] = "\0";
+    char curr_delimiters[2] = {0};
+    const char *delimiters;
+
+    if (delimiter == '?') {
+        delimiters = all_delimiters;
+    } else if (delimiter == '0') {
+        delimiters = no_delimiter;
+    } else if (delimiter == '.' && *param) {
+        return param + 1;
+    } else {
+        curr_delimiters[0] = delimiter;
+        delimiters = curr_delimiters;
+    }
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
-    case '!':
-        put_packet(s, "OK");
-        break;
-    case '?':
-        /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
-        put_packet(s, buf);
-        /* Remove all the breakpoints when this query is issued,
-         * because gdb is doing and initial connect and the state
-         * should be cleaned up.
-         */
-        gdb_breakpoint_remove_all();
-        break;
-    case 'c':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
-        }
-        s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
-    case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
-    case 'v':
-        if (strncmp(p, "Cont", 4) == 0) {
-            p += 4;
-            if (*p == '?') {
-                put_packet(s, "vCont;c;C;s;S");
-                break;
+    while (*param) {
+        delim = delimiters;
+        while (*delim) {
+            if (*param == *delim) {
+                return param + 1;
             }
+            delim++;
+        }
+        param++;
+    }
 
-            res = gdb_handle_vcont(s, p);
+    return param;
+}
 
-            if (res) {
-                if ((res == -EINVAL) || (res == -ERANGE)) {
-                    put_packet(s, "E22");
-                    break;
-                }
-                goto unknown_command;
-            }
-            break;
-        } else if (strncmp(p, "Attach;", 7) == 0) {
-            unsigned long pid;
+static int cmd_parse_params(const char *data, const char *schema,
+                            GdbCmdVariant *params, int *num_params)
+{
+    int curr_param;
+    const char *curr_schema, *curr_data;
 
-            p += 7;
+    *num_params = 0;
 
-            if (qemu_strtoul(p, &p, 16, &pid)) {
-                put_packet(s, "E22");
-                break;
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
             }
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
+        case 'x':
+            params[curr_param].data = curr_data;
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
 
-            process = gdb_get_process(s, pid);
+    *num_params = curr_param;
+    return 0;
+}
 
-            if (process == NULL) {
-                put_packet(s, "E22");
-                break;
-            }
+typedef struct GdbCmdContext {
+    GDBState *s;
+    GdbCmdVariant *params;
+    int num_params;
+    uint8_t mem_buf[MAX_PACKET_LENGTH];
+    char str_buf[MAX_PACKET_LENGTH + 1];
+} GdbCmdContext;
 
-            cpu = get_first_cpu_in_process(s, process);
+typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
 
-            if (cpu == NULL) {
-                /* Refuse to attach an empty process */
-                put_packet(s, "E22");
-                break;
-            }
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
+ * 'x' -> xml (stored in .data), must have a ':' delimiter
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
 
-            process->attached = true;
+static inline int startswith(const char *string, const char *pattern)
+{
+  return !strncmp(string, pattern, strlen(pattern));
+}
 
-            s->g_cpu = cpu;
-            s->c_cpu = cpu;
+static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
+                              GdbCmdParseEntry *cmds, int num_cmds)
+{
+    int i, schema_len, max_num_params;
+    GdbCmdContext gdb_ctx;
 
-            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
+    if (!cmds) {
+        return -1;
+    }
 
-            put_packet(s, buf);
-            break;
-        } else if (strncmp(p, "Kill;", 5) == 0) {
-            /* Kill the target */
-            put_packet(s, "OK");
-            error_report("QEMU: Terminated via GDBstub");
-            exit(0);
-        } else {
-            goto unknown_command;
+    for (i = 0; i < num_cmds; i++) {
+        if (!cmds[i].handler || !cmds[i].cmd ||
+            (cmds[i].cmd_startswith && !startswith(data, cmds[i].cmd)) ||
+            (cmds[i].cmd_full_match && strcmp(data, cmds[i].cmd))) {
+            continue;
         }
-    case 'k':
-        /* Kill the target */
-        error_report("QEMU: Terminated via GDBstub");
-        exit(0);
-    case 'D':
-        /* Detach packet */
-        pid = 1;
-
-        if (s->multiprocess) {
-            unsigned long lpid;
-            if (*p != ';') {
-                put_packet(s, "E22");
-                break;
-            }
 
-            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
-                put_packet(s, "E22");
-                break;
+        max_num_params = 0;
+        if (cmds[i].schema) {
+            schema_len = strlen(cmds[i].schema);
+            if (schema_len % 2) {
+                return -2;
             }
 
-            pid = lpid;
+            max_num_params = schema_len / 2;
         }
 
-        process = gdb_get_process(s, pid);
-        gdb_process_breakpoint_remove_all(s, process);
-        process->attached = false;
+        gdb_ctx.params =
+            (GdbCmdVariant *)alloca(sizeof(*gdb_ctx.params) * max_num_params);
+        memset(gdb_ctx.params, 0, sizeof(*gdb_ctx.params) * max_num_params);
 
-        if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
-            s->c_cpu = gdb_first_attached_cpu(s);
+        if (cmd_parse_params(&data[strlen(cmds[i].cmd)], cmds[i].schema,
+                             gdb_ctx.params, &gdb_ctx.num_params)) {
+            return -1;
         }
 
-        if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
-            s->g_cpu = gdb_first_attached_cpu(s);
-        }
+        gdb_ctx.s = s;
+        cmds[i].handler(&gdb_ctx, user_ctx);
+        return 0;
+    }
 
-        if (s->c_cpu == NULL) {
-            /* No more process attached */
-            gdb_syscall_mode = GDB_SYS_DISABLED;
-            gdb_continue(s);
-        }
-        put_packet(s, "OK");
-        break;
-    case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
-        }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
-    case 'F':
-        {
-            target_ulong ret;
-            target_ulong err;
-
-            ret = strtoull(p, (char **)&p, 16);
-            if (*p == ',') {
-                p++;
-                err = strtoull(p, (char **)&p, 16);
-            } else {
-                err = 0;
-            }
-            if (*p == ',')
-                p++;
-            type = *p;
-            if (s->current_syscall_cb) {
-                s->current_syscall_cb(s->c_cpu, ret, err);
-                s->current_syscall_cb = NULL;
-            }
-            if (type == 'C') {
-                put_packet(s, "T02");
-            } else {
-                gdb_continue(s);
-            }
-        }
-        break;
-    case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
-        }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
-        break;
-    case 'G':
-        cpu_synchronize_state(s->g_cpu);
-        registers = mem_buf;
-        len = strlen(p) / 2;
-        hextomem((uint8_t *)registers, p, len);
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs && len > 0; addr++) {
-            reg_size = gdb_write_register(s->g_cpu, registers, addr);
-            len -= reg_size;
-            registers += reg_size;
-        }
-        put_packet(s, "OK");
-        break;
-    case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
+    return -1;
+}
 
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
+static void handle_extend_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "OK");
+}
 
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
-        }
-        break;
-    case 'M':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (*p == ':')
-            p++;
-
-        /* hextomem() reads 2*len bytes */
-        if (len > strlen(p) / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-        hextomem(mem_buf, p, len);
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len,
-                                   true) != 0) {
-            put_packet(s, "E14");
-        } else {
-            put_packet(s, "OK");
-        }
-        break;
-    case 'p':
-        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-           This works, but can be very slow.  Anything new enough to
-           understand XML also knows how to use this properly.  */
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        reg_size = gdb_read_register(s->g_cpu, mem_buf, addr);
-        if (reg_size) {
-            memtohex(buf, mem_buf, reg_size);
-            put_packet(s, buf);
-        } else {
-            put_packet(s, "E14");
-        }
-        break;
-    case 'P':
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == '=')
-            p++;
-        reg_size = strlen(p) / 2;
-        hextomem(mem_buf, p, reg_size);
-        gdb_write_register(s->g_cpu, mem_buf, addr);
-        put_packet(s, "OK");
-        break;
-    case 'Z':
-    case 'z':
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
-        break;
-    case 'H':
-        type = *p++;
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
 
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
+    /* TODO: Make this return the correct value for user-mode.  */
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    /*
+     * Remove all the breakpoints when this query is issued,
+     * because gdb is doing and initial connect and the state
+     * should be cleaned up.
+     */
+    gdb_breakpoint_remove_all();
+}
 
-        if (thread_kind != GDB_ONE_THREAD) {
-            put_packet(s, "OK");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-        if (cpu == NULL) {
-            put_packet(s, "E22");
-            break;
-        }
-        switch (type) {
-        case 'c':
-            s->c_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        case 'g':
-            s->g_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        default:
-             put_packet(s, "E22");
-             break;
-        }
-        break;
-    case 'T':
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
+static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
+    }
 
-        if (cpu != NULL) {
-            put_packet(s, "OK");
-        } else {
-            put_packet(s, "E22");
-        }
-        break;
-    case 'q':
-    case 'Q':
-        /* parse any 'q' packets here */
-        if (!strcmp(p,"qemu.sstepbits")) {
-            /* Query Breakpoint bit definitions */
-            snprintf(buf, sizeof(buf), "ENABLE=%x,NOIRQ=%x,NOTIMER=%x",
-                     SSTEP_ENABLE,
-                     SSTEP_NOIRQ,
-                     SSTEP_NOTIMER);
-            put_packet(s, buf);
-            break;
-        } else if (is_query_packet(p, "qemu.sstep", '=')) {
-            /* Display or change the sstep_flags */
-            p += 10;
-            if (*p != '=') {
-                /* Display current setting */
-                snprintf(buf, sizeof(buf), "0x%x", sstep_flags);
-                put_packet(s, buf);
-                break;
-            }
-            p++;
-            type = strtoul(p, (char **)&p, 16);
-            sstep_flags = type;
-            put_packet(s, "OK");
-            break;
-        } else if (strcmp(p,"C") == 0) {
-            /*
-             * "Current thread" remains vague in the spec, so always return
-             * the first thread of the current process (gdb returns the
-             * first thread).
-             */
-            cpu = get_first_cpu_in_process(s, gdb_get_cpu_process(s, s->g_cpu));
-            snprintf(buf, sizeof(buf), "QC%s",
-                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
-            put_packet(s, buf);
-            break;
-        } else if (strcmp(p,"fThreadInfo") == 0) {
-            s->query_cpu = gdb_first_attached_cpu(s);
-            goto report_cpuinfo;
-        } else if (strcmp(p,"sThreadInfo") == 0) {
-        report_cpuinfo:
-            if (s->query_cpu) {
-                snprintf(buf, sizeof(buf), "m%s",
-                         gdb_fmt_thread_id(s, s->query_cpu,
-                                       thread_id, sizeof(thread_id)));
-                put_packet(s, buf);
-                s->query_cpu = gdb_next_attached_cpu(s, s->query_cpu);
-            } else
-                put_packet(s, "l");
-            break;
-        } else if (strncmp(p,"ThreadExtraInfo,", 16) == 0) {
-            if (read_thread_id(p + 16, &p, &pid, &tid) == GDB_READ_THREAD_ERR) {
-                put_packet(s, "E22");
-                break;
-            }
-            cpu = gdb_get_cpu(s, pid, tid);
-            if (cpu != NULL) {
-                cpu_synchronize_state(cpu);
-
-                if (s->multiprocess && (s->process_num > 1)) {
-                    /* Print the CPU model and name in multiprocess mode */
-                    ObjectClass *oc = object_get_class(OBJECT(cpu));
-                    const char *cpu_model = object_class_get_name(oc);
-                    char *cpu_name =
-                        object_get_canonical_path_component(OBJECT(cpu));
-                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
-                                   "%s %s [%s]", cpu_model, cpu_name,
-                                   cpu->halted ? "halted " : "running");
-                    g_free(cpu_name);
-                } else {
-                    /* memtohex() doubles the required space */
-                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
-                                   "CPU#%d [%s]", cpu->cpu_index,
-                                   cpu->halted ? "halted " : "running");
-                }
-                trace_gdbstub_op_extra_info((char *)mem_buf);
-                memtohex(buf, mem_buf, len);
-                put_packet(s, buf);
-            }
-            break;
-        }
-#ifdef CONFIG_USER_ONLY
-        else if (strcmp(p, "Offsets") == 0) {
-            TaskState *ts = s->c_cpu->opaque;
+    gdb_ctx->s->signal = 0;
+    gdb_continue(gdb_ctx->s);
+}
 
-            snprintf(buf, sizeof(buf),
-                     "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
-                     ";Bss=" TARGET_ABI_FMT_lx,
-                     ts->info->code_offset,
-                     ts->info->data_offset,
-                     ts->info->data_offset);
-            put_packet(s, buf);
-            break;
-        }
-#else /* !CONFIG_USER_ONLY */
-        else if (strncmp(p, "Rcmd,", 5) == 0) {
-            int len = strlen(p + 5);
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
 
-            if ((len % 2) != 0) {
-                put_packet(s, "E01");
-                break;
-            }
-            len = len / 2;
-            hextomem(mem_buf, p + 5, len);
-            mem_buf[len++] = 0;
-            qemu_chr_be_write(s->mon_chr, mem_buf, len);
-            put_packet(s, "OK");
-            break;
-        }
-#endif /* !CONFIG_USER_ONLY */
-        if (is_query_packet(p, "Supported", ':')) {
-            snprintf(buf, sizeof(buf), "PacketSize=%x", MAX_PACKET_LENGTH);
-            cc = CPU_GET_CLASS(first_cpu);
-            if (cc->gdb_core_xml_file != NULL) {
-                pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
-            }
+    if (gdb_ctx->num_params) {
+        signal = gdb_ctx->params[0].val_ul;
+    }
 
-            if (strstr(p, "multiprocess+")) {
-                s->multiprocess = true;
-            }
-            pstrcat(buf, sizeof(buf), ";multiprocess+");
+    gdb_ctx->s->signal = gdb_signal_to_target(signal);
+    if (gdb_ctx->s->signal == -1) {
+        gdb_ctx->s->signal = 0;
+    }
+    gdb_continue(gdb_ctx->s);
+}
 
-            put_packet(s, buf);
-            break;
-        }
-        if (strncmp(p, "Xfer:features:read:", 19) == 0) {
-            const char *xml;
-            target_ulong total_len;
-
-            process = gdb_get_cpu_process(s, s->g_cpu);
-            cc = CPU_GET_CLASS(s->g_cpu);
-            if (cc->gdb_core_xml_file == NULL) {
-                goto unknown_command;
-            }
+static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "vCont;c;C;s;S");
+}
 
-            gdb_has_xml = true;
-            p += 19;
-            xml = get_feature_xml(s, p, &p, process);
-            if (!xml) {
-                snprintf(buf, sizeof(buf), "E00");
-                put_packet(s, buf);
-                break;
-            }
+static void handle_v_cont(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
 
-            if (*p == ':')
-                p++;
-            addr = strtoul(p, (char **)&p, 16);
-            if (*p == ',')
-                p++;
-            len = strtoul(p, (char **)&p, 16);
-
-            total_len = strlen(xml);
-            if (addr > total_len) {
-                snprintf(buf, sizeof(buf), "E00");
-                put_packet(s, buf);
-                break;
-            }
-            if (len > (MAX_PACKET_LENGTH - 5) / 2)
-                len = (MAX_PACKET_LENGTH - 5) / 2;
-            if (len < total_len - addr) {
-                buf[0] = 'm';
-                len = memtox(buf + 1, xml + addr, len);
-            } else {
-                buf[0] = 'l';
-                len = memtox(buf + 1, xml + addr, total_len - addr);
-            }
-            put_packet_binary(s, buf, len + 1, true);
-            break;
-        }
-        if (is_query_packet(p, "Attached", ':')) {
-            put_packet(s, GDB_ATTACHED);
-            break;
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    res = gdb_handle_vcont(gdb_ctx->s, gdb_ctx->params[0].data);
+    if ((res == -EINVAL) || (res == -ERANGE)) {
+        put_packet(gdb_ctx->s, "E22");
+    } else if (res) {
+        put_packet(gdb_ctx->s, "\0");
+    }
+}
+
+static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    GDBProcess *process;
+    CPUState *cpu;
+    char thread_id[16];
+
+    strcpy(gdb_ctx->str_buf, "E22");
+    if (!gdb_ctx->num_params) {
+        goto cleanup;
+    }
+
+    process = gdb_get_process(gdb_ctx->s, gdb_ctx->params[0].val_ul);
+    if (!process) {
+        goto cleanup;
+    }
+
+    cpu = get_first_cpu_in_process(gdb_ctx->s, process);
+    if (!cpu) {
+        goto cleanup;
+    }
+
+    process->attached = true;
+    gdb_ctx->s->g_cpu = cpu;
+    gdb_ctx->s->c_cpu = cpu;
+
+    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+cleanup:
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    /* Kill the target */
+    put_packet(gdb_ctx->s, "OK");
+    error_report("QEMU: Terminated via GDBstub");
+    exit(0);
+}
+
+static GdbCmdParseEntry gdb_v_commands_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_v_cont_query,
+        .cmd = "Cont?",
+        .cmd_startswith = 1
+    },
+    {
+        .handler = handle_v_cont,
+        .cmd = "Cont",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    {
+        .handler = handle_v_attach,
+        .cmd = "Attach;",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    {
+        .handler = handle_v_kill,
+        .cmd = "Kill;",
+        .cmd_startswith = 1
+    },
+};
+
+static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_v_commands_table,
+                           ARRAY_SIZE(gdb_v_commands_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
+}
+
+static void handle_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    /* Kill the target */
+    error_report("QEMU: Terminated via GDBstub");
+    exit(0);
+}
+
+static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    GDBProcess *process;
+    GDBState *s = gdb_ctx->s;
+    uint32_t pid = 1;
+
+    if (s->multiprocess) {
+        if (!gdb_ctx->num_params) {
+            put_packet(s, "E22");
+            return;
         }
-        /* Unrecognised 'q' command.  */
-        goto unknown_command;
 
-    default:
-    unknown_command:
-        /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
-        break;
+        pid = gdb_ctx->params[0].val_ul;
+    }
+
+    process = gdb_get_process(s, pid);
+    gdb_process_breakpoint_remove_all(s, process);
+    process->attached = false;
+
+    if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
+        s->c_cpu = gdb_first_attached_cpu(s);
     }
+
+    if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
+        s->g_cpu = gdb_first_attached_cpu(s);
+    }
+
+    if (!s->c_cpu) {
+        /* No more process attached */
+        gdb_syscall_mode = GDB_SYS_DISABLED;
+        gdb_continue(s);
+    }
+    put_packet(s, "OK");
+}
+
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int num_syscall_params;
+    GdbCmdVariant syscall_params[3] = {0};
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_params,
+                         &num_syscall_params)) {
+        return;
+    }
+
+    if (!num_syscall_params) {
+        return;
+    }
+
+    if (gdb_ctx->s->current_syscall_cb) {
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
+                                       (target_ulong)syscall_params[0].val_ull,
+                                       (target_ulong)syscall_params[1].val_ull);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (syscall_params[2].opcode == (uint8_t)'C') {
+        put_packet(gdb_ctx->s, "T02");
+        return;
+    }
+
+    gdb_continue(gdb_ctx->s);
+}
+
+static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    len = 0;
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+                                 addr);
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
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
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* hextomem() reads 2*len bytes */
+    if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+             gdb_ctx->params[1].val_ull);
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, true)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    /*
+     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
+     * This works, but can be very slow.  Anything new enough to
+     * understand XML also knows how to use this properly.
+     */
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                                 gdb_ctx->params[0].val_ull);
+    if (!reg_size) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    reg_size = strlen(gdb_ctx->params[1].data) / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                       gdb_ctx->params[0].val_ull);
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
+static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind != GDB_ONE_THREAD) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
+                      gdb_ctx->params[1].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    switch (gdb_ctx->params[0].opcode) {
+    case 'c':
+        gdb_ctx->s->c_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    case 'g':
+        gdb_ctx->s->g_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    default:
+        put_packet(gdb_ctx->s, "E22");
+        break;
+    }
+}
+
+static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_query_qemu_sstepbits(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+             "ENABLE=%x,NOIRQ=%x,NOTIMER=%x", SSTEP_ENABLE,
+             SSTEP_NOIRQ, SSTEP_NOTIMER);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    sstep_flags = gdb_ctx->params[0].val_ul;
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_query_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%x", sstep_flags);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+    GDBProcess *process;
+    char thread_id[16];
+
+    /*
+     * "Current thread" remains vague in the spec, so always return
+     * the first thread of the current process (gdb returns the
+     * first thread).
+     */
+    process = gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
+    cpu = get_first_cpu_in_process(gdb_ctx->s, process);
+    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "QC%s", thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
+
+    if (!gdb_ctx->s->query_cpu) {
+        put_packet(gdb_ctx->s, "l");
+        return;
+    }
+
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->query_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "m%s", thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    gdb_ctx->s->query_cpu =
+        gdb_next_attached_cpu(gdb_ctx->s, gdb_ctx->s->query_cpu);
+}
+
+static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    gdb_ctx->s->query_cpu = gdb_first_attached_cpu(gdb_ctx->s);
+    handle_query_threads(gdb_ctx, user_ctx);
+}
+
+static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+    int len;
+
+    if (!gdb_ctx->num_params ||
+        gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        return;
+    }
+
+    cpu_synchronize_state(cpu);
+
+    if (gdb_ctx->s->multiprocess && (gdb_ctx->s->process_num > 1)) {
+        /* Print the CPU model and name in multiprocess mode */
+        ObjectClass *oc = object_get_class(OBJECT(cpu));
+        const char *cpu_model = object_class_get_name(oc);
+        char *cpu_name = object_get_canonical_path_component(OBJECT(cpu));
+        len = snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_buf) / 2,
+                       "%s %s [%s]", cpu_model, cpu_name,
+                       cpu->halted ? "halted " : "running");
+        g_free(cpu_name);
+    } else {
+        /* memtohex() doubles the required space */
+        len = snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_buf) / 2,
+                        "CPU#%d [%s]", cpu->cpu_index,
+                        cpu->halted ? "halted " : "running");
+    }
+    trace_gdbstub_op_extra_info((char *)gdb_ctx->mem_buf);
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+#ifdef CONFIG_USER_ONLY
+static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    TaskState *ts;
+
+    ts = gdb_ctx->s->c_cpu->opaque;
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+             "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
+             ";Bss=" TARGET_ABI_FMT_lx,
+             ts->info->code_offset,
+             ts->info->data_offset,
+             ts->info->data_offset);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+#else
+static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int len;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    len = strlen(gdb_ctx->params[0].data);
+    if (len % 2) {
+        put_packet(gdb_ctx->s, "E01");
+        return;
+    }
+
+    len = len / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
+    gdb_ctx->mem_buf[len++] = 0;
+    qemu_chr_be_write(gdb_ctx->s->mon_chr, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, "OK");
+
+}
+#endif
+
+static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUClass *cc;
+
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "PacketSize=%x",
+             MAX_PACKET_LENGTH);
+    cc = CPU_GET_CLASS(first_cpu);
+    if (cc->gdb_core_xml_file) {
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+                ";qXfer:features:read+");
+    }
+
+    if (gdb_ctx->num_params &&
+        strstr(gdb_ctx->params[0].data, "multiprocess+")) {
+        gdb_ctx->s->multiprocess = true;
+    }
+
+    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+");
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    GDBProcess *process;
+    CPUClass *cc;
+    unsigned long len, total_len, addr;
+    const char *xml;
+    const char *p;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    process = gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
+    cc = CPU_GET_CLASS(gdb_ctx->s->g_cpu);
+    if (!cc->gdb_core_xml_file) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    gdb_has_xml = true;
+    p = gdb_ctx->params[0].data;
+    xml = get_feature_xml(gdb_ctx->s, p, &p, process);
+    if (!xml) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    addr = gdb_ctx->params[1].val_ul;
+    len = gdb_ctx->params[2].val_ul;
+    total_len = strlen(xml);
+    if (addr > total_len) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
+        len = (MAX_PACKET_LENGTH - 5) / 2;
+    }
+
+    if (len < total_len - addr) {
+        gdb_ctx->str_buf[0] = 'm';
+        len = memtox(gdb_ctx->str_buf + 1, xml + addr, len);
+    } else {
+        gdb_ctx->str_buf[0] = 'l';
+        len = memtox(gdb_ctx->str_buf + 1, xml + addr, total_len - addr);
+    }
+
+    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
+}
+
+static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, GDB_ATTACHED);
+}
+
+static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_query_qemu_sstepbits,
+        .cmd = "qemu.sstepbits",
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_qemu_sstep,
+        .cmd = "qemu.sstep",
+        .cmd_full_match = 1,
+    },
+    {
+        .handler = handle_set_qemu_sstep,
+        .cmd = "qemu.sstep=",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+};
+
+static GdbCmdParseEntry gdb_gen_query_table[] = {
+    {
+        .handler = handle_query_curr_tid,
+        .cmd = "C",
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_threads,
+        .cmd = "sThreadInfo",
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_first_threads,
+        .cmd = "fThreadInfo",
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_thread_extra,
+        .cmd = "ThreadExtraInfo,",
+        .cmd_startswith = 1,
+        .schema = "t0"
+    },
+#ifdef CONFIG_USER_ONLY
+    {
+        .handler = handle_query_offsets,
+        .cmd = "Offsets",
+        .cmd_full_match = 1
+    },
+#else
+    {
+        .handler = handle_query_rcmd,
+        .cmd = "Rcmd,",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+#endif
+    {
+        .handler = handle_query_supported,
+        .cmd = "Supported:",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    {
+        .handler = handle_query_supported,
+        .cmd = "Supported",
+        .cmd_full_match = 1,
+        .schema = "s0"
+    },
+    {
+        .handler = handle_query_xfer_features,
+        .cmd = "Xfer:features:read:",
+        .cmd_startswith = 1,
+        .schema = "x:l,l0"
+    },
+    {
+        .handler = handle_query_attached,
+        .cmd = "Attached:",
+        .cmd_startswith = 1
+    },
+    {
+        .handler = handle_query_attached,
+        .cmd = "Attached",
+        .cmd_full_match = 1
+    },
+};
+
+static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                            gdb_gen_query_set_common_table,
+                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+        return;
+    }
+
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_gen_query_table,
+                           ARRAY_SIZE(gdb_gen_query_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
+}
+
+static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                            gdb_gen_query_set_common_table,
+                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "");
+}
+
+static GdbCmdParseEntry gdb_packet_table[0x100] = {
+    ['!'] = {
+        .handler = handle_extend_mode,
+        .cmd = "!",
+        .cmd_startswith = 1
+    },
+    ['?'] = {
+        .handler = handle_target_halt,
+        .cmd = "?",
+        .cmd_startswith = 1
+    },
+    ['c'] = {
+        .handler = handle_continue,
+        .cmd = "c",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['C'] = {
+        .handler = handle_cont_with_sig,
+        .cmd = "C",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    ['v'] = {
+        .handler = handle_v_commands,
+        .cmd = "v",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['k'] = {
+        .handler = handle_kill,
+        .cmd = "k",
+        .cmd_startswith = 1
+    },
+    ['D'] = {
+        .handler = handle_detach,
+        .cmd = "D",
+        .cmd_startswith = 1,
+        .schema = "?.l0"
+    },
+    ['s'] = {
+        .handler = handle_step,
+        .cmd = "s",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['F'] = {
+        .handler = handle_file_io,
+        .cmd = "F",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['g'] = {
+        .handler = handle_read_all_regs,
+        .cmd = "g",
+        .cmd_startswith = 1
+    },
+    ['G'] = {
+        .handler = handle_write_all_regs,
+        .cmd = "G",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['m'] = {
+        .handler = handle_read_mem,
+        .cmd = "m",
+        .cmd_startswith = 1,
+        .schema = "L,L0"
+    },
+    ['M'] = {
+        .handler = handle_write_mem,
+        .cmd = "M",
+        .cmd_startswith = 1,
+        .schema = "L,L:s0"
+    },
+    ['p'] = {
+        .handler = handle_get_reg,
+        .cmd = "p",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['P'] = {
+        .handler = handle_set_reg,
+        .cmd = "P",
+        .cmd_startswith = 1,
+        .schema = "L?s0"
+    },
+    ['Z'] = {
+        .handler = handle_insert_bp,
+        .cmd = "Z",
+        .cmd_startswith = 1,
+        .schema = "l?L?L0"
+    },
+    ['z'] = {
+        .handler = handle_remove_bp,
+        .cmd = "z",
+        .cmd_startswith = 1,
+        .schema = "l?L?L0"
+    },
+    ['H'] = {
+        .handler = handle_set_thread,
+        .cmd = "H",
+        .cmd_startswith = 1,
+        .schema = "o.t0"
+    },
+    ['T'] = {
+        .handler = handle_thread_alive,
+        .cmd = "T",
+        .cmd_startswith = 1,
+        .schema = "t0"
+    },
+    ['q'] = {
+        .handler = handle_gen_query,
+        .cmd = "q",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['Q'] = {
+        .handler = handle_gen_set,
+        .cmd = "Q",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+};
+
+static int gdb_handle_packet(GDBState *s, const char *line_buf)
+{
+    trace_gdbstub_io_command(line_buf);
+
+    if (process_string_cmd(s, NULL, line_buf,
+                           &gdb_packet_table[*(uint8_t *)line_buf], 1)) {
+        put_packet(s, "");
+    }
+
     return RS_IDLE;
 }
 
-- 
2.20.1
