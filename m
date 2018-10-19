Received: from eggs.gnu.org ([2001:4830:134:3::10]:36264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gDLN3-0002MH-Sn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gDLMz-0002VR-Fb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gDLMz-0002Mp-2t
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:22:37 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Oct 2018 11:21:59 +0800
Message-Id: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 00/26] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 37a4442a76d010f5d957e3ee09dfb23364281b37:

  qemu-options: Fix bad "macaddr" property in the documentation (2018-10-19 11:15:04 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jason Wang (5):
      ne2000: fix possible out of bound access in ne2000_receive
      rtl8139: fix possible out of bound access
      pcnet: fix possible buffer overflow
      net: ignore packet size greater than INT_MAX
      e1000: indicate dropped packets in HW counters

Thomas Huth (1):
      qemu-options: Fix bad "macaddr" property in the documentation

Zhang Chen (15):
      filter-rewriter: Add TCP state machine and fix memory leak in connection_track_table
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
      filter: Add handle_event method for NetFilterClass
      filter-rewriter: handle checkpoint and failover event
      docs: Add COLO status diagram to COLO-FT.txt

liujunjie (1):
      clean up callback when del virtqueue

zhanghailiang (4):
      qmp event: Add COLO_EXIT event to notify users while exited COLO
      COLO: flush host dirty ram from cache
      COLO: notify net filters about checkpoint/failover event
      COLO: quick failover process by kick COLO thread

 docs/COLO-FT.txt          |  34 ++++++++
 hw/net/e1000.c            |  16 +++-
 hw/net/ne2000.c           |   4 +-
 hw/net/pcnet.c            |   4 +-
 hw/net/rtl8139.c          |   8 +-
 hw/net/trace-events       |   3 +
 hw/virtio/virtio.c        |   2 +
 include/exec/ram_addr.h   |   1 +
 include/migration/colo.h  |  11 ++-
 include/net/filter.h      |   5 ++
 migration/Makefile.objs   |   2 +-
 migration/colo-comm.c     |  76 -----------------
 migration/colo-failover.c |   2 +-
 migration/colo.c          | 212 +++++++++++++++++++++++++++++++++++++++++++---
 migration/migration.c     |  46 ++++++++--
 migration/ram.c           | 166 +++++++++++++++++++++++++++++++++++-
 migration/ram.h           |   4 +
 migration/savevm.c        |  53 ++++++++++--
 migration/savevm.h        |   5 ++
 migration/trace-events    |   3 +
 net/colo-compare.c        | 115 ++++++++++++++++++++++---
 net/colo-compare.h        |  24 ++++++
 net/colo.c                |  10 ++-
 net/colo.h                |  11 +--
 net/filter-rewriter.c     | 166 +++++++++++++++++++++++++++++++++---
 net/filter.c              |  17 ++++
 net/net.c                 |  26 +++++-
 qapi/migration.json       |  80 +++++++++++++++--
 qemu-options.hx           |   2 +-
 vl.c                      |   2 -
 30 files changed, 958 insertions(+), 152 deletions(-)
 delete mode 100644 migration/colo-comm.c
 create mode 100644 net/colo-compare.h
