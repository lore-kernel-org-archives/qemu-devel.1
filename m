Received: from eggs.gnu.org ([2001:4830:134:3::10]:45580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRC5-0006Vx-BR
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRC0-0002b4-2u
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:33 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Mar 2018 17:36:11 +0100
Message-Id: <20180301163619.21072-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/8] Call check and invalidate_cache from
 coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

Check and invalidate_cache share some parts of the implementation
with the regular I/O path.  This is sometimes complicated because the
I/O path wants to use a CoMutex but that is not possible outside coroutine
context.  By moving things to coroutine context, we can remove special
cases.  In fact, invalidate_cache is already called from coroutine context
because incoming migration is placed in a coroutine.

I'm including two patches from Stefan to rename the bdrv_create callback
to bdrv_co_create, because it is already called from coroutine context.
The name is now bdrv_co_create_opts, with bdrv_co_create reserved for
the QAPI-based version that Kevin is working on.

qcow2 still has cache flushing in non-coroutine context, coming from
qcow2_reopen_prepare->qcow2_update_options_prepare,
qcow2_close->qcow2_inactivate and several dirty bitmap functions.

Paolo

v3->v4: added patch 4, patch 3 has to go before it

Paolo Bonzini (6):
  qcow2: introduce qcow2_write_caches and qcow2_flush_caches
  qcow2: fix flushing after dirty bitmap metadata writes
  qcow2: make qcow2_do_open a coroutine_fn
  qed: make bdrv_qed_do_open a coroutine_fn
  block: convert bdrv_invalidate_cache callback to coroutine_fn
  block: convert bdrv_check callback to coroutine_fn

Stefan Hajnoczi (2):
  block: rename .bdrv_create() to .bdrv_co_create_opts()
  qcow2: make qcow2_co_create2() a coroutine_fn

 block.c                   |  88 ++++++++++++++++++++++++++++++----
 block/crypto.c            |   8 ++--
 block/file-posix.c        |  15 +++---
 block/file-win32.c        |   5 +-
 block/gluster.c           |  12 ++---
 block/iscsi.c             |  13 ++---
 block/nfs.c               |  11 +++--
 block/parallels.c         |  24 ++++++----
 block/qcow.c              |   5 +-
 block/qcow2-bitmap.c      |   4 +-
 block/qcow2-refcount.c    |  28 +++++++++++
 block/qcow2.c             | 118 +++++++++++++++++++++++++++++++---------------
 block/qcow2.h             |   2 +
 block/qed-check.c         |   1 +
 block/qed-table.c         |  26 ++++------
 block/qed.c               |  72 +++++++++++++++++++++-------
 block/raw-format.c        |   5 +-
 block/rbd.c               |  12 +++--
 block/sheepdog.c          |  10 ++--
 block/ssh.c               |   5 +-
 block/vdi.c               |  11 +++--
 block/vhdx.c              |  12 +++--
 block/vmdk.c              |  12 +++--
 block/vpc.c               |   5 +-
 include/block/block_int.h |  11 +++--
 25 files changed, 358 insertions(+), 157 deletions(-)

-- 
2.14.3
