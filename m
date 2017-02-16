Received: from eggs.gnu.org ([2001:4830:134:3::10]:51832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6Y-0003jU-Qe
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6X-00086f-BZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:18 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6X-00086B-1r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:17 -0500
Received: by mail-wr0-x243.google.com with SMTP id c4so2274991wrd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:33 +0100
Message-Id: <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

When GDB issues a "vCont", QEMU was not handling it correctly when
multiple VCPUs are active.
For vCont, for each thread (VCPU), it can be specified whether to
single step, continue or stop that thread. The default is to stop a
thread.
However, when (for example) "vCont;s:2" is issued, all VCPUs continue
to run, although all but VCPU nr 2 are to be stopped.

This patch completely rewrites the vCont parsing code.

Please note that this improvement only works in system emulation mode,
when in userspace emulation mode the old behaviour is preserved.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-Id: <1487092068-16562-3-git-send-email-imbrenda@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 162 insertions(+), 47 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 755a8e3..9911153 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -387,6 +387,60 @@ static inline void gdb_continue(GDBState *s)
 #endif
 }
 
+/*
+ * Resume execution, per CPU actions. For user-mode emulation it's
+ * equivalent to gdb_continue.
+ */
+static int gdb_continue_partial(GDBState *s, char *newstates)
+{
+    CPUState *cpu;
+    int res = 0;
+#ifdef CONFIG_USER_ONLY
+    /*
+     * This is not exactly accurate, but it's an improvement compared to the
+     * previous situation, where only one CPU would be single-stepped.
+     */
+    CPU_FOREACH(cpu) {
+        if (newstates[cpu->cpu_index] == 's') {
+            cpu_single_step(cpu, sstep_flags);
+        }
+    }
+    s->running_state = 1;
+#else
+    int flag = 0;
+
+    if (!runstate_needs_reset()) {
+        if (vm_prepare_start()) {
+            return 0;
+        }
+
+        CPU_FOREACH(cpu) {
+            switch (newstates[cpu->cpu_index]) {
+            case 0:
+            case 1:
+                break; /* nothing to do here */
+            case 's':
+                cpu_single_step(cpu, sstep_flags);
+                cpu_resume(cpu);
+                flag = 1;
+                break;
+            case 'c':
+                cpu_resume(cpu);
+                flag = 1;
+                break;
+            default:
+                res = -1;
+                break;
+            }
+        }
+    }
+    if (flag) {
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+    }
+#endif
+    return res;
+}
+
 static void put_buffer(GDBState *s, const uint8_t *buf, int len)
 {
 #ifdef CONFIG_USER_ONLY
@@ -785,6 +839,107 @@ static int is_query_packet(const char *p, const char *query, char separator)
         (p[query_len] == '\0' || p[query_len] == separator);
 }
 
+/**
+ * gdb_handle_vcont - Parses and handles a vCont packet.
+ * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if there is
+ *         a format error, 0 on success.
+ */
+static int gdb_handle_vcont(GDBState *s, const char *p)
+{
+    int res, idx, signal = 0;
+    char cur_action;
+    char *newstates;
+    unsigned long tmp;
+    CPUState *cpu;
+#ifdef CONFIG_USER_ONLY
+    int max_cpus = 1; /* global variable max_cpus exists only in system mode */
+
+    CPU_FOREACH(cpu) {
+        max_cpus = max_cpus <= cpu->cpu_index ? cpu->cpu_index + 1 : max_cpus;
+    }
+#endif
+    /* uninitialised CPUs stay 0 */
+    newstates = g_new0(char, max_cpus);
+
+    /* mark valid CPUs with 1 */
+    CPU_FOREACH(cpu) {
+        newstates[cpu->cpu_index] = 1;
+    }
+
+    /*
+     * res keeps track of what error we are returning, with -ENOTSUP meaning
+     * that the command is unknown or unsupported, thus returning an empty
+     * packet, while -EINVAL and -ERANGE cause an E22 packet, due to invalid,
+     *  or incorrect parameters passed.
+     */
+    res = 0;
+    while (*p) {
+        if (*p++ != ';') {
+            res = -ENOTSUP;
+            goto out;
+        }
+
+        cur_action = *p++;
+        if (cur_action == 'C' || cur_action == 'S') {
+            cur_action = tolower(cur_action);
+            res = qemu_strtoul(p + 1, &p, 16, &tmp);
+            if (res) {
+                goto out;
+            }
+            signal = gdb_signal_to_target(tmp);
+        } else if (cur_action != 'c' && cur_action != 's') {
+            /* unknown/invalid/unsupported command */
+            res = -ENOTSUP;
+            goto out;
+        }
+        /* thread specification. special values: (none), -1 = all; 0 = any */
+        if ((p[0] == ':' && p[1] == '-' && p[2] == '1') || (p[0] != ':')) {
+            if (*p == ':') {
+                p += 3;
+            }
+            for (idx = 0; idx < max_cpus; idx++) {
+                if (newstates[idx] == 1) {
+                    newstates[idx] = cur_action;
+                }
+            }
+        } else if (*p == ':') {
+            p++;
+            res = qemu_strtoul(p, &p, 16, &tmp);
+            if (res) {
+                goto out;
+            }
+            idx = tmp;
+            /* 0 means any thread, so we pick the first valid CPU */
+            if (!idx) {
+                idx = cpu_index(first_cpu);
+            }
+
+            /*
+             * If we are in user mode, the thread specified is actually a
+             * thread id, and not an index. We need to find the actual
+             * CPU first, and only then we can use its index.
+             */
+            cpu = find_cpu(idx);
+            /* invalid CPU/thread specified */
+            if (!idx || !cpu) {
+                res = -EINVAL;
+                goto out;
+            }
+            /* only use if no previous match occourred */
+            if (newstates[cpu->cpu_index] == 1) {
+                newstates[cpu->cpu_index] = cur_action;
+            }
+        }
+    }
+    s->signal = signal;
+    gdb_continue_partial(s, newstates);
+
+out:
+    g_free(newstates);
+
+    return res;
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -830,60 +985,20 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         return RS_IDLE;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
-            int res_signal, res_thread;
-
             p += 4;
             if (*p == '?') {
                 put_packet(s, "vCont;c;C;s;S");
                 break;
             }
-            res = 0;
-            res_signal = 0;
-            res_thread = 0;
-            while (*p) {
-                int action, signal;
-
-                if (*p++ != ';') {
-                    res = 0;
-                    break;
-                }
-                action = *p++;
-                signal = 0;
-                if (action == 'C' || action == 'S') {
-                    signal = gdb_signal_to_target(strtoul(p, (char **)&p, 16));
-                    if (signal == -1) {
-                        signal = 0;
-                    }
-                } else if (action != 'c' && action != 's') {
-                    res = 0;
-                    break;
-                }
-                thread = 0;
-                if (*p == ':') {
-                    thread = strtoull(p+1, (char **)&p, 16);
-                }
-                action = tolower(action);
-                if (res == 0 || (res == 'c' && action == 's')) {
-                    res = action;
-                    res_signal = signal;
-                    res_thread = thread;
-                }
-            }
+
+            res = gdb_handle_vcont(s, p);
+
             if (res) {
-                if (res_thread != -1 && res_thread != 0) {
-                    cpu = find_cpu(res_thread);
-                    if (cpu == NULL) {
-                        put_packet(s, "E22");
-                        break;
-                    }
-                    s->c_cpu = cpu;
-                }
-                if (res == 's') {
-                    cpu_single_step(s->c_cpu, sstep_flags);
+                if ((res == -EINVAL) || (res == -ERANGE)) {
+                    put_packet(s, "E22");
+                    break;
                 }
-                s->signal = res_signal;
-                gdb_continue(s);
-                return RS_IDLE;
+                goto unknown_command;
             }
             break;
         } else {
-- 
1.8.3.1
