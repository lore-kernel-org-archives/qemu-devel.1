Received: from eggs.gnu.org ([2001:4830:134:3::10]:45314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfNun-0003OF-Fd
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfNum-0005Zl-97
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:08:37 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed,  9 Aug 2017 13:07:27 +0300
Message-Id: <20170809100734.17540-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v4 0/7] add throttle block driver filter
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

This series adds a throttle block driver filter. Currently throttling is done
at the BlockBackend level. Using block driver interfaces we can move the
throttling to any point in the BDS graph using a throttle node which uses the
existing throttling code. This allows for potentially more complex
configurations (throttling at any point in the graph, chained filters)

v4:
  fix suggestions in block/throttle.c
  fix suggestions in block/throttle_groups.c
  add doc note in BlockDevOptionsThrottle
  
v3:
  fix style error in 'add aio_context field in ThrottleGroupMember'

v2:
  change QOM throttle group object name
  print valid ranges for uint on error
  move frees in throttle_group_obj_finalize()
  split throttle_group_{set,get}()
  add throttle_recurse_is_first_non_filter()

Manos Pitsidianakis (7):
  block: move ThrottleGroup membership to ThrottleGroupMember
  block: add aio_context field in ThrottleGroupMember
  block: tidy ThrottleGroupMember initializations
  block: convert ThrottleGroup to object with QOM
  block: add throttle block filter driver
  block: add BlockDevOptionsThrottle to QAPI
  block: add throttle block filter driver interface tests

 block/Makefile.objs             |   1 +
 block/block-backend.c           |  62 ++--
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 730 +++++++++++++++++++++++++++++-----------
 block/throttle.c                | 315 +++++++++++++++++
 blockdev.c                      |   4 +-
 include/block/throttle-groups.h |  47 ++-
 include/qemu/throttle-options.h |  60 ++--
 include/qemu/throttle.h         |   3 +
 include/sysemu/block-backend.h  |  20 +-
 qapi/block-core.json            |  70 +++-
 tests/qemu-iotests/184          | 310 +++++++++++++++++
 tests/qemu-iotests/184.out      | 422 +++++++++++++++++++++++
 tests/qemu-iotests/group        |   1 +
 tests/test-throttle.c           | 111 +++---
 util/throttle.c                 | 151 +++++++++
 16 files changed, 1995 insertions(+), 320 deletions(-)
 create mode 100644 block/throttle.c
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out

-- 
2.11.0
