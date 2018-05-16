Received: from eggs.gnu.org ([2001:4830:134:3::10]:52225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fIsbX-0002kB-2C
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fIsbS-0004hy-9b
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:20:15 -0400
Received: from [45.249.212.35] (port=59461 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhaoshenglong@huawei.com>)
	id 1fIsbR-0004WQ-Ub
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:20:10 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Wed, 16 May 2018 17:18:34 +0800
Message-ID: <1526462314-19720-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] kvm: Delete the slot only when
 KVM_MEM_READONLY flag is changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, guangrong.xiao@gmail.com
Cc: kvmarm@lists.cs.columbia.edu, shannon.zhaosl@gmail.com, kvm@vger.kernel.org, zhengxiang9@huawei.com

According to KVM commit 75d61fbc, it needs to delete the slot before
changing the KVM_MEM_READONLY flag. But QEMU commit 235e8982 only check
whether KVM_MEM_READONLY flag is set instead of changing. It doesn't
need to delete the slot if the KVM_MEM_READONLY flag is not changed.

This fixes a issue that migrating a VM at the OVMF startup stage and
VM is executing the codes in rom. Between the deleting and adding the
slot in kvm_set_user_memory_region, there is a chance that guest access
rom and trap to KVM, then KVM can't find the corresponding memslot.
While KVM (on ARM) injects an abort to guest due to the broken hva, then
guest will get stuck.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 include/sysemu/kvm_int.h | 1 +
 kvm-all.c                | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 888557a..f838412 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -20,6 +20,7 @@ typedef struct KVMSlot
     void *ram;
     int slot;
     int flags;
+    int old_flags;
 } KVMSlot;
 
 typedef struct KVMMemoryListener {
diff --git a/kvm-all.c b/kvm-all.c
index 2515a23..de8250e 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -252,7 +252,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
 
-    if (slot->memory_size && mem.flags & KVM_MEM_READONLY) {
+    if (slot->memory_size && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
@@ -376,11 +376,11 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
 {
     int old_flags;
 
-    old_flags = mem->flags;
+    mem->old_flags = mem->flags;
     mem->flags = kvm_mem_flags(mr);
 
     /* If nothing changed effectively, no need to issue ioctl */
-    if (mem->flags == old_flags) {
+    if (mem->flags == mem->old_flags) {
         return 0;
     }
 
-- 
2.0.4
