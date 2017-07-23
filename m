Received: from eggs.gnu.org ([2001:4830:134:3::10]:37904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dZ8ZR-0004ba-0c
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 00:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dZ8ZM-0002hs-Uf
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 00:32:44 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:34307)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dZ8ZM-0002fU-B5
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 00:32:40 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 23 Jul 2017 20:46:11 +0800
Message-Id: <1500813971-82408-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V2] vhost: fix a migration failed because of
 vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>, Wang Yechao <wang.yechao255@zte.com.cn>

When a guest that has several hotplugged dimms is migrated, on
destination it will fail to resume. Because regions on source
are merged and on destination the order of realizing devices
is different from on source with dimms, so when part of devices
are realizd some region can not be merged.That may be more than
vhost slot limit.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 hw/mem/pc-dimm.c        | 2 +-
 include/sysemu/sysemu.h | 1 +
 vl.c                    | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index ea67b46..13f3db5 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
         goto out;
     }
 
-    if (!vhost_has_free_slot()) {
+    if (!vhost_has_free_slot() && qemu_is_machine_init_done()) {
         error_setg(&local_err, "a used vhost backend has no free"
                                " memory slots left");
         goto out;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b213696..48228ad 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -88,6 +88,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info);
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
 
+bool qemu_is_machine_init_done(void);
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
diff --git a/vl.c b/vl.c
index fb6b2ef..43aee22 100644
--- a/vl.c
+++ b/vl.c
@@ -2681,6 +2681,11 @@ static void qemu_run_exit_notifiers(void)
 
 static bool machine_init_done;
 
+bool qemu_is_machine_init_done(void)
+{
+    return machine_init_done;
+}
+
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
     notifier_list_add(&machine_init_done_notifiers, notify);
-- 
1.8.3.1
