Received: from eggs.gnu.org ([2001:4830:134:3::10]:55301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUyB5-00008a-Lg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUyB4-0002ax-RP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:38:23 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 11 Jul 2017 19:37:44 +0300
Message-Id: <20170711163748.17817-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v4 0/4] block: Block driver callbacks fixes
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
filters by passing requests to bs->file if bs->drv doesn't implement it instead
of failing, and adding default bdrv_co_get_block_status() implementations.

This is based against Kevin Wolf's block branch, commit
da4bd74d2450ab72a7c26bbabb10c6a287dd043e

v4:
  forward only for block filters
  new patch: remove bdrv_media_changed
  dropped commit `block: Use defaults of bdrv_* callbacks in raw`, since raw is
  not a filter driver and is incompatible with the changes.

v3:
  minor changes by Eric Blake's suggestion
  new patch: remove bdrv_truncate method from blkdebug

v2:
  do not pass to bs->file if bs->drv is NULL
  move bs->file check outside of bdrv_inc_in_flight() area in bdrv_co_ioctl()
  new patch: remove duplicate code from block/raw-format.c

Manos Pitsidianakis (4):
  block: pass bdrv_* methods to bs->file by default in block filters
  block: remove bdrv_media_changed
  block: remove bdrv_truncate callback in blkdebug
  block: add default implementations for bdrv_co_get_block_status()

 block.c                   | 35 +++++++++++++++++++----------------
 block/blkdebug.c          | 19 ++-----------------
 block/commit.c            | 12 +-----------
 block/io.c                | 26 ++++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 block/raw-format.c        |  6 ------
 include/block/block.h     |  1 -
 include/block/block_int.h | 25 +++++++++++++++++++++++--
 8 files changed, 72 insertions(+), 64 deletions(-)

-- 
2.11.0
