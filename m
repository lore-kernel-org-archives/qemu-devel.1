Received: from eggs.gnu.org ([2001:4830:134:3::10]:48805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUD-0005ht-DA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUA-0001Fd-8y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:27:57 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jun 2017 15:27:38 +0200
Message-Id: <20170629132749.997-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/11] Block layer thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

This part takes care of drivers and devices, making sure that they can
accept concurrent I/O from multiple AioContext.

The following drivers are thread-safe without using any QemuMutex/CoMutex:
crypto, gluster, null, rbd, win32-aio.  NBD has already been fixed,
because the patch fixed an unrelated testcase.

The following drivers already use mutexes for everything except possibly
snapshots, which do not (yet?) need protection: bochs, cloop, dmg, qcow,
parallels, vhdx, vmdk, curl, iscsi, nfs.

The following drivers already use mutexes for _almost_ everything: vpc
(missing get_block_status), vdi (missing bitmap access), vvfat (missing
commit), not protected), qcow2 (must call CoQueue APIs under CoMutex).
They are fixed by patches 1-5.

The following drivers must be changed to use CoMutex to protect internal
data: qed (patches 6-9), sheepdog (patch 10).

The following driver must be changed to support I/O from any AioContext:
ssh.  It is fixed by patch 11.

Paolo

v1->v2: new patch 8 + adjustments to patch 9 to fix qemu-iotests testcase
        183 (bdrv_invalidate_cache from block migration)

Paolo Bonzini (11):
  qcow2: call CoQueue APIs under CoMutex
  coroutine-lock: add qemu_co_rwlock_downgrade and
    qemu_co_rwlock_upgrade
  vdi: make it thread-safe
  vpc: make it thread-safe
  vvfat: make it thread-safe
  qed: move tail of qed_aio_write_main to qed_aio_write_{cow,alloc}
  block: invoke .bdrv_drain callback in coroutine context and from
    AioContext
  qed: introduce bdrv_qed_init_state
  qed: protect table cache with CoMutex
  sheepdog: add queue_lock
  ssh: support I/O from any AioContext

 block/io.c                 |  42 +++++++--
 block/qcow2.c              |   4 +-
 block/qed-cluster.c        |   4 +-
 block/qed-l2-cache.c       |   6 ++
 block/qed-table.c          |  24 +++--
 block/qed.c                | 214 ++++++++++++++++++++++++++++-----------------
 block/qed.h                |  11 ++-
 block/sheepdog.c           |  21 ++++-
 block/ssh.c                |  24 +++--
 block/vdi.c                |  48 +++++-----
 block/vpc.c                |  20 ++---
 block/vvfat.c              |   8 +-
 include/block/block_int.h  |   2 +-
 include/qemu/coroutine.h   |  18 ++++
 util/qemu-coroutine-lock.c |  35 ++++++++
 15 files changed, 331 insertions(+), 150 deletions(-)

-- 
2.13.0
