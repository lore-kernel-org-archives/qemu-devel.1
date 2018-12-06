Received: from eggs.gnu.org ([2001:4830:134:3::10]:42136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLj-00015v-Ob
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLf-00068Q-OD
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60388)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLd-0005yx-O9
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:43 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:01:26 +0300
Message-ID: <154409768651.5432.6956625765792328416.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 30/39] windbg: debug exception subscribing
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

Add handler registration of gdb debug exception. Its exception also can be used
for windbg.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 cpus.c                  |   20 ++++++++++++++++++--
 gdbstub.c               |    6 +++++-
 include/exec/gdbstub.h  |    1 -
 include/sysemu/sysemu.h |    2 ++
 windbgstub.c            |   14 ++++++++++++++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index a2b33ccb29..6a93a5795a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -33,7 +33,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
-#include "exec/gdbstub.h"
 #include "sysemu/dma.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
@@ -79,6 +78,8 @@ int64_t max_advance;
 static QEMUTimer *throttle_timer;
 static unsigned int throttle_percentage;
 
+static void (*excp_debug_handler)(CPUState *cpu);
+
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
@@ -1103,9 +1104,24 @@ static bool cpu_can_run(CPUState *cpu)
     return true;
 }
 
+bool register_excp_debug_handler(void (*handler)(CPUState *cpu))
+{
+    if (excp_debug_handler == NULL) {
+        excp_debug_handler = handler;
+        return true;
+    } else {
+        error_report("Something debugger is already in use. '-gdb' and "
+                     "'-windbg' cannot be used at the same time");
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
index c4e4f9f082..1d95965eb8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1409,7 +1409,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     return RS_IDLE;
 }
 
-void gdb_set_stop_cpu(CPUState *cpu)
+static void gdb_set_stop_cpu(CPUState *cpu)
 {
     gdbserver_state->c_cpu = cpu;
     gdbserver_state->g_cpu = cpu;
@@ -2074,6 +2074,10 @@ int gdbserver_start(const char *device)
     s->mon_chr = mon_chr;
     s->current_syscall_cb = NULL;
 
+    if (!register_excp_debug_handler(gdb_set_stop_cpu)) {
+        exit(1);
+    }
+
     return 0;
 }
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 08363969c1..ad4cdd61b3 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -45,7 +45,6 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...);
  */
 void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va);
 int use_gdb_syscalls(void);
-void gdb_set_stop_cpu(CPUState *cpu);
 void gdb_exit(CPUArchState *, int);
 #ifdef CONFIG_USER_ONLY
 /**
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 8d6095d98b..826b701bfa 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -203,6 +203,8 @@ QemuOpts *qemu_get_machine_opts(void);
 
 bool defaults_enabled(void);
 
+bool register_excp_debug_handler(void (*handler)(CPUState *cpu));
+
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
 extern QemuOptsList qemu_drive_opts;
diff --git a/windbgstub.c b/windbgstub.c
index a1c013cd8c..0e4ad6d009 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -129,9 +129,19 @@ static void windbg_send_control_packet(WindbgState *state, uint16_t type,
     qemu_chr_fe_write(&state->chr, PTR(packet), sizeof(packet));
 }
 
+static void windbg_bp_handler(CPUState *cs)
+{
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc = kd_state_change_exc(cs);
+    windbg_send_data_packet(windbg_state, (uint8_t *) sc,
+                            sizeof(DBGKD_ANY_WAIT_STATE_CHANGE),
+                            PACKET_TYPE_KD_STATE_CHANGE64);
+}
+
 static void windbg_vm_stop(void)
 {
+    CPUState *cs = qemu_get_cpu(0);
     vm_stop(RUN_STATE_PAUSED);
+    windbg_bp_handler(cs);
 }
 
 static void windbg_process_manipulate_packet(WindbgState *state)
@@ -481,6 +491,10 @@ int windbg_server_start(const char *device)
 
     qemu_register_reset(windbg_handle_reset, NULL);
 
+    if (!register_excp_debug_handler(windbg_bp_handler)) {
+        exit(1);
+    }
+
     atexit(windbg_exit);
     return 0;
 }
