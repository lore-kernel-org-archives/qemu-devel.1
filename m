Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNps-00059G-N8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpo-0003Ck-Cc
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:43:24 -0500
Received: from [45.249.212.187] (port=2978 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpn-0003AG-NQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:43:20 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:01 +0800
Message-ID: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 00/15] COLO: integrate colo frame with block
 replication and net compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Dong eddie <eddie.dong@intel.com>, Jiang
	yunhong <yunhong.jiang@intel.com>, Xu Quan <xuquan8@huawei.com>, Jason Wang <jasowang@redhat.com>

Hi,
This series tries to integrate colo frame with block replication
and net compare. Block replcation and colo proxy (net compare) parts
have been merged in upstream for last version. We need to integrate
all of them to realize complete capability of COLO.

Besides, for colo frame, there are some optimizations, including
separating the process of saving ram and device state, using
an COLO_EXIT event to notify users that VM exits COLO, for these
parts, most of them have been reviewed long time ago in old version.

Please review, thanks.

Cc: Dong eddie <eddie.dong@intel.com>
Cc: Jiang yunhong <yunhong.jiang@intel.com>
Cc: Xu Quan <xuquan8@huawei.com>
Cc: Jason Wang <jasowang@redhat.com> 

zhanghailiang (15):
  net/colo: Add notifier/callback related helpers for filter
  colo-compare: implement the process of checkpoint
  colo-compare: use notifier to notify packets comparing result
  COLO: integrate colo compare with colo frame
  COLO: Handle shutdown command for VM in COLO state
  COLO: Add block replication into colo process
  COLO: Load PVM's dirty pages into SVM's RAM cache temporarily
  ram/COLO: Record the dirty pages that SVM received
  COLO: Flush PVM's cached RAM into SVM's memory
  qmp event: Add COLO_EXIT event to notify users while exited from COLO
  savevm: split save/find loadvm_handlers entry into two helper
    functions
  savevm: split the process of different stages for loadvm/savevm
  COLO: Separate the process of saving/loading ram and device state
  COLO: Split qemu_savevm_state_begin out of checkpoint process
  COLO: flush host dirty ram from cache

 include/exec/ram_addr.h       |   1 +
 include/migration/colo.h      |   1 +
 include/migration/migration.h |   5 +
 include/sysemu/sysemu.h       |   9 ++
 migration/colo.c              | 232 +++++++++++++++++++++++++++++++++++++++---
 migration/migration.c         |   2 +-
 migration/ram.c               | 149 ++++++++++++++++++++++++++-
 migration/savevm.c            | 114 +++++++++++++++++----
 migration/trace-events        |   2 +
 net/colo-compare.c            | 104 ++++++++++++++++++-
 net/colo-compare.h            |  22 ++++
 net/colo.c                    |  92 +++++++++++++++++
 net/colo.h                    |  18 ++++
 qapi-schema.json              |  18 +++-
 qapi/event.json               |  21 ++++
 vl.c                          |  19 +++-
 16 files changed, 764 insertions(+), 45 deletions(-)
 create mode 100644 net/colo-compare.h

-- 
1.8.3.1
