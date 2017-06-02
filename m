Received: from eggs.gnu.org ([2001:4830:134:3::10]:33949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGmGI-0006G6-SX
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGmGF-0002fd-I6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:06 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGmGF-0002fB-BE
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:03 -0400
Received: by mail-wr0-x234.google.com with SMTP id g76so6683896wrd.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:05:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 14:05:17 +0100
Message-Id: <20170602130518.22943-4-alex.bennee@linaro.org>
In-Reply-To: <20170602130518.22943-1-alex.bennee@linaro.org>
References: <20170602130518.22943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/4] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

This was only used by the gdbstub and even then was only being set for
subsequent threads. Rather the continue duplicating the number just
make the gdbstub get the information from TaskState structure.

Now the tid is correctly reported for all threads the bug I was seeing
with "vCont;C04:0;c" packets is fixed as the correct tid is reported
to gdb.

I moved cpu_gdb_index into the gdbstub to facilitate easy access to
the TaskState which is used elsewhere in gdbstub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

---
v3
  - fix merge, did move of function in previous commit
---
 gdbstub.c            | 3 ++-
 include/qom/cpu.h    | 2 --
 linux-user/syscall.c | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 57befe16e2..45a3a0b16b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -63,7 +63,8 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
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
index 55214ce131..909e7ae994 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -266,7 +266,6 @@ struct qemu_work_item;
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU.
  * @numa_node: NUMA node this CPU is belonging to.
- * @host_tid: Host thread ID.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
@@ -321,7 +320,6 @@ struct CPUState {
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
