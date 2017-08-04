Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddfFb-00046Z-OV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddfFZ-0002ZY-Ki
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddfFZ-0002Yq-E9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:14:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FB26552E9
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 16:14:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  4 Aug 2017 18:14:52 +0200
Message-Id: <20170804161452.17413-3-pbonzini@redhat.com>
In-Reply-To: <20170804161452.17413-1-pbonzini@redhat.com>
References: <20170804161452.17413-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] Revert "rcu: do not create thread in
 pthread_atfork callback"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This reverts commit a59629fcc6f603e19b516dc08f75334e5c480bd0.
This is not needed anymore because the IOThread mutex is not
"magic" anymore (need not kick the CPU thread) and also because
fork callbacks are only enabled at the very beginning of
QEMU's execution.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu.h   |  1 -
 linux-user/syscall.c |  1 -
 os-posix.c           |  2 --
 util/rcu.c           | 10 +++++++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index c0da9907e8..f19413d649 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -111,7 +111,6 @@ extern void rcu_unregister_thread(void);
  */
 extern void rcu_enable_atfork(void);
 extern void rcu_disable_atfork(void);
-extern void rcu_after_fork(void);
 
 struct rcu_head;
 typedef void RCUCBFunc(struct rcu_head *head);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 54343c06be..9b6364a266 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6354,7 +6354,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ret = fork();
         if (ret == 0) {
             /* Child Process.  */
-            rcu_after_fork();
             cpu_clone_regs(env, newsp);
             fork_end(1);
             /* There is a race condition here.  The parent process could
diff --git a/os-posix.c b/os-posix.c
index c6ddb7d830..92e9d85215 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -34,7 +34,6 @@
 #include "sysemu/sysemu.h"
 #include "net/slirp.h"
 #include "qemu-options.h"
-#include "qemu/rcu.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
@@ -249,7 +248,6 @@ void os_daemonize(void)
         signal(SIGTSTP, SIG_IGN);
         signal(SIGTTOU, SIG_IGN);
         signal(SIGTTIN, SIG_IGN);
-        rcu_after_fork();
     }
 }
 
diff --git a/util/rcu.c b/util/rcu.c
index 2142ddd93b..ca5a63e36a 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -350,18 +350,22 @@ static void rcu_init_unlock(void)
     qemu_mutex_unlock(&rcu_registry_lock);
     qemu_mutex_unlock(&rcu_sync_lock);
 }
-#endif
 
-void rcu_after_fork(void)
+static void rcu_init_child(void)
 {
+    if (atfork_depth < 1) {
+        return;
+    }
+
     memset(&registry, 0, sizeof(registry));
     rcu_init_complete();
 }
+#endif
 
 static void __attribute__((__constructor__)) rcu_init(void)
 {
 #ifdef CONFIG_POSIX
-    pthread_atfork(rcu_init_lock, rcu_init_unlock, rcu_init_unlock);
+    pthread_atfork(rcu_init_lock, rcu_init_unlock, rcu_init_child);
 #endif
     rcu_init_complete();
 }
-- 
2.13.3
