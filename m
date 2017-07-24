Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZXMm-0000Mb-EL
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZXMj-0007Lx-D3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:01:20 -0400
Message-ID: <1500879657.10674.64.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Jul 2017 17:00:57 +1000
In-Reply-To: <20170724043624.GE17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=C3=A9dric Le Goater wrote:
> > These flags define some characteristics of the source :
> >=20
> >  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
> >                        specific hcall H_INT_ESB
>=20
> What's the other option?

Direct MMIO access. Normally all interrupts use normal MMIOs,
each interrupts has an associated MMIO page with special MMIOs
to control the source state (PQ bits). This is something I added
to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
to work around broken HW (which happens on some P9 versions).

> >  - XIVE_SRC_LSI        LSI or MSI source
>=20
> Hrm.  This definitely duplicates info that is in the XICS per irq
> state which you're re-using (and which you're using in the xive code
> at this point).

I think all those flags correspond to the flags passed via the PAPR
API, so it makes sense to have them there.

> >  - XIVE_SRC_TRIGGER    the full function page supports trigger
> >  - XIVE_SRC_STORE_EOI  EOI can with a store.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/intc/xive.c        | 1 +
> >  include/hw/ppc/xive.h | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 816031b8ac81..8f8bb8b787bd 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -345,6 +345,7 @@ static Property xive_ics_properties[] =3D {
> >      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> >      DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
> >      DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
> > +    DEFINE_PROP_UINT64("flags", XiveICSState, flags, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > =20
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 5303d96f5f59..1178300c9df3 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -30,9 +30,18 @@ typedef struct XiveICSState XiveICSState;
> >  #define TYPE_ICS_XIVE "xive-source"
> >  #define ICS_XIVE(obj) OBJECT_CHECK(XiveICSState, (obj), TYPE_ICS_XIV=
E)
> > =20
> > +/*
> > + * XIVE Interrupt source flags
> > + */
> > +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
> > +#define XIVE_SRC_LSI           (1ull << (63 - 61))
> > +#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
> > +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> > +
> >  struct XiveICSState {
> >      ICSState parent_obj;
> > =20
> > +    uint64_t     flags;
> >      uint32_t     esb_shift;
> >      MemoryRegion esb_iomem;
> > =20
>=20
>=20
