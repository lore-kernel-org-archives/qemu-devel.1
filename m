Received: from eggs.gnu.org ([2001:4830:134:3::10]:43409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs1-00075R-4U
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzrw-0002Jr-VL
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:17 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzrw-0002IY-LT
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:47:56 +0100
Message-Id: <20180123144807.5618-3-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 02/13] linux-user: wrap fork() in a start/end
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

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
Message-Id: <1512650481-1723-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index e8406917e3..2140465709 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -127,6 +127,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
 /* Make sure everything is in a consistent state for calling fork().  */
 void fork_start(void)
 {
+    start_exclusive();
     mmap_fork_start();
     qemu_mutex_lock(&tb_ctx.tb_lock);
     cpu_list_lock();
@@ -147,9 +148,13 @@ void fork_end(int child)
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
2.14.3
