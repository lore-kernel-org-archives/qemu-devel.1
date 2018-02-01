Received: from eggs.gnu.org ([2001:4830:134:3::10]:51950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6N-00026X-8m
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6L-0003Yq-I8
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG6L-0003Yb-Bd
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 09:44:25 -0500
Message-Id: <20180201144430.14441-2-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-1-pbonzini@redhat.com>
References: <20180201144430.14441-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] cpus: hax: register/unregister thread with
 RCU, exit loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzc@zju.edu.cn

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 1495ed5c36..231550a0d8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1474,6 +1474,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     CPUState *cpu = arg;
     int r;
 
+    rcu_register_thread();
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
 
@@ -1485,7 +1486,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     hax_init_vcpu(cpu);
     qemu_cond_signal(&qemu_cpu_cond);
 
-    while (1) {
+    do {
         if (cpu_can_run(cpu)) {
             r = hax_smp_cpu_exec(cpu);
             if (r == EXCP_DEBUG) {
@@ -1494,7 +1495,8 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
         }
 
         qemu_wait_io_event(cpu);
-    }
+    } while (!cpu->unplug || cpu_can_run(cpu));
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
2.14.3
