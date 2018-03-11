Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvfi-0005z0-IU
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvfh-0000Tk-7x
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:34 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:41328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1euvfh-0000TJ-1C
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:33 -0400
Received: by mail-pg0-x22c.google.com with SMTP id w17so1177899pgq.8
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 23:45:32 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 15:44:57 +0800
Message-Id: <1520754314-5969-2-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V6 00/17] COLO: integrate colo frame with block
 replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Hi~

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
https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10

Please review, thanks.

V6:
 - Addressed Eric Blake's comments, use the enum to feedback in patch 11/17.
 - Fixed QAPI command separator problem in patch 11/17.

V5:
 - Addressed Markus's comments add new command to
   query COLO status(patch 11/17).
 - Rebased on upstream codes.
 - Fixed qapi header problem in patch 10/17.
 - Fixed the conflict of "qemu_anon_ram_alloc()" in patch 07/17. 

V4:
 - Address Eric's comments in patch 10/16.
 - Rebase on upstream codes.
 - Fix mingw compile error in patch 02/16.
 - Fix some comments.
 - Fix conflect with the patch "migration: remove "enable_colo" var" in patch 06/16.

V3:
 - Address community comments from V2.
 - Rebase on upstream codes.
 - Fix several bugs.
 - Splite shared disk part to indepentent patch set.
 - Optimize codes.


Zhang Chen (10):
  filter-rewriter: fix memory leak for connection in
    connection_track_table
  colo-compare: implement the process of checkpoint
  colo-compare: use notifier to notify packets comparing result
  COLO: integrate colo compare with colo frame
  COLO: Add block replication into colo process
  COLO: Remove colo_state migration struct
  ram/COLO: Record the dirty pages that SVM received
  qapi: Add new command to query colo status
  filter: Add handle_event method for NetFilterClass
  filter-rewriter: handle checkpoint and failover event

zhanghailiang (7):
  COLO: Load dirty pages into SVM's RAM cache firstly
  COLO: Flush memory data from ram cache
  qmp event: Add COLO_EXIT event to notify users while exited COLO
  savevm: split the process of different stages for loadvm/savevm
  COLO: flush host dirty ram from cache
  COLO: notify net filters about checkpoint/failover event
  COLO: quick failover process by kick COLO thread

 include/exec/ram_addr.h  |   1 +
 include/migration/colo.h |  11 ++-
 include/net/filter.h     |   5 ++
 migration/Makefile.objs  |   2 +-
 migration/colo-comm.c    |  76 -----------------
 migration/colo.c         | 216 ++++++++++++++++++++++++++++++++++++++++++++---
 migration/migration.c    |  38 ++++++++-
 migration/ram.c          | 183 ++++++++++++++++++++++++++++++++++++++-
 migration/ram.h          |   4 +
 migration/savevm.c       |  54 ++++++++++--
 migration/savevm.h       |   5 ++
 migration/trace-events   |   3 +
 net/colo-compare.c       | 108 ++++++++++++++++++++++--
 net/colo-compare.h       |  24 ++++++
 net/colo.h               |   4 +
 net/filter-rewriter.c    | 109 ++++++++++++++++++++++--
 net/filter.c             |  17 ++++
 net/net.c                |  28 ++++++
 qapi/migration.json      |  68 +++++++++++++++
 vl.c                     |   2 -
 20 files changed, 840 insertions(+), 118 deletions(-)
 delete mode 100644 migration/colo-comm.c
 create mode 100644 net/colo-compare.h

-- 
2.7.4
