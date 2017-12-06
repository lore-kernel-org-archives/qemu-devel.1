Received: from eggs.gnu.org ([2001:4830:134:3::10]:50663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMXKN-0001mM-I4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMXKM-0006a7-ST
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:53:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Dec 2017 11:53:03 +0100
Message-Id: <20171206105309.3468-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] block: Fix BlockDriver callbacks in
 bdrv_drain_all_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

I was looking into the drain functions in order to develop them a bit in
the direction that Fam suggested, to unify the code between bdrv_drain()
and bdrv_drain_all() a bit more, and maybe to find a place to take
coroutine locks for graph changes.

The first thing I found is a bug in bdrv_drain_all(), so I'm already
sending this part before I have made much progress with my actual plan.

v2:
- Added patches 5 and 6 [Paolo]
- Fixed commit message of patch 1 [Eric]

Kevin Wolf (6):
  block: Make bdrv_drain_invoke() recursive
  block: Call .drain_begin only once in bdrv_drain_all_begin()
  test-bdrv-drain: Test BlockDriver callbacks for drain
  block: bdrv_drain_recurse(): Remove unused begin parameter
  block: Don't wait for requests in bdrv_drain*_end()
  block: Unify order in drain functions

 block/io.c              |  31 +++++++----
 tests/test-bdrv-drain.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include  |   2 +
 3 files changed, 159 insertions(+), 11 deletions(-)
 create mode 100644 tests/test-bdrv-drain.c

-- 
2.13.6
