Received: from eggs.gnu.org ([2001:4830:134:3::10]:55965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBX0i-0005Qf-6u
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 22:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBX0h-0006AQ-DT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 22:51:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 25 Apr 2018 21:51:23 -0500
Message-Id: <20180426025129.621969-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/6] minor qcow2 compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berto@igalia.com, qemu-block@nongnu.org

Even though v5 was posted earlier today, it was worth a respin:
- 2/6: add R-b [Berto]
- 4/6, 6/6: improve commit messages [Max]
- 5/6: new patch, with an iotests proving that 4/6 is a bug fix [Max]

The new test is rather slow (nearly 90 seconds for me using
tmpfs) unless it skips entirely (such as testing on ext4); ideas
for speeding it up are welcome (translation: maybe qemu should
optimize the search for the next available cluster to allocate,
and/or qemu-img check should be faster at reporting leaked
clusters)

001/6:[----] [--] 'qcow2: Prefer byte-based calls into bs->file'
002/6:[----] [--] 'qcow2: Document some maximum size constraints'
003/6:[----] [--] 'qcow2: Reduce REFT_OFFSET_MASK'
004/6:[----] [--] 'qcow2: Don't allow overflow during cluster allocation'
005/6:[down] 'iotests: Add new test 214 for max compressed cluster offset'
006/6:[----] [--] 'qcow2: Avoid memory over-allocation on compressed images'

Eric Blake (6):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Document some maximum size constraints
  qcow2: Reduce REFT_OFFSET_MASK
  qcow2: Don't allow overflow during cluster allocation
  iotests: Add new test 214 for max compressed cluster offset
  qcow2: Avoid memory over-allocation on compressed images

 docs/interop/qcow2.txt     | 40 +++++++++++++++++--
 block/qcow2.h              |  8 +++-
 block/qcow2-cluster.c      | 32 +++++++++------
 block/qcow2-refcount.c     | 27 ++++++++-----
 block/qcow2.c              |  2 +-
 tests/qemu-iotests/214     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out | 54 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 234 insertions(+), 27 deletions(-)
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out

-- 
2.14.3
