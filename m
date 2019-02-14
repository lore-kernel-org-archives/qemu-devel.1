Received: from eggs.gnu.org ([209.51.188.92]:35596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1guJJx-0003jT-Cd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1guJJv-0006o5-3T
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:53:05 -0500
Date: Thu, 14 Feb 2019 16:52:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190214155252.GC7178@linux.fritz.box>
References: <cover.1547739122.git.berto@igalia.com>
	<ae441a8c27cae1a80e57fb6d291fe95667da0c76.1547739122.git.berto@igalia.com>
	<20190212144747.GC5283@localhost.localdomain>
	<w51k1i231c8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51k1i231c8.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 01/13] block: Allow freezing BdrvChild links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 14.02.2019 um 15:13 hat Alberto Garcia geschrieben:
> On Tue 12 Feb 2019 03:47:47 PM CET, Kevin Wolf wrote:
> > Am 17.01.2019 um 16:33 hat Alberto Garcia geschrieben:
> >> @@ -3861,6 +3923,10 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
> >>          goto exit;
> >>      }
> >>  
> >> +    if (bdrv_is_backing_chain_frozen(top, base, NULL)) {
> >> +        goto exit;
> >> +    }
> >> +
> >>      /* If 'base' recursively inherits from 'top' then we should set
> >>       * base->inherits_from to top->inherits_from after 'top' and all
> >>       * other intermediate nodes have been dropped.
> >
> > bdrv_drop_intermediate() doesn't change the links between in the chain
> > between top and base, but the links between the parents of top and top
> > are changed to point to base instead.
> >
> > I think this is checking the wrong thing.
> 
> You're right, those links should be checked.
> 
> On the other hand it does remove all references from top's parents to
> top, so in the general case it will end up deleting all intermediate
> notes, and their backing links with them. So I think we still need that
> check.

That begs the question if removing a frozen child link should be
forbideen even when it's because the parent goes away. It don't think
there is a good reason to check this - who else than the removed parent
could be interested in keeping it frozen?

In fact, this means that the parent forgot to unfreeze its child before
going away, which shouldn't happen. So I guess bdrv_close() could just
assert that this is not the case for any children?

Kevin
