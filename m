Received: from eggs.gnu.org ([2001:4830:134:3::10]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVg6Y-0003p0-Mu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVg6X-0007A2-Gv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:32:38 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 13 Jul 2017 18:30:24 +0300
Message-Id: <20170713153028.31065-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v6 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This series makes implementing some of the bdrv_* callbacks easier for block
filters by passing requests to bs->file if bs->drv doesn't implement it instead
of failing, and adding default bdrv_co_get_block_status() implementations.

This is based against commit ced1484322 of 
https://github.com/XanClic/qemu.git block branch

v6:
  fix parameter order in bdrv_truncate() return call in 
      block: pass bdrv_* methods to bs->file by default in block filters

v5:
  rebase against ced1484322 of https://github.com/XanClic/qemu.git block to fix
  apply conflicts
  add suggested commit message in block: remove unused bdrv_media_changed
  add is_filter implication in commit message of block: remove bdrv_truncate
  callback in blkdebug

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
  block: remove unused bdrv_media_changed
  block: remove bdrv_truncate callback in blkdebug
  block: add default implementations for bdrv_co_get_block_status()

 block.c                   | 35 +++++++++++++++++++----------------
 block/blkdebug.c          | 20 ++------------------
 block/commit.c            | 12 +-----------
 block/io.c                | 26 ++++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 block/raw-format.c        |  6 ------
 include/block/block.h     |  1 -
 include/block/block_int.h | 25 +++++++++++++++++++++++--
 8 files changed, 72 insertions(+), 65 deletions(-)

-- 
2.11.0
