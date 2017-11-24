Received: from eggs.gnu.org ([2001:4830:134:3::10]:33041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIABD-0004Uh-7R
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIAB6-0004wm-Um
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:21:51 -0500
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:58507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIAB6-0004tm-MY
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:21:44 -0500
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 34026175D6B
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 10:21:43 +0100 (CET)
Date: Fri, 24 Nov 2017 10:21:37 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171124102137.43b42ce1@bahia.lan>
In-Reply-To: <20171123132955.1261-3-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 02/25] ppc/xics: assign of the
 CPU 'intc' pointer under the core
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

On Thu, 23 Nov 2017 14:29:32 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The 'intc' pointer of the CPU references the interrupt presenter in
> the XICS interrupt mode. When the XIVE interrupt mode is available and
> activated, the machine will need to reassign this pointer to reflect
> the change.
>=20
> Moving this assignment under the realize routine of the CPU will ease
> the process when the interrupt mode is toggled.
>=20

No surprise since this was violating CPU internals actually :)

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/xics.c          | 1 -
>  hw/ppc/pnv_core.c       | 2 +-
>  hw/ppc/spapr_cpu_core.c | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e4ccdff8f577..0f2e7273bc8f 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -334,7 +334,6 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>      }
> =20
>      cpu =3D POWERPC_CPU(obj);
> -    cpu->intc =3D OBJECT(icp);
>      icp->cs =3D CPU(obj);
> =20
>      env =3D &cpu->env;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a066736846f8..90acaac45889 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -133,7 +133,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
>          return;
>      }
> =20
> -    icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
> +    cpu->intc =3D icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f8a520a2fa2d..f7cc74512481 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -122,7 +122,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
>          goto error;
>      }
> =20
> -    icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
> +    cpu->intc =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &l=
ocal_err);
>      if (local_err) {
>          goto error;
>      }
