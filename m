Received: from eggs.gnu.org ([2001:4830:134:3::10]:45452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er1Y5-0000Ft-Ad
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er1Y4-0001vd-HG
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:13:33 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 14:13:13 +0100
Message-Id: <20180228131315.30194-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix fully preallocated
 truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-stable@nongnu.org

Fully preallocated truncation has a 50 % chance of working on images
files over file-posix.  It works if $SIZE % 4G < 2G, and it fails
otherwise.  To make things even more interesting, often you would not
even notice because qemu reported success even though it did nothing
(because after the successful lseek(), errno was still 0, so when the
file-posix driver tried to return a negative error code, it actually
reported success).

This issue is fixed by patch 1 in this series.  Thanks to Daniel for
reporting!


Max Reitz (2):
  block/file-posix: Fix fully preallocated truncate
  iotests: Test preallocated truncate of 2G image

 block/file-posix.c         |  5 +++--
 tests/qemu-iotests/106     | 24 ++++++++++++++++++++++++
 tests/qemu-iotests/106.out | 10 ++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.14.3
