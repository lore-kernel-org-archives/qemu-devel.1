Received: from eggs.gnu.org ([2001:4830:134:3::10]:33072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nf-0004nm-EO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9ne-00061A-Ge
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:43 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:17 +0200
Message-Id: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/11] Block layer thread-safety, next part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Here, patches 1-6 make the remaining part of the block layer thread safe.
Patches 7-11 start removing aio_context_acquire/release, so the line
count goes down instead of up.

This is the penultimate series.  The remaining part makes virtio-blk,
virtio-scsi and block jobs thread safe, so that the AioContext lock
can go away altogether.

Paolo

Paolo Bonzini (11):
  block: prepare write threshold code for thread safety
  block: make write-threshold thread-safe
  util: use RCU accessors for notifiers
  block: make before-write notifiers thread-safe
  block-backup: add reqs_lock
  block: more notes on locking
  block: do not acquire AioContext in check_to_replace_node
  block: drain I/O around key management
  block/replication: do not acquire AioContext
  block: do not take AioContext around reopen
  block/snapshot: do not take AioContext lock
  qdev: do not take AioContext when releasing (and thus closing)
    backends

 block.c                          | 19 +++--------
 block/backup.c                   | 37 +++++++++++++++------
 block/block-backend.c            |  5 ---
 block/commit.c                   |  2 +-
 block/io.c                       | 12 +++++++
 block/mirror.c                   |  9 ------
 block/replication.c              | 56 ++++++++------------------------
 block/snapshot.c                 | 28 +---------------
 block/write-threshold.c          | 39 +++++++++++-----------
 blockdev.c                       | 70 ++++++++++++----------------------------
 hmp.c                            |  7 ----
 include/block/block.h            |  2 +-
 include/block/block_backup.h     |  2 +-
 include/block/block_int.h        | 31 ++++++++++++++++--
 include/block/snapshot.h         |  4 +--
 migration/savevm.c               | 22 -------------
 monitor.c                        | 10 ++----
 qemu-io-cmds.c                   |  2 +-
 util/notify.c                    | 13 ++++----
 19 files changed, 142 insertions(+), 228 deletions(-)

-- 
2.13.0
