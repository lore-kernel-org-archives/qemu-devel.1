Received: from eggs.gnu.org ([2001:4830:134:3::10]:34488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCSoL-00041u-FS
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 12:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCSoK-0004gW-Ip
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 12:34:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 28 Apr 2018 18:34:40 +0200
Message-Id: <20180428163442.6238-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qcow2: Repair OFLAG_COPIED when fixing
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


Max Reitz (2):
  qcow2: Repair OFLAG_COPIED when fixing leaks
  iotests: Repairing error during snapshot deletion

 block/qcow2-refcount.c     | 25 ++++++++-----
 tests/qemu-iotests/217     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/217.out | 42 ++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 149 insertions(+), 8 deletions(-)
 create mode 100755 tests/qemu-iotests/217
 create mode 100644 tests/qemu-iotests/217.out

-- 
2.14.3
