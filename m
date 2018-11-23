Received: from eggs.gnu.org ([2001:4830:134:3::10]:52497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4rb-0003Dq-6w
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4rZ-0002oE-Ev
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:51 -0500
Date: Fri, 23 Nov 2018 15:36:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123043611.GZ10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-7-clg@kaod.org>
	<20181122051302.GG10448@umbus.fritz.box>
	<14e8b331-0c33-b07e-01ca-a540852bea37@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9CzcV6dAFIr7O1Ie"
Content-Disposition: inline
In-Reply-To: <14e8b331-0c33-b07e-01ca-a540852bea37@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 06/36] ppc/xive: add support for the END
 Event State buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--9CzcV6dAFIr7O1Ie
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 10:58:56PM +0100, C=E9dric Le Goater wrote:
> On 11/22/18 6:13 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:56:59AM +0100, C=E9dric Le Goater wrote:
> >> The Event Notification Descriptor also contains two Event State
> >> Buffers providing further coalescing of interrupts, one for the
> >> notification event (ESn) and one for the escalation events (ESe). A
> >> MMIO page is assigned for each to control the EOI through loads
> >> only. Stores are not allowed.
> >>
> >> The END ESBs are modeled through an object resembling the 'XiveSource'
> >> It is stateless as the END state bits are backed into the XiveEND
> >> structure under the XiveRouter and the MMIO accesses follow the same
> >> rules as for the standard source ESBs.
> >>
> >> END ESBs are not supported by the Linux drivers neither on OPAL nor on
> >> sPAPR. Nevetherless, it provides a mean to study the question in the
> >> future and validates a bit more the XIVE model.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xive.h |  20 ++++++
> >>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 178 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index ce62aaf28343..24301bf2076d 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -208,6 +208,26 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t=
 end_blk, uint32_t end_idx,
> >>  int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
> >>                          XiveEND *end);
> >> =20
> >> +/*
> >> + * XIVE END ESBs
> >> + */
> >> +
> >> +#define TYPE_XIVE_END_SOURCE "xive-end-source"
> >> +#define XIVE_END_SOURCE(obj) \
> >> +    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
> >=20
> > Is there a particular reason to make this a full QOM object, rather
> > than just embedding it in the XiveRouter?
>=20
> yes, it should probably be under the XiveRouter you are right because
> there is a direct link with the ENDT which is in the XiverRouter.=20
>=20
> But if I remove the chip_id field from the XiveRouter, it becomes a QOM
> interface. something to ponder.

Huh?  I really don't understand what you're saying here.  What does
chip_id have to do with anything?

> =20
> >> +typedef struct XiveENDSource {
> >> +    SysBusDevice parent;
> >> +
> >> +    uint32_t        nr_ends;
> >> +
> >> +    /* ESB memory region */
> >> +    uint32_t        esb_shift;
> >> +    MemoryRegion    esb_mmio;
> >> +
> >> +    XiveRouter      *xrtr;
> >> +} XiveENDSource;
> >> +
> >>  /*
> >>   * For legacy compatibility, the exceptions define up to 256 different
> >>   * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index 9cb001e7b540..5a8882d47a98 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -622,8 +622,18 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
> >>       * even futher coalescing in the Router
> >>       */
> >>      if (!(end.w0 & END_W0_UCOND_NOTIFY)) {
> >> -        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented=
\n");
> >> -        return;
> >> +        uint8_t pq =3D GETFIELD(END_W1_ESn, end.w1);
> >> +        bool notify =3D xive_esb_trigger(&pq);
> >> +
> >> +        if (pq !=3D GETFIELD(END_W1_ESn, end.w1)) {
> >> +            end.w1 =3D SETFIELD(END_W1_ESn, end.w1, pq);
> >> +            xive_router_set_end(xrtr, end_blk, end_idx, &end);
> >> +        }
> >> +
> >> +        /* ESn[Q]=3D1 : end of notification */
> >> +        if (!notify) {
> >> +            return;
> >> +        }
> >>      }
> >> =20
> >>      /*
> >> @@ -706,6 +716,151 @@ void xive_eas_pic_print_info(XiveEAS *eas, uint3=
2_t lisn, Monitor *mon)
> >>                     (uint32_t) GETFIELD(EAS_END_DATA, eas->w));
> >>  }
> >> =20
> >> +/*
> >> + * END ESB MMIO loads
> >> + */
> >> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, unsig=
ned size)
> >> +{
> >> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
> >> +    XiveRouter *xrtr =3D xsrc->xrtr;
> >> +    uint32_t offset =3D addr & 0xFFF;
> >> +    uint8_t end_blk;
> >> +    uint32_t end_idx;
> >> +    XiveEND end;
> >> +    uint32_t end_esmask;
> >> +    uint8_t pq;
> >> +    uint64_t ret =3D -1;
> >> +
> >> +    end_blk =3D xrtr->chip_id;
> >> +    end_idx =3D addr >> (xsrc->esb_shift + 1);
> >> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_bl=
k,
> >> +                      end_idx);
> >> +        return -1;
> >> +    }
> >> +
> >> +    if (!(end.w0 & END_W0_VALID)) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: END %x/%x is invalid\n",
> >> +                      end_blk, end_idx);
> >> +        return -1;
> >> +    }
> >> +
> >> +    end_esmask =3D addr_is_even(addr, xsrc->esb_shift) ? END_W1_ESn :=
 END_W1_ESe;
> >> +    pq =3D GETFIELD(end_esmask, end.w1);
> >> +
> >> +    switch (offset) {
> >> +    case XIVE_ESB_LOAD_EOI ... XIVE_ESB_LOAD_EOI + 0x7FF:
> >> +        ret =3D xive_esb_eoi(&pq);
> >> +
> >> +        /* Forward the source event notification for routing ?? */
> >> +        break;
> >> +
> >> +    case XIVE_ESB_GET ... XIVE_ESB_GET + 0x3FF:
> >> +        ret =3D pq;
> >> +        break;
> >> +
> >> +    case XIVE_ESB_SET_PQ_00 ... XIVE_ESB_SET_PQ_00 + 0x0FF:
> >> +    case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
> >> +    case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
> >> +    case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
> >> +        ret =3D xive_esb_set(&pq, (offset >> 8) & 0x3);
> >> +        break;
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid END ESB load ad=
dr %d\n",
> >> +                      offset);
> >> +        return -1;
> >> +    }
> >> +
> >> +    if (pq !=3D GETFIELD(end_esmask, end.w1)) {
> >> +        end.w1 =3D SETFIELD(end_esmask, end.w1, pq);
> >> +        xive_router_set_end(xrtr, end_blk, end_idx, &end);
> >> +    }
> >=20
> > We can probably share some more code with XiveSource here, but that's
> > something that can be refined later.
>=20
> yes clearly. The idea was to introduce a XiveESB model handling only the=
=20
> MMIO aspects and rely on an interface to query/modify the underlying PQ b=
its.
> These state bits are related to a device and the ESB pages are the XIVE w=
ay=20
> to expose them.=20
>=20
> I left that for later. I didn't want to complexify more the XiveSource=20
> with a feature not used today.=20
>=20
> Thanks,
>=20
> C.
>=20
> >=20
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +/*
> >> + * END ESB MMIO stores are invalid
> >> + */
> >> +static void xive_end_source_write(void *opaque, hwaddr addr,
> >> +                                  uint64_t value, unsigned size)
> >> +{
> >> +    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr 0x%"
> >> +                  HWADDR_PRIx"\n", addr);
> >> +}
> >> +
> >> +static const MemoryRegionOps xive_end_source_ops =3D {
> >> +    .read =3D xive_end_source_read,
> >> +    .write =3D xive_end_source_write,
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
> >> +static void xive_end_source_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(dev);
> >> +    Object *obj;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
> >> +    if (!obj) {
> >> +        error_propagate(errp, local_err);
> >> +        error_prepend(errp, "required link 'xive' not found: ");
> >> +        return;
> >> +    }
> >> +
> >> +    xsrc->xrtr =3D XIVE_ROUTER(obj);
> >> +
> >> +    if (!xsrc->nr_ends) {
> >> +        error_setg(errp, "Number of interrupt needs to be greater tha=
n 0");
> >> +        return;
> >> +    }
> >> +
> >> +    if (xsrc->esb_shift !=3D XIVE_ESB_4K &&
> >> +        xsrc->esb_shift !=3D XIVE_ESB_64K) {
> >> +        error_setg(errp, "Invalid ESB shift setting");
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Each END is assigned an even/odd pair of MMIO pages, the even =
page
> >> +     * manages the ESn field while the odd page manages the ESe field.
> >> +     */
> >> +    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> >> +                          &xive_end_source_ops, xsrc, "xive.end",
> >> +                          (1ull << (xsrc->esb_shift + 1)) * xsrc->nr_=
ends);
> >> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
> >> +}
> >> +
> >> +static Property xive_end_source_properties[] =3D {
> >> +    DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
> >> +    DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64=
K),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void xive_end_source_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    dc->desc    =3D "XIVE END Source";
> >> +    dc->props   =3D xive_end_source_properties;
> >> +    dc->realize =3D xive_end_source_realize;
> >> +}
> >> +
> >> +static const TypeInfo xive_end_source_info =3D {
> >> +    .name          =3D TYPE_XIVE_END_SOURCE,
> >> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >> +    .instance_size =3D sizeof(XiveENDSource),
> >> +    .class_init    =3D xive_end_source_class_init,
> >> +};
> >> +
> >>  /*
> >>   * XIVE Fabric
> >>   */
> >> @@ -720,6 +875,7 @@ static void xive_register_types(void)
> >>      type_register_static(&xive_source_info);
> >>      type_register_static(&xive_fabric_info);
> >>      type_register_static(&xive_router_info);
> >> +    type_register_static(&xive_end_source_info);
> >>  }
> >> =20
> >>  type_init(xive_register_types)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9CzcV6dAFIr7O1Ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3g7sACgkQbDjKyiDZ
s5LaLBAAt1cbUfGLTD/+e/YEUyEFzV2tpfcXfM+frL3a7xMmAXiGwH7u/vneXIkY
ZoL4plCDHEJvB6TRLt3pOtJ5W3YsHI0sRqT2TiX7EL0Knh2zv7zsnPrrxzC2odF5
yLVq58r+/QuvmMTtTfd/fRNsM4Ncc/Ra3p8wrG73WDypNHHijaq40lRtNbRakF0S
jdiOiE1RDXyV4r6Cv+RnbfvIJvZBQbSbFEnOaufi+2tTxzTzbVXOxcJ0dzoejxVt
J//uj7S9fYYJU2wbYiG6iZFgSTOp7gjjapzUTT0fz/7OP62iCAdGpDiIAE6uquLt
GScuaTYBcZp3iAJ0VNOcp5F5SDCtHS26TzLA1VAHbh0s/NC+e2Hc/81smTsFd2wi
M3A77VC+uyCSByC1tfIcQE+vFJyMzdxY8J7Y8W+9fdu6qYpAFLERJWJQuyj2w6Jh
Otyt1d1Db7P33kAlEtLvaqD0I/dEFdQY7f9gdcIxR3UWC6IL4GJ9KRFSwnigw5uT
lesEZpugr6gnzbAz25k1DjxBQ8NvWjEeX9E/pnvunlTL6EM15+qGZZ0BKqhYtiqe
FpAVJamZahJniqRXnUsfUl3gMV11QDr524fNDOmH73ggOkKzfyzbqd7WZHKhfEI2
UthvyqWIyOv6M6CfNzfL2NUDa4j88mG1h2eM3YYIRVfp8+IZKRc=
=Z5QY
-----END PGP SIGNATURE-----

--9CzcV6dAFIr7O1Ie--
