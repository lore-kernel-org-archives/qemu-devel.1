Received: from eggs.gnu.org ([2001:4830:134:3::10]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXHMr-0007uc-UY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXHMo-0000Od-TJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:32:06 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:35289)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXHMo-0000MD-9n
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:32:02 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Mon, 17 Jul 2017 21:49:37 -0400
Message-Id: <1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel]  [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

Add [vcpu] index support for hmp command "info lapic", which is
useful when debugging ipi and so on. Current behavior is not
changed when the parameter isn't specified.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
---
 hmp-commands-info.hx  | 6 +++---
 target/i386/monitor.c | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238..c534b03 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -115,9 +115,9 @@ ETEXI
 #if defined(TARGET_I386)
     {
         .name       = "lapic",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show local apic state",
+        .args_type  = "vcpu:i?",
+        .params     = "[vcpu]",
+        .help       = "show local apic state (vcpu: vCPU to read, default is 0)",
         .cmd        = hmp_info_local_apic,
     },
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 77ead60..813005e 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -632,8 +632,14 @@ const MonitorDef *target_monitor_defs(void)
 
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 {
-    CPUState *cs = mon_get_cpu();
+    CPUState *cs;
 
+    if (qdict_haskey(qdict, "vcpu")) {
+        int index = qdict_get_try_int(qdict, "vcpu", 0);
+        cs = qemu_get_cpu(index);
+    } else {
+        cs = mon_get_cpu();
+    }
     if (!cs) {
         monitor_printf(mon, "No CPU available\n");
         return;
-- 
1.8.3.1
