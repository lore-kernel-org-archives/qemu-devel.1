Received: from eggs.gnu.org ([209.51.188.92]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzG-0004gC-A7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsc-00019y-5b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsb-00018I-Sx
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id g3so25445869wrx.9
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:28:09 -0700 (PDT)
From: arilou@gmail.com
Date: Wed, 24 Apr 2019 17:27:12 +0300
Message-Id: <20190424142714.28460-18-arilou@gmail.com>
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 18/20] gdbstub: Implement generic query (q
 pkt) with new infra
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

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 335 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 2dc088180d..f8389528fe 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1931,6 +1931,331 @@ static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
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
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -2143,6 +2468,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'q':
+        {
+            static GdbCmdParseEntry gen_query_cmd_desc = {
+                .handler = handle_gen_query,
+                .cmd = "q",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &gen_query_cmd_desc, 1);
+        }
+        break;
     case 'Q':
         /* parse any 'q' packets here */
         if (!strcmp(p,"qemu.sstepbits")) {
-- 
2.20.1
