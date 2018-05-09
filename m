Received: from eggs.gnu.org ([2001:4830:134:3::10]:42136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGRLp-0002of-Gv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGRLo-0000Gg-KB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 17:49:47 +0200
Message-Id: <20180509154949.8206-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-img: Resolve relative backing paths
 in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

The issue addressed in this series affects relative backing paths given
to qemu-img rebase.  For the rebasing operation itself, qemu-img uses
the target backing path as-is, that is, relative to its working
directory.  But after rebasing, the path is again written as-is into the
overlay, so it is now relative to the overlay.

Simple test case:
$ mkdir /tmp/foo && cd /tmp
$ qemu-img create -f qcow2 foo/base-old.qcow2 64M
Formatting 'foo/base-old.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-img create -f qcow2 foo/base-new.qcow2 64M
Formatting 'foo/base-new.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-img create -f qcow2 -b base-old.qcow2 foo/overlay.qcow2 64M
Formatting 'foo/overlay.qcow2', fmt=qcow2 size=67108864 backing_file=base-old.qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-img rebase -b base-new.qcow2 foo/overlay.qcow2
qemu-img: Could not open new backing file 'base-new.qcow2': Could not open 'base-new.qcow2': No such file or directory

Oops.  Now one may be tempted to try:

$ qemu-img rebase -b foo/base-new.qcow2 foo/overlay.qcow2
$ echo $?
0

However:

$ qemu-img info foo/overlay.qcow2
[...]
backing file: foo/base-new.qcow2 (actual path: foo/foo/base-new.qcow2)
[...]
$ qemu-io -c close foo/overlay.qcow2
can't open device foo/overlay.qcow2: Could not open backing file: Could not open 'foo/foo/base-new.qcow2': No such file or directory

Oops.

So the only way to do it before this series is:

$ qemu-img rebase -b foo/base-new.qcow2 foo/overlay.qcow2
$ qemu-img rebase -u -b base-new.qcow2 foo/overlay.qcow2

That does not seem right to me.

So this series makes qemu-img rebase always interpret the target backing
path relatively to the overlay image, because that is how we always
interpret relative backing paths.


Max Reitz (2):
  qemu-img: Resolve relative backing paths in rebase
  iotests: Add test for rebasing with relative paths

 qemu-img.c                 | 22 ++++++++++++-
 tests/qemu-iotests/024     | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/024.out | 30 +++++++++++++++++
 3 files changed, 130 insertions(+), 4 deletions(-)

-- 
2.14.3
