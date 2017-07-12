Received: from eggs.gnu.org ([2001:4830:134:3::10]:32922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVFGo-0004jK-QV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVFGl-00020F-NZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:26 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVFGl-0001zh-HS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:23 -0400
Received: by mail-wr0-f176.google.com with SMTP id 77so28342456wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 03:53:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 12 Jul 2017 11:52:15 +0100
Message-Id: <20170712105216.747-4-alex.bennee@linaro.org>
In-Reply-To: <20170712105216.747-1-alex.bennee@linaro.org>
References: <20170712105216.747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 3/4] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

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

---
v4
  - add host_tid field for BSD (but don't populate it)
v3
  - fix merge, did move of function in previous commit
---
 bsd-user/qemu.h      | 2 ++
 gdbstub.c            | 3 ++-
 include/qom/cpu.h    | 2 --
 linux-user/syscall.c | 1 -
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index b550cee0cb..19b2b8fecb 100644
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
index 6b56f55eba..484e96dbd9 100644
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
index 7bfd50cc32..d3c783b4b5 100644
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
index 925ae11ea6..003943b736 100644
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
2.13.0
