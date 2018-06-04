Received: from eggs.gnu.org ([2001:4830:134:3::10]:46456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDh-0007QS-9u
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDc-00012v-Sf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:09 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:45712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDc-00012Z-JP
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:04 -0400
Received: by mail-pf0-x22f.google.com with SMTP id a22-v6so2533005pfo.12
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:04 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:08 +0800
Message-Id: <20180604095520.8563-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/12] migration: improve multithreads for
 compression and decompression
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

Background
----------
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

Our Ideas
---------
To make it work better, we introduce a new multithread model,
the user, currently it is the migration thread, submits request
to each thread with round-robin manner, the thread has its own
ring whose capacity is 4 and puts the result to a global ring
which is lockless for multiple producers, the user fetches result
out from the global ring and do remaining operations for the
request, e.g, posting the compressed data out for migration on
the source QEMU

Other works in this patchset is offering some statistics to see
if compression works as we expected and making the migration thread
work fast so it can feed more requests to the threads

Implementation of the Ring
--------------------------
The key component is the ring which supports both single producer
vs. single consumer and multiple producers vs. single consumer

Many lessons were learned from Linux Kernel's kfifo (1) and DPDK's
rte_ring (2) before i wrote this implementation. It corrects some
bugs of memory barriers in kfifo and it is the simpler lockless
version of rte_ring as currently multiple access is only allowed
for producer.

If has single producer vs. single consumer, it is the traditional
fifo. If has multiple producers, it uses the algorithm as followings:

For the producer, it uses two steps to update the ring:
   - first step, occupy the entry in the ring:

retry:
      in = ring->in
      if (cmpxhg(&ring->in, in, in +1) != in)
            goto retry;

     after that the entry pointed by ring->data[in] has been owned by
     the producer.

     assert(ring->data[in] == NULL);

     Note, no other producer can touch this entry so that this entry
     should always be the initialized state.

   - second step, write the data to the entry:

     ring->data[in] = data;

For the consumer, it first checks if there is available entry in the
ring and fetches the entry from the ring:

     if (!ring_is_empty(ring))
          entry = &ring[ring->out];

     Note: the ring->out has not been updated so that the entry pointed
     by ring->out is completely owned by the consumer.

Then it checks if the data is ready:

retry:
     if (*entry == NULL)
            goto retry;
That means, the producer has updated the index but haven't written any
data to it.

Finally, it fetches the valid data out, set the entry to the initialized
state and update ring->out to make the entry be usable to the producer:

      data = *entry;
      *entry = NULL;
      ring->out++;

Memory barrier is omitted here, please refer to the comment in the code

Performance Result
-----------------
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


(1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
(2) http://dpdk.org/doc/api/rte__ring_8h.html 

Xiao Guangrong (12):
  migration: do not wait if no free thread
  migration: fix counting normal page for compression
  migration: fix counting xbzrle cache_miss_rate
  migration: introduce migration_update_rates
  migration: show the statistics of compression
  migration: do not detect zero page for compression
  migration: hold the lock only if it is really needed
  migration: do not flush_compressed_data at the end of each iteration
  ring: introduce lockless ring buffer
  migration: introduce lockless multithreads model
  migration: use lockless Multithread model for compression
  migration: use lockless Multithread model for decompression

 hmp.c                   |  13 +
 include/qemu/queue.h    |   1 +
 migration/Makefile.objs |   1 +
 migration/migration.c   |  11 +
 migration/ram.c         | 898 ++++++++++++++++++++++--------------------------
 migration/ram.h         |   1 +
 migration/ring.h        | 265 ++++++++++++++
 migration/threads.c     | 265 ++++++++++++++
 migration/threads.h     | 116 +++++++
 qapi/migration.json     |  25 +-
 10 files changed, 1109 insertions(+), 487 deletions(-)
 create mode 100644 migration/ring.h
 create mode 100644 migration/threads.c
 create mode 100644 migration/threads.h

-- 
2.14.4
