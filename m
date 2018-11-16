Received: from eggs.gnu.org ([2001:4830:134:3::10]:47964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNg7H-0001Aw-Bd
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNg7G-0007B5-Mg
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:33:07 -0500
Date: Fri, 16 Nov 2018 16:32:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181116153249.GC5066@localhost.localdomain>
References: <20181115020334.1189829-1-eblake@redhat.com>
	<20181115020334.1189829-6-eblake@redhat.com>
	<20181115154529.GC12677@localhost.localdomain>
	<2e484653-79f0-ee5d-9e92-1171f886b3e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e484653-79f0-ee5d-9e92-1171f886b3e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/13] block: Switch to 64-bit
 bl.max_transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 15.11.2018 um 17:28 hat Eric Blake geschrieben:
> On 11/15/18 9:45 AM, Kevin Wolf wrote:
> > Am 15.11.2018 um 03:03 hat Eric Blake geschrieben:
> > > This change has no semantic impact: all drivers either leave the
> > > value at 0 (no inherent 32-bit limit is still translated into
> > > fragmentation below 2G; see the previous patch for that audit), or
> > > set it to a value less than 2G.  However, switching to a larger
> > > type and enforcing the 2G cap at the block layer makes it easier
> > > to audit specific drivers for their robustness to larger sizing,
> > > by letting them specify a value larger than INT_MAX if they have
> > > been audited to be 64-bit clean.
> > > 
> 
> > > +++ b/block/io.c
> > > @@ -159,6 +159,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
> > >       if (drv->bdrv_refresh_limits) {
> > >           drv->bdrv_refresh_limits(bs, errp);
> > >       }
> > > +
> > > +    /* Clamp max_transfer to 2G */
> > > +    if (bs->bl.max_transfer > UINT32_MAX) {
> > 
> > UINT32_MAX is 4G, not 2G.
> > 
> > Would it make more sense to make BDRV_REQUEST_MAX_BYTES the maximum
> > anyway?
> 
> D'oh.  Yes, that's what I intended, possibly by spelling it INT_MAX (the
> fact that the 'if' goes away in patch 13 is not an excuse for sloppy coding
> in the meantime).

INT_MAX is not a different spelling of BDRV_REQUEST_MAX_BYTES. The
latter is slightly lower (0x7ffffe00).

Kevin
