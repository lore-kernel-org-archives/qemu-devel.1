Received: from eggs.gnu.org ([2001:4830:134:3::10]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMvUa-000806-MD
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMvUZ-0002yr-Ro
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:41:32 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eMvUZ-0002rw-LS
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:41:31 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Dec 2017 12:41:21 +0000
Message-Id: <1512650481-1723-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: wrap fork() in a start/end
 exclusive section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

When we do a fork() in usermode emulation, we need to be in
a start/end exclusive section, so that we can ensure that no
other thread is in an RCU section. Otherwise you can get this
deadlock:

- fork thread: has mmap_lock, waits for rcu_sync_lock
  (because rcu_init_lock() is registered as a pthread_atfork() hook)
- RCU thread: has rcu_sync_lock, waits for rcu_read_(un)lock
- another CPU thread: in RCU critical section, waits for mmap_lock

This can show up if you have a heavily multithreaded guest program
that does a fork().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Stuart Monteith <stuart.monteith@linaro.org>
---
Based-on: <1512397331-15238-1-git-send-email-peter.maydell@linaro.org>
(this applies on top of 'linux-user: Fix locking order in fork_start()')

I think this should fix the deadlock that Stuart reports, but I
can't reproduce it, so testing welcome.

 linux-user/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 146ee3e..ff116fe 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -128,6 +128,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
 /* Make sure everything is in a consistent state for calling fork().  */
 void fork_start(void)
 {
+    start_exclusive();
     mmap_fork_start();
     qemu_mutex_lock(&tb_ctx.tb_lock);
     cpu_list_lock();
@@ -148,9 +149,13 @@ void fork_end(int child)
         qemu_mutex_init(&tb_ctx.tb_lock);
         qemu_init_cpu_list();
         gdbserver_fork(thread_cpu);
+        /* qemu_init_cpu_list() takes care of reinitializing the
+         * exclusive state, so we don't need to end_exclusive() here.
+         */
     } else {
         qemu_mutex_unlock(&tb_ctx.tb_lock);
         cpu_list_unlock();
+        end_exclusive();
     }
 }
 
-- 
2.7.4
