Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fSiEx-0002IU-67
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fSiEu-0003kB-09
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:17:35 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fSiEt-0003jp-Mj
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:17:31 -0400
Received: by mail-wr0-x243.google.com with SMTP id o12-v6so23825639wrm.12
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 05:17:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1526462314-19720-1-git-send-email-zhaoshenglong@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25094a6a-df4e-3dbb-ef69-e478edb46ff3@redhat.com>
Date: Tue, 12 Jun 2018 14:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <1526462314-19720-1-git-send-email-zhaoshenglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: Delete the slot only when
 KVM_MEM_READONLY flag is changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, guangrong.xiao@gmail.com
Cc: kvmarm@lists.cs.columbia.edu, shannon.zhaosl@gmail.com, kvm@vger.kernel.org, zhengxiang9@huawei.com

On 16/05/2018 11:18, Shannon Zhao wrote:
> According to KVM commit 75d61fbc, it needs to delete the slot before
> changing the KVM_MEM_READONLY flag. But QEMU commit 235e8982 only check
> whether KVM_MEM_READONLY flag is set instead of changing. It doesn't
> need to delete the slot if the KVM_MEM_READONLY flag is not changed.
> 
> This fixes a issue that migrating a VM at the OVMF startup stage and
> VM is executing the codes in rom. Between the deleting and adding the
> slot in kvm_set_user_memory_region, there is a chance that guest access
> rom and trap to KVM, then KVM can't find the corresponding memslot.
> While KVM (on ARM) injects an abort to guest due to the broken hva, then
> guest will get stuck.
> 
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>

I'm a bit worried about old_flags not being set on all paths to
kvm_set_user_memory_region.  This would lead to extra
KVM_SET_USER_MEMORY_REGION calls.  It should not be a problem but
it is ugly.  Does something like the additional changes below work for you?

Thanks,

Paolo


diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b04f193a76..e318bcfb78 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -257,7 +257,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     return 0;
 }
 
-static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
+static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
     struct kvm_userspace_memory_region mem;
@@ -268,7 +268,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
 
-    if (slot->memory_size && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
+    if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
@@ -276,6 +276,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
     }
     mem.memory_size = slot->memory_size;
     ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    slot->old_flags = mem.flags;
     trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
                               mem.memory_size, mem.userspace_addr, ret);
     return ret;
@@ -394,7 +395,6 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
 {
     int old_flags;
 
-    mem->old_flags = mem->flags;
     mem->flags = kvm_mem_flags(mr);
 
     /* If nothing changed effectively, no need to issue ioctl */
@@ -402,7 +402,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
         return 0;
     }
 
-    return kvm_set_user_memory_region(kml, mem);
+    return kvm_set_user_memory_region(kml, mem, false);
 }
 
 static int kvm_section_update_flags(KVMMemoryListener *kml,
@@ -756,7 +756,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
 
         /* unregister the slot */
         mem->memory_size = 0;
-        err = kvm_set_user_memory_region(kml, mem);
+        mem->flags = 0;
+        err = kvm_set_user_memory_region(kml, mem, false);
         if (err) {
             fprintf(stderr, "%s: error unregistering slot: %s\n",
                     __func__, strerror(-err));
@@ -772,7 +773,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     mem->ram = ram;
     mem->flags = kvm_mem_flags(mr);
 
-    err = kvm_set_user_memory_region(kml, mem);
+    err = kvm_set_user_memory_region(kml, mem, true);
     if (err) {
         fprintf(stderr, "%s: error registering slot: %s\n", __func__,
                 strerror(-err));
