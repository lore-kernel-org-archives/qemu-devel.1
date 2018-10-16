Received: from eggs.gnu.org ([2001:4830:134:3::10]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gCNFG-0000Wt-E1
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gCNFB-0002uD-UH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:10:37 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gCNF2-0002WU-Ip
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:10:26 -0400
Received: by mail-pl1-x644.google.com with SMTP id y11-v6so10858092plt.3
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 04:10:16 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 16 Oct 2018 19:10:02 +0800
Message-Id: <20181016111006.629-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] migration: improve multithreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

This is the last part of our previous work:
   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00526.html

This part finally improves the multithreads model used by compression
and decompression, that makes the compression feature is really usable
in the production.

Comparing with the previous version, we
1. port ptr_ring from linux kernel and use it to instead of lockless
   ring designed by ourself

   ( Michael, i added myself to the list of author in that file, if
    you dislike it, i'm fine to drop it. :) )

2  search all threads to detect if it has free room in its local ring
   to contain a request instead of RR to reduce busy-ratio

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
To make it work better, we introduce a lockless multithread model,
the user, currently it is the migration thread, submits request
to each thread which has its own ring whose capacity is 4 and
puts the result to a global ring where the user fetches result
out and do remaining operations for the request, e.g, posting the
compressed data out for migration on the source QEMU

Performance Result
-----------------
We tested live migration on two hosts:
   Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz * 64 + 256G memory

to migration a VM between each other, which has 16 vCPUs and 120G
memory, during the migration, multiple threads are repeatedly writing
the memory in the VM

We used 16 threads on the destination to decompress the data and on the
source, we tried 4, 8 and 16 threads to compress the data

1) 4 threads， compress-wait-thread = off

CPU usages

         main thread      compression threads
-----------------------------------------------
before    66.2              32.4~36.8
after     56.5              59.4~60.9

Migration result

         total time        busy-ratio
--------------------------------------------------
before   247371             0.54
after    138326             0.55

2) 4 threads， compress-wait-thread = on

CPU usages

         main thread      compression threads
-----------------------------------------------
before    55.1              51.0~63.3
after     99.9              99.9

Migration result

         total time        busy-ratio
--------------------------------------------------
before   CAN'T COMPLETE    0
after    338692            0

3) 8 threads， compress-wait-thread = off

CPU usages

         main thread      compression threads
-----------------------------------------------
before    43.3              17.5~32.5
after     54.5              54.5~56.8

Migration result

         total time        busy-ratio
--------------------------------------------------
before   427384            0.19
after    125066            0.38

4) 8 threads， compress-wait-thread = on
CPU usages

         main thread      compression threads
-----------------------------------------------
before    96.3              2.3~46.8
after     90.6              90.6~91.8

Migration result

         total time        busy-ratio
--------------------------------------------------
before   CAN'T COMPLETE    0
after    164426            0

5) 16 threads， compress-wait-thread = off
CPU usages

         main thread      compression threads
-----------------------------------------------
before    56.2              6.2~56.2
after     37.8              37.8~40.2

Migration result

         total time        busy-ratio
--------------------------------------------------
before   2317123           0.02
after    149006            0.02

5) 16 threads， compress-wait-thread = on
CPU usages

         main thread      compression threads
-----------------------------------------------
before    48.3               1.7~31.0
after     43.9              42.1~45.6

Migration result

         total time        busy-ratio
--------------------------------------------------
before   1792817           0.00
after    161423            0.00

Xiao Guangrong (4):
  ptr_ring: port ptr_ring from linux kernel to QEMU
  migration: introduce lockless multithreads model
  migration: use lockless Multithread model for compression
  migration: use lockless Multithread model for decompression

 include/qemu/lockless-threads.h |  63 +++++
 include/qemu/ptr_ring.h         | 235 ++++++++++++++++++
 migration/ram.c                 | 535 +++++++++++++++-------------------------
 util/Makefile.objs              |   1 +
 util/lockless-threads.c         | 373 ++++++++++++++++++++++++++++
 5 files changed, 865 insertions(+), 342 deletions(-)
 create mode 100644 include/qemu/lockless-threads.h
 create mode 100644 include/qemu/ptr_ring.h
 create mode 100644 util/lockless-threads.c

-- 
2.14.4
