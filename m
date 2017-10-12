Received: from eggs.gnu.org ([2001:4830:134:3::10]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1e2VDJ-0005ui-Db
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1e2VDG-0008QR-5u
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:35:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1e2VDF-0008PJ-UE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:35:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9C4Ynk2008268
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 00:35:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dhv1rv003-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 00:35:09 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Oct 2017 05:35:07 +0100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20171009154930.29095-4-clg@kaod.org>
References: <20171009154930.29095-1-clg@kaod.org>
	<20171009154930.29095-4-clg@kaod.org>
Date: Thu, 12 Oct 2017 10:04:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87shep3rwt.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] spapr/rtas: fix reboot of a SMP TCG
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Just like for hot unplugged CPUs, when a guest is rebooted, the
> secondary CPUs can be awaken by the decrementer and start entering
> SLOF at the same time the boot CPU is.
>
> To be safe, let's disable the decrementer interrupt in the LPCR for
> the secondaries.
>
> Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr_cpu_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 37beb56e8b18..112868dc39d5 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -20,6 +20,7 @@
>  #include "sysemu/numa.h"
>  #include "sysemu/hw_accel.h"
>  #include "qemu/error-report.h"
> +#include "target/ppc/cpu-models.h"
>
>  void spapr_cpu_parse_features(sPAPRMachineState *spapr)
>  {
> @@ -86,6 +87,17 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
>
>      env->spr[SPR_HIOR] =3D 0;
> +
> +    /* Don't let the decremeter wake up CPUs other than the boot
> +     * CPUs. this can cause issues when rebooting the guest */
> +    if (cs !=3D first_cpu) {
> +        if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
> +            env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> +        }
> +    }
>  }
>
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> --=20
> 2.13.6
