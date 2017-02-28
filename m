Received: from eggs.gnu.org ([2001:4830:134:3::10]:39315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmW-00052m-FU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmV-00058k-8t
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:44 -0500
Date: Tue, 28 Feb 2017 11:28:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228002810.GD17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<034945c1bbc8d4a97e5f568d4d463af2c9a24080.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="01b0+GAtiOmVD9T6"
Content-Disposition: inline
In-Reply-To: <034945c1bbc8d4a97e5f568d4d463af2c9a24080.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/12] spapr: Only setup HTP if
 necessary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com


--01b0+GAtiOmVD9T6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

s/HTP/HPT/ in subject line.


On Thu, Feb 23, 2017 at 05:00:01PM +1100, Sam Bobroff wrote:
> If QEMU is using KVM, and KVM is capable of running in radix mode,
> guests can be run in real-mode without allocating a HPT (because KVM
> will use a minimal RPT). So in this case, we avoid creating the HPT
> at reset time and later (during CAS) create it if it is necessary.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

So, IIRC, we discussed previously that the logical way to do things
was to, by default, delay HPT allocation until CAS time, and just do
it at reset time for the case that needs it: hash host with KVM.

Did you hit a problem with that approach, or is there still work to be
done here?

> ---
> v2:
>=20
> * This patch has been mostly rewritten to move the late HPT allocation to=
 CAS.
> This allows a guest to start in radix mode (when it's in real mode) and t=
hen
> change to hash, even if it is a legacy guest and will not call
> h_register_process_table().
> * Added an exported function to spapr.c to perform HPT allocation and adj=
ust
> the vrma if necessary. This makes it possible to allocate the HPT from
> h_client_architecture_support() in spapr_hcall.c.
>=20
>  hw/ppc/spapr.c         | 24 +++++++++++++++---------
>  hw/ppc/spapr_hcall.c   | 10 ++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ca3812555f..dfee0f685f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1123,6 +1123,17 @@ static void spapr_reallocate_hpt(sPAPRMachineState=
 *spapr, int shift,
>      }
>  }
> =20
> +void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
> +{
> +    spapr_reallocate_hpt(spapr,
> +                     spapr_hpt_shift_for_ramsize(MACHINE(qdev_get_machin=
e())->maxram_size),
> +                     &error_fatal);
> +    if (spapr->vrma_adjust) {
> +        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(),
> +                                          spapr->htab_shift);
> +    }
> +}
> +
>  static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
>  {
>      bool matched =3D false;
> @@ -1151,15 +1162,10 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> -    /* Allocate and/or reset the hash page table */
> -    spapr_reallocate_hpt(spapr,
> -                         spapr_hpt_shift_for_ramsize(machine->maxram_siz=
e),
> -                         &error_fatal);
> -
> -    /* Update the RMA size if necessary */
> -    if (spapr->vrma_adjust) {
> -        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(),
> -                                          spapr->htab_shift);
> +    /* If using KVM with radix mode available, VCPUs can be started
> +     * without a HPT because KVM will start them in radix mode. */
> +    if (!(kvm_enabled() && kvmppc_has_cap_mmu_radix())) {
> +        spapr_setup_hpt_and_vrma(spapr);
>      }
> =20
>      qemu_devices_reset();
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 42d20e0b92..cea34073aa 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1002,6 +1002,16 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      ov5_updates =3D spapr_ovec_new();
>      spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
>                                          ov5_cas_old, spapr->ov5_cas);
> +    if (kvm_enabled()) {
> +        if (kvmppc_has_cap_mmu_radix()) {
> +            /* If the HPT hasn't yet been set up (see
> +             * ppc_spapr_reset()), and it's needed, do it now: */

I think it's a bit fragile to have here it explicitly mirror the logic
which determines whether the HPT is allocated early.  I'd prefer to
explicitly test here whether we have allocated an HPT - adding a flag,
if we have to.

> +            if (!spapr_ovec_test(ov5_updates, OV5_MMU_RADIX)) {
> +                /* legacy hash or new hash: */
> +                spapr_setup_hpt_and_vrma(spapr);
> +            }
> +        }
> +    }
> =20
>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot =3D
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f9b17d860a..a30cbc485c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -590,6 +590,7 @@ void spapr_dt_events(sPAPRMachineState *sm, void *fdt=
);
>  int spapr_h_cas_compose_response(sPAPRMachineState *sm,
>                                   target_ulong addr, target_ulong size,
>                                   sPAPROptionVector *ov5_updates);
> +void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
>  void spapr_tce_table_enable(sPAPRTCETable *tcet,
>                              uint32_t page_shift, uint64_t bus_offset,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--01b0+GAtiOmVD9T6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtMQYAAoJEGw4ysog2bOSoOAP/2WGAgeCj0h1naK3julA0uLd
AqcG4cFEg+Bx1Gg58UFrO4EDWdTjtdNbp9HPXzinyoGC5t97zOosOXK4jjtMZTsp
Qh635CHMSQSipYwQZhrm12T3X614I0hs7CkqBmTlFQ1h7qenI6jKg9N7Ql9JRr3G
8iQDdmU9sWcIC/KnKmUCo1S484XYJrR1vNvp8HE4JG1wlztWk4PIBe5THWI7iu44
3x/twRo9nisZVPT5O9hf3PlT5jE/WikAjzjPW/d1LQXo/9C9OTo3SnESVLDygVxU
1K62Eqpb8hGOUgFo9mmZV6Al7fNcBPIr2kaII5GTNKZXoIMYyhHJzHrot9pMV5Kx
N8WOZHt3HO119I2PLyLpXXsXIaV1o2fCV0eh1xknfEYTxk9g8qKmFupTjcZCX0jy
0uvMIsfyp2W+0mV4z7pQ7pJoTvCTczQssWVsk+lvW+GpsIJSQjvR6cSFUvdz4y87
2EvcbOXai50QyIEUDAE711Z3eBDuC8hQD/d4BsIaU0tjgmK2eO6iTfprKgDTXiOi
p9shkJQn0GpX5EtVakSsXLVvVfAzt7GCG2XPQ4SnXBYfv6gqSqCKi7aUzjgpgwFu
jv+yAUA0ubUfVwdTewidiwMa5BTl7xf4U57IXRCmKLEsjweE1mMpeaEXN88SuPSs
Uc5YDX2u5LX0uDxW/w6g
=tWLd
-----END PGP SIGNATURE-----

--01b0+GAtiOmVD9T6--
