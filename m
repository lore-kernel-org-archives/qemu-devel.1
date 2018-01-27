Received: from eggs.gnu.org ([2001:4830:134:3::10]:39458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efMdd-00024S-Mw
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 04:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efMdc-0006hk-2v
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 04:19:05 -0500
Date: Sat, 27 Jan 2018 20:15:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180127091552.GC12900@umbus>
References: <151700552398.7196.2573848773899364520.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <151700552398.7196.2573848773899364520.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fix MSI/MSIX selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 11:25:24PM +0100, Greg Kurz wrote:
> In various place we don't correctly check if the device supports MSI or
> MSI-X. This can cause devices to be advertised with MSI support, even
> if they only support MSI-X (like virtio-pci-* devices for example):
>=20
>                 ethernet@0 {
>                         ibm,req#msi =3D <0x1>; <--- wrong!
> 			.
> 			ibm,loc-code =3D "qemu_virtio-net-pci:0000:00:00.0";
> 			.
> 			ibm,req#msi-x =3D <0x3>;
>                 };
>=20
> Worse, this can also cause the "ibm,change-msi" RTAS call to corrupt the
> PCI status and cause migration to fail:
>=20
>   qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x6
>     read: 0 device: 10 cmask: 10 wmask: 0 w1cmask:0
>                               ^^
>            PCI_STATUS_CAP_LIST bit which is assumed to be constant
>=20
> This patch changes spapr_populate_pci_child_dt() to properly check for
> MSI support using msi_present(): this ensures that PCIDevice::msi_cap
> was set by msi_init() and that msi_nr_vectors_allocated() will look at
> the right place in the config space.
>=20
> Checking PCIDevice::msix_entries_nr is enough for MSI-X but let's add
> a call to msix_present() there as well for consistency.
>=20
> It also changes rtas_ibm_change_msi() to select the appropriate MSI
> type in Function 1 instead of always selecting plain MSI. This new
> behaviour is compliant with LoPAPR 1.1, as described in "Table 71.
> ibm,change-msi Argument Call Buffer":
>=20
>   Function 1: If Number Outputs is equal to 3, request to set to a new
>            number of MSIs (including set to 0).
>            If the =E2=80=9Cibm,change-msix-capable=E2=80=9D property exis=
ts and Number
>            Outputs is equal to 4, request is to set to a new number of
>            MSI or MSI-X (platform choice) interrupts (including set to
>            0).
>=20
> Since MSI is the the platform default (LoPAPR 6.2.3 MSI Option), let's
> check for MSI support first.
>=20
> And finally, it checks the input parameters are valid, as described in
> LoPAPR 1.1 "R1=E2=80=937.3.10.5.1=E2=80=933":
>=20
>   For the MSI option: The platform must return a Status of -3 (Parameter
>   error) from ibm,change-msi, with no change in interrupt assignments if
>   the PCI configuration address does not support MSI and Function 3 was
>   requested (that is, the =E2=80=9Cibm,req#msi=E2=80=9D property must exi=
st for the PCI
>   configuration address in order to use Function 3), or does not support
>   MSI-X and Function 4 is requested (that is, the =E2=80=9Cibm,req#msi-x=
=E2=80=9D property
>   must exist for the PCI configuration address in order to use Function 4=
),
>   or if neither MSIs nor MSI-Xs are supported and Function 1 is requested.
>=20
> This ensures that the ret_intr_type variable contains a valid MSI type
> for this device, and that spapr_msi_setmsg() won't corrupt the PCI status.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

Alexey, is this the migration bug you were mentioning to me?

+lvivier

Laurent, could this cover any of the migration bugs you're looking at?
If not we should probably file a new downstream BZ for it.

> ---
>  hw/ppc/spapr_pci.c |   61 ++++++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 42 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 37f18b3d3235..39a14980d397 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -280,13 +280,42 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
>      int *config_addr_key;
>      Error *err =3D NULL;
> =20
> +    /* Fins sPAPRPHBState */
> +    phb =3D spapr_pci_find_phb(spapr, buid);
> +    if (phb) {
> +        pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
> +    }
> +    if (!phb || !pdev) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
>      switch (func) {
> -    case RTAS_CHANGE_MSI_FN:
>      case RTAS_CHANGE_FN:
> -        ret_intr_type =3D RTAS_TYPE_MSI;
> +        if (msi_present(pdev)) {
> +            ret_intr_type =3D RTAS_TYPE_MSI;
> +        } else if (msix_present(pdev)) {
> +            ret_intr_type =3D RTAS_TYPE_MSIX;
> +        } else {
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
> +        break;
> +    case RTAS_CHANGE_MSI_FN:
> +        if (msi_present(pdev)) {
> +            ret_intr_type =3D RTAS_TYPE_MSI;
> +        } else {
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
>          break;
>      case RTAS_CHANGE_MSIX_FN:
> -        ret_intr_type =3D RTAS_TYPE_MSIX;
> +        if (msix_present(pdev)) {
> +            ret_intr_type =3D RTAS_TYPE_MSIX;
> +        } else {
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
>          break;
>      default:
>          error_report("rtas_ibm_change_msi(%u) is not implemented", func);
> @@ -294,16 +323,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
>          return;
>      }
> =20
> -    /* Fins sPAPRPHBState */
> -    phb =3D spapr_pci_find_phb(spapr, buid);
> -    if (phb) {
> -        pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
> -    }
> -    if (!phb || !pdev) {
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
>      msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr=
);
> =20
>      /* Releasing MSIs */
> @@ -1286,13 +1305,17 @@ static void spapr_populate_pci_child_dt(PCIDevice=
 *dev, void *fdt, int offset,
>      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
>                            RESOURCE_CELLS_SIZE));
> =20
> -    max_msi =3D msi_nr_vectors_allocated(dev);
> -    if (max_msi) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
> +    if (msi_present(dev)) {
> +        max_msi =3D msi_nr_vectors_allocated(dev);
> +        if (max_msi) {
> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
> +        }
>      }
> -    max_msix =3D dev->msix_entries_nr;
> -    if (max_msix) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix));
> +    if (msix_present(dev)) {
> +        max_msix =3D dev->msix_entries_nr;
> +        if (max_msix) {
> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix=
));
> +        }
>      }
> =20
>      populate_resource_props(dev, &rp);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpsQ0YACgkQbDjKyiDZ
s5KFUQ//YO2AMAKOTzSLfl9DmhWW2AYkCBD0VWso6t7BNsjXOYEq34NqOlHEnAtU
P2Ela/praQ8/wGa1mVp5OCw1a9GuCI3C5nKG/LM1UpDPwRLVInf59AthVxZpUopU
i+44d+EtKX082c+7s2fXSNWuLqb+EDFfN9/Jzeruhtekaa7ahyitxjpZShUtPKfO
+DEVRPDfsGvhxyBQQ+ymKzRFUhLJfhk5C8RUFLj6mNICJgFH6TLPK0EmhIylNtko
fR3eeDVEJhS+BeCNw6jDKgDcCnOgdv8q1udH5eDm6PKTWW81vjPHnnyXHLNrXd3s
ZnyFjhCYZsVuJH/B6iaep3CQsd2BJoOp+b6lE3WiwqtVVbD8LuT27EOmqeseiL+e
wLpdJ8wFEafmy8kVoYQouWElT0H4cEa6yemC75705jexd1s8I+AkJT6HMwWnXuZ9
Rcf95vVJQ9g7M38VdXhVvv3r3Zb+A0/yguFnGO6W913gQUFqEND1ONeyejEXmJjC
C5s9tDyIgpJdEuNajtWt6SJJ+GRx3/EHLcNgZfh1MPX+PRtfKCuLnBuQTCu4pkqV
M819bdn5RBrTnBUCJe4AYifGmJ12zrFlsONrFAe65AqXudVSWLdvhkki3bAFcjPG
mqs1m7qYqLnOSM2PQcLL1Bhpf9tw/q03g1LEpvM/mLCaFt4euog=
=5c/1
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
