Received: from eggs.gnu.org ([2001:4830:134:3::10]:54682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZpRd-0000qh-Oo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZpRa-0005zx-HJ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:19:33 -0400
Date: Tue, 25 Jul 2017 12:19:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725021907.GD9471@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-10-git-send-email-clg@kaod.org>
	<20170724044948.GF17228@umbus.fritz.box>
	<1500876571.10674.58.camel@kernel.crashing.org>
	<9a97771c-7895-26af-d3b7-06404199684f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <9a97771c-7895-26af-d3b7-06404199684f@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 09/26] ppc/xive: add an overall memory
 region for the ESBs
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


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 03:25:29PM +0200, C=E9dric Le Goater wrote:
> On 07/24/2017 08:09 AM, Benjamin Herrenschmidt wrote:
> > On Mon, 2017-07-24 at 14:49 +1000, David Gibson wrote:
> >> On Wed, Jul 05, 2017 at 07:13:22PM +0200, C=E9dric Le Goater wrote:
> >>> Each source adds its own ESB mempry region to the overall ESB memory
> >>> region of the controller. It will be mapped in the CPU address space
> >>> when XIVE is activated.
> >>>
> >>> The default mapping address for the ESB memory region is the same one
> >>> used on baremetal.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>> ---
> >>>  hw/intc/xive-internal.h |  5 +++++
> >>>  hw/intc/xive.c          | 44 +++++++++++++++++++++++++++++++++++++++=
++++-
> >>>  2 files changed, 48 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> >>> index 8e755aa88a14..c06be823aad0 100644
> >>> --- a/hw/intc/xive-internal.h
> >>> +++ b/hw/intc/xive-internal.h
> >>> @@ -98,6 +98,7 @@ struct XIVE {
> >>>      SysBusDevice parent;
> >>> =20
> >>>      /* Properties */
> >>> +    uint32_t     chip_id;
> >>
> >> So there is a XIVE object per chip.  How does this work on PAPR?  One
> >> logical chip/XIVE, or something more complex?
> >=20
> > One global XIVE for PAPR.=20
>=20
> Yes.=20
>=20
> The chip-id is useless for sPAPR (0 is the default) but for a PowerNV
> system, the address used to map the ESB memory region depends on the=20
> chip-id and  I thought we could reuse the same XIVE object.=20

Hmm, maybe.

> So, a sPAPR guest would use the address of a single chip baremetal=20
> system. This needs more explanation I agree. Thanks to Ben who is=20
> providing a lot. I will update the changelogs in the next version.=20

> The TIMA is mapped at a fixed address so the chip-id does not come=20
> in play.
>=20
> > For the MMIOs, the way it works is that:
> >=20
> >  - For MMIOs pertaining to a specific interrupt or queue, there's an H-
> > call that will return the proper "guest physical" address. For qemu
> > with KVM we'll have to probably create a single chunk of qemu address
> > space (a single mem region) that contains individual pages mapped with
> > MAP_FIXED originating from the different HW bits, we still need to sort
> > out how exactly we'll do that in practice.
>=20
> I haven't looked at all the KVM details. But, regarding the ESBs, I had
> the above in mind and used a single memory region to contain them all.=20
> =20
> >  - For the TIMA (the presentation MMIOs), those are always at the same
> > physical address for everybody (so for a guest it's a single memory
> > region we'll map to that physical address), the HW "knows" which HW
> > thread is talking to it (and the hypervisor tells the HW which vcpu is
> > running on a given HW thread at a given point in time). That address is
> > obtained from the device-tree
> >=20
> >>>      uint32_t     nr_targets;
> >>> =20
> >>>      /* IRQ number allocator */
> >>> @@ -111,6 +112,10 @@ struct XIVE {
> >>>      void         *sbe;
> >>>      XiveIVE      *ivt;
> >>>      XiveEQ       *eqdt;
> >>> +
> >>> +    /* ESB and TIMA memory location */
> >>> +    hwaddr       vc_base;
> >>> +    MemoryRegion esb_iomem;
> >>>  };
> >>> =20
> >>>  void xive_reset(void *dev);
> >>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>> index 8f8bb8b787bd..a1cb87a07b76 100644
> >>> --- a/hw/intc/xive.c
> >>> +++ b/hw/intc/xive.c
> >>> @@ -312,6 +312,7 @@ static void xive_ics_realize(ICSState *ics, Error=
 **errp)
> >>>      XiveICSState *xs =3D ICS_XIVE(ics);
> >>>      Object *obj;
> >>>      Error *err =3D NULL;
> >>> +    XIVE *x;
> >>
> >> I don't really like just 'x' for a context variable like this (as
> >> opposed to a temporary).
>=20
> OK. I will change 'x' in 'xive' then.
>=20
> >>> =20
> >>>      obj =3D object_property_get_link(OBJECT(xs), "xive", &err);
> >>>      if (!obj) {
> >>> @@ -319,7 +320,7 @@ static void xive_ics_realize(ICSState *ics, Error=
 **errp)
> >>>                     __func__, error_get_pretty(err));
> >>>          return;
> >>>      }
> >>> -    xs->xive =3D XIVE(obj);
> >>> +    x =3D xs->xive =3D XIVE(obj);
> >>> =20
> >>>      if (!ics->nr_irqs) {
> >>>          error_setg(errp, "Number of interrupts needs to be greater 0=
");
> >>> @@ -338,6 +339,11 @@ static void xive_ics_realize(ICSState *ics, Erro=
r **errp)
> >>>                            "xive.esb",
> >>>                            (1ull << xs->esb_shift) * ICS_BASE(xs)->nr=
_irqs);
> >>> =20
> >>> +    /* Install the ESB memory region in the overall one */
> >>> +    memory_region_add_subregion(&x->esb_iomem,
> >>> +                                ICS_BASE(xs)->offset * (1 << xs->esb=
_shift),
> >>> +                                &xs->esb_iomem);
> >>> +
> >>>      qemu_register_reset(xive_ics_reset, xs);
> >>>  }
> >>> =20
> >>> @@ -375,6 +381,32 @@ static const TypeInfo xive_ics_info =3D {
> >>>   */
> >>>  #define MAX_HW_IRQS_ENTRIES (8 * 1024)
> >>> =20
> >>> +/* VC BAR contains set translations for the ESBs and the EQs. */
> >>> +#define VC_BAR_DEFAULT   0x10000000000ull
> >>> +#define VC_BAR_SIZE      0x08000000000ull
> >>> +
> >>> +#define P9_MMIO_BASE     0x006000000000000ull
> >>> +#define P9_CHIP_BASE(id) (P9_MMIO_BASE | (0x40000000000ull * (uint64=
_t) (id)))
> >>
> >> chip-based MMIO addresses leaking into the PAPR model seems like it
> >> might not be what you want
>=20
> See above for the reason.
>=20
>=20
> Thanks,
>=20
> C.=20
>=20
> >>
> >>> +static uint64_t xive_esb_default_read(void *p, hwaddr offset, unsign=
ed size)
> >>> +{
> >>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
> >>> +                  __func__, offset, size);
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static void xive_esb_default_write(void *opaque, hwaddr offset, uint=
64_t value,
> >>> +                unsigned size)
> >>> +{
> >>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 =
" [%u]\n",
> >>> +                  __func__, offset, value, size);
> >>> +}
> >>> +
> >>> +static const MemoryRegionOps xive_esb_default_ops =3D {
> >>> +    .read =3D xive_esb_default_read,
> >>> +    .write =3D xive_esb_default_write,
> >>> +    .endianness =3D DEVICE_BIG_ENDIAN,
> >>> +};
> >>> =20
> >>>  void xive_reset(void *dev)
> >>>  {
> >>> @@ -435,10 +467,20 @@ static void xive_realize(DeviceState *dev, Erro=
r **errp)
> >>>      x->eqdt =3D g_malloc0(x->nr_targets * XIVE_EQ_PRIORITY_COUNT *
> >>>                          sizeof(XiveEQ));
> >>> =20
> >>> +    /* VC BAR. That's the full window but we will only map the
> >>> +     * subregions in use. */
> >>> +    x->vc_base =3D (hwaddr)(P9_CHIP_BASE(x->chip_id) | VC_BAR_DEFAUL=
T);
> >>> +
> >>> +    /* install default memory region handlers to log bogus access */
> >>> +    memory_region_init_io(&x->esb_iomem, NULL, &xive_esb_default_ops,
> >>> +                          NULL, "xive.esb", VC_BAR_SIZE);
> >>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->esb_iomem);
> >>> +
> >>>      qemu_register_reset(xive_reset, dev);
> >>>  }
> >>> =20
> >>>  static Property xive_properties[] =3D {
> >>> +    DEFINE_PROP_UINT32("chip-id", XIVE, chip_id, 0),
> >>>      DEFINE_PROP_UINT32("nr-targets", XIVE, nr_targets, 0),
> >>>      DEFINE_PROP_END_OF_LIST(),
> >>>  };
> >>
> >>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll2qpsACgkQbDjKyiDZ
s5LRIA/8CENsn+3+ZRxAHVFthPk4Keik1D7dQMvcl1hvxeTNPsFbiaK8Ucp64+5z
EVog/AxqElGrJmJS2pn1VW29iC5byIEmwXgK5XSEGc+CZQxdinAXrIMyEaj5Soqs
lAAWCFVNVCTnotbz5xoa+RlaNlhqPB/rhDBrTTCSU0tp2QqHlKZPJJeKGdpj9W+G
ygs2xy0qIk/rEI4Ep7Ti71Smh0KdK6CEd8GKkXGiuIZC1ubdn+BxRf0ak6Rgqzag
/TRxNzEaRrA00HUlSjRxE7Ngc7LaFXvHxwVC/5wKN6utvKRL0RKOrnywCSZvHzkp
Y4sai/mO6PEYEbTs/kUabifpHr884DHYip9CGr9fSfYvxwQ3D46W0er6bEyuyneK
+uGMCcsxRI2dp6l2eU6P+DEbvG9fNBp5aVcOtniJqToEjYSCjvCDCb4qKw0rZCul
AR+28szj0X3AqT2cSD/0C/nQ1RsC/CNFM5vwAyNN07zE5qdqE7HCxR7u0lSuoQHP
w1q1CVJCPv6fLIDI0ynAGL7FoVcJInpD6hLpuQzA8lgrDxV5/QpUkIt/LbmZXjQv
xEYIo5JWdLk5rrEdgwfBWN+wGCEoPzAq8sAVq7vo8sgMEGHfH1+2eXdMErzQoWXj
QXvievkg/oVgWz25wNu0yfSYdM8uR3kxxcpo+y/xMX0fCNfsmrk=
=/U/J
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
