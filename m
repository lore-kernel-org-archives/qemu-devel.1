Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9eDh-0002F5-0K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 18:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9eDg-0000wX-32
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 18:09:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 21 Apr 2018 00:09:10 +0200
Message-Id: <20180420220913.27000-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block/file-posix: File locking during
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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


Max Reitz (3):
  block/file-posix: Pass FD to locking helpers
  block/file-posix: File locking during creation
  iotests: Add creation test to 153

 block/file-posix.c         | 68 ++++++++++++++++++++++++++++++++++++----------
 tests/qemu-iotests/153     | 18 ++++++++++++
 tests/qemu-iotests/153.out | 13 +++++++++
 3 files changed, 84 insertions(+), 15 deletions(-)

-- 
2.14.3
