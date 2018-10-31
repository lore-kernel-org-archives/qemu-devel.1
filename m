Received: from eggs.gnu.org ([2001:4830:134:3::10]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gHtBi-0008VE-TT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gHtBf-0001Wq-3w
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:17:46 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 31 Oct 2018 18:16:36 +0200
Message-Id: <cover.1541002357.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/2] Update the inherits_from pointer after
 stream and commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi all,

when you open an image [A] with a few more images on the backing chain
you get something like this:

    [E] <- [D] <- [C] <- [B] <- [A]

Here you can go from [A] to [E] by following the bs->backing
pointer. At the same time each one of the backing files has an
'inherits_from' attribute pointing to their parent, so you can go from
[E] to [A] following the inherits_from pointer.

'inherits_from' is used on bdrv_reopen_queue_child() to decide if a
node's children must be reopened together with the parent and inherit
its options.

If some the intermediate nodes are removed (either by block-stream or
by block-commit) you end up with something like this:

   [E] <- [A]

In this case we would expect [E] to inherit from [A], however its
inherits_from pointer is NULL and trying to change its options by
reopening [A] with backing.option=value fails.

This patch series fixes this. See each individual patch for more
details.

Regards,

Berto

Alberto Garcia (2):
  block: Update BlockDriverState.inherits_from on bdrv_set_backing_hd()
  block: Update BlockDriverState.inherits_from on
    bdrv_drop_intermediate()

 block.c                    |  37 ++++++++++++
 tests/qemu-iotests/161     | 137 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/161.out |  39 +++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 214 insertions(+)
 create mode 100755 tests/qemu-iotests/161
 create mode 100644 tests/qemu-iotests/161.out

-- 
2.11.0
