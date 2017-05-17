Received: from eggs.gnu.org ([2001:4830:134:3::10]:35771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxK-0002oN-9n
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxE-0004A1-C4
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:10 -0400
Date: Wed, 17 May 2017 16:59:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517065933.GM15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-6-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <1494992962-6929-6-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 5/6] spapr: Unregister HPT savevm
 handlers for radix guests
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


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 09:19:21AM +0530, Bharata B Rao wrote:
> HPT gets created by default and later when the guest turns out to be
> a radix guest, the HPT is destroyed when guest does H_REGISTER_PROC_TBL
> hcall.

I don't think that's entirely accurate.  At least in some KVM
configurations, we assume radix first, and only allocate the HPT once
the guest confirms it is doing hash.

> Let HTAB savevm handlers registration and unregistration follow
> the same model so that we don't end up having unrequired HTAB savevm
> handlers for radix guests.
>=20
> This also ensures that HTAB savevm handlers seemlessly get destroyed and
> recreated like HTAB itself when hash guest reboots.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         | 15 +++++++++++++--
>  hw/ppc/spapr_hcall.c   |  1 +
>  include/hw/ppc/spapr.h |  2 ++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 521eef1..05abfc1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1237,6 +1237,7 @@ static void spapr_reallocate_hpt(sPAPRMachineState =
*spapr, int shift,
> =20
>      /* Clean up any HPT info from a previous boot */
>      spapr_free_hpt(spapr);
> +    spapr_htab_savevm_unregister(spapr);

I'd prefer that the unregister be folded into spapr_free_hpt().
Basically we want calls that create or remove the HPT and handle
everything - allocation/freeing if necessary, informing KVM if
necessary, and registering/deregistering the savevm handlers if
necesary.

I think that will also remove the need for the trivial
spapr_htab_savevm_{un,}register() wrappers.

> =20
>      rc =3D kvmppc_reset_htab(shift);
>      if (rc < 0) {
> @@ -1275,6 +1276,7 @@ static void spapr_reallocate_hpt(sPAPRMachineState =
*spapr, int shift,
>              DIRTY_HPTE(HPTE(spapr->htab, i));
>          }
>      }
> +    spapr_htab_savevm_register(spapr);
>  }
> =20
>  void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
> @@ -1874,6 +1876,17 @@ static SaveVMHandlers savevm_htab_handlers =3D {
>      .load_state =3D htab_load,
>  };
> =20
> +void spapr_htab_savevm_register(sPAPRMachineState *spapr)
> +{
> +    register_savevm_live(NULL, "spapr/htab", -1, 1,
> +                         &savevm_htab_handlers, spapr);
> +}
> +
> +void spapr_htab_savevm_unregister(sPAPRMachineState *spapr)
> +{
> +    unregister_savevm_live(NULL, "spapr/htab", spapr);
> +}
> +
>  static void spapr_boot_set(void *opaque, const char *boot_device,
>                             Error **errp)
>  {
> @@ -2336,8 +2349,6 @@ static void ppc_spapr_init(MachineState *machine)
>       * interface, this is a legacy from the sPAPREnvironment structure
>       * which predated MachineState but had a similar function */
>      vmstate_register(NULL, 0, &vmstate_spapr, spapr);
> -    register_savevm_live(NULL, "spapr/htab", -1, 1,
> -                         &savevm_htab_handlers, spapr);
> =20
>      /* used by RTAS */
>      QTAILQ_INIT(&spapr->ccs_list);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index be79e3d..768aa57 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -914,6 +914,7 @@ static void spapr_check_setup_free_hpt(sPAPRMachineSt=
ate *spapr,
>      } else if (!(patbe_old & PATBE1_GR)) {
>          /* HASH->RADIX : Free HPT */
>          spapr_free_hpt(spapr);
> +        spapr_htab_savevm_unregister(spapr);
>      } else if (!(patbe_new & PATBE1_GR)) {
>          /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
>          spapr_setup_hpt_and_vrma(spapr);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6f9cb85..5b39a26 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -636,6 +636,8 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRD=
RConnectorType drc_type,
>                                                 uint32_t count, uint32_t =
index);
>  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>                                      sPAPRMachineState *spapr);
> +void spapr_htab_savevm_register(sPAPRMachineState *spapr);
> +void spapr_htab_savevm_unregister(sPAPRMachineState *spapr);
> =20
>  /* rtas-configure-connector state */
>  struct sPAPRConfigureConnectorState {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/TVAAoJEGw4ysog2bOS8ocQAOJXbxn06ZEbkSefIvz93j1C
k3vnNNl5eMznDgopy+v6iZsEDlj1O8VkLRkgFuIHmH1lT7M6uBMM3HgnWzDd69P0
4AkCTtmGnHvYI8XEO2Ct9TvLCLgUip0XAk/oRINmM2GgTQ+btDX0a3j1fuoyUpvK
RIjI3nan+6E2p7Tt2N6/iHh9dMFpZW0lGjxr9b8iZRrcjkGyVO8VNhf3LNf6iPUs
m2OrtDAvhHiCWwhDwHMI3EU58L52qRcbPh1o2heZX546fBa1E0qsiIXTiqpQH0wE
IYYnHWVytODeCGGCMg3c0/MoVoL4PMHc6KfUS/LXDeMLGmg59QOkoEBlnZ3sU/wz
sEP0WWrYcOPDPbjOSx5kRpZ5dWRXYgLt9Z+Jklhj1yL0QSEo4LVJL/uandMorgnG
t4+wv0tc8xlb+qsMF6PE7Nm36ZNZYJFDlO7iGxb4l03uG+1vYMGPthO/om/vYCwv
J6RT7yNY6aCYerhEzP6bQeojf6JK4vpxlvjfpj2WgPk/Uejt21aRxBBG8csFBzOx
Tlo/Nrf0DZs7IHYm/T/QiKOwSuJ5x0kVG29gTEw+sMyviO+U8w1a2goMiDa4ttWU
trnt5rSqRD2T/sKLRhy0+2MQZzjK/AeOhDnI3HPg1Y/MckX7+ykSIG78CWWsIZun
NmxxrxE3/WGdM4yoVgrN
=h4nX
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
