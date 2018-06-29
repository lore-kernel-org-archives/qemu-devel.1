Received: from eggs.gnu.org ([2001:4830:134:3::10]:34053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYt8t-0000vp-Kr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYt8q-0007Fy-D0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:08:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fYt8q-0007Er-5h
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:08:48 -0400
Date: Fri, 29 Jun 2018 16:08:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180629160249-mutt-send-email-mst@kernel.org>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620152407-mutt-send-email-mst@kernel.org>
	<a90a7cd1-3362-fdd6-0caa-148fd5d3acff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90a7cd1-3362-fdd6-0caa-148fd5d3acff@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Fri, Jun 29, 2018 at 03:30:44PM +0800, Xiao Guangrong wrote:
> 
> Hi Michael,
> 
> On 06/20/2018 08:38 PM, Michael S. Tsirkin wrote:
> > On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> > > 
> > > 
> > > (1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
> > > (2) http://dpdk.org/doc/api/rte__ring_8h.html
> > > 
> > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > 
> > So instead of all this super-optimized trickiness, how about
> > a simple port of ptr_ring from linux?
> > 
> > That one isn't lockless but it's known to outperform
> > most others for a single producer/single consumer case.
> > And with a ton of networking going on,
> > who said it's such a hot spot? OTOH this implementation
> > has more barriers which slows down each individual thread.
> > It's also a source of bugs.
> > 
> 
> Thank you for pointing it out.
> 
> I just quickly went through the code of ptr_ring that is very nice and
> really impressive. I will consider to port it to QEMU.

The port is pretty trivial. See below. It's a SPSC structure though.  So
you need to use it with lock.  Given the critical section is small, I
put in QmueSpin, not a mutex.  To reduce cost of locks, it helps if you
can use the batches API to consume. I assume producers can't batch
but if they can, we should add an API for that, will help too.


---

qemu/ptr_ring.h: straight port from Linux 4.17

Port done by author.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/include/qemu/ptr_ring.h b/include/qemu/ptr_ring.h
new file mode 100644
index 0000000000..f7446678de
--- /dev/null
+++ b/include/qemu/ptr_ring.h
@@ -0,0 +1,464 @@
+/*
+ *	Definitions for the 'struct ptr_ring' datastructure.
+ *
+ *	Author:
+ *		Michael S. Tsirkin <mst@redhat.com>
+ *
+ *	Copyright (C) 2016 Red Hat, Inc.
+ *
+ *	This program is free software; you can redistribute it and/or modify it
+ *	under the terms of the GNU General Public License as published by the
+ *	Free Software Foundation; either version 2 of the License, or (at your
+ *	option) any later version.
+ *
+ *	This is a limited-size FIFO maintaining pointers in FIFO order, with
+ *	one CPU producing entries and another consuming entries from a FIFO.
+ *
+ *	This implementation tries to minimize cache-contention when there is a
+ *	single producer and a single consumer CPU.
+ */
+
+#ifndef QEMU_PTR_RING_H
+#define QEMU_PTR_RING_H 1
+
+#include "qemu/thread.h"
+
+#define PTR_RING_CACHE_BYTES 64
+#define PTR_RING_CACHE_ALIGNED __attribute__((__aligned__(PTR_RING_CACHE_BYTES)))
+#define PTR_RING_WRITE_ONCE(p, v) (*(volatile typeof(&(p)))(&(p)) = (v))
+#define PTR_RING_READ_ONCE(p) (*(volatile typeof(&(p)))(&(p)))
+
+struct ptr_ring {
+	int producer PTR_RING_CACHE_ALIGNED;
+	QemuSpin producer_lock;
+	int consumer_head PTR_RING_CACHE_ALIGNED; /* next valid entry */
+	int consumer_tail; /* next entry to invalidate */
+	QemuSpin consumer_lock;
+	/* Shared consumer/producer data */
+	/* Read-only by both the producer and the consumer */
+	int size PTR_RING_CACHE_ALIGNED; /* max entries in queue */
+	int batch; /* number of entries to consume in a batch */
+	void **queue;
+};
+
+/* Note: callers invoking this in a loop must use a compiler barrier,
+ * for example cpu_relax().
+ *
+ * NB: this is unlike __ptr_ring_empty in that callers must hold producer_lock:
+ * see e.g. ptr_ring_full.
+ */
+static inline bool __ptr_ring_full(struct ptr_ring *r)
+{
+	return r->queue[r->producer];
+}
+
+static inline bool ptr_ring_full(struct ptr_ring *r)
+{
+	bool ret;
+
+	qemu_spin_lock(&r->producer_lock);
+	ret = __ptr_ring_full(r);
+	qemu_spin_unlock(&r->producer_lock);
+
+	return ret;
+}
+
+/* Note: callers invoking this in a loop must use a compiler barrier,
+ * for example cpu_relax(). Callers must hold producer_lock.
+ * Callers are responsible for making sure pointer that is being queued
+ * points to a valid data.
+ */
+static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
+{
+	if (unlikely(!r->size) || r->queue[r->producer])
+		return -ENOSPC;
+
+	/* Make sure the pointer we are storing points to a valid data. */
+	/* Pairs with smp_read_barrier_depends in __ptr_ring_consume. */
+	smp_wmb();
+
+	PTR_RING_WRITE_ONCE(r->queue[r->producer++], ptr);
+	if (unlikely(r->producer >= r->size))
+		r->producer = 0;
+	return 0;
+}
+
+/*
+ * Note: resize (below) nests producer lock within consumer lock, so if you
+ * consume in interrupt or BH context, you must disable interrupts/BH when
+ * calling this.
+ */
+static inline int ptr_ring_produce(struct ptr_ring *r, void *ptr)
+{
+	int ret;
+
+	qemu_spin_lock(&r->producer_lock);
+	ret = __ptr_ring_produce(r, ptr);
+	qemu_spin_unlock(&r->producer_lock);
+
+	return ret;
+}
+
+static inline void *__ptr_ring_peek(struct ptr_ring *r)
+{
+	if (likely(r->size))
+		return PTR_RING_READ_ONCE(r->queue[r->consumer_head]);
+	return NULL;
+}
+
+/*
+ * Test ring empty status without taking any locks.
+ *
+ * NB: This is only safe to call if ring is never resized.
+ *
+ * However, if some other CPU consumes ring entries at the same time, the value
+ * returned is not guaranteed to be correct.
+ *
+ * In this case - to avoid incorrectly detecting the ring
+ * as empty - the CPU consuming the ring entries is responsible
+ * for either consuming all ring entries until the ring is empty,
+ * or synchronizing with some other CPU and causing it to
+ * re-test __ptr_ring_empty and/or consume the ring enteries
+ * after the synchronization point.
+ *
+ * Note: callers invoking this in a loop must use a compiler barrier,
+ * for example cpu_relax().
+ */
+static inline bool __ptr_ring_empty(struct ptr_ring *r)
+{
+	if (likely(r->size))
+		return !r->queue[PTR_RING_READ_ONCE(r->consumer_head)];
+	return true;
+}
+
+static inline bool ptr_ring_empty(struct ptr_ring *r)
+{
+	bool ret;
+
+	qemu_spin_lock(&r->consumer_lock);
+	ret = __ptr_ring_empty(r);
+	qemu_spin_unlock(&r->consumer_lock);
+
+	return ret;
+}
+
+/* Must only be called after __ptr_ring_peek returned !NULL */
+static inline void __ptr_ring_discard_one(struct ptr_ring *r)
+{
+	/* Fundamentally, what we want to do is update consumer
+	 * index and zero out the entry so producer can reuse it.
+	 * Doing it naively at each consume would be as simple as:
+	 *       consumer = r->consumer;
+	 *       r->queue[consumer++] = NULL;
+	 *       if (unlikely(consumer >= r->size))
+	 *               consumer = 0;
+	 *       r->consumer = consumer;
+	 * but that is suboptimal when the ring is full as producer is writing
+	 * out new entries in the same cache line.  Defer these updates until a
+	 * batch of entries has been consumed.
+	 */
+	/* Note: we must keep consumer_head valid at all times for __ptr_ring_empty
+	 * to work correctly.
+	 */
+	int consumer_head = r->consumer_head;
+	int head = consumer_head++;
+
+	/* Once we have processed enough entries invalidate them in
+	 * the ring all at once so producer can reuse their space in the ring.
+	 * We also do this when we reach end of the ring - not mandatory
+	 * but helps keep the implementation simple.
+	 */
+	if (unlikely(consumer_head - r->consumer_tail >= r->batch ||
+		     consumer_head >= r->size)) {
+		/* Zero out entries in the reverse order: this way we touch the
+		 * cache line that producer might currently be reading the last;
+		 * producer won't make progress and touch other cache lines
+		 * besides the first one until we write out all entries.
+		 */
+		while (likely(head >= r->consumer_tail))
+			r->queue[head--] = NULL;
+		r->consumer_tail = consumer_head;
+	}
+	if (unlikely(consumer_head >= r->size)) {
+		consumer_head = 0;
+		r->consumer_tail = 0;
+	}
+	/* matching READ_ONCE in __ptr_ring_empty for lockless tests */
+	PTR_RING_WRITE_ONCE(r->consumer_head, consumer_head);
+}
+
+static inline void *__ptr_ring_consume(struct ptr_ring *r)
+{
+	void *ptr;
+
+	/* The READ_ONCE in __ptr_ring_peek guarantees that anyone
+	 * accessing data through the pointer is up to date. Pairs
+	 * with smp_wmb in __ptr_ring_produce.
+	 */
+	ptr = __ptr_ring_peek(r);
+	if (ptr)
+		__ptr_ring_discard_one(r);
+
+	return ptr;
+}
+
+static inline int __ptr_ring_consume_batched(struct ptr_ring *r,
+					     void **array, int n)
+{
+	void *ptr;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		ptr = __ptr_ring_consume(r);
+		if (!ptr)
+			break;
+		array[i] = ptr;
+	}
+
+	return i;
+}
+
+/*
+ * Note: resize (below) nests producer lock within consumer lock, so if you
+ * call this in interrupt or BH context, you must disable interrupts/BH when
+ * producing.
+ */
+static inline void *ptr_ring_consume(struct ptr_ring *r)
+{
+	void *ptr;
+
+	qemu_spin_lock(&r->consumer_lock);
+	ptr = __ptr_ring_consume(r);
+	qemu_spin_unlock(&r->consumer_lock);
+
+	return ptr;
+}
+
+static inline int ptr_ring_consume_batched(struct ptr_ring *r,
+					   void **array, int n)
+{
+	int ret;
+
+	qemu_spin_lock(&r->consumer_lock);
+	ret = __ptr_ring_consume_batched(r, array, n);
+	qemu_spin_unlock(&r->consumer_lock);
+
+	return ret;
+}
+
+/* Cast to structure type and call a function without discarding from FIFO.
+ * Function must return a value.
+ * Callers must take consumer_lock.
+ */
+#define __PTR_RING_PEEK_CALL(r, f) ((f)(__ptr_ring_peek(r)))
+
+#define PTR_RING_PEEK_CALL(r, f) ({ \
+	typeof((f)(NULL)) __PTR_RING_PEEK_CALL_v; \
+	\
+	qemu_spin_lock(&(r)->consumer_lock); \
+	__PTR_RING_PEEK_CALL_v = __PTR_RING_PEEK_CALL(r, f); \
+	qemu_spin_unlock(&(r)->consumer_lock); \
+	__PTR_RING_PEEK_CALL_v; \
+})
+
+static inline void **__ptr_ring_init_queue_alloc(unsigned int size)
+{
+	return g_try_new(void *, size);
+}
+
+static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
+{
+	r->size = size;
+	r->batch = PTR_RING_CACHE_BYTES * 2 / sizeof(*(r->queue));
+	/* We need to set batch at least to 1 to make logic
+	 * in __ptr_ring_discard_one work correctly.
+	 * Batching too much (because ring is small) would cause a lot of
+	 * burstiness. Needs tuning, for now disable batching.
+	 */
+	if (r->batch > r->size / 2 || !r->batch)
+		r->batch = 1;
+}
+
+static inline int ptr_ring_init(struct ptr_ring *r, int size)
+{
+	r->queue = __ptr_ring_init_queue_alloc(size);
+	if (!r->queue)
+		return -ENOMEM;
+
+	__ptr_ring_set_size(r, size);
+	r->producer = r->consumer_head = r->consumer_tail = 0;
+	qemu_spin_init(&r->producer_lock);
+	qemu_spin_init(&r->consumer_lock);
+
+	return 0;
+}
+
+/*
+ * Return entries into ring. Destroy entries that don't fit.
+ *
+ * Note: this is expected to be a rare slow path operation.
+ *
+ * Note: producer lock is nested within consumer lock, so if you
+ * resize you must make sure all uses nest correctly.
+ * In particular if you consume ring in interrupt or BH context, you must
+ * disable interrupts/BH when doing so.
+ */
+static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
+				      void (*destroy)(void *))
+{
+	int head;
+
+	qemu_spin_lock(&r->consumer_lock);
+	qemu_spin_lock(&r->producer_lock);
+
+	if (!r->size)
+		goto done;
+
+	/*
+	 * Clean out buffered entries (for simplicity). This way following code
+	 * can test entries for NULL and if not assume they are valid.
+	 */
+	head = r->consumer_head - 1;
+	while (likely(head >= r->consumer_tail))
+		r->queue[head--] = NULL;
+	r->consumer_tail = r->consumer_head;
+
+	/*
+	 * Go over entries in batch, start moving head back and copy entries.
+	 * Stop when we run into previously unconsumed entries.
+	 */
+	while (n) {
+		head = r->consumer_head - 1;
+		if (head < 0)
+			head = r->size - 1;
+		if (r->queue[head]) {
+			/* This batch entry will have to be destroyed. */
+			goto done;
+		}
+		r->queue[head] = batch[--n];
+		r->consumer_tail = head;
+		/* matching READ_ONCE in __ptr_ring_empty for lockless tests */
+		PTR_RING_WRITE_ONCE(r->consumer_head, head);
+	}
+
+done:
+	/* Destroy all entries left in the batch. */
+	while (n)
+		destroy(batch[--n]);
+	qemu_spin_unlock(&r->producer_lock);
+	qemu_spin_unlock(&r->consumer_lock);
+}
+
+static inline void **__ptr_ring_swap_queue(struct ptr_ring *r, void **queue,
+						    int size,
+						    void (*destroy)(void *))
+{
+	int producer = 0;
+	void **old;
+	void *ptr;
+
+	while ((ptr = __ptr_ring_consume(r)))
+		if (producer < size)
+			queue[producer++] = ptr;
+		else if (destroy)
+			destroy(ptr);
+
+	__ptr_ring_set_size(r, size);
+	r->producer = producer;
+	r->consumer_head = 0;
+	r->consumer_tail = 0;
+	old = r->queue;
+	r->queue = queue;
+
+	return old;
+}
+
+/*
+ * Note: producer lock is nested within consumer lock, so if you
+ * resize you must make sure all uses nest correctly.
+ * In particular if you consume ring in interrupt or BH context, you must
+ * disable interrupts/BH when doing so.
+ */
+static inline int ptr_ring_resize(struct ptr_ring *r, int size,
+				  void (*destroy)(void *))
+{
+	void **queue = __ptr_ring_init_queue_alloc(size);
+	void **old;
+
+	if (!queue)
+		return -ENOMEM;
+
+	qemu_spin_lock(&(r)->consumer_lock);
+	qemu_spin_lock(&(r)->producer_lock);
+
+	old = __ptr_ring_swap_queue(r, queue, size, destroy);
+
+	qemu_spin_unlock(&(r)->producer_lock);
+	qemu_spin_unlock(&(r)->consumer_lock);
+
+	g_free(old);
+
+	return 0;
+}
+
+/*
+ * Note: producer lock is nested within consumer lock, so if you
+ * resize you must make sure all uses nest correctly.
+ * In particular if you consume ring in interrupt or BH context, you must
+ * disable interrupts/BH when doing so.
+ */
+static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
+					   unsigned int nrings,
+					   int size,
+					   void (*destroy)(void *))
+{
+	void ***queues;
+	int i;
+
+	queues = g_try_new(void **, nrings);
+	if (!queues)
+		goto noqueues;
+
+	for (i = 0; i < nrings; ++i) {
+		queues[i] = __ptr_ring_init_queue_alloc(size);
+		if (!queues[i])
+			goto nomem;
+	}
+
+	for (i = 0; i < nrings; ++i) {
+		qemu_spin_lock(&(rings[i])->consumer_lock);
+		qemu_spin_lock(&(rings[i])->producer_lock);
+		queues[i] = __ptr_ring_swap_queue(rings[i], queues[i],
+						  size, destroy);
+		qemu_spin_unlock(&(rings[i])->producer_lock);
+		qemu_spin_unlock(&(rings[i])->consumer_lock);
+	}
+
+	for (i = 0; i < nrings; ++i)
+		g_free(queues[i]);
+
+	g_free(queues);
+
+	return 0;
+
+nomem:
+	while (--i >= 0)
+		g_free(queues[i]);
+
+	g_free(queues);
+
+noqueues:
+	return -ENOMEM;
+}
+
+static inline void ptr_ring_cleanup(struct ptr_ring *r, void (*destroy)(void *))
+{
+	void *ptr;
+
+	if (destroy)
+		while ((ptr = ptr_ring_consume(r)))
+			destroy(ptr);
+	g_free(r->queue);
+}
+
+#endif /* _LINUX_PTR_RING_H  */
