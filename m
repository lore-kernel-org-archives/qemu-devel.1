Received: from eggs.gnu.org ([2001:4830:134:3::10]:55013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cWQmj-0000uC-8p
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cWQmh-00059A-M3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:51:01 -0500
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <64f835ae-0bad-ab2a-f5b4-74ece4499b23@openvz.org>
Date: Wed, 25 Jan 2017 19:50:45 +0300
MIME-Version: 1.0
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/18] I/O prefetch cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com

On 12/30/2016 05:31 PM, Pavel Butsykin wrote:
> The prefetch cache aims to improve the performance of sequential read data.
> Of most interest here are the requests of a small size of data for sequential
> read, such requests can be optimized by extending them and moving into 
> the prefetch cache. However, there are 2 issues:
>  - In aggregate only a small portion of requests is sequential, so delays caused
>    by the need to read more volumes of data will lead to an overall decrease
>    in performance.
>  - The presence of redundant data in the cache memory with a large number of
>    random requests.
> This pcache implementation solves the above and other problems prefetching data.
> The pcache algorithm can be summarised by the following main steps.
>
> 1. Monitor I/O requests to identify typical sequences.
> This implementation of prefetch cache works at the storage system level and has 
> information only about the physical block addresses of I/O requests. Statistics 
> are collected only from read requests to a maximum size of 64kb(by default),
> each request that matches the criteria falls into a pool of requests. In order
> to store request statistics used by the rb-tree, it's simple but for
> this issue a quite efficient data structure.
>
> 2. Identifying sequential I/O streams.
> For each read request to be carried out attempting to lift the chain sequence 
> from the tree statistics, where this request will be element of a sequential
> chain of requests. The key to search for consecutive requests is the area of bytes 
> preceding the current request. The size of this area should not be too small to 
> avoid false readahead. The sequential stream data requests can be identified
> even when a large number of random requests. For example, if there is access to 
> the blocks 100, 1157, 27520, 4, 101, 312, 1337, 102, in the context of request
> processing 102 will be identified the chain of sequential requests 100, 101. 102
> and then should a decision be made to do readahead. Also a situation may arise
> when multiple applications A, B, C simultaneously perform sequential read of
> data. For each separate application that will be sequential read data 
> A(100, 101, 102), B(300, 301, 302), C(700, 701, 702), but for block devices it 
> may look like a random data reading: 100,300,700,101,301,701,102,302,702. 
> In this case, the sequential streams will also be recognised because location
> requests in the rb-tree will allow to separate the sequential I/O streams.
>
> 3. Do the readahead into the cache for recognized sequential data streams.
> After the issue of the detection of pcache case was resolved, need using larger 
> requests to bring data into the cache. In this implementation the pcache used
> readahead instead of the extension request, therefore the request goes as is. 
> There is not any reason to put data in the cache that will never be picked up, 
> but this will always happen in the case of extension requests. In order to store
> areas of cached blocks is also used the rb-tree, it's simple but for this issue
> a quite efficient data structure.
>
> 4. Control size of the prefetch cache pool and the requests statistic pool
> For control the border of the pool statistic of requests, the data of requests 
> are placed and replaced according to the FIFO principle, everything is simple.
> For control the boundaries of the memory cache used LRU list, it allows to limit
> the max amount memory that we can allocate for pcache. But the LRU is there
> mainly to prevent displacement of the cache blocks that was read partially. 
> The main way the memory is pushed out immediately after use, as soon as a chunk
> of memory from the cache has been completely read, since the probability of
> repetition of the request is very low. Cases when one and the same portion of
> the cache memory has been read several times are not optimized and do not apply
> to the cases that can optimize the pcache. Thus, using a cache memory of small
> volume, by the optimization of the operations read-ahead and clear memory, we
> can read entire volumes of data, providing a 100% cache hit. Also does not
> decrease the effectiveness of random read requests.
>
> PCache is implemented as a qemu block filter driver, has some configurable
> parameters, such as: total cache size, statistics size, readahead size,
> maximum size of block that can be processed.
>
> For performance evaluation has been used several test cases with different
> sequential and random read data on SSD disk. Here are the results of tests and
> qemu parameters:
>
> qemu parameters: 
> -machine pc,accel=kvm,usb=off,vmport=off -m 1024 -smp 8
> -drive file=/img/harddisk.hdd,if=none,cache=none,id=drive-scsi0-0-0-0,aio=native
> -drive driver=pcache,image=drive-scsi0-0-0-0,if=virtio
>
> *****************************************************************
> * Testcase                        * Results in iops             *
> *                                 *******************************
> *                                 *  clean qemu  *    pcache    *
> *****************************************************************
> * Create/open 16 file(s) of total * 21645 req/s  * 74793 req/s  *
> * size 2048.00 MB named           * 20385 req/s  * 66481 req/s  *
> * /tmp/tmp.tmp, start 4 thread(s) * 20616 req/s  * 69007 req/s  *
> * and do uncached sequential read *              *              *
> * by 4KB blocks                   *              *              *
> *****************************************************************
> * Create/open 16 file(s) of total * 84033 req/s  * 87828 req/s  *
> * size 2048.00 MB named           * 84602 req/s  * 89678 req/s  *
> * /tmp/tmp.tmp, start 4 thread(s) * 83163 req/s  * 96202 req/s  *
> * and do uncached sequential read *              *              *
> * by 4KB blocks with constant     *              *              *
> * queue len 32                    *              *              *
> *****************************************************************
> * Create/open 16 file(s) of total * 14104 req/s  * 14164 req/s  *
> * size 2048.00 MB named           * 14130 req/s  * 14232 req/s  *
> * /tmp/tmp.tmp, start 4 thread(s) * 14183 req/s  * 14080 req/s  *
> * and do uncached random read by  *              *              *
> * 4KB blocks                      *              *              *
> *****************************************************************
> * Create/open 16 file(s) of total * 23480 req/s  * 23483 req/s  *
> * size 2048.00 MB named           * 23070 req/s  * 22432 req/s  *
> * /tmp/tmp.tmp, start 4 thread(s) * 24090 req/s  * 23499 req/s  *
> * and do uncached random read by  *              *              *
> * 4KB blocks with constant queue  *              *              *
> * len 32                          *              *              *
> *****************************************************************
>
> Changes from v1:
> - avoid bdrv_aio_*() interfaces
> - add pcache to the QAPI schema
> - fix remarks and add more comments for rbcache
> - add more scenarios for "/rbcache/insert" test
> - fix rbcache/shrink/* tests
> - pcache: up-to-date cache for removed nodes
> - rewrite "block/pcache: pick up parts of the cache" patch
> - changed the statuses of nodes for a more flexible determination of
>   the node state
>
> Pavel Butsykin (18):
>   block/pcache: empty pcache driver filter
>   util/rbtree: add rbtree from linux kernel
>   util/rbcache: range-based cache core
>   tests/test-rbcache: add test cases
>   block/pcache: statistics collection read requests
>   block/pcache: skip large aio read
>   block/pcache: updating statistics for overlapping requests
>   block/pcache: add AIO readahead
>   block/pcache: skip readahead for unallocated clusters
>   block/pcache: cache invalidation on write requests
>   block/pcache: add reading data from the cache
>   block/pcache: inflight readahead request waiting for read
>   block/pcache: write through
>   block/pcache: up-to-date cache for removed nodes
>   block/pcache: pick up parts of the cache
>   block/pcache: drop used pcache nodes
>   qapi: allow blockdev-add for pcache
>   block/pcache: add tracepoints
>
>  MAINTAINERS                     |  13 +
>  block/Makefile.objs             |   1 +
>  block/pcache.c                  | 764 ++++++++++++++++++++++++++++++++++++++++
>  block/trace-events              |  10 +
>  include/qemu/rbcache.h          | 128 +++++++
>  include/qemu/rbtree.h           | 107 ++++++
>  include/qemu/rbtree_augmented.h | 235 ++++++++++++
>  qapi/block-core.json            |  30 +-
>  tests/Makefile.include          |   3 +
>  tests/test-rbcache.c            | 431 +++++++++++++++++++++++
>  util/Makefile.objs              |   2 +
>  util/rbcache.c                  | 253 +++++++++++++
>  util/rbtree.c                   | 570 ++++++++++++++++++++++++++++++
>  13 files changed, 2545 insertions(+), 2 deletions(-)
>  create mode 100644 block/pcache.c
>  create mode 100644 include/qemu/rbcache.h
>  create mode 100644 include/qemu/rbtree.h
>  create mode 100644 include/qemu/rbtree_augmented.h
>  create mode 100644 tests/test-rbcache.c
>  create mode 100644 util/rbcache.c
>  create mode 100644 util/rbtree.c
>
ping?
