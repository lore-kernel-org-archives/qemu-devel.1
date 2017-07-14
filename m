Received: from eggs.gnu.org ([2001:4830:134:3::10]:35098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAm-0002ss-NB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAj-0002md-ME
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:08 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 12:45:14 +0300
Message-Id: <20170714094521.4909-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 0/7] add throttle block driver filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This series adds a throttle block driver filter. Currently throttling is done
at the BlockBackend level. Using block driver interfaces we can move the
throttling to any point in the BDS graph using a throttle node which uses the
existing throttling code. This allows for potentially more complex
configurations (throttling at any point in the graph, chained filters)

There's also the question of how filter drivers affect the rest of the block
layer, especially live block jobs. This won't be tackled in this series though.

Manos Pitsidianakis (7):
  block: move ThrottleGroup membership to ThrottleGroupMember
  block: add aio_context field in ThrottleGroupMember
  block: tidy ThrottleGroupMember initializations
  block: convert ThrottleGroup to object with QOM
  block: add throttle block filter driver
  block: add BlockDevOptionsThrottle to QAPI
  block: add throttle block filter driver interface tests

 block/Makefile.objs             |   1 +
 block/block-backend.c           |  61 +--
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 820 +++++++++++++++++++++++++++++++---------
 block/throttle.c                | 345 +++++++++++++++++
 blockdev.c                      |   4 +-
 include/block/throttle-groups.h |  47 ++-
 include/qemu/throttle-options.h |  60 ++-
 include/qemu/throttle.h         |   3 +
 include/sysemu/block-backend.h  |  20 +-
 qapi/block-core.json            |  65 +++-
 tests/qemu-iotests/184          | 237 ++++++++++++
 tests/qemu-iotests/184.out      | 319 ++++++++++++++++
 tests/qemu-iotests/group        |   1 +
 tests/test-throttle.c           | 111 +++---
 util/throttle.c                 | 121 ++++++
 16 files changed, 1913 insertions(+), 310 deletions(-)
 create mode 100644 block/throttle.c
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out

-- 
2.11.0
