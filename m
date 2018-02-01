Received: from eggs.gnu.org ([2001:4830:134:3::10]:34006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1ehCfe-0006It-HR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1ehCfY-0005RF-EB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:04:46 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:18836 helo=zju.edu.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1ehCfX-0005P7-QQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:04:40 -0500
From: linzhecheng <linzc@zju.edu.cn>
Date: Thu,  1 Feb 2018 19:04:28 +0800
Message-Id: <1517483068-18735-1-git-send-email-linzc@zju.edu.cn>
Subject: [Qemu-devel] [PATCH v2] vcpu: join vcpu thread after it exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, linzhecheng <linzc@zju.edu.cn>, linzhecheng <linzhecheng@huawei.com>

As we create vcpu thread with QEMU_THREAD_JOINABLE mode,
we should join it after it exiting to cleanup resources.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f48..5cc1ba2 100644
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
index 2cb0af9..1890bfe 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1205,6 +1205,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     cpu->created = false;
     qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
@@ -1759,6 +1760,7 @@ void cpu_remove_sync(CPUState *cpu)
     cpu_remove(cpu);
     while (cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+        qemu_thread_join(cpu->thread);
     }
 }
 
-- 
1.8.3.1
