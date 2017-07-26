Received: from eggs.gnu.org ([2001:4830:134:3::10]:45078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOI-0006QU-TH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOG-0006CM-3R
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:50 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56040)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOF-0006BR-G7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:48 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Wed, 26 Jul 2017 02:18:37 -0400
Message-Id: <1501049917-4701-3-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
References: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel]  [PATCH v2 2/2] hmp: allow apic-id for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

Add [apic-id] support for hmp command "info lapic", which is
useful when debugging ipi and so on. Current behavior is not
changed when the parameter isn't specified.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hmp-commands-info.hx  |  7 ++++---
 include/qom/cpu.h     | 10 ++++++++++
 qom/cpu.c             | 11 ++++++++---
 target/i386/monitor.c | 10 +++++++++-
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238..4ab7fce 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -115,9 +115,10 @@ ETEXI
 #if defined(TARGET_I386)
     {
         .name       = "lapic",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show local apic state",
+        .args_type  = "apic-id:i?",
+        .params     = "[apic-id]",
+        .help       = "show local apic state (apic-id: local apic to read, default is which of current CPU)",
+
         .cmd        = hmp_info_local_apic,
     },
 #endif
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea..b7ac949 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -755,6 +755,16 @@ CPUState *qemu_get_cpu(int index);
 bool cpu_exists(int64_t id);
 
 /**
+ * cpu_by_arch_id:
+ * @id: Guest-exposed CPU ID of the CPU to obtain.
+ *
+ * Get a CPU with matching @id.
+ *
+ * Returns: The CPU or %NULL if there is no matching CPU.
+ */
+CPUState *cpu_by_arch_id(int64_t id);
+
+/**
  * cpu_throttle_set:
  * @new_throttle_pct: Percent of sleep time. Valid range is 1 to 99.
  *
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0..e6210d5 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -34,7 +34,7 @@
 
 CPUInterruptHandler cpu_interrupt_handler;
 
-bool cpu_exists(int64_t id)
+CPUState *cpu_by_arch_id(int64_t id)
 {
     CPUState *cpu;
 
@@ -42,10 +42,15 @@ bool cpu_exists(int64_t id)
         CPUClass *cc = CPU_GET_CLASS(cpu);
 
         if (cc->get_arch_id(cpu) == id) {
-            return true;
+            return cpu;
         }
     }
-    return false;
+    return NULL;
+}
+
+bool cpu_exists(int64_t id)
+{
+    return !!cpu_by_arch_id(id);
 }
 
 CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 77ead60..fe7d57b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -632,7 +632,15 @@ const MonitorDef *target_monitor_defs(void)
 
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 {
-    CPUState *cs = mon_get_cpu();
+    CPUState *cs;
+
+    if (qdict_haskey(qdict, "apic-id")) {
+        int id = qdict_get_try_int(qdict, "apic-id", 0);
+        cs = cpu_by_arch_id(id);
+    } else {
+        cs = mon_get_cpu();
+    }
+
 
     if (!cs) {
         monitor_printf(mon, "No CPU available\n");
-- 
1.8.3.1
