Received: from eggs.gnu.org ([2001:4830:134:3::10]:42598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3pS9-0004Q9-Vl
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3pS4-0001QA-ND
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3pS4-0001Oq-Es
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3RJncuS037417
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:51:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3dhrvp1d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:51:40 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 15:51:39 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170427072843.8089-4-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-4-david@gibson.dropbear.id.au>
Date: Thu, 27 Apr 2017 13:08:59 -0500
Message-Id: <149331653979.32299.5281663417364207528@loki>
Subject: Re: [Qemu-devel] [PATCHv3 3/4] pseries: Reset CPU compatibility mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, aik@ozlabs.ru, clg@kaod.org, groug@kaod.org, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Quoting David Gibson (2017-04-27 02:28:42)
> Currently, the CPU compatibility mode is set when the cpu is initialized,
> then again when the guest negotiates features.  This means if a guest
> negotiates a compatibility mode, then reboots, that compatibility mode
> will be retained across the reset.
> =

> Usually that will get overridden when features are negotiated on the next
> boot, but it's still not really correct.  This patch moves the initial set
> up of the compatibility mode from cpu init to reset time.  The mode *is*
> retained if the reboot was caused by the feature negotiation (it might
> be important in that case, though it's unlikely).
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr.c          |  2 ++
>  hw/ppc/spapr_cpu_core.c | 10 ----------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 547fa27..67f5106 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1332,6 +1332,8 @@ static void ppc_spapr_reset(void)
>      if (!spapr->cas_reboot) {
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas =3D spapr_ovec_new();
> +
> +        ppc_set_compat_all(spapr->max_compat_pvr, &error_abort);
>      }
> =

>      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ba610bc..e810431 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -107,16 +107,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
>      /* Enable PAPR mode in TCG or KVM */
>      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> =

> -    if (spapr->max_compat_pvr) {
> -        Error *local_err =3D NULL;
> -
> -        ppc_set_compat(cpu, spapr->max_compat_pvr, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    }
> -
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
>  }
> -- =

> 2.9.3
>=20
