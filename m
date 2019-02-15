Received: from eggs.gnu.org ([209.51.188.92]:38106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud0O-000108-Na
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud0N-000466-Q5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:54:12 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:39416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gud0M-0003pt-B4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:54:11 -0500
Received: from player694.ha.ovh.net (unknown [10.109.160.12])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id A062B1AE0CE
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:54:07 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023080049.1011724.15423463482790260696.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b25de46d-9449-4538-b2b5-dd18d373e6d9@kaod.org>
Date: Fri, 15 Feb 2019 13:54:02 +0100
MIME-Version: 1.0
In-Reply-To: <155023080049.1011724.15423463482790260696.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] xics: Handle KVM ICP realize from
 the common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2/15/19 12:40 PM, Greg Kurz wrote:
> The realization of KVM ICP currently follows the parent_realize logic,
> which is a bit overkill here. Also we want to get rid of the KVM ICP
> class. Explicitely call icp_kvm_realize() from the base ICP realize
> function.
>=20
> Note that ICPStateClass::parent_realize is retained because powernv
> needs it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>>
> ---
>  hw/intc/xics.c        |    8 ++++++++
>  hw/intc/xics_kvm.c    |   10 +---------
>  include/hw/ppc/xics.h |    1 +
>  3 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 822d367e6388..acd63ab5e0b9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -349,6 +349,14 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
>          return;
>      }
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        icp_kvm_realize(dev, &err);

While we are at changing things, I would prefix all the KVM=20
backends routine with kvmppc_*. so that icp_kvm_realize()=20
becomes kvmppc_icp_realize()

Apart from that,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +    }
> +
>      qemu_register_reset(icp_reset_handler, dev);
>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, ic=
p);
>  }
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 80321e9b75ab..4eebced516b6 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -115,11 +115,9 @@ int icp_set_kvm_state(ICPState *icp)
>      return 0;
>  }
> =20
> -static void icp_kvm_realize(DeviceState *dev, Error **errp)
> +void icp_kvm_realize(DeviceState *dev, Error **errp)
>  {
>      ICPState *icp =3D ICP(dev);
> -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> -    Error *local_err =3D NULL;
>      CPUState *cs;
>      KVMEnabledICP *enabled_icp;
>      unsigned long vcpu_id;
> @@ -129,12 +127,6 @@ static void icp_kvm_realize(DeviceState *dev, Erro=
r **errp)
>          abort();
>      }
> =20
> -    icpc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
>      cs =3D icp->cs;
>      vcpu_id =3D kvm_arch_vcpu_id(cs);
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index e33282a576d0..ab61dc24010a 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -202,5 +202,6 @@ Object *icp_create(Object *cpu, const char *type, X=
ICSFabric *xi,
>  void icp_get_kvm_state(ICPState *icp);
>  int icp_set_kvm_state(ICPState *icp);
>  void icp_synchronize_state(ICPState *icp);
> +void icp_kvm_realize(DeviceState *dev, Error **errp);
> =20
>  #endif /* XICS_H */
>=20
