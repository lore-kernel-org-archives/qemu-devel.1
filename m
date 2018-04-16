Received: from eggs.gnu.org ([2001:4830:134:3::10]:60467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87T7-0007Rn-VM
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87T6-0003Ez-O5
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Apr 2018 18:58:40 +0200
Message-Id: <20180416165849.28864-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

In our quest to... (Oh, man, I always struggle with writing cover
letters.  But rarely have I become stuck so early on.)  Orthogonalize?
the block layer (that is, turn hard-coded special options into
independent data processing nodes you can put anywhere in your data flow
graph), this series adds a copy-on-read filter driver that is supposed
to replace the copy-on-read -drive option in the long run.  In the short
run, it allows you to use COR with blockdev-add.

The patch itself is extremely simple.  It's just patch 1.  All we have
to do for now is to set the BDRV_REQ_COPY_ON_READ flag for read
requests.  We probably want to extend the COR driver's capabilities
later on, though, more on that below under "What to do as a follow-up?".

But there is something to do on top of that.  One real issue with the
current copy-on-read model is that you generally cannot do COR through
filter nodes (-drive copy-on-read=on,driver=raw,file.driver=qcow2,...).
Unless you are lucky that someone has requested WRITE permission, you
will run into a failed assertion from the permission system (see
patch 9).  Actually, you should always run into such an abort, but the
COR code cleverly sneaks its writes around it.  Well, actually, the
respective assertion is just commented out with a comment noting that
we'd need a proper COR filter so we could do the assertion.

So the new COR node will take the permission for its child that the
current code does not (because it cannot, for the lack of a node that
would do this).  However, of course we don't want it to require a WRITE
permission but just WRITE_UNCHANGED.  But when it issues a post-COR
write request that goes down to a filter and that filter re-issues that
write down to its child, then it will just be a normal write.  So
suddenly WRITE_UNCHANGED won't be sufficient, we'd need a standard WRITE
instead.

That isn't what we want, though.  So this series also adds a
BDRV_REQ_WRITE_UNCHANGED write request flag that is set when issuing a
COR write.  This flag tells the block code that the WRITE_UNCHANGED
permission will be sufficient to execute the request.  Filter drivers
need to pass this along; format drivers don't because they take a
full-on WRITE permission on their file anyway.

So most of this series is about adding this new flag.

(Note that this does nothing to fix the situation with the old
 copy-on-read=on.  That will still runs into a failed assertion if you
 poke it the right way.  But the cruel reality is that the only way to
 really fix this is by converting copy-on-read=on into an implicit COR
 node.)


Finally, the test we have for COR (197) is copied and modified to use
the COR filter; and another test is added for the situation described
above (COR through filter nodes).


=== What to do as a follow-up? ===

The obvious thing is to transform the current copy-on-read flag into an
implicit COR node.  Probably not too difficult, actually (just handle it
like snapshot=on), but we need to hide that fact in the query functions.

Also, we want to make the stream block job code use this node.  Maybe we
eventually want this node become the stream block job eventually,
actually.  That is, give it enough runtime options that you can perform
a stream operation just by inserting a COR node into the graph.  But
probably that won't be possible, because someone still needs to submit
reads requests across the whole disk so that everything is actually
copied.  This could be achieved with a blockdev-copy to null-co://,
though.

Once both is done, we want to remove the COR code from block.c and move
it directly into the COR driver.

Max Reitz (9):
  block: Add COR filter driver
  block: BLK_PERM_WRITE includes ..._UNCHANGED
  block: Add BDRV_REQ_WRITE_UNCHANGED flag
  block: Set BDRV_REQ_WRITE_UNCHANGED for COR writes
  block/quorum: Support BDRV_REQ_WRITE_UNCHANGED
  block: Support BDRV_REQ_WRITE_UNCHANGED in filters
  iotests: Clean up wrap image in 197
  iotests: Copy 197 for COR filter driver
  iotests: Add test for COR across nodes

 block/Makefile.objs        |   2 +-
 qapi/block-core.json       |   5 +-
 include/block/block.h      |   9 ++-
 block/blkdebug.c           |   9 +--
 block/blkreplay.c          |   3 +
 block/blkverify.c          |   3 +
 block/cor.c                | 173 +++++++++++++++++++++++++++++++++++++++++++++
 block/io.c                 |  12 +++-
 block/mirror.c             |   2 +
 block/quorum.c             |  19 +++--
 block/raw-format.c         |   9 +--
 block/throttle.c           |   6 +-
 tests/qemu-iotests/197     |   1 +
 tests/qemu-iotests/215     | 120 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/215.out |  26 +++++++
 tests/qemu-iotests/216     | 117 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/216.out |  28 ++++++++
 tests/qemu-iotests/group   |   2 +
 18 files changed, 524 insertions(+), 22 deletions(-)
 create mode 100644 block/cor.c
 create mode 100755 tests/qemu-iotests/215
 create mode 100644 tests/qemu-iotests/215.out
 create mode 100755 tests/qemu-iotests/216
 create mode 100644 tests/qemu-iotests/216.out

-- 
2.14.3
