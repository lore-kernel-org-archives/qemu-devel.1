Received: from eggs.gnu.org ([2001:4830:134:3::10]:44209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCtNW-0004Dk-9t
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCtNV-0006LB-9z
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:52:30 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 May 2017 21:52:14 +0200
Message-Id: <20170522195217.12991-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block: Fix backing paths for filenames
 with colons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

There are (at least) two issues with filenames that contain colons when
trying to use relative backing filenames with them, for each of which
there is a patch in this series.

The first patch fixes an issue in the general block layer
(path_combine() does not have the same opinion on what constitutes a
protocol prefix as path_has_protocl()), the second fixes an issue in
file-* (when stripping off the optional "file:" prefix we should not
create a filename that seems to have another valid protocol prefix).

The third patch adds a test.


Bonus info: The following is something I did not change, although it is
weird:
$ mkdir foo && cd foo
$ ../qemu-img create -f qcow2 file:image:base.qcow2 64M
Formatting 'file:image:base.qcow2', fmt=qcow2 size=67108864
    encryption=off cluster_size=65536 lazy_refcounts=off
    refcount_bits=16
$ ../qemu-img create -f qcow2 -b file:image:base.qcow2 file:image:top.qcow2
Formatting 'file:image:top.qcow2', fmt=qcow2 size=67108864
    backing_file=file:image:base.qcow2 encryption=off
    cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ cd ..
$ ./qemu-img info foo/image:top.qcow2
image: foo/image:top.qcow2
file format: qcow2
virtual size: 64M (67108864 bytes)
disk size: 196K
cluster_size: 65536
backing file: file:image:base.qcow2
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
$ ./qemu-io foo/image:top.qcow2
can't open device foo/image:top.qcow2: Could not open backing file:
    Could not open './image:base.qcow2': No such file or directory

Patch 3 adds a comment to the test which explains this behavior in a bit
more detail, but the gist is this: qemu generally thinks that
protocol-prefixed filenames are absolute filenames; but from a
file-posix perspective, "file:foo" is still a relative filename.

I think the above behavior is what we want and that it's the best we can
do, but it still is weird, so I just wanted to mention it.


v2:
- Kept patch 1 unchanged
- Added patch 2
- Extended patch 3 (did NOT change the patch title)


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[----] [--] 'block: Fix backing paths for filenames with colons'
002/3:[down] 'block/file-*: *_parse_filename() and colons'
003/3:[0036] [FC] 'iotests: Add test for colon handling'


Max Reitz (3):
  block: Fix backing paths for filenames with colons
  block/file-*: *_parse_filename() and colons
  iotests: Add test for colon handling

 include/block/block_int.h  |   3 ++
 block.c                    |  50 ++++++++++++++++++---
 block/file-posix.c         |  17 ++------
 block/file-win32.c         |  12 +-----
 tests/qemu-iotests/126     | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/126.out |  23 ++++++++++
 tests/qemu-iotests/group   |   1 +
 7 files changed, 182 insertions(+), 29 deletions(-)
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out

-- 
2.9.4
