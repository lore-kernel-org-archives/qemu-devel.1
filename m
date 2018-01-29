Received: from eggs.gnu.org ([2001:4830:134:3::10]:36319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eg5ol-0003jw-Uy
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eg5oi-0000is-O4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:33:35 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:60865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eg5oi-0000bN-DY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:33:32 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A001F98805
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 10:33:22 +0100 (CET)
Date: Mon, 29 Jan 2018 10:33:08 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180129103308.09657670@bahia.lan>
In-Reply-To: <20180127091552.GC12900@umbus>
References: <151700552398.7196.2573848773899364520.stgit@bahia.lan>
	<20180127091552.GC12900@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/A==.k4L3+IXFWdkW2EvzGGS";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fix MSI/MSIX selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org

--Sig_/A==.k4L3+IXFWdkW2EvzGGS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2018 20:15:52 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jan 26, 2018 at 11:25:24PM +0100, Greg Kurz wrote:
> > In various place we don't correctly check if the device supports MSI or
> > MSI-X. This can cause devices to be advertised with MSI support, even
> > if they only support MSI-X (like virtio-pci-* devices for example):
> >=20
> >                 ethernet@0 {
> >                         ibm,req#msi =3D <0x1>; <--- wrong!
> > 			.
> > 			ibm,loc-code =3D "qemu_virtio-net-pci:0000:00:00.0";
> > 			.
> > 			ibm,req#msi-x =3D <0x3>;
> >                 };
> >=20
> > Worse, this can also cause the "ibm,change-msi" RTAS call to corrupt the
> > PCI status and cause migration to fail:
> >=20
> >   qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x6
> >     read: 0 device: 10 cmask: 10 wmask: 0 w1cmask:0
> >                               ^^
> >            PCI_STATUS_CAP_LIST bit which is assumed to be constant
> >=20
> > This patch changes spapr_populate_pci_child_dt() to properly check for
> > MSI support using msi_present(): this ensures that PCIDevice::msi_cap
> > was set by msi_init() and that msi_nr_vectors_allocated() will look at
> > the right place in the config space.
> >=20
> > Checking PCIDevice::msix_entries_nr is enough for MSI-X but let's add
> > a call to msix_present() there as well for consistency.
> >=20
> > It also changes rtas_ibm_change_msi() to select the appropriate MSI
> > type in Function 1 instead of always selecting plain MSI. This new
> > behaviour is compliant with LoPAPR 1.1, as described in "Table 71.
> > ibm,change-msi Argument Call Buffer":
> >=20
> >   Function 1: If Number Outputs is equal to 3, request to set to a new
> >            number of MSIs (including set to 0).
> >            If the =E2=80=9Cibm,change-msix-capable=E2=80=9D property ex=
ists and Number
> >            Outputs is equal to 4, request is to set to a new number of
> >            MSI or MSI-X (platform choice) interrupts (including set to
> >            0).
> >=20
> > Since MSI is the the platform default (LoPAPR 6.2.3 MSI Option), let's
> > check for MSI support first.
> >=20
> > And finally, it checks the input parameters are valid, as described in
> > LoPAPR 1.1 "R1=E2=80=937.3.10.5.1=E2=80=933":
> >=20
> >   For the MSI option: The platform must return a Status of -3 (Parameter
> >   error) from ibm,change-msi, with no change in interrupt assignments if
> >   the PCI configuration address does not support MSI and Function 3 was
> >   requested (that is, the =E2=80=9Cibm,req#msi=E2=80=9D property must e=
xist for the PCI
> >   configuration address in order to use Function 3), or does not support
> >   MSI-X and Function 4 is requested (that is, the =E2=80=9Cibm,req#msi-=
x=E2=80=9D property
> >   must exist for the PCI configuration address in order to use Function=
 4),
> >   or if neither MSIs nor MSI-Xs are supported and Function 1 is request=
ed.
> >=20
> > This ensures that the ret_intr_type variable contains a valid MSI type
> > for this device, and that spapr_msi_setmsg() won't corrupt the PCI stat=
us.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied, thanks.
>=20
> Alexey, is this the migration bug you were mentioning to me?
>=20
> +lvivier
>=20
> Laurent, could this cover any of the migration bugs you're looking at?
> If not we should probably file a new downstream BZ for it.
>=20

This bug has been around for a long time, but maybe worth pushing this to
stable as well ?

Cc'ing stable.

> > ---
> >  hw/ppc/spapr_pci.c |   61 ++++++++++++++++++++++++++++++++++++--------=
--------
> >  1 file changed, 42 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 37f18b3d3235..39a14980d397 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -280,13 +280,42 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
> >      int *config_addr_key;
> >      Error *err =3D NULL;
> > =20
> > +    /* Fins sPAPRPHBState */
> > +    phb =3D spapr_pci_find_phb(spapr, buid);
> > +    if (phb) {
> > +        pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
> > +    }
> > +    if (!phb || !pdev) {
> > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +        return;
> > +    }
> > +
> >      switch (func) {
> > -    case RTAS_CHANGE_MSI_FN:
> >      case RTAS_CHANGE_FN:
> > -        ret_intr_type =3D RTAS_TYPE_MSI;
> > +        if (msi_present(pdev)) {
> > +            ret_intr_type =3D RTAS_TYPE_MSI;
> > +        } else if (msix_present(pdev)) {
> > +            ret_intr_type =3D RTAS_TYPE_MSIX;
> > +        } else {
> > +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +            return;
> > +        }
> > +        break;
> > +    case RTAS_CHANGE_MSI_FN:
> > +        if (msi_present(pdev)) {
> > +            ret_intr_type =3D RTAS_TYPE_MSI;
> > +        } else {
> > +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +            return;
> > +        }
> >          break;
> >      case RTAS_CHANGE_MSIX_FN:
> > -        ret_intr_type =3D RTAS_TYPE_MSIX;
> > +        if (msix_present(pdev)) {
> > +            ret_intr_type =3D RTAS_TYPE_MSIX;
> > +        } else {
> > +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +            return;
> > +        }
> >          break;
> >      default:
> >          error_report("rtas_ibm_change_msi(%u) is not implemented", fun=
c);
> > @@ -294,16 +323,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> >          return;
> >      }
> > =20
> > -    /* Fins sPAPRPHBState */
> > -    phb =3D spapr_pci_find_phb(spapr, buid);
> > -    if (phb) {
> > -        pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
> > -    }
> > -    if (!phb || !pdev) {
> > -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > -        return;
> > -    }
> > -
> >      msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_ad=
dr);
> > =20
> >      /* Releasing MSIs */
> > @@ -1286,13 +1305,17 @@ static void spapr_populate_pci_child_dt(PCIDevi=
ce *dev, void *fdt, int offset,
> >      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
> >                            RESOURCE_CELLS_SIZE));
> > =20
> > -    max_msi =3D msi_nr_vectors_allocated(dev);
> > -    if (max_msi) {
> > -        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
> > +    if (msi_present(dev)) {
> > +        max_msi =3D msi_nr_vectors_allocated(dev);
> > +        if (max_msi) {
> > +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi)=
);
> > +        }
> >      }
> > -    max_msix =3D dev->msix_entries_nr;
> > -    if (max_msix) {
> > -        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix));
> > +    if (msix_present(dev)) {
> > +        max_msix =3D dev->msix_entries_nr;
> > +        if (max_msix) {
> > +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_ms=
ix));
> > +        }
> >      }
> > =20
> >      populate_resource_props(dev, &rp);
> >  =20
>=20


--Sig_/A==.k4L3+IXFWdkW2EvzGGS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlpu6lQACgkQcdTV5YIv
c9bwgA//W2Izt9yiXXAxU3JVikV0rwg028izvsoF2uyaEBfdWNU6sRJZg6b/5bJ7
t7FAPPWM0bPKwtJscLXM514R/Vr6+8XO8q/ZO39MB8mGLd7mGByQ75hN93aeqc7H
KL5hiSgpKm0ZAUhsUqhk2VC8V/+7eAyQB3WyklwV9bC4gVrl/7udR8f4q57ueUk9
YqhZRz+9YooWLv2h3q4+YsaQxPmJ81OylEUTM3Q/zBwEEgO2Sr1FIn3zluje3cJj
92tN2LPQow3mhshTlz3pdkj5CDfDR/4WxUTlx45DaVPXi3v5gWkFDIhF+6IjUp5X
xO2/sxKYik659J66l/Tnq4BOvLdp8zcFVixVpHFI8Uf0EBZ7zGPnAuPokm1p2A+j
6WS3f+QRZo8IEkYeuP+tMDFsW2WR8YC+Do1FFLhuDQGLn06X55936Wo40jzs2JmB
Vb74MJh2Rfvnc2OzVvoDBviEpt5y+0Pd9/GiweCjq6rQijtFNOMNnfcHFtCEB3OP
thByM1OzMCuw1bjvXZaKqKlOCMpekq0XQvgyP3o/QkOQjoTKYNhhuvC3FIaV4fbA
z/L2wuv9WieENH5xKHsJYo3fYxI9p2y1IINVV9OyJsE7+Dq+QJU0Z8wk/f93KUd1
bepsLmn8nRw/dX1rlbfxfKRMbQqFsDac0qonUqLi9KoO5zZd2l0=
=G10J
-----END PGP SIGNATURE-----

--Sig_/A==.k4L3+IXFWdkW2EvzGGS--
