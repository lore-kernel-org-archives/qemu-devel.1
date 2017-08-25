Received: from eggs.gnu.org ([2001:4830:134:3::10]:38303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbP-0006fj-9t
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbO-0003PU-5w
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:47 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 16:23:25 +0300
Message-Id: <20170825132332.6734-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 0/6] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This series depends on my other series 'add throttle block driver filter'
currently on v9

Based-on: <20170825132028.6184-1-el13635@mail.ntua.gr>

Replacing the current I/O interface means the user will use the same options as
before and QEMU will create a hidden throttle filter node beneath the device's
BlockBackend. 

v3:
  fix suggestions by berto
  new commit: remove throttle-groups list

v2:
  new commit: require job-id when device is a node name
  new commit: remove BlockBackendPublic
  new commit: add dedicated iotest
  cleanup reference counting in block/block-backend.c functions
  add new function to get filter child bs
  take ownership of options in bdrv_new_open_driver()

Manos Pitsidianakis (7):
  block: skip implicit nodes in snapshots, blockjobs
  block: add options parameter to bdrv_new_open_driver()
  block: require job-id when device is a node name
  block: remove legacy I/O throttling
  block/throttle-groups.c: remove throttle-groups list
  block: remove BlockBackendPublic
  qemu-iotests: add 191 for legacy throttling interface

 include/block/block.h           |   2 +-
 include/block/block_int.h       |  17 +++++
 include/block/blockjob_int.h    |   4 +-
 include/block/throttle-groups.h |   2 +
 include/sysemu/block-backend.h  |  16 +---
 block.c                         |  26 ++++++-
 block/block-backend.c           | 158 ++++++++++++++++++++++++----------------
 block/commit.c                  |   4 +-
 block/mirror.c                  |   2 +-
 block/qapi.c                    |  24 +++---
 block/throttle-groups.c         | 145 ++++++++++++++++++++----------------
 block/throttle.c                |   8 ++
 block/vvfat.c                   |   2 +-
 blockdev.c                      | 136 ++++++++++++++++++++++++++++++----
 blockjob.c                      |  19 ++---
 tests/test-blockjob.c           |   9 +--
 tests/test-throttle.c           |  22 ++++--
 tests/qemu-iotests/191          | 138 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/191.out      |   5 ++
 tests/qemu-iotests/group        |   1 +
 20 files changed, 538 insertions(+), 202 deletions(-)
 create mode 100644 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out

-- 
2.11.0
