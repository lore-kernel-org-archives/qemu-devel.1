Received: from eggs.gnu.org ([2001:4830:134:3::10]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dShSG-0008SF-QL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dShSG-0002f9-4C
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:22:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  5 Jul 2017 11:22:29 +0100
Message-Id: <20170705102231.20711-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] block: make .bdrv_create() a coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The BlockDriver->bdrv_create() function is always called from coroutine
context.  These patches rename it and clean up qcow2 code that is current=
ly
calling CoMutex functions outside coroutine_fn.

Stefan Hajnoczi (2):
  block: rename .bdrv_create() to .bdrv_co_create()
  qcow2: make qcow2_co_create2() a coroutine_fn

 include/block/block_int.h |  3 ++-
 block.c                   |  4 ++--
 block/crypto.c            |  8 ++++----
 block/file-posix.c        | 15 ++++++++-------
 block/file-win32.c        |  3 ++-
 block/gluster.c           | 12 ++++++------
 block/iscsi.c             |  7 ++++---
 block/nfs.c               |  5 +++--
 block/parallels.c         |  6 ++++--
 block/qcow.c              |  5 +++--
 block/qcow2.c             | 22 ++++++++++++----------
 block/qed.c               |  6 ++++--
 block/raw-format.c        |  5 +++--
 block/rbd.c               |  6 ++++--
 block/sheepdog.c          | 10 +++++-----
 block/ssh.c               |  5 +++--
 block/vdi.c               |  5 +++--
 block/vhdx.c              |  5 +++--
 block/vmdk.c              |  5 +++--
 block/vpc.c               |  5 +++--
 20 files changed, 81 insertions(+), 61 deletions(-)

--=20
2.9.4
