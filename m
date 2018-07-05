Received: from eggs.gnu.org ([2001:4830:134:3::10]:58302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1Ss-0006q2-LM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1Sq-0004WU-TA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:25:52 +0200
Message-Id: <20180705102604.4986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/12] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit fe8d2d5737ab20ed0118863f5eb888cae37122=
ab:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-p=
ull-request' into staging (2018-07-04 22:38:10 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7c20c808a5cbf5d244735bc78fc3138c739c1946:

  file-posix: Unlock FD after creation (2018-07-05 11:07:58 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2: Use worker threads for compression to improve performance of
  'qemu-img convert -W' and compressed backup jobs
- blklogwrites: New filter driver to log write requests to an image in
  the dm-log-writes format
- file-posix: Fix image locking during image creation
- crypto: Fix memory leak in error path
- Error out instead of silently truncating node names

----------------------------------------------------------------
Aapo Vienamo (1):
      block: Add blklogwrites

Ari Sundholm (4):
      block: Move two block permission constants to the relevant enum
      block/blklogwrites: Change log_sector_size from int64_t to uint64_t
      block/blklogwrites: Add an option for appending to an old log
      block/blklogwrites: Add an option for the update interval of the lo=
g superblock

Kevin Wolf (2):
      block: Don't silently truncate node names
      block/crypto: Fix memory leak in create error path

Max Reitz (2):
      file-posix: Fix creation locking
      file-posix: Unlock FD after creation

Vladimir Sementsov-Ogievskiy (3):
      qemu-img: allow compressed not-in-order writes
      qcow2: refactor data compression
      qcow2: add compress threads

 qapi/block-core.json          |  38 ++-
 block/qcow2.h                 |   3 +
 include/block/block.h         |   7 +
 block.c                       |  12 +-
 block/blklogwrites.c          | 547 ++++++++++++++++++++++++++++++++++++=
++++++
 block/crypto.c                |   2 +-
 block/file-posix.c            |  21 +-
 block/qcow2.c                 | 138 ++++++++---
 qemu-img.c                    |   5 -
 MAINTAINERS                   |   6 +
 block/Makefile.objs           |   1 +
 tests/qemu-iotests/051        |  15 ++
 tests/qemu-iotests/051.out    |  23 ++
 tests/qemu-iotests/051.pc.out |  23 ++
 14 files changed, 791 insertions(+), 50 deletions(-)
 create mode 100644 block/blklogwrites.c
