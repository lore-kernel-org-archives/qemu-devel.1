Received: from eggs.gnu.org ([209.51.188.92]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2EM0-00007G-Ss
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2ELu-0000FR-TT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:11:55 -0500
Date: Fri, 8 Mar 2019 22:08:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308110814.GA15851@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-6-clg@kaod.org>
	<20190308000107.GD7722@umbus.fritz.box>
	<52db5166-7d8f-8758-3e1d-fd4b8738eb4d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <52db5166-7d8f-8758-3e1d-fd4b8738eb4d@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 05/15] ppc/pnv: add a 'dt_isa_nodename'
 to the chip
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 07:55:33AM +0100, C=E9dric Le Goater wrote:
> On 3/8/19 1:01 AM, David Gibson wrote:
> > On Thu, Mar 07, 2019 at 11:35:38PM +0100, C=E9dric Le Goater wrote:
> >> The ISA bus has a different DT nodename on POWER9. Compute the name
> >> when the PnvChip is realized, that is before it is used by the machine
> >> to populate the device tree with the ISA devices.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > I still tend to think that passing an offset into pnv_dt_isa would
> > have been a better solution, but this will serve.  Applied.
>=20
> Do you mean something like below possibly ?=20
>=20
>    int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nodename=
);
>=20
>    /* Populate ISA devices on chip 0 */
>    pnv_dt_isa(pnv->isa_bus, fdt, isa_offset);

Yes, although if you do it from the same code that constructed the isa
node in the first place, you should already know its offset without
having to look it up by name.

> pnv_dt_isa() is called at the machine level but we could change it
> to be called at the chip level for chip0 only.

Either or; the machine is already divided into power8 and power9
versions, isn't it?

>=20
> C.
>=20
>=20
> >> ---
> >>  include/hw/ppc/pnv.h |  2 ++
> >>  hw/ppc/pnv.c         | 18 +++++-------------
> >>  2 files changed, 7 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> >> index 8d80cb34eebb..c81f157f41a9 100644
> >> --- a/include/hw/ppc/pnv.h
> >> +++ b/include/hw/ppc/pnv.h
> >> @@ -58,6 +58,8 @@ typedef struct PnvChip {
> >>      MemoryRegion xscom_mmio;
> >>      MemoryRegion xscom;
> >>      AddressSpace xscom_as;
> >> +
> >> +    gchar        *dt_isa_nodename;
> >>  } PnvChip;
> >> =20
> >>  #define TYPE_PNV8_CHIP "pnv8-chip"
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 922e3ec48bb5..6625562d276d 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -417,24 +417,12 @@ static int pnv_dt_isa_device(DeviceState *dev, v=
oid *opaque)
> >>      return 0;
> >>  }
> >> =20
> >> -static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
> >> -{
> >> -    char *name;
> >> -    int offset;
> >> -
> >> -    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> >> -                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM=
_LPC_BASE);
> >> -    offset =3D fdt_path_offset(fdt, name);
> >> -    g_free(name);
> >> -    return offset;
> >> -}
> >> -
> >>  /* The default LPC bus of a multichip system is on chip 0. It's
> >>   * recognized by the firmware (skiboot) using a "primary" property.
> >>   */
> >>  static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
> >>  {
> >> -    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
> >> +    int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nod=
ename);
> >>      ForeachPopulateArgs args =3D {
> >>          .fdt =3D fdt,
> >>          .offset =3D isa_offset,
> >> @@ -866,6 +854,10 @@ static void pnv_chip_power8_realize(DeviceState *=
dev, Error **errp)
> >>                               &error_fatal);
> >>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xsc=
om_regs);
> >> =20
> >> +    chip->dt_isa_nodename =3D g_strdup_printf("/xscom@%" PRIx64 "/isa=
@%x",
> >> +                                            (uint64_t) PNV_XSCOM_BASE=
(chip),
> >> +                                            PNV_XSCOM_LPC_BASE);
> >> +
> >>      /* Interrupt Management Area. This is the memory region holding
> >>       * all the Interrupt Control Presenter (ICP) registers */
> >>      pnv_chip_icp_realize(chip8, &local_err);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyCTRwACgkQbDjKyiDZ
s5KkqhAArgoJdRJuDOd1hK+UiUUH4xQBqXsQrqZyze8M9Jw+RCUwuVB9kBYpEjzZ
rf51NSrmrSJXN9mxmee5yGWJmXDd/IUbHxBxOpdNmAu3JeeFPSsYHFFAWauQRLiS
Go4eY4QTv0XeWQAhj+pZBvP5baY+muOkjM5JgpRLesK+55t+pB/LjLBWnolEPckG
v7zfQeDyj2mg3+wcODX714wINzMwNN5I5YY7BPxY6wDtN3BpVgf/as4uafYtJ2jU
ugf1oHIO99nHnnqhDnmlullmkzgHzejTWMKU8mQahKL/2XgNBjKY4ICWmIzOJnq2
tNRDYQic3lauTw6fcTwVwikUjV12hSTBKCVT3rEnDAZsNTFuWL5z5cIDjw+UUF0n
jA612WdrldxqgKYyjfXgi/lNytglkdxvM2DYjahOChu5osBUjKn7alTJY9guCc9t
kQ1wS+kWSawroSaUe52Oxietej4cSqbiYlPS8k7iDhh1UhWdgWDPrF8VtCywxyhk
64lCKuIHeuzvr8zmnqXJQHcqS80tnm0iPmf2TDxtRNUkhUBJVH+eR9jGBAzQDHYF
WXCvCD1EXKUp16RlUv/QXHqycC3Q/+Han/Q2yqzMkPJeVz8lE8LfbR1feTWWYr4L
I+Q6555yuTmIQthmjYsNmzNDCbh+3f3A+/R95+QygSL9In2Z3cQ=
=UOpz
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
