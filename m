Received: from eggs.gnu.org ([2001:4830:134:3::10]:33282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dMfbe-0000R8-51
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 15:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dMfba-0006y1-UA
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 15:11:30 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dMfba-0006xR-Oh
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 15:11:26 -0400
Received: by mail-vk0-x242.google.com with SMTP id p62so5800322vkp.0
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 12:11:26 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Sun, 18 Jun 2017 14:11:01 -0500
Message-Id: <20170618191101.3457-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH] vcpu_dirty: share the same field in CPUState
 for all accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, "open list:CPU" <qemu-devel@nongnu.org>, "open list:Overall" <kvm@vger.kernel.org>

This patch simply replaces the separate boolean field in CPUState that
kvm, hax (and upcoming hvf) have for keeping track of vcpu dirtiness
with a single shared field.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 include/qom/cpu.h     |  5 +++--
 kvm-all.c             | 18 +++++++++---------
 target/i386/hax-all.c | 12 ++++++------
 target/mips/kvm.c     |  4 ++--
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb686fb..2098eeae03 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -369,7 +369,6 @@ struct CPUState {
     vaddr mem_io_vaddr;
 
     int kvm_fd;
-    bool kvm_vcpu_dirty;
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
 
@@ -386,6 +385,9 @@ struct CPUState {
     uint32_t can_do_io;
     int32_t exception_index; /* used by m68k TCG */
 
+    /* shared by kvm, hax and hvf */
+    bool vcpu_dirty;
+
     /* Used to keep track of an outstanding cpu throttle thread for migration
      * autoconverge
      */
@@ -400,7 +402,6 @@ struct CPUState {
         icount_decr_u16 u16;
     } icount_decr;
 
-    bool hax_vcpu_dirty;
     struct hax_vcpu_state *hax_vcpu;
 
     /* The pending_tlb_flush flag is set and cleared atomically to
diff --git a/kvm-all.c b/kvm-all.c
index ab8262f672..a5eaff270e 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -318,7 +318,7 @@ int kvm_init_vcpu(CPUState *cpu)
 
     cpu->kvm_fd = ret;
     cpu->kvm_state = s;
-    cpu->kvm_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
 
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
@@ -1864,15 +1864,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
 
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->kvm_vcpu_dirty) {
+    if (!cpu->vcpu_dirty) {
         kvm_arch_get_registers(cpu);
-        cpu->kvm_vcpu_dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 void kvm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->kvm_vcpu_dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_kvm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -1880,7 +1880,7 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
 static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE);
-    cpu->kvm_vcpu_dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 void kvm_cpu_synchronize_post_reset(CPUState *cpu)
@@ -1891,7 +1891,7 @@ void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
     kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
-    cpu->kvm_vcpu_dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 void kvm_cpu_synchronize_post_init(CPUState *cpu)
@@ -1901,7 +1901,7 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->kvm_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -1981,9 +1981,9 @@ int kvm_cpu_exec(CPUState *cpu)
     do {
         MemTxAttrs attrs;
 
-        if (cpu->kvm_vcpu_dirty) {
+        if (cpu->vcpu_dirty) {
             kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
-            cpu->kvm_vcpu_dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         kvm_arch_pre_run(cpu, run);
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 097db5cae1..3ada8b54d4 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -232,7 +232,7 @@ int hax_init_vcpu(CPUState *cpu)
     }
 
     cpu->hax_vcpu = hax_global.vm->vcpus[cpu->cpu_index];
-    cpu->hax_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
     qemu_register_reset(hax_reset_vcpu_state, (CPUArchState *) (cpu->env_ptr));
 
     return ret;
@@ -598,12 +598,12 @@ static void do_hax_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
     CPUArchState *env = cpu->env_ptr;
 
     hax_arch_get_registers(env);
-    cpu->hax_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 void hax_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->hax_vcpu_dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_hax_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -614,7 +614,7 @@ static void do_hax_cpu_synchronize_post_reset(CPUState *cpu,
     CPUArchState *env = cpu->env_ptr;
 
     hax_vcpu_sync_state(env, 1);
-    cpu->hax_vcpu_dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 void hax_cpu_synchronize_post_reset(CPUState *cpu)
@@ -627,7 +627,7 @@ static void do_hax_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
     CPUArchState *env = cpu->env_ptr;
 
     hax_vcpu_sync_state(env, 1);
-    cpu->hax_vcpu_dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 void hax_cpu_synchronize_post_init(CPUState *cpu)
@@ -637,7 +637,7 @@ void hax_cpu_synchronize_post_init(CPUState *cpu)
 
 static void do_hax_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->hax_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 void hax_cpu_synchronize_pre_loadvm(CPUState *cpu)
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 0982e874bb..3317905e71 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -523,7 +523,7 @@ static void kvm_mips_update_state(void *opaque, int running, RunState state)
      * already saved and can be restored when it is synced back to KVM.
      */
     if (!running) {
-        if (!cs->kvm_vcpu_dirty) {
+        if (!cs->vcpu_dirty) {
             ret = kvm_mips_save_count(cs);
             if (ret < 0) {
                 fprintf(stderr, "Failed saving count\n");
@@ -539,7 +539,7 @@ static void kvm_mips_update_state(void *opaque, int running, RunState state)
             return;
         }
 
-        if (!cs->kvm_vcpu_dirty) {
+        if (!cs->vcpu_dirty) {
             ret = kvm_mips_restore_count(cs);
             if (ret < 0) {
                 fprintf(stderr, "Failed restoring count\n");
-- 
2.13.0
