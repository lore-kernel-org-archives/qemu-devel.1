Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dHgAu-0002Dt-S7
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dHgAp-0005o8-VY
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:47:16 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1dHgAp-0005l2-Ns
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:47:11 -0400
Received: by mail-pg0-x242.google.com with SMTP id s62so7877894pgc.0
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 17:47:10 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon,  5 Jun 2017 10:47:01 +1000
Message-Id: <20170605004701.31891-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH] monitor: Add -a (all) option to info registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The info registers command in the qemu monitor is used to dump register
values.

Currently this command uses the monitor cpu (which can be set by the
user) as the cpu for whose registers will be dumped. Sometimes it is
useful to see the registers for all cpus and currently this requires
setting the monitor cpu and the re-running the command for each cpu
in the system. I would be nice if there was an easier way to do this.

Add the "-a" option to the info registers command to dump the register
values for all cpus.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hmp-commands-info.hx |  6 +++---
 monitor.c            | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ae16901..ba98e58 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -100,9 +100,9 @@ ETEXI
 
     {
         .name       = "registers",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show the cpu registers",
+        .args_type  = "cpustate_all:-a",
+        .params     = "[-a]",
+        .help       = "show the cpu registers (-a: all - show register info for all cpus)",
         .cmd        = hmp_info_registers,
     },
 
diff --git a/monitor.c b/monitor.c
index baa73c9..5875f88 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1078,13 +1078,23 @@ int monitor_get_cpu_index(void)
 
 static void hmp_info_registers(Monitor *mon, const QDict *qdict)
 {
-    CPUState *cs = mon_get_cpu();
+    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
+    CPUState *cs;
 
-    if (!cs) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
+    if (all_cpus) {
+        CPU_FOREACH(cs) {
+            cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
+        }
+    } else {
+        cs = mon_get_cpu();
+
+        if (!cs) {
+            monitor_printf(mon, "No CPU available\n");
+            return;
+        }
+
+        cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
     }
-    cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
 }
 
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
-- 
2.9.4
