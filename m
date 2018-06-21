Received: from eggs.gnu.org ([2001:4830:134:3::10]:42084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVsDI-0004cs-3f
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVsDD-0000CM-TV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:32:56 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:44118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVsDD-0000Bw-Nm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:32:51 -0400
Received: from player692.ha.ovh.net (unknown [10.109.120.111])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8EC901BE610
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:32:48 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <89c037a0-22ee-10ff-6e86-fe4295860a4a@kaod.org>
Date: Thu, 21 Jun 2018 07:32:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180618063606.2513-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/9] spapr: Compute effective capability
 values earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, abologna@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On 06/18/2018 08:35 AM, David Gibson wrote:
> Previously, the effective values of the various spapr capability flags
> were only determined at machine reset time.  That was a lazy way of mak=
ing
> sure it was after cpu initialization so it could use the cpu object to
> inform the defaults.
>=20
> But we've now improved the compat checking code so that we don't need t=
o
> instantiate the cpus to use it.  That lets us move the resolution of th=
e
> capability defaults much earlier.
>=20
> This is going to be necessary for some future capabilities.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.
> ---
>  hw/ppc/spapr.c         | 6 ++++--
>  hw/ppc/spapr_caps.c    | 9 ++++++---
>  include/hw/ppc/spapr.h | 3 ++-
>  3 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b0b94fc1f0..40858d047c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1612,7 +1612,7 @@ static void spapr_machine_reset(void)
>      void *fdt;
>      int rc;
> =20
> -    spapr_caps_reset(spapr);
> +    spapr_caps_apply(spapr);
> =20
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>      if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
> @@ -2526,7 +2526,9 @@ static void spapr_machine_init(MachineState *mach=
ine)
>      QLIST_INIT(&spapr->phbs);
>      QTAILQ_INIT(&spapr->pending_dimm_unplugs);
> =20
> -    /* Check HPT resizing availability */
> +    /* Determine capabilities to run with */
> +    spapr_caps_init(spapr);
> +
>      kvmppc_check_papr_resize_hpt(&resize_hpt_err);
>      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
>          /*
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 469f38f0ef..dabed817d1 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -439,12 +439,12 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> =20
> -void spapr_caps_reset(sPAPRMachineState *spapr)
> +void spapr_caps_init(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities default_caps;
>      int i;
> =20
> -    /* First compute the actual set of caps we're running with.. */
> +    /* Compute the actual set of caps we should run with */
>      default_caps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_=
type);
> =20
>      for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> @@ -455,8 +455,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
>              spapr->eff.caps[i] =3D default_caps.caps[i];
>          }
>      }
> +}
> =20
> -    /* .. then apply those caps to the virtual hardware */
> +void spapr_caps_apply(sPAPRMachineState *spapr)
> +{
> +    int i;
> =20
>      for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
>          sPAPRCapabilityInfo *info =3D &capability_table[i];
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3388750fc7..9dbd6010f5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -798,7 +798,8 @@ static inline uint8_t spapr_get_cap(sPAPRMachineSta=
te *spapr, int cap)
>      return spapr->eff.caps[cap];
>  }
> =20
> -void spapr_caps_reset(sPAPRMachineState *spapr);
> +void spapr_caps_init(sPAPRMachineState *spapr);
> +void spapr_caps_apply(sPAPRMachineState *spapr);
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
>  int spapr_caps_post_migration(sPAPRMachineState *spapr);
> =20
>=20
