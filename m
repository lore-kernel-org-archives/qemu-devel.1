Received: from eggs.gnu.org ([2001:4830:134:3::10]:52022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6T-00029p-GU
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6S-0003cJ-CE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG6S-0003bz-6A
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 09:44:30 -0500
Message-Id: <20180201144430.14441-7-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-1-pbonzini@redhat.com>
References: <20180201144430.14441-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] cpus: join thread when removing a vCPU
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

If no one joins the thread, its associated memory is leaked.

Reported-by: CheneyLin <linzc@zju.edu.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/cpus.c b/cpus.c
index 03b4533b7d..e8c3ba064c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1795,19 +1795,14 @@ void resume_all_vcpus(void)
     }
 }
 
-void cpu_remove(CPUState *cpu)
+void cpu_remove_sync(CPUState *cpu)
 {
     cpu->stop = true;
     cpu->unplug = true;
     qemu_cpu_kick(cpu);
-}
-
-void cpu_remove_sync(CPUState *cpu)
-{
-    cpu_remove(cpu);
-    while (cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
+    qemu_mutex_unlock_iothread();
+    qemu_thread_join(cpu->thread);
+    qemu_mutex_lock_iothread();
 }
 
 /* For temporary buffers for forming a name */
-- 
2.14.3
