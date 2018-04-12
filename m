Received: from eggs.gnu.org ([2001:4830:134:3::10]:41784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6anJ-0004Wr-FJ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6anF-0003PB-3S
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:53:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6anE-0003Os-Tg
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:53:33 -0400
Date: Thu, 12 Apr 2018 12:53:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180412115326.GF2704@work-vm>
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 12 April 2018 at 11:18, C=E9dric Le Goater <clg@kaod.org> wrote:
> > On the POWER9 processor, the XIVE interrupt controller can control
> > interrupt sources using MMIO to trigger events, to EOI or to turn off
> > the sources. Priority management and interrupt acknowledgment is also
> > controlled by MMIO in the presenter sub-engine.
> >
> > These MMIO regions are exposed to guests in QEMU with a set of 'ram
> > device' memory mappings, similarly to VFIO, and the VMAs are populate=
d
> > dynamically with the appropriate pages using a fault handler.
> >
> > But, these regions are an issue for migration. We need to discard the
> > associated RAMBlocks from the RAM state on the source VM and let the
> > destination VM rebuild the memory mappings on the new host in the
> > post_load() operation just before resuming the system.
> >
> > To achieve this goal, the following introduces a new helper,
> > ram_block_is_migratable(), which identifies RAMBlocks to discard on
> > the source. Some checks are also performed on the destination to make
> > sure nothing invalid was sent.
>=20
> David suggested on IRC that we would want a flag on the ramblock
> for "not migratable", because there are other uses for "don't
> migrate this" than just "is this a ram device".

My original suggestion to your series was with a flag, but I'd forgotten
about that by the time I'd made the suggestion to C=E9dric.
In your case would just adding an extra term to the
ram_block_is_migratable function work, or do you really need a flag?

Dave

> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >
> >  I am not sure we want to taker into account patchew complaint :
> >
> >    ERROR: braces {} are necessary for all arms of this statement
> >    #52: FILE: migration/ram.c:203:
> >    +        if (ram_block_is_migratable(block))
> >    [...]
> >
> >    total: 1 errors, 0 warnings, 136 lines checked
> >
> >  migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++-----=
-----
> >  1 file changed, 42 insertions(+), 10 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 0e90efa09236..32371950865b 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -188,6 +188,21 @@ void ramblock_recv_bitmap_set_range(RAMBlock *rb=
, void *host_addr,
> >  }
> >
> >  /*
> > + * Identifies RAM blocks which should be discarded from migration. F=
or
> > + * the moment, it only applies to blocks backed by a 'ram_device'
> > + * memory region.
> > + */
> > +static inline bool ram_block_is_migratable(RAMBlock *block)
> > +{
> > +    return !memory_region_is_ram_device(block->mr);
> > +}
> > +
> > +/* Should be holding either ram_list.mutex, or the RCU lock. */
> > +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> > +    RAMBLOCK_FOREACH(block)                            \
> > +        if (ram_block_is_migratable(block))
>=20
> This will mishandle some uses, like:
>=20
>     if (foo)
>         RAMBLOCK_FOREACH_MIGRATABLE(block)
>             stuff;
>     else
>         morestuff;
>=20
> as the if() inside the macro will capture the else clause.
> (The lack of braces in the calling code would be against our
> coding style, of course, so not very likely.)
>=20
> Eric, is there a 'standard' trick for this? I thought of
> maybe
>=20
> #define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
>     RAMBLOCK_FOREACH(block)                            \
>         if (!ram_block_is_migratable(block)) {} else
>=20
> ?
>=20
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
