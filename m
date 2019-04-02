Received: from eggs.gnu.org ([209.51.188.92]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTl-0001eP-TM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTk-0000V8-Lu
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:37 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Apr 2019 18:37:20 +0300
Message-Id: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 00/10] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, berrange@redhat.com

v5: rebase on master, some conflicts resolved due to data-file feature

01: new patch, just move test from cover letter to a file. I really hope that it
    will not hang the whole series, so, if we don't want it as is or with really
    tiny improvements, I'd prefer to skip it and queue 02-10 first.
09: "true" parameter added to moved qcow2_pre_write_overlap_check() call due to
    rebase on master (both before and after patch). Seems OK, so keep Alberto's r-b.

performance:

after 01:
 # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.enc.qcow2
14.18
 # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.enc.qcow2 -W
13.77

after 10:
 # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.enc.qcow2
14.35
 # ./tests/perf/block/qcow2/convert-to-encrypted /ssd/src.raw /ssd/dst.enc.qcow2 -W
5.62

Vladimir Sementsov-Ogievskiy (10):
  tests/perf: Test qemu-img convert from raw to encrypted qcow2
  qcow2.h: add missing include
  qcow2: add separate file for threaded data processing functions
  qcow2-threads: use thread_pool_submit_co
  qcow2-threads: qcow2_co_do_compress: protect queuing by mutex
  qcow2-threads: split out generic path
  qcow2: qcow2_co_preadv: improve locking
  qcow2: qcow2_co_preadv: skip using hd_qiov when possible
  qcow2: bdrv_co_pwritev: move encryption code out of the lock
  qcow2: do encryption in threads

 block/qcow2.h                               |  20 +-
 block/qcow2-bitmap.c                        |   1 -
 block/qcow2-cache.c                         |   1 -
 block/qcow2-cluster.c                       |   8 +-
 block/qcow2-refcount.c                      |   1 -
 block/qcow2-snapshot.c                      |   1 -
 block/qcow2-threads.c                       | 268 +++++++++++++++++++
 block/qcow2.c                               | 275 ++++----------------
 block/Makefile.objs                         |   2 +-
 tests/perf/block/qcow2/convert-to-encrypted |  48 ++++
 10 files changed, 389 insertions(+), 236 deletions(-)
 create mode 100644 block/qcow2-threads.c
 create mode 100755 tests/perf/block/qcow2/convert-to-encrypted

-- 
2.18.0
