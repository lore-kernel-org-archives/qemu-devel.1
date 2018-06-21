Received: from eggs.gnu.org ([2001:4830:134:3::10]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVszI-00080z-W7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVszF-0007SJ-QM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:22:32 -0400
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:55395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVszF-0007Ri-GX
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:22:29 -0400
Received: from player779.ha.ovh.net (unknown [10.109.105.115])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 328D2165855
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:22:27 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4dd7753b-f0a4-1f79-2acc-9fa037b40860@kaod.org>
Date: Thu, 21 Jun 2018 08:22:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180618063606.2513-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] spapr: Maximum (HPT) pagesize property
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

On 06/18/2018 08:36 AM, David Gibson wrote:
> The way the POWER Hash Page Table (HPT) MMU is virtualized by KVM HV me=
ans
> that every page that the guest puts in the pagetables must be truly
> physically contiguous, not just GPA-contiguous.  In effect this means t=
hat
> an HPT guest can't use any pagesizes greater than the host page size us=
ed
> to back its memory.
>=20
> At present we handle this by changing what we advertise to the guest ba=
sed
> on the backing pagesizes.  This is pretty bad, because it means the gue=
st
> sees a different environment depending on what should be host configura=
tion
> details.
>=20
> As a start on fixing this, we add a new capability parameter to the pse=
ries
> machine type which gives the maximum allowed pagesizes for an HPT guest=
 (as
> a shift).  For now we just create and validate the parameter without ma=
king
> it do anything.
>=20
> For backwards compatibility, on older machine types we set it to the ma=
x
> available page size for the host.  For the 3.0 machine type, we fix it =
to
> 16, the intention being to only allow HPT pagesizes up to 64kiB by defa=
ult
> in future.

Why not do it now ? I don't think the pseries machine supports 4k pages
anyway. so you could change the warn_report() below in an error I think.
=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/ppc/spapr.c         | 12 +++++++++
>  hw/ppc/spapr_caps.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  4 ++-
>  3 files changed, 71 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 40858d047c..74a76e7e09 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -63,6 +63,7 @@
>  #include "hw/virtio/vhost-scsi-common.h"
> =20
>  #include "exec/address-spaces.h"
> +#include "exec/ram_addr.h"
>  #include "hw/usb.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> @@ -4043,6 +4044,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB=
 */
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> =20
> @@ -4126,8 +4128,18 @@ static void spapr_machine_2_12_instance_options(=
MachineState *machine)
> =20
>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    uint8_t mps;
> +
>      spapr_machine_3_0_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
> +
> +    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> +        mps =3D ctz64(qemu_getrampagesize());
> +    } else {
> +        mps =3D 34; /* allow everything up to 16GiB, i.e. everything *=
/
> +    }
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 68a4243efc..6cdc0c94e7 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -27,6 +27,7 @@
>  #include "qapi/visitor.h"
>  #include "sysemu/hw_accel.h"
>  #include "target/ppc/cpu.h"
> +#include "target/ppc/mmu-hash64.h"
>  #include "cpu-models.h"
>  #include "kvm_ppc.h"
> =20
> @@ -144,6 +145,42 @@ out:
>      g_free(val);
>  }
> =20
> +static void spapr_cap_get_pagesize(Object *obj, Visitor *v, const char=
 *name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    uint8_t val =3D spapr_get_cap(spapr, cap->index);
> +    uint64_t pagesize =3D (1ULL << val);
> +
> +    visit_type_size(v, name, &pagesize, errp);
> +}
> +
> +static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char=
 *name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    uint64_t pagesize;
> +    uint8_t val;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_size(v, name, &pagesize, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!is_power_of_2(pagesize)) {
> +        error_setg(errp, "cap-%s must be a power of 2", cap->name);
> +        return;
> +    }
> +
> +    val =3D ctz64(pagesize);
> +    spapr->cmd_line_caps[cap->index] =3D true;
> +    spapr->eff.caps[cap->index] =3D val;
> +}
> +
>  static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error=
 **errp)
>  {
>      if (!val) {
> @@ -267,6 +304,16 @@ static void cap_safe_indirect_branch_apply(sPAPRMa=
chineState *spapr,
> =20
>  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> =20
> +static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
> +                                      uint8_t val, Error **errp)
> +{
> +    if (val < 12) {
> +        error_setg(errp, "Require at least 4kiB hpt-max-page-size");
> +    } else if (val < 16) {
> +        warn_report("Many guests require at least 64kiB hpt-max-page-s=
ize");
> +    }
> +}
> +
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -326,6 +373,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM=
] =3D {
>          .possible =3D &cap_ibs_possible,
>          .apply =3D cap_safe_indirect_branch_apply,
>      },
> +    [SPAPR_CAP_HPT_MAXPAGESIZE] =3D {
> +        .name =3D "hpt-max-page-size",
> +        .description =3D "Maximum page size for Hash Page Table guests=
",
> +        .index =3D SPAPR_CAP_HPT_MAXPAGESIZE,
> +        .get =3D spapr_cap_get_pagesize,
> +        .set =3D spapr_cap_set_pagesize,
> +        .type =3D "int",
> +        .apply =3D cap_hpt_maxpagesize_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spap=
r,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9dd46a72f6..c97593d032 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -66,8 +66,10 @@ typedef enum {
>  #define SPAPR_CAP_SBBC                  0x04
>  /* Indirect Branch Serialisation */
>  #define SPAPR_CAP_IBS                   0x05
> +/* HPT Maximum Page Size (encoded as a shift) */
> +#define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_HPT_MAXPAGESIZE + 1=
)
> =20
>  /*
>   * Capability Values
>=20
