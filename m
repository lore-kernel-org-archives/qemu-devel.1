Received: from eggs.gnu.org ([2001:4830:134:3::10]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQcKf-00072w-O7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQcKe-0000i7-NO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQcKe-0000hV-I7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 966671393C0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:30:15 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-88.ams2.redhat.com
	[10.36.116.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14306900B9
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:30:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 29 Jun 2017 17:30:10 +0100
Message-Id: <20170629163011.13388-2-dgilbert@redhat.com>
In-Reply-To: <20170629163011.13388-1-dgilbert@redhat.com>
References: <20170629163011.13388-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] monitor: Add -a (all) option to info
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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

Message-Id: <20170608054116.17203-1-sjitindarsingh@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx |  6 +++---
 monitor.c            | 21 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ae169011b1..ba98e581ab 100644
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
index 3c369f4dd5..4031876411 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1078,13 +1078,24 @@ int monitor_get_cpu_index(void)
 
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
+            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
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
2.13.0
