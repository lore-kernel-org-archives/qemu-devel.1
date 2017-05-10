Received: from eggs.gnu.org ([2001:4830:134:3::10]:45232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Ip2-0007Xg-Jv
	for qemu-devel@nongnu.org; Wed, 10 May 2017 00:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Iox-0006aY-Nk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 00:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8Iox-0006aU-E7
	for qemu-devel@nongnu.org; Wed, 10 May 2017 00:01:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45BF080C0D
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 04:01:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 12:01:29 +0800
Message-Id: <1494388889-3558-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1494388889-3558-1-git-send-email-peterx@redhat.com>
References: <1494388889-3558-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/3] ramblock: add new hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

To dump information about ramblocks. It looks like:

(qemu) info ramblock
              Block Name    PSize              Offset               Used              Total
            /objects/mem    2 MiB  0x0000000000000000 0x0000000080000000 0x0000000080000000
                vga.vram    4 KiB  0x0000000080060000 0x0000000001000000 0x0000000001000000
    /rom@etc/acpi/tables    4 KiB  0x00000000810b0000 0x0000000000020000 0x0000000000200000
                 pc.bios    4 KiB  0x0000000080000000 0x0000000000040000 0x0000000000040000
  0000:00:03.0/e1000.rom    4 KiB  0x0000000081070000 0x0000000000040000 0x0000000000040000
                  pc.rom    4 KiB  0x0000000080040000 0x0000000000020000 0x0000000000020000
    0000:00:02.0/vga.rom    4 KiB  0x0000000081060000 0x0000000000010000 0x0000000000010000
   /rom@etc/table-loader    4 KiB  0x00000000812b0000 0x0000000000001000 0x0000000000001000
      /rom@etc/acpi/rsdp    4 KiB  0x00000000812b1000 0x0000000000001000 0x0000000000001000

Ramblock is something hidden internally in QEMU implementation, and this
command should only be used by mostly QEMU developers on RAM stuff. It
is not a command suitable for QMP interface. So only HMP interface is
provided for it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c                 | 22 ++++++++++++++++++++++
 hmp-commands-info.hx   | 14 ++++++++++++++
 hmp.c                  |  6 ++++++
 hmp.h                  |  1 +
 include/exec/ramlist.h |  1 +
 5 files changed, 44 insertions(+)

diff --git a/exec.c b/exec.c
index 50519ae..821bef3 100644
--- a/exec.c
+++ b/exec.c
@@ -71,6 +71,8 @@
 #include "qemu/mmap-alloc.h"
 #endif
 
+#include "monitor/monitor.h"
+
 //#define DEBUG_SUBPAGE
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1333,6 +1335,26 @@ void qemu_mutex_unlock_ramlist(void)
     qemu_mutex_unlock(&ram_list.mutex);
 }
 
+void ram_block_dump(Monitor *mon)
+{
+    RAMBlock *block;
+    char *psize;
+
+    rcu_read_lock();
+    monitor_printf(mon, "%24s %8s  %18s %18s %18s\n",
+                   "Block Name", "PSize", "Offset", "Used", "Total");
+    RAMBLOCK_FOREACH(block) {
+        psize = size_to_str(block->page_size);
+        monitor_printf(mon, "%24s %8s  0x%016" PRIx64 " 0x%016" PRIx64
+                       " 0x%016" PRIx64 "\n", block->idstr, psize,
+                       (uint64_t)block->offset,
+                       (uint64_t)block->used_length,
+                       (uint64_t)block->max_length);
+        g_free(psize);
+    }
+    rcu_read_unlock();
+}
+
 #ifdef __linux__
 /*
  * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index a53f105..ae16901 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -788,6 +788,20 @@ Display the latest dump status.
 ETEXI
 
     {
+        .name       = "ramblock",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Display system ramblock information",
+        .cmd        = hmp_info_ramblock,
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
index ab407d6..8369388 100644
--- a/hmp.c
+++ b/hmp.c
@@ -37,6 +37,7 @@
 #include "qemu-io.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "exec/ramlist.h"
 #include "hw/intc/intc.h"
 
 #ifdef CONFIG_SPICE
@@ -2563,6 +2564,11 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict)
     qapi_free_DumpQueryResult(result);
 }
 
+void hmp_info_ramblock(Monitor *mon, const QDict *qdict)
+{
+    ram_block_dump(mon);
+}
+
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/hmp.h b/hmp.h
index 799fd37..7353b67 100644
--- a/hmp.h
+++ b/hmp.h
@@ -136,6 +136,7 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
 void hmp_info_dump(Monitor *mon, const QDict *qdict);
+void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index f1c6b45..2e2ac6c 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -73,5 +73,6 @@ void ram_block_notifier_remove(RAMBlockNotifier *n);
 void ram_block_notify_add(void *host, size_t size);
 void ram_block_notify_remove(void *host, size_t size);
 
+void ram_block_dump(Monitor *mon);
 
 #endif /* RAMLIST_H */
-- 
2.7.4
