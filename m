Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qiaochong@loongson.cn>) id 1fcidu-000490-3f
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qiaochong@loongson.cn>) id 1fcidq-0008Nk-5V
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:44:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47205)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qiaochong@loongson.cn>) id 1fcidp-0008Fa-Ev
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:44:38 -0400
From: QiaoChong <qiaochong@loongson.cn>
Date: Tue, 10 Jul 2018 10:44:21 +0800
Message-Id: <1531190661-19327-1-git-send-email-qiaochong@loongson.cn>
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

    mask=<optimized out>, attrs=...) at /work/work/loongson/qemu/qemu-latest/memory.c:559
    access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=0x555555876850 <memory_region_write_accessor>,
    mr=0x5555569608c0, attrs=...) at /work/work/loongson/qemu/qemu-latest/memory.c:626
    at /work/work/loongson/qemu/qemu-latest/memory.c:1518
    buf=buf@entry=0x7fffbff0ae40 "", len=len@entry=4, addr1=4, l=4, mr=0x5555569608c0) at /work/work/loongson/qemu/qemu-latest/exec.c:3255
    at /work/work/loongson/qemu/qemu-latest/exec.c:3294
    at /work/work/loongson/qemu/qemu-latest/exec.c:2910
    shift=<optimized out>, mask=<optimized out>, attrs=...) at /work/work/loongson/qemu/qemu-latest/memory.c:585
    access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=0x555555874700 <memory_region_write_with_attrs_accessor>,
    mr=0x555557338120, attrs=...) at /work/work/loongson/qemu/qemu-latest/memory.c:626
    size=size@entry=4, attrs=...) at /work/work/loongson/qemu/qemu-latest/memory.c:1518
    val=val@entry=44040192, addr=addr@entry=18446744072502722564, retaddr=retaddr@entry=140736012783717, recheck=false, size=4)
    at /work/work/loongson/qemu/qemu-latest/accel/tcg/cputlb.c:905
    mmu_idx=<optimized out>, env=0x55555681d218) at /work/work/loongson/qemu/qemu-latest/accel/tcg/softmmu_template.h:268
    at /work/work/loongson/qemu/qemu-latest/accel/tcg/softmmu_template.h:304
    at /work/work/loongson/qemu/qemu-latest/accel/tcg/cpu-exec.c:171
    at /work/work/loongson/qemu/qemu-latest/accel/tcg/cpu-exec.c:612

here mr mr->owner, mr->name has been freed in object_unparent before.

void memory_region_unref(MemoryRegion *mr)
{
    if (mr && mr->owner) {
        object_unref(mr->owner);
    }
}

Signed-off-by: QiaoChong <qiaochong@loongson.cn>
---
 hw/pci/pci_bridge.c         | 12 +++++++++++-
 include/hw/pci/pci_bridge.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 40a39f5..a3c9501 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -233,6 +233,16 @@ static void pci_bridge_region_cleanup(PCIBridge *br, PCIBridgeWindows *w)
     g_free(w);
 }
 
+/*
+pci_bridge_region_cleanup need to done after flatview_destroy,
+because memory_region_unref need access memory regions in PCIBridgeWindows in flatview_destroy.
+here we delay pci_bridge_region_cleanup to be done in rcu queue work.
+*/
+static void pci_bridge_region_cleanup_schedule(PCIBridgeWindows *w)
+{
+  pci_bridge_region_cleanup(NULL, w);
+}
+
 void pci_bridge_update_mappings(PCIBridge *br)
 {
     PCIBridgeWindows *w = br->windows;
@@ -243,7 +253,7 @@ void pci_bridge_update_mappings(PCIBridge *br)
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
