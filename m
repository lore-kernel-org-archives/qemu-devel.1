Received: from eggs.gnu.org ([2001:4830:134:3::10]:51965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSjAH-00049n-QW
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSjAG-0004Mv-Sq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:12:17 -0400
Date: Wed, 5 Jul 2017 20:12:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170705121204.GG29382@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-15-eblake@redhat.com>
	<20170704094411.GO10298@lemon.lan>
	<9d6ff1e7-4d8a-a329-3c2a-0305f1bc706d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6ff1e7-4d8a-a329-3c2a-0305f1bc706d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/15] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 07/05 07:01, Eric Blake wrote:
> On 07/04/2017 04:44 AM, Fam Zheng wrote:
> > On Mon, 07/03 17:14, Eric Blake wrote:
> >> Any device that has request_alignment greater than 512 should be
> >> unable to report status at a finer granularity; it may also be
> >> simpler for such devices to be guaranteed that the block layer
> >> has rounded things out to the granularity boundary (the way the
> >> block layer already rounds all other I/O out).  Besides, getting
> >> the code correct for super-sector alignment also benefits us
> >> for the fact that our public interface now has byte granularity,
> >> even though none of our drivers have byte-level callbacks.
> >>
> >> Add an assertion in blkdebug that proves that the block layer
> >> never requests status of unaligned sections, similar to what it
> >> does on other requests (while still keeping the generic helper
> >> in place for when future patches add a throttle driver).  Note
> >> note that iotest 177 already covers this (it would fail if you
> > 
> > Drop one "note"?
> 
> Indeed. There are studies on how people read that show that redundant
> words that cross a line boundaries are the most easy to mentally overlook.
> 
> 
> >> +    /* Round out to request_alignment boundaries */
> >> +    align = MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
> >> +    aligned_offset = QEMU_ALIGN_DOWN(offset, align);
> >> +    aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
> >> +
> >> +    {
> > 
> > Not sure why using a {} block here?
> > 
> >> +        int count; /* sectors */
> 
> Because it makes it easier (less indentation churn) to delete the code
> when series 4 later deletes the .bdrv_co_get_block_status sector-based
> callback in favor of the newer .bdrv_co_block_status byte-based (patch
> 16/15 which start series 4 turns it into an if statement, then a later
> patch deletes the entire conditional); it is also justifiable because it
> creates a tighter scope for 'int count' which is needed only on the
> boundary of sector-based operations when the rest of the function is
> byte-based (rather than declaring the helper variable up front).  I'll
> have to call it out more specifically in the commit message as intentional.

Thanks for explaining, with the syntax error fixed in the commit message:

Reviewed-by: Fam Zheng <famz@redhat.com>
