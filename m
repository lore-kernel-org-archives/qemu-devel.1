Received: from eggs.gnu.org ([2001:4830:134:3::10]:43319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0LZ-0002mR-4Z
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0LV-0001c1-Dj
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:41 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gK0LT-0001XW-MH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:36 -0500
Received: by mail-pl1-x62a.google.com with SMTP id w24-v6so6133996plq.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:20:34 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Tue,  6 Nov 2018 20:20:20 +0800
Message-Id: <20181106122025.3487-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 0/5] migration: improve multithreads
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

Changelog in v2:
These changes are based on Paolo's suggestion:
1) rename the lockless multithreads model to threaded workqueue
2) hugely improve the internal design, that make all the request be
   a large array, properly partition it, assign requests to threads
   respectively and use bitmaps to sync up threads and the submitter,
   after that ptr_ring and spinlock are dropped
3) introduce event wait for the submitter

These changes are based on Emilio's review:
4) make more detailed description for threaded workqueue
5) add a benchmark for threaded workqueue

The previous version can be found at
	https://marc.info/?l=kvm&m=153968821910007&w=2

There's the simple performance measurement comparing these two versions,
the environment is the same as we listed in the previous version.

Use 8 threads to compress the data in the source QEMU
- with compress-wait-thread = off


      total time        busy-ratio
--------------------------------------------------
v1    125066            0.38
v2    120444            0.35

- with compress-wait-thread = on
         total time    busy-ratio
--------------------------------------------------
v1    164426            0
v2    142609            0

The v2 win slightly.

Xiao Guangrong (5):
  bitops: introduce change_bit_atomic
  util: introduce threaded workqueue
  migration: use threaded workqueue for compression
  migration: use threaded workqueue for decompression
  tests: add threaded-workqueue-bench

 include/qemu/bitops.h             |  13 +
 include/qemu/threaded-workqueue.h |  94 +++++++
 migration/ram.c                   | 538 ++++++++++++++------------------------
 tests/Makefile.include            |   5 +-
 tests/threaded-workqueue-bench.c  | 256 ++++++++++++++++++
 util/Makefile.objs                |   1 +
 util/threaded-workqueue.c         | 466 +++++++++++++++++++++++++++++++++
 7 files changed, 1030 insertions(+), 343 deletions(-)
 create mode 100644 include/qemu/threaded-workqueue.h
 create mode 100644 tests/threaded-workqueue-bench.c
 create mode 100644 util/threaded-workqueue.c

-- 
2.14.5
