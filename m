Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6P-00027c-2O
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6O-0003aQ-AB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG6O-0003Zv-3S
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:36 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 09:44:27 -0500
Message-Id: <20180201144430.14441-4-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-1-pbonzini@redhat.com>
References: <20180201144430.14441-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] cpus: dummy: unregister thread with RCU,
 exit loop on unplug
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
 cpus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 789ff7897b..34c86192d1 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1235,7 +1235,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
     cpu->created = true;
     qemu_cond_signal(&qemu_cpu_cond);
 
-    while (1) {
+    do {
         qemu_mutex_unlock_iothread();
         do {
             int sig;
@@ -1247,8 +1247,9 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
         }
         qemu_mutex_lock_iothread();
         qemu_wait_io_event(cpu);
-    }
+    } while (!cpu->unplug);
 
+    rcu_unregister_thread();
     return NULL;
 #endif
 }
-- 
2.14.3
