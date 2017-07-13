Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4T-0001vJ-A9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4P-0004L4-Dt
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4P-0004Kj-63
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so5456275wmg.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:19 +0200
Message-Id: <1499955874-10954-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/41] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

This was only used by the gdbstub and even then was only being set for
subsequent threads. Rather the continue duplicating the number just
make the gdbstub get the information from TaskState structure.

Now the tid is correctly reported for all threads the bug I was seeing
with "vCont;C04:0;c" packets is fixed as the correct tid is reported
to gdb.

I moved cpu_gdb_index into the gdbstub to facilitate easy access to
the TaskState which is used elsewhere in gdbstub.

To prevent BSD failing to build I've included ts_tid into its
TaskStruct but not populated it - which was the same state as the old
cpu->host_tid. I'll leave it up to the BSD maintainers to actually
populate this properly if they want a working gdbstub with
user-threads.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Message-Id: <20170712105216.747-4-alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/qemu.h      | 2 ++
 gdbstub.c            | 3 ++-
 include/qom/cpu.h    | 2 --
 linux-user/syscall.c | 1 -
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index b550cee..19b2b8f 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -85,6 +85,8 @@ struct emulated_sigtable {
 /* NOTE: we force a big alignment so that the stack stored after is
    aligned too */
 typedef struct TaskState {
+    pid_t ts_tid;     /* tid (or pid) of this task */
+
     struct TaskState *next;
     int used; /* non zero if used */
     struct image_info *info;
diff --git a/gdbstub.c b/gdbstub.c
index b1efe0b..378fdd8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -64,7 +64,8 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
 static inline int cpu_gdb_index(CPUState *cpu)
 {
 #if defined(CONFIG_USER_ONLY)
-    return cpu->host_tid;
+    TaskState *ts = (TaskState *) cpu->opaque;
+    return ts->ts_tid;
 #else
     return cpu->cpu_index + 1;
 #endif
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 7bfd50c..d3c783b 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -265,7 +265,6 @@ struct qemu_work_item;
  * @cpu_index: CPU index (informative).
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU.
- * @host_tid: Host thread ID.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
@@ -319,7 +318,6 @@ struct CPUState {
     HANDLE hThread;
 #endif
     int thread_id;
-    uint32_t host_tid;
     bool running, has_waiter;
     struct QemuCond *halt_cond;
     bool thread_kicked;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 925ae11..003943b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6219,7 +6219,6 @@ static void *clone_func(void *arg)
     thread_cpu = cpu;
     ts = (TaskState *)cpu->opaque;
     info->tid = gettid();
-    cpu->host_tid = info->tid;
     task_settid(ts);
     if (info->child_tidptr)
         put_user_u32(info->tid, info->child_tidptr);
-- 
1.8.3.1
