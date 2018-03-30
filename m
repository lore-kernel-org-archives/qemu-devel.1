Received: from eggs.gnu.org ([2001:4830:134:3::10]:39206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f1uC5-00071T-8Z
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 09:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f1uC4-0003op-GF
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 09:35:49 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:37243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f1uC4-0003nN-7u
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 09:35:48 -0400
Received: by mail-lf0-x241.google.com with SMTP id m200-v6so6855626lfm.4
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 06:35:48 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 30 Mar 2018 06:35:25 -0700
Message-Id: <20180330133525.10994-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user: call cpu_copy under clone_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

cpu_copy adds newly created CPU object to container/machine/unattached,
but does it w/o proper locking. As a result when multiple threads are
created rapidly QEMU may abort with the following message:

  GLib-CRITICAL **: g_hash_table_iter_next: assertion
  'ri->version == ri->hash_table->version' failed

  ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component:
  code should not be reached

Move cpu_copy invocation under clone_lock to fix that.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 889abbda1e65..18ea79140f16 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6346,6 +6346,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
 
         ts = g_new0(TaskState, 1);
         init_task_state(ts);
+
+        /* Grab a mutex so that thread setup appears atomic.  */
+        pthread_mutex_lock(&clone_lock);
+
         /* we create a new CPU instance. */
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
@@ -6364,9 +6368,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             cpu_set_tls (new_env, newtls);
         }
 
-        /* Grab a mutex so that thread setup appears atomic.  */
-        pthread_mutex_lock(&clone_lock);
-
         memset(&info, 0, sizeof(info));
         pthread_mutex_init(&info.mutex, NULL);
         pthread_mutex_lock(&info.mutex);
-- 
2.11.0
