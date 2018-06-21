Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVsF1-0005Tz-CL
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVsEj-0000mY-0e
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:34:43 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:49318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVsEi-0000lt-NO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:34:24 -0400
Received: from player789.ha.ovh.net (unknown [10.109.105.21])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id ED2D91C3590
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:34:22 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5c3da8b8-32dd-11c6-9739-b42b27f65b4c@kaod.org>
Date: Thu, 21 Jun 2018 07:34:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180618063606.2513-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] spapr: Add cpu_apply hook to
 capabilities
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
> spapr capabilities have an apply hook to actually activate (or deactiva=
te)
> the feature in the system at reset time.  However, a number of capabili=
ties
> affect the setup of cpus, and need to be applied to each of them -
> including hotplugged cpus for extra complication.  To make this simpler=
,
> add an optional cpu_apply hook that is called from spapr_cpu_reset().
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


Thanks,

C.

> ---
>  hw/ppc/spapr_caps.c     | 19 +++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c |  2 ++
>  include/hw/ppc/spapr.h  |  1 +
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index dabed817d1..68a4243efc 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -59,6 +59,8 @@ typedef struct sPAPRCapabilityInfo {
>      sPAPRCapPossible *possible;
>      /* Make sure the virtual hardware can support this capability */
>      void (*apply)(sPAPRMachineState *spapr, uint8_t val, Error **errp)=
;
> +    void (*cpu_apply)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
> +                      uint8_t val, Error **errp);
>  } sPAPRCapabilityInfo;
> =20
>  static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *na=
me,
> @@ -472,6 +474,23 @@ void spapr_caps_apply(sPAPRMachineState *spapr)
>      }
>  }
> =20
> +void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> +        sPAPRCapabilityInfo *info =3D &capability_table[i];
> +
> +        /*
> +         * If the apply function can't set the desired level and think=
s it's
> +         * fatal, it should cause that.
> +         */
> +        if (info->cpu_apply) {
> +            info->cpu_apply(spapr, cpu, spapr->eff.caps[i], &error_fat=
al);
> +        }
> +    }
> +}
> +
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
>  {
>      Error *local_err =3D NULL;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index aef3be33a3..324623190d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -76,6 +76,8 @@ static void spapr_cpu_reset(void *opaque)
>      spapr_cpu->slb_shadow_size =3D 0;
>      spapr_cpu->dtl_addr =3D 0;
>      spapr_cpu->dtl_size =3D 0;
> +
> +    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
>  }
> =20
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9dbd6010f5..9dd46a72f6 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -800,6 +800,7 @@ static inline uint8_t spapr_get_cap(sPAPRMachineSta=
te *spapr, int cap)
> =20
>  void spapr_caps_init(sPAPRMachineState *spapr);
>  void spapr_caps_apply(sPAPRMachineState *spapr);
> +void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu);
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
>  int spapr_caps_post_migration(sPAPRMachineState *spapr);
> =20
>=20
