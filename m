Received: from eggs.gnu.org ([2001:4830:134:3::10]:60168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwni7-0005py-C5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwni1-0001cY-Cf
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52330)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwni1-0001c4-1c
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:25 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:22 +0300
Message-ID: <150642404260.3900.15791385339764676289.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 35/43] windbg: debug exception subscribing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Added handler registration of gdb debug exception. Its exception also can be used for windbg.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 cpus.c                  |   18 +++++++++++++++++-
 gdbstub.c               |    4 ++++
 include/sysemu/sysemu.h |    2 ++
 windbgstub.c            |   16 ++++++++++++----
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index 9bed61eefc..212553b7e3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -77,6 +77,8 @@ int64_t max_advance;
 static QEMUTimer *throttle_timer;
 static unsigned int throttle_percentage;
 
+static void (*excp_debug_handler)(CPUState *cpu);
+
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
@@ -960,9 +962,23 @@ static bool cpu_can_run(CPUState *cpu)
     return true;
 }
 
+bool register_excp_debug_handler(void (*handler)(CPUState *cpu))
+{
+    if (excp_debug_handler == NULL) {
+        excp_debug_handler = handler;
+        return true;
+    } else {
+        error_report("ERROR: Something debugger already using");
+        return false;
+    }
+}
+
 static void cpu_handle_guest_debug(CPUState *cpu)
 {
-    gdb_set_stop_cpu(cpu);
+    if (excp_debug_handler != NULL) {
+        excp_debug_handler(cpu);
+    }
+
     qemu_system_debug_request();
     cpu->stopped = true;
 }
diff --git a/gdbstub.c b/gdbstub.c
index 2a94030d3b..8c76f54117 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2006,6 +2006,10 @@ int gdbserver_start(const char *device)
     s->mon_chr = mon_chr;
     s->current_syscall_cb = NULL;
 
+    if (!register_excp_debug_handler(gdb_set_stop_cpu)) {
+        exit(1);
+    }
+
     return 0;
 }
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b21369672a..34588c99b4 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -193,6 +193,8 @@ QemuOpts *qemu_get_machine_opts(void);
 
 bool defaults_enabled(void);
 
+bool register_excp_debug_handler(void (*handler)(CPUState *cpu));
+
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
 extern QemuOptsList qemu_drive_opts;
diff --git a/windbgstub.c b/windbgstub.c
index f8e80c60ab..54564962a5 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -112,16 +112,20 @@ static void windbg_send_control_packet(uint16_t type)
     windbg_state->ctrl_packet_id ^= 1;
 }
 
-static void windbg_vm_stop(void)
+static void windbg_bp_handler(CPUState *cpu)
 {
-    CPUState *cpu = qemu_get_cpu(0);
-    vm_stop(RUN_STATE_PAUSED);
-
     SizedBuf buf = kd_gen_exception_sc(cpu);
     windbg_send_data_packet(buf.data, buf.size, PACKET_TYPE_KD_STATE_CHANGE64);
     SBUF_FREE(buf);
 }
 
+static void windbg_vm_stop(void)
+{
+    CPUState *cpu = qemu_get_cpu(0);
+    vm_stop(RUN_STATE_PAUSED);
+    windbg_bp_handler(cpu);
+}
+
 static void windbg_process_manipulate_packet(ParsingContext *ctx)
 {
     CPUState *cpu;
@@ -406,6 +410,10 @@ int windbg_server_start(const char *device)
     qemu_chr_fe_set_handlers(&windbg_state->chr, windbg_chr_can_receive,
                              windbg_chr_receive, NULL, NULL, NULL, NULL, true);
 
+    if (!register_excp_debug_handler(windbg_bp_handler)) {
+        exit(1);
+    }
+
     atexit(windbg_exit);
     return 0;
 }
