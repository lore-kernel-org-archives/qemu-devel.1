Received: from eggs.gnu.org ([2001:4830:134:3::10]:48822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Slx-0002eU-7n
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Slw-000111-4d
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:15:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  4 May 2017 21:14:58 -0500
Message-Id: <20170505021500.19315-1-eblake@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] Enhance block status when crossing EOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

As mentioned in my 'qcow2 zero-cluster tweaks' cover letter
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00722.html
I hit a case where we were not fully optimizing a write-zeroes
operation when we have a backing file that is shorter than the
active layer, and where the request crosses that boundary.  I don't
know that the situation will be all that common (most qcow2 files
happen to be cluster-aligned in size; and most backing chains use
the same length at each layer of the chain), but for RFC purposes,
I wanted to explore how easy it would be to optimize the case
anyways, and to see if we can think of any other cases where
knowing that a block status crossed an end-of-file boundary can
be exploited for less work.

Thus, this is a followup to that series, but I'm also okay if we
think it is too much maintenance compared to the potential gains,
and decide to drop it after all.

Another potential use that I thought of: we may someday want to
track BDS length by bytes.  Right now, bdrv_getlength() returns a
value in bytes, but which is sector-aligned, by adding padding;
but raw-format.c is able to see the transition between data up to
EOF followed by a hole after EOF.  Because of that, my series to
convert bdrv_get_block_status() into a byte-based interface has to
fudge things - any time we see a mid-sector hole being reported,
we know it is because we hit EOF, and can round the result up to
the next sector boundary.  Having the BDRV_BLOCK_EOF flag set in
that case may alert clients that the rounding took place, or help
us when we quit doing the rounding and actually start tracking BDS
lengths by bytes even where it is not sector-aligned.

Eric Blake (2):
  block: Add BDRV_BLOCK_EOF to bdrv_get_block_status()
  block: Exploit BDRV_BLOCK_EOF for larger zero blocks

 include/block/block.h      |  2 ++
 block/io.c                 | 42 +++++++++++++++++++++++++++++++++---------
 tests/qemu-iotests/154     |  4 ----
 tests/qemu-iotests/154.out | 12 ++++++------
 4 files changed, 41 insertions(+), 19 deletions(-)

-- 
2.9.3
