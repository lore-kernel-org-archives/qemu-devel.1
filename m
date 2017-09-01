Received: from eggs.gnu.org ([2001:4830:134:3::10]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTl-0007mG-Hs
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTk-0002tD-PS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnTk-0002sq-Jo
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:51 -0300
Message-Id: <20170901150317.10380-4-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/29] hmp: allow apic-id for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Wang <wang.yi59@zte.com.cn>

From: Yi Wang <wang.yi59@zte.com.cn>

Add [apic-id] support for hmp command "info lapic", which is
useful when debugging ipi and so on. Current behavior is not
changed when the parameter isn't specified.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
Message-Id: <1501049917-4701-3-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/monitor.c | 10 +++++++++-
 hmp-commands-info.hx  |  7 ++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 77ead60437..fe7d57b6aa 100644
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
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238a5f..4ab7fcee98 100644
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
-- 
2.13.5
