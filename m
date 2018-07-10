Received: from eggs.gnu.org ([2001:4830:134:3::10]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qiaochong@loongson.cn>) id 1fcj50-0002IC-Q2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qiaochong@loongson.cn>) id 1fcj4x-0002Ul-K3
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:12:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47732)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qiaochong@loongson.cn>) id 1fcj4w-0002U5-QM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:12:39 -0400
From: QiaoChong <qiaochong@loongson.cn>
Date: Tue, 10 Jul 2018 11:12:28 +0800
Message-Id: <1531192348-21056-1-git-send-email-qiaochong@loongson.cn>
Subject: [Qemu-devel] [PATCH] make pci_bridge_region_cleanup to be done in
 rcu queue after flatview_destroy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qiaochong@loongson.cn

pci_bridge_region_cleanup need to done after flatview_destroy,
because memory_region_unref need access memory regions in PCIBridgeWindows in flatview_destroy.
here we delay pci_bridge_region_cleanup to be done in rcu queue work.

bellow are gdb backtraces.

oldcode mr->name will be freed in object_unparent, before flatview_destroy.

0  _int_free (av=0x7fffe00bcb20 <main_arena>, p=0x555556a988c0, have_lock=0) at malloc.c:3947
1  0x00007fffdfd7c53c in __GI___libc_free (mem=<optimized out>) at malloc.c:2968
2  0x000055555587ad73 in memory_region_finalize (obj=<optimized out>) at /work/work/loongson/qemu/qemu-latest/memory.c:1731
3  0x0000555555b52e52 in object_deinit (type=0x5555565a54f0, obj=0x5555567dcbf0) at qom/object.c:462
4  object_finalize (data=0x5555567dcbf0) at qom/object.c:476
5  object_unref (obj=0x5555567dcbf0) at qom/object.c:924
6  0x0000555555b51e57 in object_property_del_child (obj=0x55555695f3d0, child=child@entry=0x5555567dcbf0, errp=0x0) at qom/object.c:436
7  0x0000555555b525e4 in object_unparent (obj=obj@entry=0x5555567dcbf0) at qom/object.c:455
8  0x0000555555a7bd70 in pci_bridge_region_cleanup (w=0x5555567dca10, br=<optimized out>) at hw/pci/pci_bridge.c:229
9  0x0000555555a7c336 in pci_bridge_update_mappings (br=<optimized out>) at hw/pci/pci_bridge.c:248
10 0x0000555555a7c3ba in pci_bridge_write_config (d=0x55555695f3d0, address=4, val=44040192, len=4) at hw/pci/pci_bridge.c:272

here mr mr->owner, mr->name has been freed in object_unparent before.

0  memory_region_unref_do (mr=0x5555567dcbf0) at /work/work/loongson/qemu/qemu-latest/memory.c:296
1  0x0000555555877c49 in flatview_destroy (view=0x555557344020) at /work/work/loongson/qemu/qemu-latest/memory.c:290
2  0x0000555555c4a0ae in call_rcu_thread (opaque=<optimized out>) at util/rcu.c:284
3  0x00007fffe00c96ba in start_thread (arg=0x7fffd007c700) at pthread_create.c:333
4  0x00007fffdfdff41d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

void memory_region_unref(MemoryRegion *mr)
{
    if (mr && mr->owner) {
        object_unref(mr->owner);
    }
}

Signed-off-by: QiaoChong <qiaochong@loongson.cn>
---
 hw/pci/pci_bridge.c         | 14 +++++++++++++-
 include/hw/pci/pci_bridge.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 40a39f5..c080471 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -233,6 +233,18 @@ static void pci_bridge_region_cleanup(PCIBridge *br, PCIBridgeWindows *w)
     g_free(w);
 }
 
+/*
+ * pci_bridge_region_cleanup need to done after flatview_destroy,
+ * because memory_region_unref need access memory regions in PCIBridgeWindows
+ * in flatview_destroy.Here we delay pci_bridge_region_cleanup to be done
+ * in rcu queue work.
+ */
+
+static void pci_bridge_region_cleanup_schedule(PCIBridgeWindows *w)
+{
+    pci_bridge_region_cleanup(NULL, w);
+}
+
 void pci_bridge_update_mappings(PCIBridge *br)
 {
     PCIBridgeWindows *w = br->windows;
@@ -243,7 +255,7 @@ void pci_bridge_update_mappings(PCIBridge *br)
     pci_bridge_region_del(br, br->windows);
     br->windows = pci_bridge_region_init(br);
     memory_region_transaction_commit();
-    pci_bridge_region_cleanup(br, w);
+    call_rcu(w,  pci_bridge_region_cleanup_schedule, rcu);
 }
 
 /* default write_config function for PCI-to-PCI bridge */
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 0347da5..0e1fd82 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -37,6 +37,7 @@ typedef struct PCIBridgeWindows PCIBridgeWindows;
  * as subregions.
  */
 struct PCIBridgeWindows {
+    struct rcu_head rcu;
     MemoryRegion alias_pref_mem;
     MemoryRegion alias_mem;
     MemoryRegion alias_io;
-- 
2.7.4
