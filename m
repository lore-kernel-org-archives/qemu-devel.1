Received: from eggs.gnu.org ([2001:4830:134:3::10]:54483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1ecnzE-0003pa-0i
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 02:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1ecnzA-0001Zt-5R
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 02:54:48 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:8604 helo=zju.edu.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1ecnz9-0001Xj-Gw
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 02:54:44 -0500
From: linzhecheng <linzc@zju.edu.cn>
Date: Sat, 20 Jan 2018 15:54:28 +0800
Message-Id: <1516434868-24776-1-git-send-email-linzc@zju.edu.cn>
Subject: [Qemu-devel] [PATCH] vcpu: create vcpu thread with
 QEMU_THREAD_DETACHED mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, linzhecheng <linzc@zju.edu.cn>

1. If we create vcpu thread with QEMU_THREAD_JOINABLE mode,
we will get memory leak when vcpu thread exits, which will happen
when hot-unplug vcpus.
2. We should use QLIST_FOREACH_SAFE instead of QLIST_FOREACH
if we need to remove the entry in QLIST.

Signed-off-by: linzhecheng <linzc@zju.edu.cn>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 071f4f5..fd95b18 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -282,9 +282,9 @@ err:
 
 static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
 {
-    struct KVMParkedVcpu *cpu;
+    struct KVMParkedVcpu *cpu, *next_cpu;
 
-    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
+    QLIST_FOREACH_SAFE(cpu, &s->kvm_parked_vcpus, node, next_cpu) {
         if (cpu->vcpu_id == vcpu_id) {
             int kvm_fd;
 
diff --git a/cpus.c b/cpus.c
index 2cb0af9..de3a96b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1113,6 +1113,9 @@ static void qemu_kvm_destroy_vcpu(CPUState *cpu)
         error_report("kvm_destroy_vcpu failed");
         exit(EXIT_FAILURE);
     }
+    g_free(cpu->thread);
+    g_free(cpu->halt_cond);
+    g_free(cpu->cpu_ases);
 }
 
 static void qemu_tcg_destroy_vcpu(CPUState *cpu)
@@ -1205,6 +1208,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     cpu->created = false;
     qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
@@ -1850,7 +1854,7 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_DETACHED);
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
     }
-- 
1.8.3.1
