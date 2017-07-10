Received: from eggs.gnu.org ([2001:4830:134:3::10]:58316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc17-00043q-Iq
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc12-0002yW-Ga
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUc12-0002xq-Av
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E933A61D30
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:58:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jul 2017 18:58:22 +0200
Message-Id: <20170710165827.4250-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/5] move bdrv_invalidate_cache,
 bdrv_check to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kwolf@redhat.com

bdrv_invalidate_cache and bdrv_check are reading/processing metadata,
which is usually protected by a lock (CoMutex).  However, they are
not called from coroutine context, so they are not using the same
protection.  This series moves these functions into coroutine context,
as suggested by Kevin for bdrv_check, so that they can take the CoMutex
just like everyone else.

In addition, bdrv_invalidate_cache is already being called from coroutine
context when doing incoming migration; making this explicit is cleaner.

This is particularly important for QED which, unlike QCOW2, drops the
lock while reading metadata; this series lets it make the
qemu_co_mutex_release/acquire unconditional, instead of wrapping it
with qemu_in_coroutine.  It will help Marc-Andr=C3=A9's effort to validat=
e
coroutine_fn with clang's -Wthread-safety.

This series of course doesn't change the fact that concurrent I/O is
not a very good idea for either bdrv_invalidate_cache or bdrv_check:
in the case of bdrv_invalidate_cache, you should not do I/O prior to
invalidation, while the case of bdrv_check corrupted metadata may cause
all sorts of misbehavior.  However, it would now be possible to do
multiple bdrv_invalidate_cache in parallel if we were so inclined.

Note: I'm fairly sure of the qed changes, but a bit less of the qcow2
parts.  Patch 4 should make sure that there is no recursive locking,
and qemu-iotests is happy.

Paolo

Paolo Bonzini (5):
  qcow2: make qcow2_do_open a coroutine_fn
  qed: make bdrv_qed_do_open a coroutine_fn
  block: convert bdrv_invalidate_cache callback to coroutine_fn
  qcow2: introduce qcow2_write_caches and qcow2_flush_caches
  block: convert bdrv_check callback to coroutine_fn

 block.c                   | 84 +++++++++++++++++++++++++++++++++++++----
 block/iscsi.c             |  6 +--
 block/nfs.c               |  6 +--
 block/parallels.c         | 17 ++++++---
 block/qcow2-refcount.c    | 28 ++++++++++++++
 block/qcow2.c             | 95 +++++++++++++++++++++++++++++++++--------=
------
 block/qcow2.h             |  2 +
 block/qed-check.c         |  1 +
 block/qed-table.c         | 26 +++++--------
 block/qed.c               | 66 ++++++++++++++++++++++++--------
 block/rbd.c               |  6 +--
 block/vdi.c               |  6 +--
 block/vhdx.c              |  7 ++--
 block/vmdk.c              |  7 ++--
 include/block/block_int.h |  8 ++--
 15 files changed, 272 insertions(+), 93 deletions(-)

--=20
2.13.0
