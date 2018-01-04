Received: from eggs.gnu.org ([2001:4830:134:3::10]:36646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWyb0-0003Qg-5t
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWyaw-0003md-0Q
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:42 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWyav-0003mF-Qj
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:37 -0500
Received: by mail-pg0-x235.google.com with SMTP id 77so337169pgd.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:01:37 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:00:59 +0800
Message-Id: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 00/16] COLO: integrate colo frame
 with block replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>

Hi~

(Sorry, I forgot add the qemu-devel maillist, resend this series)

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
https://github.com/zhangckid/qemu/tree/qemu-colo-18jan4

Please review, thanks.

V3:
 - Address community comments from V2.
 - Rebase on upstream codes.
 - Fix several bugs.
 - Splite shared disk part to indepentent patch set.
 - Optimize codes.

Zhang Chen (8):
  filter-rewriter: fix memory leak for connection in
    connection_track_table
  colo-compare: implement the process of checkpoint
  colo-compare: use notifier to notify packets comparing result
  COLO: integrate colo compare with colo frame
  COLO: Add block replication into colo process
  ram/COLO: Record the dirty pages that SVM received
  filter: Add handle_event method for NetFilterClass
  filter-rewriter: handle checkpoint and failover event

zhanghailiang (8):
  COLO: Remove colo_state migration struct
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
 migration/colo-comm.c    |  76 -------------------
 migration/colo.c         | 188 ++++++++++++++++++++++++++++++++++++++++++++---
 migration/migration.c    |  38 +++++++++-
 migration/ram.c          | 181 ++++++++++++++++++++++++++++++++++++++++++++-
 migration/ram.h          |   4 +
 migration/savevm.c       |  54 ++++++++++++--
 migration/savevm.h       |   5 ++
 migration/trace-events   |   3 +
 net/colo-compare.c       | 103 ++++++++++++++++++++++++--
 net/colo-compare.h       |  24 ++++++
 net/colo.h               |   4 +
 net/filter-rewriter.c    | 109 +++++++++++++++++++++++++--
 net/filter.c             |  17 +++++
 net/net.c                |  28 +++++++
 qapi-schema.json         |  21 ++++++
 qapi/migration.json      |  13 ++++
 vl.c                     |   2 -
 21 files changed, 771 insertions(+), 118 deletions(-)
 delete mode 100644 migration/colo-comm.c
 create mode 100644 net/colo-compare.h

-- 
2.7.4
