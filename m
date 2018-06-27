Received: from eggs.gnu.org ([2001:4830:134:3::10]:49017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHGD-0003Sr-7P
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHG8-00059m-Fm
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:41:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fYHG8-00058y-7I
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:41:48 -0400
Received: by mail-pf0-x244.google.com with SMTP id s21-v6so1499233pfm.6
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:41:47 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 28 Jun 2018 04:41:16 +0800
Message-Id: <20180627204136.4177-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V9 00/20] COLO: integrate colo frame with block
 replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Hi~ All~

COLO Frame, block replication and COLO proxy(colo-compare,filter-mirror,
filter-redirector,filter-rewriter) have been exist in qemu
for long time, it's time to integrate these three parts to make COLO really works.

In this series, we have some optimizations for COLO frame, including separating the
process of saving ram and device state, using an COLO_EXIT event to notify users that
VM exits COLO, for these parts, most of them have been reviewed long time ago in old version,
but since this series have just rebased on upstream which had merged a new series of migration,
parts of pathes in this series deserve review again.

We use notifier/callback method for COLO compare to notify COLO frame about
net packets inconsistent event, and add a handle_event method for NetFilterClass to
help COLO frame to notify filters and colo-compare about checkpoint/failover event,
it is flexible.

For the neweset version, please refer to:
https://github.com/zhangckid/qemu/tree/qemu-colo-18jun25

Please review, thanks.

V9:
 - Rebased on upstream codes.
 - Addressed Jason's comments add TCP state machine track in
   filter-rewriter.
 - Fix some bug in colo-compare.
 - Fix typo.
 - Add filter-rewriter failover handle.
 - Add net client type check in colo-compare.
 - Add COLO state diagram.
 - Addressed Markus and Daive's comments.


V8:
 - Rebased on upstream codes.
 - Addressed Markus's comments in patch 10/17.
 - Addressed Markus's comments in patch 11/17.
 - Removed some comments in patch 4/17.
 - Moved the "migration_bitmap_clear_dirty()" to suitable position in
   patch 9/17.
 - Rewrote the patch 07/17 to address Davie's comments.
 - Moved the "qemu_savevm_live_state" out of the
   qemu_mutex_lock_iothread.
 - Fixed the bug that in some status COLO vm crash with segmentation fault.

V7:
 - Addressed Markus's comments in 11/17.
 - Rebased on upstream.

V6:
 - Addressed Eric Blake's comments, use the enum to feedback in patch 11/17.
 - Fixed QAPI command separator problem in patch 11/17.



Zhang Chen (16):
  filter-rewriter: Add TCP state machine and fix memory leak in
    connection_track_table
  colo-compare: implement the process of checkpoint
  colo-compare: use notifier to notify packets comparing result
  COLO: integrate colo compare with colo frame
  COLO: Add block replication into colo process
  COLO: Remove colo_state migration struct
  COLO: Load dirty pages into SVM's RAM cache firstly
  ram/COLO: Record the dirty pages that SVM received
  COLO: Flush memory data from ram cache
  qapi/migration.json: Rename COLO unknown mode to none mode.
  qapi: Add new command to query colo status
  savevm: split the process of different stages for loadvm/savevm
  net/net.c: Add net client type check function for COLO
  filter: Add handle_event method for NetFilterClass
  filter-rewriter: handle checkpoint and failover event
  docs: Add COLO status diagram to COLO-FT.txt

zhanghailiang (4):
  qmp event: Add COLO_EXIT event to notify users while exited COLO
  COLO: flush host dirty ram from cache
  COLO: notify net filters about checkpoint/failover event
  COLO: quick failover process by kick COLO thread

 docs/COLO-FT.txt          |  34 ++++++
 include/exec/ram_addr.h   |   1 +
 include/migration/colo.h  |  11 +-
 include/net/filter.h      |   5 +
 include/net/net.h         |   1 +
 migration/Makefile.objs   |   2 +-
 migration/colo-comm.c     |  76 -------------
 migration/colo-failover.c |   2 +-
 migration/colo.c          | 230 ++++++++++++++++++++++++++++++++++++--
 migration/migration.c     |  44 +++++++-
 migration/ram.c           | 163 ++++++++++++++++++++++++++-
 migration/ram.h           |   4 +
 migration/savevm.c        |  53 +++++++--
 migration/savevm.h        |   5 +
 migration/trace-events    |   3 +
 net/colo-compare.c        | 120 ++++++++++++++++++--
 net/colo-compare.h        |  24 ++++
 net/colo.c                |  10 +-
 net/colo.h                |  11 +-
 net/filter-rewriter.c     | 162 +++++++++++++++++++++++++--
 net/filter.c              |  17 +++
 net/net.c                 |  42 +++++++
 qapi/migration.json       |  82 +++++++++++++-
 vl.c                      |   2 -
 24 files changed, 965 insertions(+), 139 deletions(-)
 delete mode 100644 migration/colo-comm.c
 create mode 100644 net/colo-compare.h

-- 
2.17.GIT
