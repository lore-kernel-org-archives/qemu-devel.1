Received: from eggs.gnu.org ([2001:4830:134:3::10]:33939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qWe-0000bl-7U
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qWb-0003bW-3d
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3407
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qWa-0003Zj-GU
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:13 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:10 +0800
Message-ID: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 00/18] COLO: integrate colo frame
 with block replication and net compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Dong eddie <eddie.dong@intel.com>, Jiang
	yunhong <yunhong.jiang@intel.com>, Xu Quan <xuquan8@huawei.com>, Jason Wang <jasowang@redhat.com>

Hi,

(Sorry, I have misspelled Dave's email address, resend this series.)

COLO Frame, block replication and COLO net compare have been exist in qemu
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

Besides, this series is on top of '[PATCH 0/3] colo-compare: fix three bugs' series.

For the neweset version, please refer to:
https://github.com/coloft/qemu/tree/colo-for-qemu-2.10-2017-4-22

Please review, thanks.

Cc: Dong eddie <eddie.dong@intel.com>
Cc: Jiang yunhong <yunhong.jiang@intel.com>
Cc: Xu Quan <xuquan8@huawei.com>
Cc: Jason Wang <jasowang@redhat.com>

zhanghailiang (18):
  net/colo: Add notifier/callback related helpers for filter
  colo-compare: implement the process of checkpoint
  colo-compare: use notifier to notify packets comparing result
  COLO: integrate colo compare with colo frame
  COLO: Handle shutdown command for VM in COLO state
  COLO: Add block replication into colo process
  COLO: Load dirty pages into SVM's RAM cache firstly
  ram/COLO: Record the dirty pages that SVM received
  COLO: Flush memory data from ram cache
  qmp event: Add COLO_EXIT event to notify users while exited COLO
  savevm: split save/find loadvm_handlers entry into two helper
    functions
  savevm: split the process of different stages for loadvm/savevm
  COLO: Separate the process of saving/loading ram and device state
  COLO: Split qemu_savevm_state_begin out of checkpoint process
  COLO: flush host dirty ram from cache
  filter: Add handle_event method for NetFilterClass
  filter-rewriter: handle checkpoint and failover event
  COLO: notify net filters about checkpoint/failover event

 include/exec/ram_addr.h       |   1 +
 include/migration/colo.h      |   1 +
 include/migration/migration.h |   5 +
 include/net/filter.h          |   5 +
 include/sysemu/sysemu.h       |   9 ++
 migration/colo.c              | 242 +++++++++++++++++++++++++++++++++++++++---
 migration/migration.c         |  24 ++++-
 migration/ram.c               | 147 ++++++++++++++++++++++++-
 migration/savevm.c            | 113 ++++++++++++++++----
 migration/trace-events        |   2 +
 net/colo-compare.c            | 110 ++++++++++++++++++-
 net/colo-compare.h            |   8 ++
 net/colo.c                    | 105 ++++++++++++++++++
 net/colo.h                    |  19 ++++
 net/filter-rewriter.c         |  39 +++++++
 net/filter.c                  |  16 +++
 net/net.c                     |  28 +++++
 qapi-schema.json              |  18 +++-
 qapi/event.json               |  21 ++++
 vl.c                          |  19 +++-
 20 files changed, 886 insertions(+), 46 deletions(-)
 create mode 100644 net/colo-compare.h

-- 
1.8.3.1
