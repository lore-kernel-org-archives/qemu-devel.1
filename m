Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC69n-0005oP-SR
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC69m-0006Wn-NJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:23:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 27 Apr 2018 17:23:10 +0100
Message-Id: <20180427162312.18583-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Sergio Lopez <slp@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Add comment on !__linux__ situation [Fam]
 * Add file-posix.c x-check-cache-dropped=on|off option [DaveG, Kevin]

file-posix.c only supports shared storage live migration with -drive
cache.direct=off due to cache consistency issues.  There are two main shared
storage configurations: files on NFS and host block devices on SAN LUNs.

The problem is that QEMU starts on the destination host before the source host
has written everything out to the disk.  The page cache on the destination host
may contain stale data read when QEMU opened the image file (before migration
handover).  Using O_DIRECT avoids this problem but prevents users from taking
advantage of the host page cache.

Although cache=none is the recommended setting for virtualization use cases,
there are scenarios where cache=writeback makes sense.  If the guest has much
less RAM than the host or many guests share the same backing file, then the
host page cache can significantly improve disk I/O performance.

This patch series implements .bdrv_co_invalidate_cache() for block/file-posix.c
on Linux so that shared storage live migration works.  I have sent it as an RFC
because cache consistency is not binary, there are corner cases which I've
described in the actual patch, and this may require more discussion.

Regarding NFS, QEMU relies on O_DIRECT rather than the close-to-open
consistency model (see nfs(5)), which is the basic guarantee provided by NFS.
After this patch cache consistency is no longer provided by O_DIRECT.

This patch series relies on fdatasync(2) (source) +
posix_fadvise(POSIX_FADV_DONTNEED) (destination) instead.  I believe it is safe
for both NFS and SAN LUNs.  Maybe we should use fsync(2) instead of
fdatasync(2) so that NFS has up-to-date inode metadata?

Stefan Hajnoczi (2):
  block/file-posix: implement bdrv_co_invalidate_cache() on Linux
  block/file-posix: add x-check-page-cache=on|off option

 qapi/block-core.json |   7 ++-
 block/file-posix.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 3 deletions(-)

-- 
2.14.3
