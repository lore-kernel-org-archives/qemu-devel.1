Received: from eggs.gnu.org ([2001:4830:134:3::10]:37511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zk-0002KO-Pg
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zj-0001wS-UF
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:36 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 14 Feb 2018 21:49:12 +0100
Message-Id: <20180214204915.7980-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block/ssh: Add basic .bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>

For (x-)blockdev-create, all protocol drivers that support image
creation also need to offer a .bdrv_truncate() implementation that
matches in features.  A previous series of mine brought gluster's and
sheepdog's implementation up to par regarding preallocated truncation;
but I forgot about drivers that have a .bdrv_create() but no
.bdrv_truncate() at all.

There is only one of these, and that is ssh.  Since libssh2 does not
seem to know any way of truncating files, we can only support growing
files -- but that is what we need for (x-)blockdev-create.

Note that there are also drivers which do not support growing files,
namely iscsi and file-posix for host devices (maybe more?  I hope not).
But these also pretty much ignore the specified size on .bdrv_create()
and just use the size of the existing device.  They just check that the
specified size does not exceed the actual size, so that pretty much
matches what their .bdrv_truncate() supports, and we should be fine
there.


Max Reitz (3):
  block/ssh: Pull ssh_grow_file() from ssh_create()
  block/ssh: Make ssh_grow_file() blocking
  block/ssh: Add basic .bdrv_truncate()

 block/ssh.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 8 deletions(-)

-- 
2.14.3
