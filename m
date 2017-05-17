Received: from eggs.gnu.org ([2001:4830:134:3::10]:35732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxH-0002lA-MR
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxB-00048k-RQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:07 -0400
Date: Wed, 17 May 2017 17:00:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517070049.GN15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-7-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
In-Reply-To: <1494992962-6929-7-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 6/6] spapr: Fix migration of Radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 09:19:22AM +0530, Bharata B Rao wrote:
> Fix migration of radix guests by ensuring that we issue
> KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
>=20
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         | 15 +++++++++++++++
>  hw/ppc/spapr_hcall.c   |  1 +
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 05abfc1..dd1d687 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1443,6 +1443,20 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> =20
> +    if (spapr->patb_entry) {
> +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> +            err =3D kvmppc_configure_v3_mmu(POWERPC_CPU(first_cpu),
> +                                          spapr->patb_flags &
> +                                          SPAPR_PROC_TABLE_RADIX,
> +                                          spapr->patb_flags &
> +                                          SPAPR_PROC_TABLE_GTSE,

You should be able to work out the things you need here from
patb_entry without adding the new patb_flags field.

> +                                          spapr->patb_entry);
> +        } else {
> +            error_report("Radix guest is unsupported by the host");
> +            return -EINVAL;
> +        }
> +    }
> +
>      return err;
>  }
> =20
> @@ -1527,6 +1541,7 @@ static const VMStateDescription vmstate_spapr_patb_=
entry =3D {
>      .needed =3D spapr_patb_entry_needed,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT64(patb_entry, sPAPRMachineState),
> +        VMSTATE_UINT64(patb_flags, sPAPRMachineState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 768aa57..b002fae 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -986,6 +986,7 @@ static target_ulong h_register_process_table(PowerPCC=
PU *cpu,
>      spapr_check_setup_free_hpt(spapr, spapr->patb_entry, cproc);
> =20
>      spapr->patb_entry =3D cproc; /* Save new process table */
> +    spapr->patb_flags =3D flags; /* Save the flags */
> =20
>      /* Update the UPRT and GTSE bits in the LPCR for all cpus */
>      CPU_FOREACH(cs) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5b39a26..c25a32e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -75,6 +75,7 @@ struct sPAPRMachineState {
>      void *htab;
>      uint32_t htab_shift;
>      uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_T=
ABLE */
> +    uint64_t patb_flags;
>      hwaddr rma_size;
>      int vrma_adjust;
>      ssize_t rtas_size;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/UhAAoJEGw4ysog2bOSE0IP/1fH9oHPUo7CZXfk9tQhiMap
XaD5Faid0lwHKi5qfHbnugw6QelKuyRm7mn/eH3FHkderqTLTwZbI06v3JwfNQgM
pEcuxcMgdGSDJAcDAH9l+0VcMXLtCTIPqBwE/cpqFvuGD9PH8ccaUSL4PcB9iu8r
N3FME9BmeuN9QBkgpF0pbm+ytrHlrIjo5FwrJuk1Z4+DO07hhDIiuvBf93zR/OX3
nDi0I6TjPuxEuLFy/R5ZS0sWOJyF2Bb6Yw+ueXGCSw/AtL3FjR746Vj5jwI9x2Kp
FqLN2ozy/2PZvU6bGk+8KjjkQIT2oMgktRFbT5CBAJ59HTsbIDKAokC2TZ+pOQkk
XNOUWAHbaKe9JQNxrxr+IBGt2zM2Pq+PEpJemgJiu8TcHTOCWz0jV6DaLrp4ZV7d
UdbKlBtFswAI8mhMQkZ8nwFywMSG03BJk7EstRs1tWf+SiDb3jCiftdTB4mP5WMu
ki4pgZZkRcwgOE1Yo1AgRGt3mL9HH5XPXkmjT8lbbF/A97kjnrKZ2ca8JYeCn3WU
SJJRh3b4a5SwtIi+Qs7/IEu2HtQuY+rAd5/dcjKcV2ZxjpfYPTsKQ16N6ud4fI6F
GmvsuMNfv22jn7O2veekaKPO5iPU64TtGVowqSdmEqpCrKKJBdI0PO4p6GoaqFvu
52IXy84yIpnqcQ1h4j5c
=Gr/2
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--
