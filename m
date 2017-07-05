Received: from eggs.gnu.org ([2001:4830:134:3::10]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSj5n-0002mS-0R
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSj5m-0002ph-6G
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:07:39 -0400
Date: Wed, 5 Jul 2017 20:07:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170705120725.GF29382@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-4-eblake@redhat.com>
	<20170704070643.GB10298@lemon.lan>
	<6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Wed, 07/05 06:56, Eric Blake wrote:
> On 07/04/2017 02:06 AM, Fam Zheng wrote:
> > On Mon, 07/03 17:14, Eric Blake wrote:
> >> @@ -1717,6 +1718,10 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
> >>   * Drivers not implementing the functionality are assumed to not support
> >>   * backing files, hence all their sectors are reported as allocated.
> >>   *
> >> + * If 'allocation' is true, the caller only cares about allocation
> >> + * status; this is a hint that a larger 'pnum' result is more
> >> + * important than including BDRV_BLOCK_OFFSET_VALID in the return.
> >> + *
> > 
> > This is slightly unintuitive. I would guess "allocation == false" means "I don't
> > care about the allocation status" but it actually is "I don't care about the
> > consecutiveness". The "only" semantics is missing in the parameter name.
> > 
> > Maybe rename it to "consecutive" and invert the logic?  I.e. "consecutive ==
> > true" means BDRV_BLOCK_OFFSET_VALID is wanted.
> 
> Reasonable idea; other [shorter] names I've been toying with:
> strict
> mapping
> precise
> 
> any of which, if true (set true by bdrv_get_block_status), means that I
> care more about BDRV_BLOCK_OFFSET_VALID and validity for learning host
> offsets, if false  it means I'm okay getting a larger *pnum even if it
> extends over disjoint host offsets; or:
> 
> fast
> 
> which if true (set true by bdrv_is_allocated) means I want a larger
> *pnum even if I have to sacrifice accuracy by omitting
> BDRV_BLOCK_OFFSET_VALID, because I'm trying to reduce effort spent.
> 
> > 
> > Sorry for bikeshedding.
> 
> Not a problem, I also had some double-takes in writing my own code
> trying to remember which way I wanted the 'allocation' boolean to be
> set, so coming up with a more intuitive name/default state in order to
> help legibility is worth it.  Do any of my above suggestions sound better?
> 

I'd vote for "mapping" because it has a close connection with offset (as in
BDRV_BLOCK_OFFSET_VALID).

Or simply call it "offset" and if false, never return BDRV_BLOCK_OFFSET_VALID.

Fam
