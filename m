Received: from eggs.gnu.org ([2001:4830:134:3::10]:49729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGX1w-0007Hg-DZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGX1v-0006mh-8l
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:53:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 23:53:33 +0200
Message-Id: <20180509215336.31304-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block/file-posix: File locking during
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

[Unchanged text from v1 ahead]

Currently we do not take permissions on a file while it is being
created.  That is a bit sad.  The simplest way to test this is the
following:

    $ qemu-img create -f qcow2 foo.qcow2 64M
    Formatting 'foo.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
    $ qemu-img convert -f qcow2 -O qcow2 foo.qcow2 foo.qcow2
    qemu-img: foo.qcow2: error while converting qcow2: Failed to get "write" lock
    Is another process using the image?
    $ qemu-img info foo.qcow2
    image: foo.qcow2
    file format: raw
    virtual size: 0 (0 bytes)
    disk size: 0

(See also https://bugzilla.redhat.com/show_bug.cgi?id=1519144)

Here is what's happening: file-posix opens the file with
O_CREAT | O_TRUNC, thus truncating the file to 0.  Then qcow2 tries to
format it, but fails because it needs the WRITE permission to do so.  So
it cannot format it and the file stays empty.

We should actually take a WRITE and a RESIZE permission before we
truncate the file, and this is what this series does.

I personally consider the solution taken here a bit of a hack, but it
works and we don't have any locking in any drivers but file-posix
anyway, so it isn't lacking anything in that regard.  Integrating it in
blockdev-create might be possible, but there are two issues:
(1) It would be harder.
(2) What would we do anyway?  We'd advise protocol drivers to take WRITE
    and RESIZE permissions before they truncate a file to be empty...
    Well, and then they'd do exactly what file-posix is made to do in
    this series.

So basically what I consider a hack could be seen as exactly the right
way to tackle the issue: Protocol drivers have to ensure the correct
permissions (and they have to choose what those are) are applied before
changing any file -- which is what this series implements.


v2:
- Patch 2: [Fam]
  - Add a note that while not sharing the RESIZE permission does protect
    us from other block-layer-infused programs resizing the file while
    raw_co_create() is active; it does not protect against anyone
    resizing the file afterwards.
  - Drop the unnecessary second raw_apply_lock_bytes()


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[----] [--] 'block/file-posix: Pass FD to locking helpers'
002/3:[0016] [FC] 'block/file-posix: File locking during creation'
003/3:[----] [--] 'iotests: Add creation test to 153'


Max Reitz (3):
  block/file-posix: Pass FD to locking helpers
  block/file-posix: File locking during creation
  iotests: Add creation test to 153

 block/file-posix.c         | 64 +++++++++++++++++++++++++++++++++++-----------
 tests/qemu-iotests/153     | 18 +++++++++++++
 tests/qemu-iotests/153.out | 13 ++++++++++
 3 files changed, 80 insertions(+), 15 deletions(-)

-- 
2.14.3
