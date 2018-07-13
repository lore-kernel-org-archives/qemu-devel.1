Received: from eggs.gnu.org ([2001:4830:134:3::10]:32840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1fdsoo-0007FY-WC
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1fdsol-0002RC-S6
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:48:47 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <felix.yzg@gmail.com>) id 1fdsol-0002Om-JI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:48:43 -0400
Received: by mail-pf0-x244.google.com with SMTP id b17-v6so22181516pfi.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 00:48:43 -0700 (PDT)
From: FelixYao <felix.yzg@gmail.com>
Date: Fri, 13 Jul 2018 15:48:27 +0800
Message-Id: <1531468107-1579-1-git-send-email-felix.yzg@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] util/thread-pool: add parameter to limit
 maximum threads in thread pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com
Cc: yaozhenguo@jd.com, qemu-devel@nongnu.org, FelixYao <felix.yzg@gmail.com>

Hi all:

Max threads in thread pool is fixed at 64 before which is not
propriate in some situations. For public cloud environment,
there are lots of VMs in one host machine. We should limit the worker thread
numbers for each machine alone based on its ability to prevent impacting
each other. Although we can use iotune to limit bandwidth or IOPS of block
device. That is not enough. Lots of worker threads still impact other VMs.
I think the ability to limit maximum threads in thread pool is necessary.

What's your opinion about this patch? please review it.

Signed-off-by: FelixYao <felix.yzg@gmail.com>
---
 include/block/thread-pool.h |  1 +
 qemu-options.hx             | 11 +++++++++++
 util/thread-pool.c          |  3 ++-
 vl.c                        | 31 +++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 7dd7d73..2634339 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -23,6 +23,7 @@
 typedef int ThreadPoolFunc(void *opaque);
 
 typedef struct ThreadPool ThreadPool;
+extern int max_threads;
 
 ThreadPool *thread_pool_new(struct AioContext *ctx);
 void thread_pool_free(ThreadPool *pool);
diff --git a/qemu-options.hx b/qemu-options.hx
index 16208f6..e7337f6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3948,6 +3948,17 @@ STEXI
 prepend a timestamp to each log message.(default:on)
 ETEXI
 
+DEF("thread-pool", HAS_ARG, QEMU_OPTION_threadpool,
+    "-thread-pool max-threads=[n]\n"
+    "                limit maximum threads in thread pool \n"
+    "                when block device using aio=threads parameter\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -thread-pool max-threads=[n]
+@findex -thread-pool
+limit maximum threads in thread pool.(default:64)
+ETEXI
+
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
     "-dump-vmstate <file>\n"
     "                Output vmstate information in JSON format to file.\n"
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d..debad3c 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -26,6 +26,7 @@
 static void do_spawn_thread(ThreadPool *pool);
 
 typedef struct ThreadPoolElement ThreadPoolElement;
+int max_threads = 64;
 
 enum ThreadState {
     THREAD_QUEUED,
@@ -308,7 +309,7 @@ static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
     qemu_mutex_init(&pool->lock);
     qemu_cond_init(&pool->worker_stopped);
     qemu_sem_init(&pool->sem, 0);
-    pool->max_threads = 64;
+    pool->max_threads = max_threads;
     pool->new_thread_bh = aio_bh_new(ctx, spawn_thread_bh_fn, pool);
 
     QLIST_INIT(&pool->head);
diff --git a/vl.c b/vl.c
index 16b913f..3f40424 100644
--- a/vl.c
+++ b/vl.c
@@ -82,6 +82,7 @@ int main(int argc, char **argv)
 #include "qemu/log.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
+#include "block/thread-pool.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "migration/global_state.h"
@@ -540,6 +541,22 @@ static QemuOptsList qemu_fw_cfg_opts = {
     },
 };
 
+static QemuOptsList qemu_thread_pool_opts = {
+    .name = "thread-pool",
+    .implied_opt_name = "max-threads",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_thread_pool_opts.head),
+    .desc = {
+        {
+            .name = "max-threads",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit maximum threads in thread pool \n"
+		    "when block device using aio=threads parameter",
+            .def_value_str = "64",
+        },
+        { /* end of list */ }
+    },
+};
+
 /**
  * Get machine options
  *
@@ -2993,6 +3010,8 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
+    qemu_add_opts(&qemu_thread_pool_opts);
+
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
@@ -3947,6 +3966,18 @@ int main(int argc, char **argv, char **envp)
                 }
                 configure_msg(opts);
                 break;
+            case QEMU_OPTION_threadpool:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("thread-pool"),
+                                               optarg, false);
+                if (!opts) {
+                    exit(1);
+                }
+                max_threads = qemu_opt_get_number(opts, "max-threads", 0);
+                if (max_threads <= 0) {
+                    error_report("max-threads is invalid");
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_dump_vmstate:
                 if (vmstate_dump_file) {
                     error_report("only one '-dump-vmstate' "
-- 
1.8.3.1
