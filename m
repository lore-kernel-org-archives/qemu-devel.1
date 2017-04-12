Received: from eggs.gnu.org ([2001:4830:134:3::10]:36228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyDwN-0002k2-Fk
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyDwK-0005i2-CL
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:47:51 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:38124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cyDwK-0005h2-6M
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:47:48 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B698331730
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 10:47:45 +0200 (CEST)
References: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9e992fd5-8f42-5ec6-2a77-f6d9ce088226@kaod.org>
Date: Wed, 12 Apr 2017 10:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr-cpu-core: Release ICPState object
 during CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 04/12/2017 10:15 AM, Bharata B Rao wrote:
> Recent commits that re-organized ICPState object missed to destroy
> the object when CPU is unrealized. Fix this so that CPU unplug
> doesn't abort QEMU.

Indeed.

> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

I am wondering if we should not be doing the unparent under=20
spapr_cpu_destroy() or even xics_cpu_destroy(). Apart from
that,=20

Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2e689b5..4389ef4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -127,6 +127,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
>          spapr_cpu_destroy(cpu);
> +        object_unparent(cpu->intc);
>          cpu_remove_sync(cs);
>          object_unparent(obj);
>      }
>=20
