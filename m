Received: from eggs.gnu.org ([2001:4830:134:3::10]:44552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fR-1U
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Le-0001iB-Vy
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:21 +0300
Message-Id: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 0/8] Take the image size into account when
 allocating the L2 cache
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

This series makes the qcow2 L2 cache assignment aware of the image size,
with the intention for it to cover the entire image. The importance of
this change is in noticeable performance improvement, especially with
heavy random I/O. The memory overhead is not big in most cases, as only
1 MB of cache for every 8 GB of image size is used. For cases with very
large images and/or small cluster sizes, or systems with limited RAM
resources, there is an upper limit on the default L2 cache: 32 MB. To
modify this limit one can use the already existing 'l2-cache-size' and
'cache-size' options. Moreover, this fixes the behavior of 'l2-cache-size',
as it was documented as the *maximum* L2 cache size, but in practice
behaved as the absolute size.

To compensate the memory overhead which may be increased following this
behavior, the default cache-clean-interval is set to 10 minutes by default
(was disabled by default before).

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

Differences from v3:
* The default cache-clean-interval is set to 10 minutes instead of 30
  seconds before.
* Commit message changes to better explain the patches.
* Some refactoring.

Differences from v4:
* Refactoring.
* Documentation and commit message fixes.

Differences from v5:
* A patch with cosmetic changes is split from the main patch
* A patch for avoiding duplication in refcount cache size assignment is
  split from the main patch.
* In the main patch the cap on the L2 cache size is set to only 1 MB (in
  order to be close to the previous behavior) and a separate patch sets
  it to 32 MB.
* Changes in the documentation fixes patch [1/8].

Differences from v6:
* A patch is added to make the defined sizes more humanly readable.

Differences from v7:
* Documentation and commit message changes.
* Fix: when cache-size is specified and is large enough, with the L2 and
  refcount caches not set, the L2 cache will be as large as needed to
  cover the entire image, and not as the default max. size. (Return to
  the previous behavior in this part, which was correct).
* Cosmetic changes patch not used.


Leonid Bloch (8):
  qcow2: Options' documentation fixes
  qcow2: Make sizes more humanly readable
  qcow2: Avoid duplication in setting the refcount cache size
  qcow2: Assign the L2 cache relatively to the image size
  qcow2: Increase the default upper limit on the L2 cache size
  qcow2: Resize the cache upon image resizing
  qcow2: Set the default cache-clean-interval to 10 minutes
  qcow2: Explicit number replaced by a constant

 block/qcow2.c              | 42 ++++++++++++++++++++++----------------
 block/qcow2.h              | 12 +++++------
 docs/qcow2-cache.txt       | 39 ++++++++++++++++++++++-------------
 qapi/block-core.json       |  3 ++-
 qemu-options.hx            | 11 ++++++----
 tests/qemu-iotests/137     |  1 -
 tests/qemu-iotests/137.out |  1 -
 7 files changed, 64 insertions(+), 45 deletions(-)

-- 
2.17.1
