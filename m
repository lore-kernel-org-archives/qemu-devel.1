Received: from eggs.gnu.org ([2001:4830:134:3::10]:47021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnIcy-0003yZ-9i
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnIcv-00035E-1z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:11:28 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed,  8 Aug 2018 10:10:46 +0300
Message-Id: <20180808071051.30628-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/5] qcow2: Make the L2 cache cover the
 whole image by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

This series makes the qcow2 L2 cache cover the entire image by default.
The importance of this change is in noticeable performance improvement,
especially with heavy random I/O. The memory overhead is not big in most
cases, as only 1 MB of cache for every 8 GB of image size is used.
For cases with very large images and/or small cluster sizes, or systems
with limited RAM resources, there is an upper limit on the default L2
cache: 32 MB. To modify this limit one can use the already existing
'l2-cache-size' and 'cache-size' options. Moreover, this fixes the
behavior of 'l2-cache-size', as it was documented as the *maximum* L2
cache size, but in practice behaved as the absolute size.

To compensate the memory overhead which may be increased following this
behavior, the default cache-clean-interval is set to 30 seconds by
default (was disabled by default before).

The L2 cache is also resized accordingly, by default, if the image is
resized.

Additionally, few minor changes are made (refactoring and documentation
fixes).

Differences from v1:
* .gitignore modification patch removed (unneeded).
* The grammar fix in conflicting cache sizing patch removed (merged).
* The update total_sectors when resizing patch squashed with the
  resizing patch.
* L2 cache is now capped at 32 MB.
* The default cache-clean-interval is set to 30 seconds.

Differences from v2:
* Made it clear in the documentation that setting cache-clean-interval
  to 0 disables this feature.

Leonid Bloch (5):
  qcow2: Options' documentation fixes
  qcow2: Make the default L2 cache sufficient to cover the entire image
  qcow2: Resize the cache upon image resizing
  qcow2: Set the default cache-clean-interval to 30 seconds
  qcow2: Explicit number replaced by a constant

 block/qcow2.c              | 47 +++++++++++++++++++-------------------
 block/qcow2.h              |  5 ++--
 docs/qcow2-cache.txt       | 31 +++++++++++++++----------
 qapi/block-core.json       |  3 ++-
 qemu-options.hx            | 11 +++++----
 tests/qemu-iotests/137     |  1 -
 tests/qemu-iotests/137.out |  1 -
 7 files changed, 54 insertions(+), 45 deletions(-)

-- 
2.17.1
