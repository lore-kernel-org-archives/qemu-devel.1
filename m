Received: from eggs.gnu.org ([2001:4830:134:3::10]:44509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cedtr-0002fB-Qc
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cedtm-0000M0-Su
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:19 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skiver.cloud.yzy@gmail.com>)
	id 1cedtm-0000L9-JA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:14 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so3611766pfg.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 00:28:14 -0800 (PST)
From: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Date: Fri, 17 Feb 2017 16:27:04 +0800
Message-Id: <20170217082704.23270-3-skiver.cloud.yzy@gmail.com>
In-Reply-To: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] target/i386/monitor.c: check return value
 of mon_get_cpu before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Ziyue Yang <yzylivezh@hotmail.com>, Ziyue Yang <skiver.cloud.yzy@gmail.com>

From: Ziyue Yang <yzylivezh@hotmail.com>

This patch eliminates the segfault caused by accessing CPU that doesn't
exist in hmp command "info lapic", which can be reproduced by

$ qemu-system-x86_64 -nographic -M none -serial none -monitor stdio

and then type "info lapic" into qemu monitor.

Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
---
 target/i386/monitor.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 468aa073bc..7b96c74a24 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -624,8 +624,11 @@ const MonitorDef *target_monitor_defs(void)
 
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 {
-    x86_cpu_dump_local_apic_state(mon_get_cpu(), (FILE *)mon, monitor_fprintf,
-                                  CPU_DUMP_FPU);
+    CPUState *cs = mon_get_cpu();
+    if (cs) {
+        x86_cpu_dump_local_apic_state(cs, (FILE *)mon, monitor_fprintf,
+                                      CPU_DUMP_FPU);
+    }
 }
 
 void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
-- 
2.11.0
