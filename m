Received: from eggs.gnu.org ([2001:4830:134:3::10]:33383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctigY-00071a-UQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctigX-0000qO-OB
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:36:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 30 Mar 2017 17:36:42 -0500
Message-Id: <20170330223645.349-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v7 0/3] Fix wipe of unaligned qcow2
 image [was add blkdebug tests]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v7

(which is somewhat of a misnomer for this current version of the
series, but historically correct)

v6 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01562.html

In that version, Kevin said patches 1 and 2 might be 2.9 material,
even if the rest of the series was 2.10 material. But in reviewing
patch 2, Max pointed out that my test didn't exercise a particular
corner case - and sure enough, improving the test showed that we
have a (minor) bug.  We don't discard as much of an unaligned image
as desired when discard goes through the slow path.

001/3:[----] [--] 'iotests: fix 097 when run with qcow'
002/3:[0082] [FC] 'iotests: Improve image-clear tests on non-aligned image'
003/3:[down] 'qcow2: Discard unaligned tail when wiping image'

(the blkdebug enhancements from the rest of v6 will be rebased
and posted as v8 once 2.10 is final)

Daniel P. Berrange (1):
  iotests: fix 097 when run with qcow

Eric Blake (2):
  iotests: Improve image-clear tests on non-aligned image
  qcow2: Discard unaligned tail when wiping image

 block/qcow2-cluster.c      |  10 +--
 tests/qemu-iotests/097     |  27 +++----
 tests/qemu-iotests/097.out | 180 ++++++++++++---------------------------------
 tests/qemu-iotests/176     | 131 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/176.out | 150 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 345 insertions(+), 154 deletions(-)
 create mode 100755 tests/qemu-iotests/176
 create mode 100644 tests/qemu-iotests/176.out

-- 
2.9.3
