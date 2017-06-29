Received: from eggs.gnu.org ([2001:4830:134:3::10]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQeQO-0002bA-6J
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQeQN-0005PR-CL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:44:20 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 29 Jun 2017 21:43:17 +0300
Message-Id: <20170629184320.7151-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 0/3] block: block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This series makes implementing some of the bdrv_* callbacks easier for block
drivers by passing requests to bs->file if bs->drv doesn't implement it instead
of failing, and adding default bdrv_co_get_block_status() implementations.

This is based against Kevin Wolf's block branch, commit
0dd2ec6bc46bd93ea0b9df602962883417f31400

v2:
  do not pass to bs->file if bs->drv is NULL
  move bs->file check outside of bdrv_inc_in_flight() area in bdrv_co_ioctl()
  new patch: remove duplicate code from block/raw-format.c

Manos Pitsidianakis (3):
  block: pass bdrv_* methods to bs->file by default
  block: use defaults of bdrv_* callbacks in raw
  block: add default implementations for bdrv_co_get_block_status()

 block.c                   | 27 +++++++++++++++++++++++++--
 block/blkdebug.c          | 12 +-----------
 block/commit.c            | 12 +-----------
 block/io.c                | 29 +++++++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 block/raw-format.c        | 32 +-------------------------------
 include/block/block_int.h | 16 ++++++++++++++++
 7 files changed, 74 insertions(+), 66 deletions(-)

-- 
2.11.0
