Received: from eggs.gnu.org ([2001:4830:134:3::10]:51314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPi-0004s3-FQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPh-00033x-Cd
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmPh-00032y-4R
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3211CC04574C
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:04:00 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 17:03:33 +0800
Message-Id: <1498554219-4942-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1498554219-4942-1-git-send-email-peterx@redhat.com>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] hmp: add info iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Introducing a new HMP interface "info iommu" to dump IOMMU information.
This command will be only used for developers' debugging purpose, and no
possible use for users. So QMP interface will not be implemented.

This patch only implements the stub one.  We can provide arch-dependent
status dump in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands-info.hx | 14 ++++++++++++++
 hmp.c                |  6 ++++++
 hmp.h                |  1 +
 include/hw/iommu.h   |  9 +++++++++
 stubs/Makefile.objs  |  1 +
 stubs/iommu.c        |  9 +++++++++
 6 files changed, 40 insertions(+)
 create mode 100644 include/hw/iommu.h
 create mode 100644 stubs/iommu.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ae16901..a39243d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -802,6 +802,20 @@ Dump all the ramblocks of the system.
 ETEXI
 
     {
+        .name       = "iommu",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Display system IOMMU information",
+        .cmd        = hmp_info_iommu,
+    },
+
+STEXI
+@item info ramblock
+@findex ramblock
+Dump all the ramblocks of the system.
+ETEXI
+
+    {
         .name       = "hotpluggable-cpus",
         .args_type  = "",
         .params     = "",
diff --git a/hmp.c b/hmp.c
index 8c72c58..68994af 100644
--- a/hmp.c
+++ b/hmp.c
@@ -42,6 +42,7 @@
 #include "qemu/error-report.h"
 #include "exec/ramlist.h"
 #include "hw/intc/intc.h"
+#include "hw/iommu.h"
 #include "migration/snapshot.h"
 
 #ifdef CONFIG_SPICE
@@ -2817,3 +2818,8 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
     qapi_free_GuidInfo(info);
 }
+
+void hmp_info_iommu(Monitor *mon, const QDict *qdict)
+{
+    arch_iommu_info(mon, qdict);
+}
diff --git a/hmp.h b/hmp.h
index d8b94ce..ed01c49 100644
--- a/hmp.h
+++ b/hmp.h
@@ -143,5 +143,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
+void hmp_info_iommu(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
new file mode 100644
index 0000000..5201a8d
--- /dev/null
+++ b/include/hw/iommu.h
@@ -0,0 +1,9 @@
+#ifndef __HW_IOMMU_H__
+#define __HW_IOMMU_H__
+
+#include "qemu/typedefs.h"
+#include "qapi/qmp/qdict.h"
+
+void arch_iommu_info(Monitor *mon, const QDict *qdict);
+
+#endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f5b47bf..dfd5569 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -39,3 +39,4 @@ stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
+stub-obj-y += iommu.o
diff --git a/stubs/iommu.c b/stubs/iommu.c
new file mode 100644
index 0000000..75b4f4c
--- /dev/null
+++ b/stubs/iommu.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "hw/iommu.h"
+
+void arch_iommu_info(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "This command is not supported "
+                   "on this platform.\n");
+}
-- 
2.7.4
