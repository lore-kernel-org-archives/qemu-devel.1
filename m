Received: from eggs.gnu.org ([2001:4830:134:3::10]:48188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvI-0006nb-17
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvE-00083c-SC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVvE-00082x-Jc
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99B714E4C6
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 22:03:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:11 +0200
Message-Id: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/35] RFC: coroutine annotations & clang check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

After investigating a bit using clang-tidy to do some coroutine checks
(and hitting a wall as there are no pre-processor info in the AST), it
was suggested to me on the clang mailing list to try to use
-Wthread-safety. I had to modify clang a bit to make it work on qemu
code base (annotations on function typedef etc,
https://github.com/elmarco/clang qemu-ta branch - very hackish state).

The analysis simply checks that coroutine_fn are called from a
coroutine "context" (or "role"). I couldn't find any misuse in qemu
code base, however, a number of coroutine_fn annotations are missing.

(I think it would make sense to squash all the "mark coroutine_fn"
commits if we apply them, I tried to split them by domains/maintainer
to ease review)

Marc-Andr=C3=A9 Lureau (35):
  WIP: coroutine: annotate coroutine with clang thread safety attributes
  WIP: coroutine: manually tag the fast-paths
  test-coroutine: fix coroutine attribute
  coroutine: remove coroutine_fn from qemu_coroutine_self()
  coroutine: remove coroutine_fn from qemu_co_queue_run_restart()
  coroutine: mark CoRwLock coroutine_fn
  blockjob: mark coroutine_fn
  block: all bdrv_aio callbacks are coroutine_fn
  block: bdrv_create() and bdrv_debug_event() are coroutine_fn
  vmdk: mark coroutine_fn
  qcow2: mark coroutine_fn
  raw: mark coroutine_fn
  nbd: mark coroutine_fn
  migration: mark coroutine_fn
  backup: mark coroutine_fn
  crypto: mark coroutine_fn
  curl: mark coroutine_fn
  gluster: mark coroutine_fn
  nfs: mark coroutine_fn
  quorum: mark coroutine_fn
  rbd: mark coroutine_fn
  sheepdog: mark coroutine_fn
  ssh: mark coroutine_fn
  null: mark coroutine_fn
  mirror: mark coroutine_fn
  iscsi: mark coroutine_fn
  file-posix: mark coroutine_fn
  9p: mark coroutine_fn
  block: mark coroutine_fn
  block-backend: mark coroutine_fn
  parallels: mark coroutine_fn
  qed: mark coroutine_fn
  vdi: mark coroutine_fn
  vhdx: mark coroutine_fn
  vpc: mark coroutine_fn

 block/nbd-client.h             | 10 +++++-----
 block/qcow2.h                  |  6 ++++--
 hw/9pfs/9p.h                   |  9 ++++++---
 include/block/block_backup.h   |  4 ++--
 include/block/block_int.h      | 14 +++++++-------
 include/block/blockjob_int.h   |  4 ++--
 include/qemu/coroutine.h       | 39 ++++++++++++++++++++++++++++++++++--=
---
 include/qemu/coroutine_int.h   |  2 +-
 include/sysemu/block-backend.h |  4 ++--
 block.c                        |  2 ++
 block/backup.c                 |  9 ++++++---
 block/blkdebug.c               | 15 ++++++++++-----
 block/blkverify.c              |  3 ++-
 block/block-backend.c          | 38 ++++++++++++++++++++++++++----------=
--
 block/crypto.c                 |  3 ++-
 block/curl.c                   |  3 ++-
 block/file-posix.c             | 15 ++++++++++-----
 block/gluster.c                |  3 ++-
 block/io.c                     | 25 +++++++++++++++++++++----
 block/iscsi.c                  |  6 ++++--
 block/mirror.c                 | 15 ++++++++++-----
 block/nbd-client.c             | 24 ++++++++++++++++--------
 block/nbd.c                    |  3 ++-
 block/nfs.c                    |  3 ++-
 block/null.c                   |  9 ++++++---
 block/parallels.c              |  3 ++-
 block/qcow.c                   |  4 +++-
 block/qcow2-cluster.c          | 11 +++++++----
 block/qcow2.c                  | 15 ++++++++++-----
 block/qed.c                    |  3 ++-
 block/quorum.c                 | 25 ++++++++++++++++---------
 block/raw-format.c             |  6 ++++--
 block/rbd.c                    | 15 ++++++++++-----
 block/sheepdog.c               | 20 ++++++++++++++------
 block/ssh.c                    |  6 ++++--
 block/throttle-groups.c        | 10 ++++++++--
 block/vdi.c                    |  3 ++-
 block/vhdx.c                   |  3 ++-
 block/vmdk.c                   | 12 ++++++++----
 block/vpc.c                    |  3 ++-
 blockjob.c                     |  6 ++++--
 migration/migration.c          |  3 ++-
 migration/rdma.c               |  2 ++
 nbd/server.c                   |  3 ++-
 tests/test-coroutine.c         |  2 +-
 util/coroutine-sigaltstack.c   |  2 ++
 util/coroutine-ucontext.c      |  2 ++
 util/coroutine-win32.c         |  2 ++
 util/qemu-coroutine.c          |  2 ++
 49 files changed, 299 insertions(+), 132 deletions(-)

--=20
2.13.1.395.gf7b71de06
