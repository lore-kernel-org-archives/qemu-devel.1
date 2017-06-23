Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0p-0001ah-8T
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0n-0004TI-Jm
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:35 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:52 +0300
Message-Id: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 0/8] I/O Throtting block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This patch series adds a filter driver that uses the existing I/O throttle
code. Throttle groups can be then created and managed with QOM.

The 'remove legacy I/O throttling' patch replaces existing interface (command
line, qmp, hmp) to use the throttle filter transparently so as to not break
backwards compatibility. The created throttle node is stored in a field in
BlockBackendPublic so that the legacy interface can access it. The patch
currently breaks test 129 which commits, mirrors and backups a device with
legacy throttling options. I assume the internal throttling node affects this,
so I'd like some advice on how to approach this.

Test 139 could be updated to include the throttle driver though I'm not sure if
it's needed.

I'm also not sure about the test I created for this (last patch).

v2: 
- Move throttle group membership to ThrottleGroupMember struct
v3:
- add ThrottleGroup object
- convert legacy interface to use the driver
- add tests


Manos Pitsidianakis (8):
  block: move ThrottleGroup membership to ThrottleGroupMember
  block: Add aio_context field in ThrottleGroupMember
  block: add throttle block filter driver
  block: convert ThrottleGroup to object with QOM
  block: add BlockDevOptionsThrottle to QAPI
  block: add options parameter to bdrv_new_open_driver()
  block: remove legacy I/O throttling
  block: add throttle block filter driver interface tests

 block.c                         |  13 +-
 block/Makefile.objs             |   1 +
 block/block-backend.c           | 151 +++++----
 block/commit.c                  |   4 +-
 block/mirror.c                  |   2 +-
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 660 ++++++++++++++++++++++++++++++----------
 block/throttle.c                | 431 ++++++++++++++++++++++++++
 block/vvfat.c                   |   2 +-
 blockdev.c                      |  55 +++-
 include/block/block.h           |   2 +-
 include/block/throttle-groups.h |  15 +-
 include/qemu/throttle-options.h |  60 ++--
 include/qemu/throttle.h         |  31 ++
 include/sysemu/block-backend.h  |  26 +-
 qapi/block-core.json            |  19 +-
 tests/qemu-iotests/184          | 144 +++++++++
 tests/qemu-iotests/184.out      |  31 ++
 tests/qemu-iotests/group        |   1 +
 tests/test-throttle.c           | 125 ++++----
 20 files changed, 1441 insertions(+), 340 deletions(-)
 create mode 100644 block/throttle.c
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out

-- 
2.11.0
