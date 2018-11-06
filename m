Received: from eggs.gnu.org ([2001:4830:134:3::10]:43359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0Ld-0002pc-EA
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0Lb-0001kW-Fn
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:45 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gK0Lb-0001im-6d
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:43 -0500
Received: by mail-pf1-x441.google.com with SMTP id e22-v6so6035089pfn.8
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:20:42 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Tue,  6 Nov 2018 20:20:22 +0800
Message-Id: <20181106122025.3487-3-xiaoguangrong@tencent.com>
In-Reply-To: <20181106122025.3487-1-xiaoguangrong@tencent.com>
References: <20181106122025.3487-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

This modules implements the lockless and efficient threaded workqueue.

Three abstracted objects are used in this module:
- Request.
     It not only contains the data that the workqueue fetches out
    to finish the request but also offers the space to save the result
    after the workqueue handles the request.

    It's flowed between user and workqueue. The user fills the request
    data into it when it is owned by user. After it is submitted to the
    workqueue, the workqueue fetched data out and save the result into
    it after the request is handled.

    All the requests are pre-allocated and carefully partitioned between
    threads so there is no contention on the request, that make threads
    be parallel as much as possible.

  - User, i.e, the submitter
    It's the one fills the request and submits it to the workqueue,
    the result will be collected after it is handled by the work queue.

    The user can consecutively submit requests without waiting the previous
    requests been handled.
    It only supports one submitter, you should do serial submission by
    yourself if you want more, e.g, use lock on you side.

  - Workqueue, i.e, thread
    Each workqueue is represented by a running thread that fetches
    the request submitted by the user, do the specified work and save
    the result to the request.

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 include/qemu/threaded-workqueue.h |  94 ++++++++
 util/Makefile.objs                |   1 +
 util/threaded-workqueue.c         | 466 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 561 insertions(+)
 create mode 100644 include/qemu/threaded-workqueue.h
 create mode 100644 util/threaded-workqueue.c

diff --git a/include/qemu/threaded-workqueue.h b/include/qemu/threaded-workqueue.h
new file mode 100644
index 0000000000..d7eb66c8d2
--- /dev/null
+++ b/include/qemu/threaded-workqueue.h
@@ -0,0 +1,94 @@
+/*
+ * Lockless and Efficient Threaded Workqueue Abstraction
+ *
+ * Author:
+ *   Xiao Guangrong <xiaoguangrong@tencent.com>
+ *
+ * Copyright(C) 2018 Tencent Corporation.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QEMU_THREADED_WORKQUEUE_H
+#define QEMU_THREADED_WORKQUEUE_H
+
+#include "qemu/queue.h"
+#include "qemu/thread.h"
+
+/*
+ * This modules implements the lockless and efficient threaded workqueue.
+ *
+ * Three abstracted objects are used in this module:
+ * - Request.
+ *   It not only contains the data that the workqueue fetches out
+ *   to finish the request but also offers the space to save the result
+ *   after the workqueue handles the request.
+ *
+ *   It's flowed between user and workqueue. The user fills the request
+ *   data into it when it is owned by user. After it is submitted to the
+ *   workqueue, the workqueue fetched data out and save the result into
+ *   it after the request is handled.
+ *
+ *   All the requests are pre-allocated and carefully partitioned between
+ *   threads so there is no contention on the request, that make threads
+ *   be parallel as much as possible.
+ *
+ * - User, i.e, the submitter
+ *   It's the one fills the request and submits it to the workqueue,
+ *   the result will be collected after it is handled by the work queue.
+ *
+ *   The user can consecutively submit requests without waiting the previous
+ *   requests been handled.
+ *   It only supports one submitter, you should do serial submission by
+ *   yourself if you want more, e.g, use lock on you side.
+ *
+ * - Workqueue, i.e, thread
+ *   Each workqueue is represented by a running thread that fetches
+ *   the request submitted by the user, do the specified work and save
+ *   the result to the request.
+ */
+
+typedef struct Threads Threads;
+
+struct ThreadedWorkqueueOps {
+    /* return the size of each request */
+    int (*thread_get_request_size)(void);
+
+    /* constructor of the request */
+    int (*thread_request_init)(void *request);
+    /*  destructor of the request */
+    void (*thread_request_uninit)(void *request);
+
+    /* the handler of the request that is called by the thread */
+    void (*thread_request_handler)(void *request);
+    /* called by the user after the request has been handled */
+    void (*thread_request_done)(void *request);
+};
+typedef struct ThreadedWorkqueueOps ThreadedWorkqueueOps;
+
+/* the default number of requests that thread need handle */
+#define DEFAULT_THREAD_REQUEST_NR 4
+
+Threads *threaded_workqueue_create(const char *name, unsigned int threads_nr,
+                                   int thread_request_nr,
+                                   ThreadedWorkqueueOps *ops);
+
+void threaded_workqueue_destroy(Threads *threads);
+
+/*
+ * find a free request where the user can store the data that is needed to
+ * finish the request
+ *
+ * If all requests are used up, return NULL
+ */
+void *threaded_workqueue_get_request(Threads *threads);
+/* submit the request and notify the thread */
+void threaded_workqueue_submit_request(Threads *threads, void *request);
+
+/*
+ * wait all threads to complete the request to make sure there is no
+ * previous request exists.
+ */
+void threaded_workqueue_wait_for_requests(Threads *threads);
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 0820923c18..f26dfe5182 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -50,5 +50,6 @@ util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
 util-obj-y += iova-tree.o
+util-obj-y += threaded-workqueue.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_OPENGL) += drm.o
diff --git a/util/threaded-workqueue.c b/util/threaded-workqueue.c
new file mode 100644
index 0000000000..966479631a
--- /dev/null
+++ b/util/threaded-workqueue.c
@@ -0,0 +1,466 @@
+/*
+ * Lockless and Efficient Threaded Workqueue Abstraction
+ *
+ * Author:
+ *   Xiao Guangrong <xiaoguangrong@tencent.com>
+ *
+ * Copyright(C) 2018 Tencent Corporation.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitmap.h"
+#include "qemu/threaded-workqueue.h"
+
+#define SMP_CACHE_BYTES 64
+#define BITS_ALIGNED_TO_CACHE(_bits_)   \
+    QEMU_ALIGN_UP(_bits_, SMP_CACHE_BYTES * BITS_PER_BYTE)
+
+/*
+ * the request representation which contains the internally used mete data,
+ * it is the header of user-defined data.
+ *
+ * It should be aligned to the nature size of CPU.
+ */
+struct ThreadRequest {
+    /*
+     * the request has been handled by the thread and need the user
+     * to fetch result out.
+     */
+    bool done;
+    /*
+     * the index to Threads::requests.
+     * Save it to the padding space although it can be calculated at runtime.
+     */
+    int index;
+};
+typedef struct ThreadRequest ThreadRequest;
+
+struct ThreadLocal {
+    struct Threads *threads;
+
+    /*
+     * the request region in Threads::requests that the thread
+     * need handle
+     */
+    int start_request_index;
+    int end_request_index;
+
+    /*
+     * the interim bitmap used by the thread to avoid frequent
+     * memory allocation
+     */
+    unsigned long *result_bitmap;
+
+    /* the index of the thread */
+    int self;
+
+    /* thread is useless and needs to exit */
+    bool quit;
+
+    QemuThread thread;
+
+    /* the event used to wake up the thread */
+    QemuEvent ev;
+};
+typedef struct ThreadLocal ThreadLocal;
+
+/*
+ * the main data struct represents multithreads which is shared by
+ * all threads
+ */
+struct Threads {
+    /*
+     * in order to avoid contention, the @requests is partitioned to
+     * @threads_nr pieces, each thread exclusively handles
+     * @thread_request_nr requests in the array.
+     */
+    void *requests;
+
+    /*
+     * the bit in these two bitmaps indicates the index of the ＠requests
+     * respectively. If it's the same, the corresponding request is free
+     * and owned by the user, i.e, where the user fills a request. Otherwise,
+     * it is valid and owned by the thread, i.e, where the thread fetches
+     * the request and write the result.
+     */
+
+    /* after the user fills the request, the bit is flipped. */
+    unsigned long *request_fill_bitmap;
+    /* after handles the request, the thread flips the bit. */
+    unsigned long *request_done_bitmap;
+
+    /*
+     * the interim bitmap used by the user to avoid frequent
+     * memory allocation
+     */
+    unsigned long *result_bitmap;
+
+    /* the request header, ThreadRequest, is contained */
+    unsigned int request_size;
+
+    /* the number of requests that each thread need handle */
+    unsigned int thread_request_nr;
+    unsigned int total_requests;
+
+    unsigned int threads_nr;
+
+    /* the request is pushed to the thread with round-robin manner */
+    unsigned int current_thread_index;
+
+    ThreadedWorkqueueOps *ops;
+
+    const char *name;
+    QemuEvent ev;
+
+    ThreadLocal per_thread_data[0];
+};
+typedef struct Threads Threads;
+
+static ThreadRequest *index_to_request(Threads *threads, int request_index)
+{
+    ThreadRequest *request;
+
+    request = threads->requests + request_index * threads->request_size;
+
+    assert(request->index == request_index);
+    return request;
+}
+
+static int request_to_index(ThreadRequest *request)
+{
+    return request->index;
+}
+
+static int thread_to_first_request_index(Threads *threads, int thread_id)
+{
+    thread_id %= threads->threads_nr;
+    return thread_id * threads->thread_request_nr;
+}
+
+static int request_index_to_thread(Threads *threads, int request_index)
+{
+    return request_index / threads->thread_request_nr;
+}
+
+/*
+ * free request: the request is not used by any thread, however, it might
+ *   contian the result need the user to call thread_request_done()
+ *
+ * valid request: the request contains the request data and it's commited
+ *   to the thread, i,e. it's owned by thread.
+ */
+static unsigned long *get_free_request_bitmap(Threads *threads)
+{
+    bitmap_xor(threads->result_bitmap, threads->request_fill_bitmap,
+               threads->request_done_bitmap, threads->total_requests);
+
+    /*
+     * paired with smp_wmb() in mark_request_free() to make sure that we
+     * read request_done_bitmap before fetch the result out.
+     */
+    smp_rmb();
+
+    return threads->result_bitmap;
+}
+
+static int find_free_request_index(Threads *threads)
+{
+    unsigned long *result_bitmap = get_free_request_bitmap(threads);
+    int index, cur_index;
+
+    cur_index = thread_to_first_request_index(threads,
+                                              threads->current_thread_index);
+
+retry:
+    index = find_next_zero_bit(result_bitmap, threads->total_requests,
+                               cur_index);
+    if (index < threads->total_requests) {
+        return index;
+    }
+
+    /* if we get nothing, start it over. */
+    if (cur_index != 0) {
+        cur_index = 0;
+        goto retry;
+    }
+
+    return -1;
+}
+
+static void mark_request_valid(Threads *threads, int request_index)
+{
+    /*
+     * paired with smp_rmb() in find_first_valid_request_index() to make
+     * sure the request has been filled before the bit is flipped that
+     * will make the request be visible to the thread
+     */
+    smp_wmb();
+
+    change_bit(request_index, threads->request_fill_bitmap);
+}
+
+static int thread_find_first_valid_request_index(ThreadLocal *thread)
+{
+    Threads *threads = thread->threads;
+    int index;
+
+    bitmap_xor(thread->result_bitmap, threads->request_fill_bitmap,
+               threads->request_done_bitmap, threads->total_requests);
+    /*
+     * paired with smp_wmb() in mark_request_valid() to make sure that
+     * we read request_fill_bitmap before fetch the request out.
+     */
+    smp_rmb();
+
+    index = find_next_bit(thread->result_bitmap, threads->total_requests,
+                          thread->start_request_index);
+    return index > thread->end_request_index ? -1 : index;
+}
+
+static void mark_request_free(ThreadLocal *thread, ThreadRequest *request)
+{
+    int index = request_to_index(request);
+
+    /*
+     * smp_wmb() is implied in change_bit_atomic() that is paired with
+     * smp_rmb() in get_free_request_bitmap() to make sure the result
+     * has been saved before the bit is flipped.
+     */
+    change_bit_atomic(index, thread->threads->request_done_bitmap);
+}
+
+/* retry to see if there is available request before actually go to wait. */
+#define BUSY_WAIT_COUNT 1000
+
+static ThreadRequest *
+thread_busy_wait_for_request(ThreadLocal *thread)
+{
+    int index, count = 0;
+
+    for (count = 0; count < BUSY_WAIT_COUNT; count++) {
+        index = thread_find_first_valid_request_index(thread);
+        if (index >= 0) {
+            assert(index >= thread->start_request_index &&
+                   index <= thread->end_request_index);
+            return index_to_request(thread->threads, index);
+        }
+
+        cpu_relax();
+    }
+
+    return NULL;
+}
+
+static void *thread_run(void *opaque)
+{
+    ThreadLocal *self_data = (ThreadLocal *)opaque;
+    Threads *threads = self_data->threads;
+    void (*handler)(void *request) = threads->ops->thread_request_handler;
+    ThreadRequest *request;
+
+    for ( ; !atomic_read(&self_data->quit); ) {
+        qemu_event_reset(&self_data->ev);
+
+        request = thread_busy_wait_for_request(self_data);
+        if (!request) {
+            qemu_event_wait(&self_data->ev);
+            continue;
+        }
+
+        assert(!request->done);
+
+        handler(request + 1);
+        request->done = true;
+        mark_request_free(self_data, request);
+        qemu_event_set(&threads->ev);
+    }
+
+    return NULL;
+}
+
+static void uninit_requests(Threads *threads, int free_nr)
+{
+    ThreadRequest *request;
+    int i;
+
+    for (request = threads->requests, i = 0; i < free_nr; i++) {
+        threads->ops->thread_request_uninit(request + 1);
+        request = (void *)request + threads->request_size;
+    }
+
+    g_free(threads->result_bitmap);
+    g_free(threads->request_fill_bitmap);
+    g_free(threads->request_done_bitmap);
+    g_free(threads->requests);
+}
+
+static int init_requests(Threads *threads)
+{
+    ThreadRequest *request;
+    int aligned_requests, free_nr = 0, ret = -1;
+
+    aligned_requests = BITS_ALIGNED_TO_CACHE(threads->total_requests);
+    threads->request_fill_bitmap = bitmap_new(aligned_requests);
+    threads->request_done_bitmap = bitmap_new(aligned_requests);
+    threads->result_bitmap = bitmap_new(threads->total_requests);
+
+    QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(sizeof(ThreadRequest), sizeof(long)));
+
+    threads->request_size = threads->ops->thread_get_request_size();
+    threads->request_size = QEMU_ALIGN_UP(threads->request_size, sizeof(long));
+    threads->request_size += sizeof(ThreadRequest);
+    threads->requests = g_try_malloc0_n(threads->total_requests,
+                                        threads->request_size);
+    if (!threads->requests) {
+        goto exit;
+    }
+
+    for (request = threads->requests; free_nr < threads->total_requests;
+        free_nr++) {
+        ret = threads->ops->thread_request_init(request + 1);
+        if (ret < 0) {
+            goto exit;
+        }
+
+        request->index = free_nr;
+        request = (void *)request + threads->request_size;
+    }
+
+    return 0;
+
+exit:
+    uninit_requests(threads, free_nr);
+    return ret;
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
+        g_free(thread_local[i].result_bitmap);
+    }
+}
+
+static void init_thread_data(Threads *threads)
+{
+    ThreadLocal *thread_local = threads->per_thread_data;
+    char *name;
+    int start_index, end_index, i;
+
+    for (i = 0; i < threads->threads_nr; i++) {
+        thread_local[i].threads = threads;
+        thread_local[i].self = i;
+
+        start_index = thread_to_first_request_index(threads, i);
+        end_index = start_index + threads->thread_request_nr - 1;
+        thread_local[i].start_request_index = start_index;
+        thread_local[i].end_request_index = end_index;
+
+        thread_local[i].result_bitmap = bitmap_new(threads->total_requests);
+
+        qemu_event_init(&thread_local[i].ev, false);
+
+        name = g_strdup_printf("%s/%d", threads->name, thread_local[i].self);
+        qemu_thread_create(&thread_local[i].thread, name,
+                           thread_run, &thread_local[i], QEMU_THREAD_JOINABLE);
+        g_free(name);
+    }
+}
+
+Threads *threaded_workqueue_create(const char *name, unsigned int threads_nr,
+                               int thread_request_nr, ThreadedWorkqueueOps *ops)
+{
+    Threads *threads;
+
+    threads = g_malloc0(sizeof(*threads) + threads_nr * sizeof(ThreadLocal));
+    threads->name = name;
+    threads->ops = ops;
+
+    threads->threads_nr = threads_nr;
+    threads->thread_request_nr = thread_request_nr;
+
+    threads->total_requests = thread_request_nr * threads_nr;
+    if (init_requests(threads) < 0) {
+        g_free(threads);
+        return NULL;
+    }
+
+    qemu_event_init(&threads->ev, false);
+    init_thread_data(threads);
+    return threads;
+}
+
+void threaded_workqueue_destroy(Threads *threads)
+{
+    uninit_thread_data(threads);
+    uninit_requests(threads, threads->total_requests);
+    qemu_event_destroy(&threads->ev);
+    g_free(threads);
+}
+
+static void request_done(Threads *threads, ThreadRequest *request)
+{
+    if (!request->done) {
+        return;
+    }
+
+    threads->ops->thread_request_done(request + 1);
+    request->done = false;
+}
+
+void *threaded_workqueue_get_request(Threads *threads)
+{
+    ThreadRequest *request;
+    int index;
+
+    index = find_free_request_index(threads);
+    if (index < 0) {
+        return NULL;
+    }
+
+    request = index_to_request(threads, index);
+    request_done(threads, request);
+    return request + 1;
+}
+
+void threaded_workqueue_submit_request(Threads *threads, void *request)
+{
+    ThreadRequest *req = request - sizeof(ThreadRequest);
+    int request_index = request_to_index(req);
+    int thread_index = request_index_to_thread(threads, request_index);
+    ThreadLocal *thread_local = &threads->per_thread_data[thread_index];
+
+    assert(!req->done);
+
+    mark_request_valid(threads, request_index);
+
+    threads->current_thread_index = ++thread_index;
+    qemu_event_set(&thread_local->ev);
+}
+
+void threaded_workqueue_wait_for_requests(Threads *threads)
+{
+    unsigned long *result_bitmap;
+    int index = 0;
+
+retry:
+    qemu_event_reset(&threads->ev);
+    result_bitmap = get_free_request_bitmap(threads);
+    for (; index < threads->total_requests; index++) {
+        if (test_bit(index, result_bitmap)) {
+            qemu_event_wait(&threads->ev);
+            goto retry;
+        };
+
+        request_done(threads, index_to_request(threads, index));
+    }
+}
-- 
2.14.5
