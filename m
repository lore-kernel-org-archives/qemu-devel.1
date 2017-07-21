Received: from eggs.gnu.org ([2001:4830:134:3::10]:34065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSG6-0005TV-P1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSG2-0001nb-15
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:58 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:55662)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSG1-0001mO-Bx
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:53 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Fri, 21 Jul 2017 03:38:56 -0400
Message-Id: <1500622736-20865-3-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1500622736-20865-1-git-send-email-wang.yi59@zte.com.cn>
References: <1500622736-20865-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel] [PATCH 2/2] [PATCH] hmp: allow apic-id for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

Add [apic-id] support for hmp command "info lapic", which is
useful when debugging ipi and so on. Current behavior is not
changed when the parameter isn't specified.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
---
 hmp-commands-info.hx  |  6 +++---
 target/i386/cpu.h     | 10 ++++++++++
 target/i386/helper.c  | 16 ++++++++++++++++
 target/i386/monitor.c |  9 ++++++++-
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238..00623df 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -115,9 +115,9 @@ ETEXI
 #if defined(TARGET_I386)
     {
         .name       = "lapic",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show local apic state",
+        .args_type  = "apic-id:i?",
+        .params     = "[apic-id]",
+        .help       = "show local apic state (apic-id: local apic to read, default is 0)",
         .cmd        = hmp_info_local_apic,
     },
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 31ad681..4da2ca2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1712,6 +1712,16 @@ void enable_compat_apic_id_mode(void);
 #define APIC_DEFAULT_ADDRESS 0xfee00000
 #define APIC_SPACE_SIZE      0x100000
 
+/**
+ * x86_get_cpu_by_apic:
+ * @id: The apic-id of the specified CPU to obtain.
+ *
+ * Gets a CPU on which @id given of apic.
+ *
+ * Returns: The CPU or %NULL if there is no matching CPU.
+ */
+CPUState *x86_get_cpu_by_apic(int id);
+
 void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
                                    fprintf_function cpu_fprintf, int flags);
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index fd4f1af..6972833 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -398,6 +398,22 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
     }
     cpu_fprintf(f, " PPR 0x%02x\n", apic_get_ppr(s));
 }
+
+CPUState *x86_get_cpu_by_apic(int id)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        X86CPU *cpu = X86_CPU(cs);
+        APICCommonState *s = APIC_COMMON(cpu->apic_state);
+        if (id == s->id) {
+            return cs;
+        }
+    }
+
+    return NULL;
+}
+
 #else
 void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
                                    fprintf_function cpu_fprintf, int flags)
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 77ead60..e911a57 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -632,7 +632,14 @@ const MonitorDef *target_monitor_defs(void)
 
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 {
-    CPUState *cs = mon_get_cpu();
+    CPUState *cs;
+
+    if (qdict_haskey(qdict, "apic-id")) {
+        int id = qdict_get_try_int(qdict, "apic-id", 0);
+        cs = x86_get_cpu_by_apic(id);
+    } else {
+        cs = mon_get_cpu();
+    }
 
     if (!cs) {
         monitor_printf(mon, "No CPU available\n");
-- 
1.8.3.1
