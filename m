Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gPjI2-0002gT-IQ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gPjHy-0001gV-5D
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:20:42 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gPjHx-0001f9-Sm
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:20:38 -0500
Received: by mail-pg1-x541.google.com with SMTP id z10so1312366pgp.7
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 23:20:37 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Thu, 22 Nov 2018 15:20:23 +0800
Message-Id: <20181122072028.22819-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 0/5] migration: improve multithreads
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

Changelog in v3:
Thanks to Emilio's comments and his example code, the changes in
this version are:
1. move @requests from the shared data struct to each single thread
2. move completion ev from the shared data struct to each single thread
3. move bitmaps from the shared data struct to each single thread
4. limit the number of request that each thread need handle to 64, then
   use uint64_t instead of bitmap pointer.
   
The performance is measured by using the benchmark we introduced in
this pachset:
	./tests/threaded-workqueue-bench -c 20 -m 16 -t N
the data is as followings:

The baseline of v2:
Thread #, Throughput
1, 0.428024
4, 1.668876
8, 3.501940
12, 5.026403
16, 1.912374
20, 1.174771
24, 1.074085
28, 0.747920
32, 0.651409
36, 0.533240
40, 0.517421
44, 0.482153
48, 0.525176
52, 0.492677
56, 0.798679
60, 0.733868
64, 0.751396

After this patchset:
Thread #, Throughput
1, 0.449192
4, 1.849271
8, 3.644339
12, 4.809391
16, 4.709095
20, 4.942153
24, 5.116967
28, 4.921542
32, 5.008816
36, 5.408070
40, 5.166064
44, 4.994953
48, 4.853351
52, 4.797540
56, 4.815153
60, 4.793704
64, 4.913544

To see more detailed compression by each step, please refer to
   https://ibb.co/hq7u5V

Xiao Guangrong (5):
  bitops: introduce change_bit_atomic
  util: introduce threaded workqueue
  migration: use threaded workqueue for compression
  migration: use threaded workqueue for decompression
  tests: add threaded-workqueue-bench

 include/qemu/bitops.h             |  13 +
 include/qemu/threaded-workqueue.h | 106 ++++++++
 migration/ram.c                   | 530 ++++++++++++++------------------------
 tests/Makefile.include            |   5 +-
 tests/threaded-workqueue-bench.c  | 255 ++++++++++++++++++
 util/Makefile.objs                |   1 +
 util/threaded-workqueue.c         | 463 +++++++++++++++++++++++++++++++++
 7 files changed, 1029 insertions(+), 344 deletions(-)
 create mode 100644 include/qemu/threaded-workqueue.h
 create mode 100644 tests/threaded-workqueue-bench.c
 create mode 100644 util/threaded-workqueue.c

-- 
2.14.5
