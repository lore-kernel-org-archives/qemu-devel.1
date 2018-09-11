Received: from eggs.gnu.org ([2001:4830:134:3::10]:38094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzpau-0005UW-Kt
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzpap-00025w-Ic
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:49:08 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 16:43:49 -0400
Message-Id: <cover.1536698311.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block/rbd: enable filename parsing on
 open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com

Changes from v1:

Patch 1: Don't pass unused BlockDriverState to helper function

Patch 2: Do not allow mixed usage; fail if keyvalue is present [Eric]
         Add deprecation warning [John]
         Pull legacy parsing code into function [John]
         Fixed filename leak

Patch 3: New; iotest 231. [Eric]


iotest failure on current master:

 QA output created by 231
-qemu-img: RBD options encoded in the filename as keyvalue pairs is deprecated.  Future versions may cease to parse these options in the future.
-unable to get monitor info from DNS SRV with service name: ceph-mon
-no monitors specified to connect to.
-qemu-img: Could not open 'json:{'file.driver':'rbd','file.filename':'rbd:rbd/bogus:conf=BOGUS_CONF'}': error connecting: No such file or directory
+qemu-img: Could not open 'json:{'file.driver':'rbd','file.filename':'rbd:rbd/bogus:conf=BOGUS_CONF'}': Parameter 'pool' is missing
 unable to get monitor info from DNS SRV with service name: ceph-mon
 no monitors specified to connect to.
 qemu-img: Could not open 'json:{'file.driver':'rbd','file.pool':'rbd','file.image':'bogus','file.conf':'BOGUS_CONF'}': error connecting: No such file or directory
Failures: 231
Failed 1 of 1 tests



Jeff Cody (3):
  block/rbd: pull out qemu_rbd_convert_options
  block/rbd: Attempt to parse legacy filenames
  block/rbd: add iotest for rbd legacy keyvalue filename parsing

 block/rbd.c                | 89 ++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/231     | 62 ++++++++++++++++++++++++++
 tests/qemu-iotests/231.out |  9 ++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 147 insertions(+), 14 deletions(-)
 create mode 100755 tests/qemu-iotests/231
 create mode 100644 tests/qemu-iotests/231.out

-- 
2.17.1
