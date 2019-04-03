Received: from eggs.gnu.org ([209.51.188.92]:41647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDX-0000C5-Ks
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDW-0004sl-Hm
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:19 -0500
Message-Id: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0? 0/7] Final round of NBD alignment fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

My recent pull request for -rc2 documented several places where our
server still does not comply with the NBD specification with regards
to alignment. This series finishes the work in making everything
compliant, insofar as I could test.

The first three patches are rather trivial - they don't drive -rc3 on
their own, but are worth having if there is another patch that we want
in 4.0 (oh, and I need to fix the missing space in nbd/client's error
message in commit 3add3ab7, also in that same category but not posted
here).

Patch 4 is as close as I can get to demonstrating the remaining
alignment bugs in existing qemu (the test passes on current master,
but fails if you revert the client workarounds, and then passes again
once you apply the tail of this series to fix the server
noncompliance). (Viewing traces is a lot more informative than running
iotests when it comes to diagnosing protocol compliance issues,
although it is also a lot slower and more verbose). Again, not
something to drive -rc3 on its own, but worth having if we want the
rest.

Patches 5-6 fix the most common cases of bad server alignments, but
does so by changing a fundamental algorithm in
io.c:bdrv_co_block_status() - any time we grab block status by
deferral with BDRV_BLOCK_RAW, we want to ensure that the lower layer
status is aligned to the requirements of the upper layer.  While it
passed iotests for me, I'm very much on the fence as to whether this
is 4.0 material as a bug fix, or whether we declare that because the
alignment bugs are not a regression over 3.1, we save the patch until
4.1.

Patch 7 is definitely not 4.0 material - it fixes a bug that I could
not provoke in practice, without applying other patches to let NBD
exports see through blkdebug (Max's series to fix filter handling will
presumably be applied for 4.1, at which point patch 7 should be
rebased on top of those patches).

Eric Blake (7):
  nbd/server: Fix blockstatus trace
  nbd/server: Trace server noncompliance on unaligned requests
  nbd/server: Don't fail NBD_OPT_INFO for byte-aligned sources
  iotests: Update 241 to expose backing layer fragmentation
  block: Fix BDRV_BLOCK_RAW status to honor alignment
  nbd/server: Avoid unaligned read/block_status from backing
  nbd/server: Avoid unaligned dirty-bitmap status

 include/block/block.h      |   2 +
 block/io.c                 | 155 +++++++++++++++++++++++++++++++++++--
 nbd/server.c               |  88 +++++++++++++++------
 nbd/trace-events           |   1 +
 tests/qemu-iotests/221     |  10 +++
 tests/qemu-iotests/221.out |   6 ++
 tests/qemu-iotests/241     |  20 ++++-
 tests/qemu-iotests/241.out |  12 ++-
 8 files changed, 258 insertions(+), 36 deletions(-)

--=20
2.20.1
