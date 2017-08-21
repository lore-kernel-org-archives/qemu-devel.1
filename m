Received: from eggs.gnu.org ([2001:4830:134:3::10]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1djj5s-0005mT-6u
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1djj5r-0001Dt-D6
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:34:00 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Mon, 21 Aug 2017 12:31:44 +0300
Message-Id: <20170821093150.6783-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v6 0/6] add throttle block driver filter
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

v6:
  don't allow named group limit configuration in block/throttle.c; allow either
        -drive driver=throttle,file.filename=foo.qcow2, \
            limits.iops-total=...
      or
        -drive driver=throttle,file.filename=foo.qcow2,throttle-group=bar
  fixes suggested by berto

v5:
  fix crash in 'add aio_context field in ThrottleGroupMember'
  fix suggestions in block/throttle.c

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

Manos Pitsidianakis (6):
  block: move ThrottleGroup membership to ThrottleGroupMember
  block: add aio_context field in ThrottleGroupMember
  block: tidy ThrottleGroupMember initializations
  block: convert ThrottleGroup to object with QOM
  block: add throttle block filter driver
  qemu-iotests: add 184 for throttle filter driver

 qapi/block-core.json            |  70 +++-
 include/block/throttle-groups.h |  47 ++-
 include/qapi/qmp/qdict.h        |   1 +
 include/qemu/throttle-options.h |  60 ++--
 include/qemu/throttle.h         |   3 +
 include/sysemu/block-backend.h  |  20 +-
 block/block-backend.c           |  62 ++--
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 734 +++++++++++++++++++++++++++++-----------
 block/throttle.c                | 332 ++++++++++++++++++
 blockdev.c                      |   4 +-
 qobject/qdict.c                 |   2 +-
 tests/test-throttle.c           | 111 +++---
 util/throttle.c                 | 151 +++++++++
 block/Makefile.objs             |   1 +
 tests/qemu-iotests/184          | 244 +++++++++++++
 tests/qemu-iotests/184.out      | 339 +++++++++++++++++++
 tests/qemu-iotests/group        |   1 +
 18 files changed, 1868 insertions(+), 322 deletions(-)
 create mode 100644 block/throttle.c
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out

-- 
2.11.0
