Received: from eggs.gnu.org ([2001:4830:134:3::10]:40773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dSJOo-0002rT-4K
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dSJOn-0004o8-Bo
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:41:34 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue,  4 Jul 2017 11:40:55 +0300
Message-Id: <20170704084059.6278-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>

This series makes implementing some of the bdrv_* callbacks easier for block
drivers by passing requests to bs->file if bs->drv doesn't implement it instead
of failing, and adding default bdrv_co_get_block_status() implementations.

This is based against Kevin Wolf's block branch, commit
da4bd74d2450ab72a7c26bbabb10c6a287dd043e

v3:
  minor changes by Eric Blake's suggestion
  new patch: remove bdrv_truncate method from blkdebug

v2:
  do not pass to bs->file if bs->drv is NULL
  move bs->file check outside of bdrv_inc_in_flight() area in bdrv_co_ioctl()
  new patch: remove duplicate code from block/raw-format.c

Manos Pitsidianakis (4):
  block: Pass bdrv_* methods to bs->file by default
  block: Use defaults of bdrv_* callbacks in raw
  block: Remove bdrv_truncate callback in blkdebug
  block: Add default implementations for bdrv_co_get_block_status()

 block.c                   | 27 +++++++++++++++++++++++++--
 block/blkdebug.c          | 18 +-----------------
 block/commit.c            | 12 +-----------
 block/io.c                | 31 +++++++++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 block/raw-format.c        | 30 ------------------------------
 include/block/block_int.h | 18 ++++++++++++++++++
 7 files changed, 77 insertions(+), 71 deletions(-)

-- 
2.11.0
