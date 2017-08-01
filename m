Received: from eggs.gnu.org ([2001:4830:134:3::10]:59639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrd-0004Sz-UR
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrc-0007IH-Lf
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:45 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrc-0007Gl-Fn
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:44 -0400
Received: by mail-wr0-x242.google.com with SMTP id c24so1805612wra.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:19 +0200
Message-Id: <1501604245-33460-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/17] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jay Zhou <jianjay.zhou@huawei.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

Qemu_savevm_state_cleanup takes about 300ms in my ram migration tests
with a 8U24G vm(20G is really occupied), the main cost comes from
KVM_SET_USER_MEMORY_REGION ioctl when mem.memory_size = 0 in
kvm_set_user_memory_region. In kmod, the main cost is
kvm_zap_obsolete_pages, which traverses the active_mmu_pages list to
zap the unsync sptes.

It can be optimized by delaying memory_global_dirty_log_stop to the next
vm_start.

Changes v2->v3:
 - NULL VMChangeStateHandler if it is deleted and protect the scenario
   of nested invocations of memory_global_dirty_log_start/stop [Paolo]

Changes v1->v2:
 - create a VMChangeStateHandler in memory.c to reduce the coupling [Paolo]

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Message-Id: <1501237733-2736-1-git-send-email-jianjay.zhou@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index a7bc70a..c0adc35 100644
--- a/memory.c
+++ b/memory.c
@@ -2357,8 +2357,15 @@ void memory_global_dirty_log_sync(void)
     }
 }
 
+static VMChangeStateEntry *vmstate_change;
+
 void memory_global_dirty_log_start(void)
 {
+    if (vmstate_change) {
+        qemu_del_vm_change_state_handler(vmstate_change);
+        vmstate_change = NULL;
+    }
+
     global_dirty_log = true;
 
     MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
@@ -2369,7 +2376,7 @@ void memory_global_dirty_log_start(void)
     memory_region_transaction_commit();
 }
 
-void memory_global_dirty_log_stop(void)
+static void memory_global_dirty_log_do_stop(void)
 {
     global_dirty_log = false;
 
@@ -2381,6 +2388,33 @@ void memory_global_dirty_log_stop(void)
     MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
 }
 
+static void memory_vm_change_state_handler(void *opaque, int running,
+                                           RunState state)
+{
+    if (running) {
+        memory_global_dirty_log_do_stop();
+
+        if (vmstate_change) {
+            qemu_del_vm_change_state_handler(vmstate_change);
+            vmstate_change = NULL;
+        }
+    }
+}
+
+void memory_global_dirty_log_stop(void)
+{
+    if (!runstate_is_running()) {
+        if (vmstate_change) {
+            return;
+        }
+        vmstate_change = qemu_add_vm_change_state_handler(
+                                memory_vm_change_state_handler, NULL);
+        return;
+    }
+
+    memory_global_dirty_log_do_stop();
+}
+
 static void listener_add_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
-- 
1.8.3.1
