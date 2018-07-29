Received: from eggs.gnu.org ([2001:4830:134:3::10]:33888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF2-00020d-8e
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF0-0000XV-Oz
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 30 Jul 2018 00:27:38 +0300
Message-Id: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/6] qcow2: Make the L2 cache cover the whole
 image by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

This series makes the qcow2 L2 cache cover the entire image by default.
The importance of this change is in noticeable performance improvement,
especially with heavy random I/O. The memory overhead is very small:
only 1 MB of cache for every 8 GB of image size. On systems with very
limited RAM the maximal cache size can be limited by the existing
cache-size and l2-cache-size options.

The L2 cache is also resized accordingly, by default, if the image is
resized.

The reasons for making this behavior default, unlike in the patches I
have sent previously, are the following:
1) Unelegant complications with making an option to accept either a
   size or a string, while outputting a proper error message.
2) More bulky logic to sort out what to do if the image is being resized
   but the (defined) overall cache size is too small to contain the
   new l2-cache-size.
(Making this behavior default resolves all of these technical issues
neatly)
3) The performance gain (as measured by fio in random read/write tests)
   can be as high as 50%, or even more, so this would be a reasonable
   default behavior.
4) The memory overhead is really small for the gain, and in cases when
   memory economy is critical, the maximal cache values can always be
   set by the appropriate options.

Leonid Bloch (6):
  Update .gitignore
  qcow2: A grammar fix in conflicting cache sizing error message
  qcow2: Options' documentation fixes
  qcow2: Update total_sectors when resizing the image
  qcow2: Make the default L2 cache sufficient to cover the entire image
  qcow2: Resize the cache upon image resizing

 .gitignore                 |  1 +
 block/qcow2.c              | 20 +++++++++++++-------
 block/qcow2.h              |  4 ----
 docs/qcow2-cache.txt       | 30 +++++++++++++++++-------------
 qapi/block-core.json       |  6 +++---
 qemu-options.hx            | 15 +++++++++------
 tests/qemu-iotests/103.out |  4 ++--
 tests/qemu-iotests/137.out |  2 +-
 8 files changed, 46 insertions(+), 36 deletions(-)

-- 
2.17.1
