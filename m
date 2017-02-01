Received: from eggs.gnu.org ([2001:4830:134:3::10]:52172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYjs4-0007dx-JR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYjs1-0000cr-E9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:38:04 -0500
Date: Wed, 1 Feb 2017 03:37:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170201033722-mutt-send-email-mst@kernel.org>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
	<1485868446-10587-4-git-send-email-mst@redhat.com>
	<20170131221628.GN14879@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170131221628.GN14879@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PULL v3 03/21] ppc: switch to constants within
 BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Wed, Feb 01, 2017 at 09:16:28AM +1100, David Gibson wrote:
> On Tue, Jan 31, 2017 at 03:14:29PM +0200, Michael S. Tsirkin wrote:
> > We are switching BUILD_BUG_ON to verify that it's parameter is a
> > compile-time constant, and it turns out that some gcc versions
> > (specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
> > not smart enough to figure it out for expressions involving local
> > variables. This is harmless but means that the check is ineffective for
> > these platforms.  To fix, replace the variable with macros.
> > 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Ugh.. I pulled this into my tree already (I've been having trouble
> with my test setup, which is why I haven't sent my own pullreq yet).
> However, it needs a s/%u/%llu/ to compile correctly on some platforms.

I need it to avoid breaking build. I fixed it up - want to drop it
from you tree? Or leave it there - git will resolve the trivial conflict.

> > ---
> >  hw/ppc/spapr.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index a642e66..b81f2ac 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2630,8 +2630,8 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
> >       * 1TiB 64-bit MMIO windows for each PHB.
> >       */
> >      const uint64_t base_buid = 0x800000020000000ULL;
> > -    const int max_phbs =
> > -        (SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / SPAPR_PCI_MEM64_WIN_SIZE - 1;
> > +#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> > +                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
> >      int i;
> >  
> >      /* Sanity check natural alignments */
> > @@ -2640,12 +2640,14 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
> >      QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
> >      QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
> >      /* Sanity check bounds */
> > -    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_IO_WIN_SIZE) > SPAPR_PCI_MEM32_WIN_SIZE);
> > -    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_MEM32_WIN_SIZE) > SPAPR_PCI_MEM64_WIN_SIZE);
> > +    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
> > +                      SPAPR_PCI_MEM32_WIN_SIZE);
> > +    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
> > +                      SPAPR_PCI_MEM64_WIN_SIZE);
> >  
> > -    if (index >= max_phbs) {
> > +    if (index >= SPAPR_MAX_PHBS) {
> >          error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
> > -                   max_phbs - 1);
> > +                   SPAPR_MAX_PHBS - 1);
> >          return;
> >      }
> >  
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
