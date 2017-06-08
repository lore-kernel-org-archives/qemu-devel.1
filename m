Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIy8U-0003oo-J2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIy8P-0006W7-Kq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:10:06 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:44098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIy8P-0006UP-ED
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:10:01 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E716E70CCD
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 16:09:59 +0200 (CEST)
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692938872.12119.17948850600182624221.stgit@bahia>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <16cc02b2-91e7-8909-0516-f7243c636b65@kaod.org>
Date: Thu, 8 Jun 2017 16:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <149692938872.12119.17948850600182624221.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/6] xics: drop
 ICPStateClass::cpu_setup() handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/08/2017 03:43 PM, Greg Kurz wrote:
> The cpu_setup() handler is only implemented by xics_kvm, where it reall=
y
> does a typical "realize" job. Moreover, the realize() handler is called
> shortly after cpu_setup(), on the same path.
>=20
> This patch converts xics_kvm to implement realize() instead of cpu_setu=
p().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics.c        |    4 ----
>  hw/intc/xics_kvm.c    |   12 ++++++------
>  include/hw/ppc/xics.h |    1 -
>  3 files changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index fdbfddffeea5..7ccfb53c55a0 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -324,10 +324,6 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
>      cpu->intc =3D OBJECT(icp);
>      icp->cs =3D CPU(obj);
> =20
> -    if (icpc->cpu_setup) {
> -        icpc->cpu_setup(icp, cpu);
> -    }
> -
>      env =3D &cpu->env;
>      switch (PPC_INPUT(env)) {
>      case PPC_FLAGS_INPUT_POWER7:
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 41c5b9439562..3091ad3ac2c8 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -115,9 +115,9 @@ static void icp_kvm_reset(ICPState *icp)
>      icp_set_kvm_state(icp, 1);
>  }
> =20
> -static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
> +static void icp_kvm_realize(ICPState *icp, Error **errp)
>  {
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D icp->cs;
>      KVMEnabledICP *enabled_icp;
>      unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
>      int ret;
> @@ -139,9 +139,9 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerP=
CCPU *cpu)
> =20
>      ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_f=
d, vcpu_id);
>      if (ret < 0) {
> -        error_report("Unable to connect CPU%ld to kernel XICS: %s", vc=
pu_id,
> -                     strerror(errno));
> -        exit(1);
> +        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s"=
, vcpu_id,
> +                   strerror(errno));
> +        return;
>      }
>      enabled_icp =3D g_malloc(sizeof(*enabled_icp));
>      enabled_icp->vcpu_id =3D vcpu_id;
> @@ -154,7 +154,7 @@ static void icp_kvm_class_init(ObjectClass *klass, =
void *data)
> =20
>      icpc->pre_save =3D icp_get_kvm_state;
>      icpc->post_load =3D icp_set_kvm_state;
> -    icpc->cpu_setup =3D icp_kvm_cpu_setup;
> +    icpc->realize =3D icp_kvm_realize;
>      icpc->reset =3D icp_kvm_reset;
>  }
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 37b8fb1e8817..28d248abad61 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -68,7 +68,6 @@ struct ICPStateClass {
>      void (*realize)(ICPState *icp, Error **errp);
>      void (*pre_save)(ICPState *icp);
>      int (*post_load)(ICPState *icp, int version_id);
> -    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
>      void (*reset)(ICPState *icp);
>  };
> =20
>=20
