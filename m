Received: from eggs.gnu.org ([2001:4830:134:3::10]:36590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1deyV7-0001ho-Qv
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1deyV2-0005gS-Or
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:00:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1deyV2-0005YC-HV
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:00:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D897356ED
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 07:00:16 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  8 Aug 2017 15:00:07 +0800
Message-Id: <1502175607-9531-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] rcu: init globals only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

We were calling rcu_init_complete() twice in the child processes when
fork happened. However the pthread library does not really suggest to do
it that way:

http://pubs.opengroup.org/onlinepubs/7908799/xsh/pthread_mutex_init.html

"Attempting to initialise an already initialised mutex results in
 undefined behaviour."

Actually, IMHO we can do it in a more natural way: Firstly, we only init
the RCU globals once in rcu_init(). Then, in rcu_init_child(), we unlock
all the locks held in rcu_init_lock() just like what we do in the parent
process, then do the rest of RCU re-init (e.g., create the RCU thread).

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
this is based on Paolo's series:
"[PATCH for-2.10 0/2] RCU: forking fix and cleanups"
---
 util/rcu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index ca5a63e..6fbbe4c 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -299,15 +299,17 @@ void rcu_unregister_thread(void)
     qemu_mutex_unlock(&rcu_registry_lock);
 }
 
-static void rcu_init_complete(void)
+static void rcu_init_globals(void)
 {
-    QemuThread thread;
-
     qemu_mutex_init(&rcu_registry_lock);
     qemu_mutex_init(&rcu_sync_lock);
     qemu_event_init(&rcu_gp_event, true);
-
     qemu_event_init(&rcu_call_ready_event, false);
+}
+
+static void rcu_init_complete(void)
+{
+    QemuThread thread;
 
     /* The caller is assumed to have iothread lock, so the call_rcu thread
      * must have been quiescent even after forking, just recreate it.
@@ -357,6 +359,13 @@ static void rcu_init_child(void)
         return;
     }
 
+    rcu_init_unlock();
+
+    /*
+     * For the newly forked child, we need something extra: since
+     * after fork the threads are all gone, we need to re-init the RCU
+     * thread, along with the globals.
+     */
     memset(&registry, 0, sizeof(registry));
     rcu_init_complete();
 }
@@ -367,5 +376,6 @@ static void __attribute__((__constructor__)) rcu_init(void)
 #ifdef CONFIG_POSIX
     pthread_atfork(rcu_init_lock, rcu_init_unlock, rcu_init_child);
 #endif
+    rcu_init_globals();
     rcu_init_complete();
 }
-- 
2.7.4
