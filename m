Received: from eggs.gnu.org ([2001:4830:134:3::10]:50267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisa-0007I3-Gu
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisX-0003B8-Bq
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:03 +0200
Message-Id: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/18] block: Configuration fixes and rbd
 authentication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

PATCH 01-17 are configuration fixes and cleanup, in particular
-blockdev driver=nfs,... and -drive driver=(nbd|sheepdog|ssh),... with
non-string scalars.

PATCH 18-19 provide support for configuring rbd authentication.

I'm happy to split the series if that helps.

Since the RFC post, I amended the documentation of the rbd
authentication parameters, and squashed PATCH 04 into 03.

Jeff Cody tested the RFC on his Ceph rig.  All results match
expectations.

The series clashes with Max's "[PATCH 00/13] block: Try to create well
typed json:{} filenames", but Max has rebased his work on mine.

Markus Armbruster (17):
  rbd: Drop deprecated -drive parameter "filename"
  iscsi: Drop deprecated -drive parameter "filename"
  qobject: Move block-specific qdict code to block-qdict.c
  block: Fix -blockdev for certain non-string scalars
  block: Fix -drive for certain non-string scalars
  block: Clean up a misuse of qobject_to() in .bdrv_co_create_opts()
  block: Factor out qobject_input_visitor_new_flat_confused()
  block: Make remaining uses of qobject input visitor more robust
  block-qdict: Simplify qdict_flatten_qdict()
  block-qdict: Tweak qdict_flatten_qdict(), qdict_flatten_qlist()
  block-qdict: Clean up qdict_crumple() a bit
  block-qdict: Simplify qdict_is_list() some
  check-block-qdict: Rename qdict_flatten()'s variables for clarity
  check-block-qdict: Cover flattening of empty lists and dictionaries
  block: Fix -blockdev / blockdev-add for empty objects and arrays
  rbd: New parameter auth-client-required
  rbd: New parameter key-secret

Max Reitz (1):
  block: Add block-specific QDict header

 MAINTAINERS               |   2 +
 block.c                   |   1 +
 block/crypto.c            |   6 +-
 block/gluster.c           |   1 +
 block/iscsi.c             |  24 +-
 block/nbd.c               |  16 +-
 block/nfs.c               |   8 +-
 block/parallels.c         |  11 +-
 block/qcow.c              |  11 +-
 block/qcow2.c             |  11 +-
 block/qed.c               |  11 +-
 block/quorum.c            |   1 +
 block/rbd.c               |  85 +++--
 block/sheepdog.c          |  23 +-
 block/snapshot.c          |   1 +
 block/ssh.c               |  16 +-
 block/vdi.c               |   4 +-
 block/vhdx.c              |  11 +-
 block/vpc.c               |  11 +-
 block/vvfat.c             |   1 +
 block/vxhs.c              |   1 +
 blockdev.c                |   1 +
 include/block/qdict.h     |  34 ++
 include/qapi/qmp/qdict.h  |  17 -
 qapi/block-core.json      |  19 +
 qobject/Makefile.objs     |   1 +
 qobject/block-qdict.c     | 722 ++++++++++++++++++++++++++++++++++++++
 qobject/qdict.c           | 628 ---------------------------------
 tests/Makefile.include    |   4 +
 tests/check-block-qdict.c | 690 ++++++++++++++++++++++++++++++++++++
 tests/check-qdict.c       | 641 ---------------------------------
 tests/check-qobject.c     |   1 +
 tests/test-replication.c  |   1 +
 util/qemu-config.c        |   1 +
 34 files changed, 1577 insertions(+), 1439 deletions(-)
 create mode 100644 include/block/qdict.h
 create mode 100644 qobject/block-qdict.c
 create mode 100644 tests/check-block-qdict.c

-- 
2.17.1
