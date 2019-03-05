Received: from eggs.gnu.org ([209.51.188.92]:55905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h0zaC-0004nC-CJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h0za6-0004hl-PT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:13:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h0zZz-0004Y8-Kb
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:13:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so7447725qtc.10
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 18:13:11 -0800 (PST)
Date: Mon, 4 Mar 2019 21:13:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190304211210-mutt-send-email-mst@kernel.org>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190228083821-mutt-send-email-mst@kernel.org>
	<20190305005332.GB7877@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305005332.GB7877@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Tue, Mar 05, 2019 at 11:53:32AM +1100, David Gibson wrote:
> On Thu, Feb 28, 2019 at 08:39:21AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 14, 2019 at 03:39:11PM +1100, David Gibson wrote:
> > > I posted some RFCs for this back in December, but didn't wrap it up in
> > > time for 3.1.  Posting again for inclusion in 4.0.
> > > 
> > > The virtio-balloon devices was never really thought out for cases
> > > other than 4kiB pagesize on both guest and host.  It works in some
> > > cases, but in others can be ineffectual or even cause guest memory
> > > corruption.
> > > 
> > > This series makes a handful of preliminary cleanups, then makes a
> > > change to safely, though not perfectly, handle cases with non 4kiB
> > > pagesizes.
> > 
> > I'd like to see a version of this that does not depend on patch 1 which
> > is not a cleanup nor a bugfix. Could you look into this please?
> 
> Ok... the original series is already applied to master, so I'm not
> exactly sure what you want me to do here.  Should I try to come up
> with a "logical revert" of the first patch?  Or do you intend to
> revert the whole series, and I rewrite the series without the first
> patch?

Whatever you prefer. Maybe the best idea is to add a flag
that says whether to madvise or not. Default can be compatible.
Hmm?


> > We can then debate merits of patch 1 separately.
> > 
> > 
> > > Changes since RFC:
> > >  * Further refinement of when to issue warnings in 5/5
> > > 
> > > David Gibson (5):
> > >   virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
> > >   virtio-balloon: Corrections to address verification
> > >   virtio-balloon: Rework ballon_page() interface
> > >   virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
> > >   virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size
> > > 
> > >  hw/virtio/virtio-balloon.c         | 102 ++++++++++++++++++++++++-----
> > >  include/hw/virtio/virtio-balloon.h |   3 +
> > >  2 files changed, 89 insertions(+), 16 deletions(-)
> > > 
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
