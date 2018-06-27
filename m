Received: from eggs.gnu.org ([2001:4830:134:3::10]:46918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fXzQ3-0008Lx-Qn
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fXzPy-0004dt-U7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:38:51 -0400
Message-ID: <1d70c0f9179990cd33d7c82c5190179e60ae4ce3.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jun 2018 11:38:17 +1000
In-Reply-To: <20180627033321-mutt-send-email-mst@kernel.org>
References: <20180626135928.23950-1-clg@kaod.org>
	<20180627033321-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>

On Wed, 2018-06-27 at 03:35 +0300, Michael S. Tsirkin wrote:
> 
> > +
> > +/* Extract field fname from val */
> > +#define GETFIELD(fname, val)                    \
> > +        (((val) & fname##_MASK) >> fname##_LSH)
> > +
> > +/* Set field fname of oval to fval
> > + * NOTE: oval isn't modified, the combined result is returned
> > + */
> > +#define SETFIELD(fname, oval, fval)                     \
> > +        (((oval) & ~fname##_MASK) | \
> > +         ((((typeof(oval))(fval)) << fname##_LSH) & fname##_MASK))
> > +
> 
> Pls don't make up macros like these. We can't have each device do it.

So what ? We move the macros in a generic place ? These are MUCH better
than open-coding the masks & shifts and much less error prone.

> > @@ -1031,6 +1110,7 @@ static Property pnv_chip_properties[] = {
> >      DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
> >      DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
> >      DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
> > +    DEFINE_PROP_UINT32("num-phbs", PnvChip, num_phbs, 1),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> 
> How about instanciating each extra phb using -device?
> Seems better than teaching everyone about platform-specific
> options.

It's about which PHBs are enabled, not which are instanciated, if I
understand Cedric changes ...

This aims are implementing the POWER8 chip correctly, it has a fixed
number of PHBs per-chip at very specific XSCOM addresses, that the
firwmare knows about.

Cheers,
Ben.
