Received: from eggs.gnu.org ([2001:4830:134:3::10]:36393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332I-0004Is-Hs
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332H-0004bm-Dy
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:26 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f332H-0004bJ-7C
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:25 -0400
Received: by mail-wr0-x242.google.com with SMTP id z73so14739986wrb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:25 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:49 -0700
Message-Id: <20180402171354.27706-4-jcmvbkbc@gmail.com>
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 3/8] linux-user: call cpu_copy under clone_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

cpu_copy adds newly created CPU object to container/machine/unattached,
but does it w/o proper locking. As a result when multiple threads create
threads rapidly QEMU may abort with the following message:

  GLib-CRITICAL **: g_hash_table_iter_next: assertion
  'ri->version == ri->hash_table->version' failed

  ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component:
  code should not be reached

E.g. this issue is observed when running glibc test nptl/tst-eintr1.
Move cpu_copy invocation under clone_lock to fix that.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
