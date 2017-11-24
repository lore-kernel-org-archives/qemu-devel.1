Received: from eggs.gnu.org ([2001:4830:134:3::10]:48730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIAvU-0004mR-BC
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIAvQ-0002Sz-T3
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:09:40 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:46636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIAvQ-0002SM-N5
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:09:36 -0500
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 89DF7175C23
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 11:09:34 +0100 (CET)
Date: Fri, 24 Nov 2017 11:09:27 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171124110927.57c0ead2@bahia.lan>
In-Reply-To: <20171123132955.1261-4-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 03/25] spapr: introduce a
 spapr_icp_create() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, 23 Nov 2017 14:29:33 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On sPAPR, the creation of the interrupt presenter depends on some of
> the machine attributes. When the XIVE interrupt mode is available,
> this will get more complex. So provide a machine-level helper to
> isolate the process and hide the details to the sPAPR core realize
> function.
>=20

Not sure it makes sense to introduce this helper that early in the series...
what about folding it in patch 23 where it is really needed ?

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c          | 14 ++++++++++++++
>  hw/ppc/spapr_cpu_core.c |  2 +-
>  include/hw/ppc/spapr.h  |  2 ++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 174e7ff0678d..925cbd3c1bf4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3556,6 +3556,20 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 vcpu_id)
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> =20
> +Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Error *=
*errp)
> +{
> +    Error *local_err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_e=
rr);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return obj;
> +}
> +
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f7cc74512481..61a9850e688b 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -122,7 +122,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
>          goto error;
>      }
> =20
> -    cpu->intc =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &l=
ocal_err);
> +    cpu->intc =3D spapr_icp_create(spapr, cs, &local_err);
>      if (local_err) {
>          goto error;
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9d21ca9bde3a..9da38de34277 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -707,4 +707,6 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
>  int spapr_vcpu_id(PowerPCCPU *cpu);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
> +Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Error *=
*errp);
> +
>  #endif /* HW_SPAPR_H */
