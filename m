Received: from eggs.gnu.org ([2001:4830:134:3::10]:46608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmEB-0007py-0B
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmE8-0001Jx-QH
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:39 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:36248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmE8-0001JI-GO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:36 -0400
Received: by mail-pl0-x234.google.com with SMTP id v24-v6so19393304plo.3
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:36 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:18 +0800
Message-Id: <20180604095520.8563-11-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/12] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Current implementation of compression and decompression are very
hard to be enabled on productions. We noticed that too many wait-wakes
go to kernel space and CPU usages are very low even if the system
is really free

The reasons are:
1) there are two many locks used to do synchronous，there
　　is a global lock and each single thread has its own lock,
　　migration thread and work threads need to go to sleep if
　　these locks are busy

2) migration thread separately submits request to the thread
   however, only one request can be pended, that means, the
   thread has to go to sleep after finishing the request

To make it work better, we introduce a new multithread model,
the user, currently it is the migration thread, submits request
to each thread with round-robin manner, the thread has its own
ring whose capacity is 4 and puts the result to a global ring
which is lockless for multiple producers, the user fetches result
out from the global ring and do remaining operations for the
request, e.g, posting the compressed data out for migration on
the source QEMU

Performance Result:
The test was based on top of the patch:
   ring: introduce lockless ring buffer
that means, previous optimizations are used for both of original case
and applying the new multithread model

We tested live migration on two hosts:
   Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz * 64 + 256G memory
to migration a VM between each other, which has 16 vCPUs and 60G
memory, during the migration, multiple threads are repeatedly writing
the memory in the VM

We used 16 threads on the destination to decompress the data and on the
source, we tried 8 threads and 16 threads to compress the data

--- Before our work ---
migration can not be finished for both 8 threads and 16 threads. The data
is as followings:

Use 8 threads to compress:
- on the source:
	    migration thread   compress-threads
CPU usage       70%          some use 36%, others are very low ~20%
- on the destination:
            main thread        decompress-threads
CPU usage       100%         some use ~40%, other are very low ~2%

Migration status (CAN NOT FINISH):
info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: on events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
Migration status: active
total time: 1019540 milliseconds
expected downtime: 2263 milliseconds
setup: 218 milliseconds
transferred ram: 252419995 kbytes
throughput: 2469.45 mbps
remaining ram: 15611332 kbytes
total ram: 62931784 kbytes
duplicate: 915323 pages
skipped: 0 pages
normal: 59673047 pages
normal bytes: 238692188 kbytes
dirty sync count: 28
page size: 4 kbytes
dirty pages rate: 170551 pages
compression pages: 121309323 pages
compression busy: 60588337
compression busy rate: 0.36
compression reduced size: 484281967178
compression rate: 0.97

Use 16 threads to compress:
- on the source:
	    migration thread   compress-threads
CPU usage       96%          some use 45%, others are very low ~6%
- on the destination:
            main thread        decompress-threads
CPU usage       96%         some use 58%, other are very low ~10%

Migration status (CAN NOT FINISH):
info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: on events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
Migration status: active
total time: 1189221 milliseconds
expected downtime: 6824 milliseconds
setup: 220 milliseconds
transferred ram: 90620052 kbytes
throughput: 840.41 mbps
remaining ram: 3678760 kbytes
total ram: 62931784 kbytes
duplicate: 195893 pages
skipped: 0 pages
normal: 17290715 pages
normal bytes: 69162860 kbytes
dirty sync count: 33
page size: 4 kbytes
dirty pages rate: 175039 pages
compression pages: 186739419 pages
compression busy: 17486568
compression busy rate: 0.09
compression reduced size: 744546683892
compression rate: 0.97

--- After our work ---
Migration can be finished quickly for both 8 threads and 16 threads. The
data is as followings:

Use 8 threads to compress:
- on the source:
	    migration thread   compress-threads
CPU usage       30%               30% (all threads have same CPU usage)
- on the destination:
            main thread        decompress-threads
CPU usage       100%              50% (all threads have same CPU usage)

Migration status (finished in 219467 ms):
info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: on events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
Migration status: completed
total time: 219467 milliseconds
downtime: 115 milliseconds
setup: 222 milliseconds
transferred ram: 88510173 kbytes
throughput: 3303.81 mbps
remaining ram: 0 kbytes
total ram: 62931784 kbytes
duplicate: 2211775 pages
skipped: 0 pages
normal: 21166222 pages
normal bytes: 84664888 kbytes
dirty sync count: 15
page size: 4 kbytes
compression pages: 32045857 pages
compression busy: 23377968
compression busy rate: 0.34
compression reduced size: 127767894329
compression rate: 0.97

Use 16 threads to compress:
- on the source:
	    migration thread   compress-threads
CPU usage       60%               60% (all threads have same CPU usage)
- on the destination:
            main thread        decompress-threads
CPU usage       100%              75% (all threads have same CPU usage)

Migration status (finished in 64118 ms):
info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: on events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
Migration status: completed
total time: 64118 milliseconds
downtime: 29 milliseconds
setup: 223 milliseconds
transferred ram: 13345135 kbytes
throughput: 1705.10 mbps
remaining ram: 0 kbytes
total ram: 62931784 kbytes
duplicate: 574921 pages
skipped: 0 pages
normal: 2570281 pages
normal bytes: 10281124 kbytes
dirty sync count: 9
page size: 4 kbytes
compression pages: 28007024 pages
compression busy: 3145182
compression busy rate: 0.08
compression reduced size: 111829024985
compression rate: 0.97

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/Makefile.objs |   1 +
 migration/threads.c     | 265 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/threads.h     | 116 +++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 migration/threads.c
 create mode 100644 migration/threads.h

diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index c83ec47ba8..bdb61a7983 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-y += qemu-file-channel.o
 common-obj-y += xbzrle.o postcopy-ram.o
 common-obj-y += qjson.o
 common-obj-y += block-dirty-bitmap.o
+common-obj-y += threads.o
 
 common-obj-$(CONFIG_RDMA) += rdma.o
 
diff --git a/migration/threads.c b/migration/threads.c
new file mode 100644
index 0000000000..eecd3229b7
--- /dev/null
+++ b/migration/threads.c
@@ -0,0 +1,265 @@
+#include "threads.h"
+
+/* retry to see if there is avilable request before actually go to wait. */
+#define BUSY_WAIT_COUNT 1000
+
+static void *thread_run(void *opaque)
+{
+    ThreadLocal *self_data = (ThreadLocal *)opaque;
+    Threads *threads = self_data->threads;
+    void (*handler)(ThreadRequest *data) = threads->thread_request_handler;
+    ThreadRequest *request;
+    int count, ret;
+
+    for ( ; !atomic_read(&self_data->quit); ) {
+        qemu_event_reset(&self_data->ev);
+
+        count = 0;
+        while ((request = ring_get(self_data->request_ring)) ||
+            count < BUSY_WAIT_COUNT) {
+             /*
+             * wait some while before go to sleep so that the user
+             * needn't go to kernel space to wake up the consumer
+             * threads.
+             *
+             * That will waste some CPU resource indeed however it
+             * can significantly improve the case that the request
+             * will be available soon.
+             */
+             if (!request) {
+                cpu_relax();
+                count++;
+                continue;
+            }
+            count = 0;
+
+            handler(request);
+
+            do {
+                ret = ring_put(threads->request_done_ring, request);
+                /*
+                 * request_done_ring has enough room to contain all
+                 * requests, however, theoretically, it still can be
+                 * fail if the ring's indexes are overflow that would
+                 * happen if there is more than 2^32 requests are
+                 * handled between two calls of threads_wait_done().
+                 * So we do retry to make the code more robust.
+                 *
+                 * It is unlikely the case for migration as the block's
+                 * memory is unlikely more than 16T (2^32 pages) memory.
+                 */
+                if (ret) {
+                    fprintf(stderr,
+                            "Potential BUG if it is triggered by migration.\n");
+                }
+            } while (ret);
+        }
+
+        qemu_event_wait(&self_data->ev);
+    }
+
+    return NULL;
+}
+
+static void add_free_request(Threads *threads, ThreadRequest *request)
+{
+    QSLIST_INSERT_HEAD(&threads->free_requests, request, node);
+    threads->free_requests_nr++;
+}
+
+static ThreadRequest *get_and_remove_first_free_request(Threads *threads)
+{
+    ThreadRequest *request;
+
+    if (QSLIST_EMPTY(&threads->free_requests)) {
+        return NULL;
+    }
+
+    request = QSLIST_FIRST(&threads->free_requests);
+    QSLIST_REMOVE_HEAD(&threads->free_requests, node);
+    threads->free_requests_nr--;
+    return request;
+}
+
+static void uninit_requests(Threads *threads, int free_nr)
+{
+    ThreadRequest *request;
+
+    /*
+     * all requests should be released to the list if threads are being
+     * destroyed, i,e. should call threads_wait_done() first.
+     */
+    assert(threads->free_requests_nr == free_nr);
+
+    while ((request = get_and_remove_first_free_request(threads))) {
+        threads->thread_request_uninit(request);
+    }
+
+    assert(ring_is_empty(threads->request_done_ring));
+    ring_free(threads->request_done_ring);
+}
+
+static int init_requests(Threads *threads)
+{
+    ThreadRequest *request;
+    unsigned int done_ring_size = pow2roundup32(threads->total_requests);
+    int i, free_nr = 0;
+
+    threads->request_done_ring = ring_alloc(done_ring_size,
+                                            RING_MULTI_PRODUCER);
+
+    QSLIST_INIT(&threads->free_requests);
+    for (i = 0; i < threads->total_requests; i++) {
+        request = threads->thread_request_init();
+        if (!request) {
+            goto cleanup;
+        }
+
+        free_nr++;
+        add_free_request(threads, request);
+    }
+    return 0;
+
+cleanup:
+    uninit_requests(threads, free_nr);
+    return -1;
+}
+
+static void uninit_thread_data(Threads *threads)
+{
+    ThreadLocal *thread_local = threads->per_thread_data;
+    int i;
+
+    for (i = 0; i < threads->threads_nr; i++) {
+        thread_local[i].quit = true;
+        qemu_event_set(&thread_local[i].ev);
+        qemu_thread_join(&thread_local[i].thread);
+        qemu_event_destroy(&thread_local[i].ev);
+        assert(ring_is_empty(thread_local[i].request_ring));
+        ring_free(thread_local[i].request_ring);
+    }
+}
+
+static void init_thread_data(Threads *threads)
+{
+    ThreadLocal *thread_local = threads->per_thread_data;
+    char *name;
+    int i;
+
+    for (i = 0; i < threads->threads_nr; i++) {
+        qemu_event_init(&thread_local[i].ev, false);
+
+        thread_local[i].threads = threads;
+        thread_local[i].self = i;
+        thread_local[i].request_ring = ring_alloc(threads->thread_ring_size, 0);
+        name = g_strdup_printf("%s/%d", threads->name, thread_local[i].self);
+        qemu_thread_create(&thread_local[i].thread, name,
+                           thread_run, &thread_local[i], QEMU_THREAD_JOINABLE);
+        g_free(name);
+    }
+}
+
+/* the size of thread local request ring */
+#define THREAD_REQ_RING_SIZE 4
+
+Threads *threads_create(unsigned int threads_nr, const char *name,
+                        ThreadRequest *(*thread_request_init)(void),
+                        void (*thread_request_uninit)(ThreadRequest *request),
+                        void (*thread_request_handler)(ThreadRequest *request),
+                        void (*thread_request_done)(ThreadRequest *request))
+{
+    Threads *threads;
+    int ret;
+
+    threads = g_malloc0(sizeof(*threads) + threads_nr * sizeof(ThreadLocal));
+    threads->threads_nr = threads_nr;
+    threads->thread_ring_size = THREAD_REQ_RING_SIZE;
+    threads->total_requests = threads->thread_ring_size * threads_nr;
+
+    threads->name = name;
+    threads->thread_request_init = thread_request_init;
+    threads->thread_request_uninit = thread_request_uninit;
+    threads->thread_request_handler = thread_request_handler;
+    threads->thread_request_done = thread_request_done;
+
+    ret = init_requests(threads);
+    if (ret) {
+        g_free(threads);
+        return NULL;
+    }
+
+    init_thread_data(threads);
+    return threads;
+}
+
+void threads_destroy(Threads *threads)
+{
+    uninit_thread_data(threads);
+    uninit_requests(threads, threads->total_requests);
+    g_free(threads);
+}
+
+ThreadRequest *threads_submit_request_prepare(Threads *threads)
+{
+    ThreadRequest *request;
+    unsigned int index;
+
+    index = threads->current_thread_index % threads->threads_nr;
+
+    /* the thread is busy */
+    if (ring_is_full(threads->per_thread_data[index].request_ring)) {
+        return NULL;
+    }
+
+    /* try to get the request from the list */
+    request = get_and_remove_first_free_request(threads);
+    if (request) {
+        goto got_request;
+    }
+
+    /* get the request already been handled by the threads */
+    request = ring_get(threads->request_done_ring);
+    if (request) {
+        threads->thread_request_done(request);
+        goto got_request;
+    }
+    return NULL;
+
+got_request:
+    threads->current_thread_index++;
+    request->thread_index = index;
+    return request;
+}
+
+void threads_submit_request_commit(Threads *threads, ThreadRequest *request)
+{
+    int ret, index = request->thread_index;
+    ThreadLocal *thread_local = &threads->per_thread_data[index];
+
+    ret = ring_put(thread_local->request_ring, request);
+
+    /*
+     * we have detected that the thread's ring is not full in
+     * threads_submit_request_prepare(), there should be free
+     * room in the ring
+     */
+    assert(!ret);
+    /* new request arrived, notify the thread */
+    qemu_event_set(&thread_local->ev);
+}
+
+void threads_wait_done(Threads *threads)
+{
+    ThreadRequest *request;
+
+retry:
+    while ((request = ring_get(threads->request_done_ring))) {
+        threads->thread_request_done(request);
+        add_free_request(threads, request);
+    }
+
+    if (threads->free_requests_nr != threads->total_requests) {
+        cpu_relax();
+        goto retry;
+    }
+}
diff --git a/migration/threads.h b/migration/threads.h
new file mode 100644
index 0000000000..eced913065
--- /dev/null
+++ b/migration/threads.h
@@ -0,0 +1,116 @@
+#ifndef QEMU_MIGRATION_THREAD_H
+#define QEMU_MIGRATION_THREAD_H
+
+/*
+ * Multithreads abstraction
+ *
+ * This is the abstraction layer for multithreads management which is
+ * used to speed up migration.
+ *
+ * Note: currently only one producer is allowed.
+ *
+ * Copyright(C) 2018 Tencent Corporation.
+ *
+ * Author:
+ *   Xiao Guangrong <xiaoguangrong@tencent.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+
+#include "ring.h"
+
+/*
+ * the request representation which contains the internally used mete data,
+ * it can be embedded to user's self-defined data struct and the user can
+ * use container_of() to get the self-defined data
+ */
+struct ThreadRequest {
+    QSLIST_ENTRY(ThreadRequest) node;
+    unsigned int thread_index;
+};
+typedef struct ThreadRequest ThreadRequest;
+
+struct Threads;
+
+struct ThreadLocal {
+    QemuThread thread;
+
+    /* the event used to wake up the thread */
+    QemuEvent ev;
+
+    struct Threads *threads;
+
+    /* local request ring which is filled by the user */
+    Ring *request_ring;
+
+    /* the index of the thread */
+    int self;
+
+    /* thread is useless and needs to exit */
+    bool quit;
+};
+typedef struct ThreadLocal ThreadLocal;
+
+/*
+ * the main data struct represents multithreads which is shared by
+ * all threads
+ */
+struct Threads {
+    const char *name;
+    unsigned int threads_nr;
+    /* the request is pushed to the thread with round-robin manner */
+    unsigned int current_thread_index;
+
+    int thread_ring_size;
+    int total_requests;
+
+    /* the request is pre-allocated and linked in the list */
+    int free_requests_nr;
+    QSLIST_HEAD(, ThreadRequest) free_requests;
+
+    /* the constructor of request */
+    ThreadRequest *(*thread_request_init)(void);
+    /* the destructor of request */
+    void (*thread_request_uninit)(ThreadRequest *request);
+    /* the handler of the request which is called in the thread */
+    void (*thread_request_handler)(ThreadRequest *request);
+    /*
+     * the handler to process the result which is called in the
+     * user's context
+     */
+    void (*thread_request_done)(ThreadRequest *request);
+
+    /* the thread push the result to this ring so it has multiple producers */
+    Ring *request_done_ring;
+
+    ThreadLocal per_thread_data[0];
+};
+typedef struct Threads Threads;
+
+Threads *threads_create(unsigned int threads_nr, const char *name,
+                        ThreadRequest *(*thread_request_init)(void),
+                        void (*thread_request_uninit)(ThreadRequest *request),
+                        void (*thread_request_handler)(ThreadRequest *request),
+                        void (*thread_request_done)(ThreadRequest *request));
+void threads_destroy(Threads *threads);
+
+/*
+ * find a free request and associate it with a free thread.
+ * If no request or no thread is free, return NULL
+ */
+ThreadRequest *threads_submit_request_prepare(Threads *threads);
+/*
+ * push the request to its thread's local ring and notify the thread
+ */
+void threads_submit_request_commit(Threads *threads, ThreadRequest *request);
+
+/*
+ * wait all threads to complete the request filled in their local rings
+ * to make sure there is no previous request exists.
+ */
+void threads_wait_done(Threads *threads);
+#endif
-- 
2.14.4
