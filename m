Received: from eggs.gnu.org ([2001:4830:134:3::10]:39743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmU-0004pr-6o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmP-0005uH-V8
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:46 -0400
Date: Tue, 25 Jul 2017 22:21:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725122154.GE8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-8-git-send-email-clg@kaod.org>
	<20170724042956.GD17228@umbus.fritz.box>
	<006293c9-b396-82f9-19ba-d57301934ffe@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <006293c9-b396-82f9-19ba-d57301934ffe@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 07/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 05:55:42PM +0200, C=E9dric Le Goater wrote:
> On 07/24/2017 06:29 AM, David Gibson wrote:
> > On Wed, Jul 05, 2017 at 07:13:20PM +0200, C=E9dric Le Goater wrote:
> >> Each interrupt source is associated with a 2-bit state machine called
> >> an Event State Buffer (ESB). It is controlled by MMIO to trigger
> >> events.
[snip]
> >> +/* TODO: handle second page */
> >=20
> > Is this comment still relevent?
>=20
> Some HW have a second page to trigger the event. I am not sure we need=20
> to model it though. I will make some inquiries.

Ah, ok.  Maybe clarify the comment a bit.

[snip]
> >> +static void xive_esb_write(void *opaque, hwaddr addr,
> >> +                           uint64_t value, unsigned size)
> >> +{
> >> +    XiveICSState *xs =3D ICS_XIVE(opaque);
> >> +    XIVE *x =3D xs->xive;
> >> +    uint32_t offset =3D addr & 0xF00;
> >> +    uint32_t srcno =3D addr >> xs->esb_shift;
> >> +    uint32_t lisn =3D srcno + ICS_BASE(xs)->offset;
> >> +    XiveIVE *ive;
> >> +    bool notify =3D false;
> >> +
> >> +    ive =3D xive_get_ive(x, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID))  {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
> >> +        return;
> >> +    }
> >=20
> > Having this code associated with the individual ICS look directly at
> > the IVE table in the core xive object seems a bit dubious.
>=20
> The IVE table holds the validity and mask status of the interrupt=20
> entries, so we need that lookup. However, (continues below) ...
>=20
> > This also
> > points out another mismatch between the re-used ICS code and the new
> > XIVE code: ICS gathers all the per-source-irq flags/state into the
> > irqstate structure, whereas xive has per-irq information in the
> > centralized ecb and IVE tables.  There can certainly be good reasons
> > for that, but using both at once is kind of clunky.
>=20
> I understand that you would rather put the esbs in the source they=20
> belong to. That is the case on real HW but it makes the modeling a=20
> bit more difficult. We would need to choose a MMIO address to give=20
> to the guest OS. I had some issues with the allocator (I need=20
> to look at this problem closer).

Uh.. what do MMIO addresses have to do with this?  I'm talking about
the actual ESB state in the packed bit array.

> It might also be an "issue" for KVM. Ben talked about maintaining=20
> all the esbs of a guest under a single memory region to be able to=20
> map the pages in the host.
>=20
> Any how, I agree this is another point to discuss in the sPAPR=20
> model.
>=20
> Thanks,
>=20
> C.=20
>=20
>=20
> >> +    if (srcno >=3D ICS_BASE(xs)->nr_irqs) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR,
> >> +                      "XIVE: invalid IRQ number: %d/%d lisn: %d\n",
> >> +                      srcno, ICS_BASE(xs)->nr_irqs, lisn);
> >> +        return;
> >> +    }
> >> +
> >> +    switch (offset) {
> >> +    case 0:
> >> +        /* TODO: should we trigger even if the IVE is masked ? */
> >> +        notify =3D xive_pq_trigger(x, lisn);
> >> +        break;
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr =
%d\n",
> >> +                      offset);
> >> +        return;
> >> +    }
> >> +
> >> +    if (notify && !(ive->w & IVE_MASKED)) {
> >> +        qemu_irq_pulse(ICS_BASE(xs)->qirqs[srcno]);
> >> +    }
> >> +}
> >> +
> >> +static const MemoryRegionOps xive_esb_ops =3D {
> >> +    .read =3D xive_esb_read,
> >> +    .write =3D xive_esb_write,
> >> +    .endianness =3D DEVICE_BIG_ENDIAN,
> >> +    .valid =3D {
> >> +        .min_access_size =3D 8,
> >> +        .max_access_size =3D 8,
> >> +    },
> >> +    .impl =3D {
> >> +        .min_access_size =3D 8,
> >> +        .max_access_size =3D 8,
> >> +    },
> >> +};
> >> +
> >> +/*
> >>   * XIVE Interrupt Source
> >>   */
> >>  static void xive_ics_set_irq_msi(XiveICSState *xs, int srcno, int val)
> >> @@ -106,15 +326,25 @@ static void xive_ics_realize(ICSState *ics, Erro=
r **errp)
> >>          return;
> >>      }
> >> =20
> >> +    if (!xs->esb_shift) {
> >> +        error_setg(errp, "ESB page size needs to be greater 0");
> >> +        return;
> >> +    }
> >> +
> >>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> >>      ics->qirqs =3D qemu_allocate_irqs(xive_ics_set_irq, xs, ics->nr_i=
rqs);
> >> =20
> >> +    memory_region_init_io(&xs->esb_iomem, OBJECT(xs), &xive_esb_ops, =
xs,
> >> +                          "xive.esb",
> >> +                          (1ull << xs->esb_shift) * ICS_BASE(xs)->nr_=
irqs);
> >> +
> >>      qemu_register_reset(xive_ics_reset, xs);
> >>  }
> >> =20
> >>  static Property xive_ics_properties[] =3D {
> >>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> >>      DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
> >> +    DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >> =20
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 544cc6e0c796..5303d96f5f59 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -33,6 +33,9 @@ typedef struct XiveICSState XiveICSState;
> >>  struct XiveICSState {
> >>      ICSState parent_obj;
> >> =20
> >> +    uint32_t     esb_shift;
> >> +    MemoryRegion esb_iomem;
> >> +
> >>      XIVE         *xive;
> >>  };
> >> =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll3N+AACgkQbDjKyiDZ
s5IJeRAA36n29IwDfliNjQvQe3echREpXWkHpf9e2PVDnP77rfIyHUl3vgMYQK9F
fWU6vdVf/iBi/VVdyGbhiS4+yLaLL5hIuYBJeJrX2NR3NZZqkx8mp7OQ9eFw5tqg
LgtdNjuKIJa/r2XM9pJePB37CNO/1bB7FJ/QWO9FYhNxDZ38pWGm4w4/AJw4P4gK
I6UK3iyUE72/XhuUcaVbWltybBWAeLEIpN03hzj2m20yzMsEmbG/0HxPk4cp7hgk
taQzK71lGp7H8jWq7mEBLGe0DtPXwUZzrP4HJ6EDhT66uOVmlpyT3tka0ZvYaReN
2TTb6S6wGiAf+SxE6MXXNeEXOVcAcufPGmpbruQfNgcdoZFJvg0xJJMcobM4h/mp
6MjV+vgUqirBOpqtjKbOvEaSDj4y+jPKg23D4uN2/DPEVfGpruRNcbgtc8bHYhHG
GSnk6lZkGWLPSIT0uA2KfK6kDOsz1v23mdU/E83cG+oqxFw24Y1WpB8w8cIB/3c+
ET6/Sz58Uf4ETcaMSjbzed6E3ZKpFhfiFpYbZGcyL+s7UtqlZ6mrZ7RRqaNJOXtq
0PoqJrYfyHHeEgjM0QALmqTaOnAw1gQk53V45W/6DRGd4aVie2sJbb6d+35v21+f
GXldLRYnc+uQkrPN5S8hMb1tI5uU3Aa2tSa1YuanCBpwkM2cAzs=
=G9Bm
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
