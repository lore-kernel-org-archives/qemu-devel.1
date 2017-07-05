Received: from eggs.gnu.org ([2001:4830:134:3::10]:46277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWY-0004N2-6X
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWT-0007PI-Mw
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:58 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWT-0007Nj-Df
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:53 -0400
Received: by mail-wm0-x241.google.com with SMTP id y5so30406731wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:04 +0200
Message-Id: <1499238885-26161-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/42] vcpu_dirty: share the same field in
 CPUState for all accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch simply replaces the separate boolean field in CPUState that
kvm, hax (and upcoming hvf) have for keeping track of vcpu dirtiness
with a single shared field.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170618191101.3457-1-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c   | 18 +++++++++---------
 include/qom/cpu.h     |  5 +++--
 target/i386/hax-all.c | 12 ++++++------
 target/mips/kvm.c     |  4 ++--
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75feffa..cd71e28 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
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
@@ -1982,9 +1982,9 @@ int kvm_cpu_exec(CPUState *cpu)
     do {
         MemTxAttrs attrs;
 
-        if (cpu->kvm_vcpu_dirty) {
+        if (cpu->vcpu_dirty) {
             kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
-            cpu->kvm_vcpu_dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         kvm_arch_pre_run(cpu, run);
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 2fe7cff..b9440b6 100644
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
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index ba6117d..3ce6950 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -232,7 +232,7 @@ int hax_init_vcpu(CPUState *cpu)
     }
 
     cpu->hax_vcpu = hax_global.vm->vcpus[cpu->cpu_index];
-    cpu->hax_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
     qemu_register_reset(hax_reset_vcpu_state, (CPUArchState *) (cpu->env_ptr));
 
     return ret;
@@ -599,12 +599,12 @@ static void do_hax_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
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
@@ -615,7 +615,7 @@ static void do_hax_cpu_synchronize_post_reset(CPUState *cpu,
     CPUArchState *env = cpu->env_ptr;
 
     hax_vcpu_sync_state(env, 1);
-    cpu->hax_vcpu_dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 void hax_cpu_synchronize_post_reset(CPUState *cpu)
@@ -628,7 +628,7 @@ static void do_hax_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
     CPUArchState *env = cpu->env_ptr;
 
     hax_vcpu_sync_state(env, 1);
-    cpu->hax_vcpu_dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 void hax_cpu_synchronize_post_init(CPUState *cpu)
@@ -638,7 +638,7 @@ void hax_cpu_synchronize_post_init(CPUState *cpu)
 
 static void do_hax_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->hax_vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 void hax_cpu_synchronize_pre_loadvm(CPUState *cpu)
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 0982e87..3317905 100644
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
1.8.3.1
