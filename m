Received: from eggs.gnu.org ([209.51.188.92]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwent-0000tj-3M
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 22:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwenr-0002x0-JK
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 22:13:41 -0500
Date: Thu, 21 Feb 2019 14:13:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190221031316.GE13129@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-6-clg@kaod.org>
	<20190212054013.GL1884@umbus.fritz.box>
	<ef18dbf0-87dc-1ec2-247f-28bae0aef308@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <ef18dbf0-87dc-1ec2-247f-28bae0aef308@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 05/19] ppc/pnv: add XIVE support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 08:31:25AM +0100, C=E9dric Le Goater wrote:
> On 2/12/19 6:40 AM, David Gibson wrote:
> > On Mon, Jan 28, 2019 at 10:46:11AM +0100, C=E9dric Le Goater wrote:
[snip]
> >>  #endif /* _PPC_PNV_H */
> >> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> >> index 9961ea3a92cd..8e57c064e661 100644
> >> --- a/include/hw/ppc/pnv_core.h
> >> +++ b/include/hw/ppc/pnv_core.h
> >> @@ -49,6 +49,7 @@ typedef struct PnvCoreClass {
> >> =20
> >>  typedef struct PnvCPUState {
> >>      struct ICPState *icp;
> >> +    struct XiveTCTX *tctx;
> >=20
> > Unlike sPAPR, we really do always know in advance the interrupt
> > controller for a particular machine.  I think it makes sense to
> > further split the POWER8 and POWER9 cases here, so we only track one
> > for any given setup.
>=20
> So, you would define a :=20
>=20
>   typedef struct Pnv9CPUState {
>       struct XiveTCTX *tctx;
>   } Pnv9CPUState;
>=20
> to be allocated when the core is realized ? and later the routine=20
> pnv_chip_power9_intc_create() would assign the ->tctx pointer.

Sounds about right.

[snip]
> >> +    uint32_t      nr_ends;
> >> +    XiveENDSource end_source;
> >> +
> >> +    /* Interrupt controller registers */
> >> +    uint64_t      regs[0x300];
> >> +
> >> +    /* Can be configured by FW */
> >> +    uint32_t      tctx_chipid;
> >> +    uint32_t      chip_id;
> >=20
> > Can't you derive that since you have a pointer to the owning chip?
>=20
> Not always, there are register fields to purposely override this value.
> I can improve the current code a little I think.

Ok.

[snip]
> >> +/*
> >> + * Virtual structures table (VST)
> >> + */
> >> +typedef struct XiveVstInfo {
> >> +    uint32_t    type;
> >> +    const char *name;
> >> +    uint32_t    size;
> >> +    uint32_t    max_blocks;
> >> +} XiveVstInfo;
> >> +
> >> +static const XiveVstInfo vst_infos[] =3D {
> >> +    [VST_TSEL_IVT]  =3D { VST_TSEL_IVT,  "EAT",  sizeof(XiveEAS), 16 =
},
> >=20
> > I don't love explicitly storing the type/index in each record, as well
> > as it being implicit in the table slot.
>=20
> The 'vst_infos' table decribes the different table types and the 'type'=
=20
> field is used to index the runtime table of VSDs. See
> pnv_xive_vst_addr()

Yes, I know what it's for but it's still redundant information.  You
could avoid it, for example, by passing around an index instead of a
pointer to a vst_infos[] slot - then you can look up both vst_infos
and the other table using that index.

[snip]
> >> +    case CQ_TM1_BAR: /* TM BAR. 4 pages. Map only once */
> >> +    case CQ_TM2_BAR: /* second TM BAR. for hotplug. Not modeled */
> >> +        xive->tm_shift =3D val & CQ_TM_BAR_64K ? 16 : 12;
> >> +        if (!(val & CQ_TM_BAR_VALID)) {
> >> +            xive->tm_base =3D 0;
> >> +            if (xive->regs[reg] & CQ_TM_BAR_VALID && xive->chip_id =
=3D=3D 0) {
> >> +                memory_region_del_subregion(sysmem, &xive->tm_mmio);
> >> +            }
> >> +        } else {
> >> +            xive->tm_base =3D val & ~(CQ_TM_BAR_VALID | CQ_TM_BAR_64K=
);
> >> +            if (!(xive->regs[reg] & CQ_TM_BAR_VALID) && xive->chip_id=
 =3D=3D 0) {
> >> +                memory_region_add_subregion(sysmem, xive->tm_base,
> >> +                                            &xive->tm_mmio);
> >> +            }
> >> +        }
> >> +        break;
> >> +
> >> +    case CQ_PC_BARM:
> >> +        xive->regs[reg] =3D val;
> >=20
> > As discussed elsewhere, this seems to be a big mix of writing things
> > directly into regs[reg] and doing other things instead, and you really
> > want to go one way or the other.  I'd suggest dropping xive->regs[]
> > and instead putting the state you need persistent into its own
> > variables.
>=20
> I made a big effort to introduce helper routines to avoid storing values=
=20
> that can be calculated under the PnvXive model, as you asked for it.=20
> The assignment above is only necessary for the pnv_xive_pc_size() below
> and I don't know how handle this current case without duplicating the=20
> switch statement, which I think is ugly.

I'm not sure quite what you mean about duplicating the case.

The point here is that since you're only storing in a couple of the
switch cases, you can just have explicit data backing just those
values and write to those in the switch cases instead of having a
great big regs[] array of which only a few bits are used.

> So, I will keep the xive->regs[] and make the couple of fixes still neede=
d.

[snip]
> >> +/*
> >> + * Virtualization Controller MMIO region containing the IPI and END E=
SB pages
> >> + */
> >> +static uint64_t pnv_xive_vc_read(void *opaque, hwaddr offset,
> >> +                                 unsigned size)
> >> +{
> >> +    PnvXive *xive =3D PNV_XIVE(opaque);
> >> +    uint64_t edt_index =3D offset >> pnv_xive_edt_shift(xive);
> >> +    uint64_t edt_type =3D 0;
> >> +    uint64_t edt_offset;
> >> +    MemTxResult result;
> >> +    AddressSpace *edt_as =3D NULL;
> >> +    uint64_t ret =3D -1;
> >> +
> >> +    if (edt_index < XIVE_TABLE_EDT_MAX) {
> >> +        edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_index]);
> >> +    }
> >> +
> >> +    switch (edt_type) {
> >> +    case CQ_TDR_EDT_IPI:
> >> +        edt_as =3D &xive->ipi_as;
> >> +        break;
> >> +    case CQ_TDR_EDT_EQ:
> >> +        edt_as =3D &xive->end_as;
> >=20
> > I'm not entirely understanding the function of these AddressSpace objec=
tz.
>=20
> The IPI and END ESB pages are exposed in the same VC region. But this VC=
=20
> region is not splitted between the two types with a single offset. It=20
> is segmented with the EDT tables which defines the type of each segment.=
=20
>=20
> The purpose of these address spaces is to translate the load/stores in=20
> the VC region in the equivalent IPI or END region exposing contigously=20
> ESB pages of the same type: 'end_edt_mmio' and 'ipi_edt_mmio'.=20
>=20
> The memory regions of the XiveENDSource and the XiveSource for the IPIs=
=20
> are mapped in 'end_edt_mmio' and 'ipi_edt_mmio'.

Hmm.  Ok, I'm not immediately seeing why you can't map the various IPI
or END blocks directly into address_space memory rather than having
this extra internal layer of indirection.

> (This is changing for P10, should be simpler)  =20

[snip]
> >> +/*
> >> + *  Maximum number of IRQs and ENDs supported by HW
> >> + */
> >> +#define PNV_XIVE_NR_IRQS (PNV9_XIVE_VC_SIZE / (1ull << XIVE_ESB_64K_2=
PAGE))
> >> +#define PNV_XIVE_NR_ENDS (PNV9_XIVE_VC_SIZE / (1ull << XIVE_ESB_64K_2=
PAGE))
> >> +
> >> +static void pnv_xive_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    PnvXive *xive =3D PNV_XIVE(dev);
> >> +    XiveSource *xsrc =3D &xive->source;
> >> +    XiveENDSource *end_xsrc =3D &xive->end_source;
> >> +    Error *local_err =3D NULL;
> >> +    Object *obj;
> >> +
> >> +    obj =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
> >> +    if (!obj) {
> >> +        error_propagate(errp, local_err);
> >> +        error_prepend(errp, "required link 'chip' not found: ");
> >> +        return;
> >> +    }
> >> +
> >> +    /* The PnvChip id identifies the XIVE interrupt controller. */
> >> +    xive->chip =3D PNV_CHIP(obj);
> >> +
> >> +    /*
> >> +     * Xive Interrupt source and END source object with the maximum
> >> +     * allowed HW configuration. The ESB MMIO regions will be resized
> >> +     * dynamically when the controller is configured by the FW to
> >> +     * limit accesses to resources not provisioned.
> >> +     */
> >> +    object_property_set_int(OBJECT(xsrc), PNV_XIVE_NR_IRQS, "nr-irqs",
> >> +                            &error_fatal);
> >=20
> > You have a constant here, but your router object also includes a
> > nr_irqs field.  What's up with that?
>=20
> The XiveSource object of PnvXive is realized for the maximum size allowed
> by HW because we don't know how much IRQs the FW will provision for.
>=20
> The 'nr_irqs' is the number of IRQs configured by the FW (We changed the
> name to 'nr_ipis') See routine pnv_xive_vst_set_exclusive()

Ah, ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxuF0kACgkQbDjKyiDZ
s5I67Q/7BAdsIni1p91AvtT34tWbofj4HHJyMpfYYNSfryXeZ17tb6LsuYdskIBC
aralWfG7hXrTaHVOITTA0lIwt3AcByE8/yVKsCuFAkcSk7R+YWffHYBvyrM5Xdyd
1wFGp+hF5P7WYru5B4BNPYLNgGucJ/kvpVXI4vGbF4OrIuK3YximpAxCoztwIMZo
mqvNOIV6KOCJrJhYa+dAmBPSpAp8dT0jrfzuDWqwr6fWyVdUGpUwvsl5QQl9DFoN
R/8GTNr6n9Q6O66Dunhl0gQRQw/n3vBqm1bHQVN/SxBngDKpH6IdTOxbkvjStSy6
GsNXjGyeURjnsXJNlR1q2LgOxx60gOnkAY6vcQPjuO0K46EykvQORuuJbT6MGjU/
5V6UODWSwq/wQv4nBWXVxxk/1+HrzXludB89CaPBlEQ0qWQT05PvC2Fh5bwSe3PJ
ilDYA1biIKDQ93fzti5tBemhQHOYiTFHsQQd4AJo2Na3Vz01NozY65qyBnT4t+fB
E0uu15dqBoApEhKeV+YQd8uHhD2yvAvqYV1nU0B+oXgrWE2Z2xxi4Iw14djSxk0g
H0QeXNTVc+rCZYIumT/2Y3Jkz1Wc4ONQZt6lzutbdNSEpRGc7Tg1y5MuTd1HbM74
qnqzb4AwKGz3g2jGY1jQocannlVeR3YJH6cxeU5xv7HXiX8O1Wo=
=/K1v
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
