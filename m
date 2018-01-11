Received: from eggs.gnu.org ([2001:4830:134:3::10]:57191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuG-0004sO-0n
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuF-000056-2m
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:52:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:15 +0100
Message-Id: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/10] x-blockdev-create for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This series implements a minimal QMP command that allows to create an
image format on a given block node. The interface is still going to
change to some kind of an async command (possibly a block job), so I
prefixed x- for now.

At this point, I'm mostly interested in comments about
BlockdevCreateOptions in the schema, the .bdrv_co_create callback and
the way that legacy .bdrv_create is implemented in qcow2 now.

It looks to me as if we will have to keep .bdrv_create in addition to
the new .bdrv_co_create for a while in all drivers, where the
implementation of .bdrv_create would call .bdrv_co_create like this
series does it for qcow2. We'll only be able to drop the old interface
after deprecating and eventually removing all of the driver-specific
compatibility work that remains. The example of qcow2 shows that the
"translation" from old to new is managable, but there are a few
differences.

Kevin Wolf (10):
  block/qapi: Introduce BlockdevCreateOptions
  block/qapi: Add qcow2 create options to schema
  qcow2: Let qcow2_create() handle protocol layer
  qcow2: Pass BlockdevCreateOptions to qcow2_create2()
  qcow2: Use BlockdevRef in qcow2_create2()
  qcow2: Use QCryptoBlockCreateOptions in qcow2_create2()
  qcow2: Handle full/falloc preallocation in qcow2_create2()
  util: Add qemu_opts_to_qdict_filtered()
  qcow2: Use visitor for options in qcow2_create()
  block: x-blockdev-create QMP command

 qapi/block-core.json       | 107 ++++++++++++
 include/block/block.h      |   1 +
 include/block/block_int.h  |   2 +
 include/qemu/option.h      |   2 +
 block.c                    |  87 ++++++++++
 block/qcow2.c              | 395 +++++++++++++++++++++++++++++----------------
 util/qemu-option.c         |  28 +++-
 tests/qemu-iotests/049.out |  10 +-
 8 files changed, 486 insertions(+), 146 deletions(-)

-- 
2.13.6
