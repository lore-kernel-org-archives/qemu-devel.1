Received: from eggs.gnu.org ([2001:4830:134:3::10]:57480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGVGu-00087r-9a
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGVGt-00045h-DE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:01:08 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 22:00:57 +0200
Message-Id: <20180509200059.31125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] qcow2: Repair OFLAG_COPIED when fixing
 leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Suppose you have an image with consistent OFLAG_COPIED and refcounts.
Now further suppose that image has leaked clusters (single reference,
but refcount 2).  When checking such an image with qemu-img check, it
will notify you of the leakage, and that's it.

Now when trying to repair that image, you naturally use -r leaks because
that should be sufficient and you want to give qemu-img check just as
many "permissions" as it needs so it doesn't destroy your image by
accident.  But while the qcow2 driver will fix the refcounts, alas! it
will now complain about OFLAG_COPIED because that should be set now.
However, it will not set that without -r all.  So, congratulations, now
you have an image that qemu-img check tells you is really corrupted.

This series makes -r leaks fix OFLAG_COPIED as well, but only if
repairing the refcounts was completely successful.

There is a Red Hat Bugzilla entry here:
https://bugzilla.redhat.com/show_bug.cgi?id=1527085

...but I'm afraid the bug description is set to confidential, although I
don't know why.  Sorry. :-/
For everyone who cannot read it, let's say the test case in this series
may very well be a good indication of what you don't see.


v2:
- Reworded the comment in patch 2 on why the test does not support
  refcount_bits=1 -- it's not just because of the snapshotting, but
  mostly because we test OFLAG_COPIED and refcount_bits=1 won't get us
  far there [Eric]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[----] [--] 'qcow2: Repair OFLAG_COPIED when fixing leaks'
002/2:[0003] [FC] 'iotests: Repairing error during snapshot deletion'


Max Reitz (2):
  qcow2: Repair OFLAG_COPIED when fixing leaks
  iotests: Repairing error during snapshot deletion

 block/qcow2-refcount.c     | 25 ++++++++-----
 tests/qemu-iotests/217     | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/217.out | 42 ++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 150 insertions(+), 8 deletions(-)
 create mode 100755 tests/qemu-iotests/217
 create mode 100644 tests/qemu-iotests/217.out

-- 
2.14.3
