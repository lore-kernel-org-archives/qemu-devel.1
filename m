Received: from eggs.gnu.org ([2001:4830:134:3::10]:52633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIf3A-0007VP-Lc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIf38-0004Ru-3z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:47:20 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:46861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIf37-0004Qz-UP
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:47:18 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 013916C7F5
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:47:14 +0200 (CEST)
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582071.12025.6876143197982490443.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a5acff8a-62dc-6d76-4d54-2a952423ab77@kaod.org>
Date: Wed, 7 Jun 2017 19:47:04 +0200
MIME-Version: 1.0
In-Reply-To: <149685582071.12025.6876143197982490443.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] xics: add reset() handler to
 ICPStateClass
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

On 06/07/2017 07:17 PM, Greg Kurz wrote:
> Taking into account that qemu_set_irq() returns immediatly if its first
> argument is NULL, icp_kvm_reset() largely duplicates icp_reset().
>=20
> This patch introduces a reset() handler, so that the common logic can
> be implemented in icp_reset() only.
>=20
> While there we can also drop icp_kvm_realize() and icp_kvm_unrealize().=
 This
> causes icp-kvm to be realized in icp_realize(), which sets icp->xics, b=
ut
> it has no impact.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/xics.c        |    5 +++++
>  hw/intc/xics_kvm.c    |   27 ++-------------------------
>  include/hw/ppc/xics.h |    1 +
>  3 files changed, 8 insertions(+), 25 deletions(-)

another good cleanup !

Thanks,

C.=20

>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index ea3516794af7..ec73f02144c9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -325,6 +325,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>  static void icp_reset(void *dev)
>  {
>      ICPState *icp =3D ICP(dev);
> +    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> =20
>      icp->xirr =3D 0;
>      icp->pending_priority =3D 0xff;
> @@ -332,6 +333,10 @@ static void icp_reset(void *dev)
> =20
>      /* Make all outputs are deasserted */
>      qemu_set_irq(icp->output, 0);
> +
> +    if (icpc->reset) {
> +        icpc->reset(icp);
> +    }
>  }
> =20
>  static void icp_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 14b8f6f6e478..45bf110b51e6 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -110,19 +110,8 @@ static int icp_set_kvm_state(ICPState *icp, int ve=
rsion_id)
>      return 0;
>  }
> =20
> -static void icp_kvm_reset(void *dev)
> +static void icp_kvm_reset(ICPState *icp)
>  {
> -    ICPState *icp =3D ICP(dev);
> -
> -    icp->xirr =3D 0;
> -    icp->pending_priority =3D 0xff;
> -    icp->mfrr =3D 0xff;
> -
> -    /* Make all outputs as deasserted only if the CPU thread is in use=
 */
> -    if (icp->output) {
> -        qemu_set_irq(icp->output, 0);
> -    }
> -
>      icp_set_kvm_state(icp, 1);
>  }
> =20
> @@ -159,26 +148,14 @@ static void icp_kvm_cpu_setup(ICPState *icp, Powe=
rPCCPU *cpu)
>      QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
>  }
> =20
> -static void icp_kvm_realize(DeviceState *dev, Error **errp)
> -{
> -    qemu_register_reset(icp_kvm_reset, dev);
> -}
> -
> -static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
> -{
> -    qemu_unregister_reset(icp_kvm_reset, dev);
> -}
> -
>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICPStateClass *icpc =3D ICP_CLASS(klass);
> =20
> -    dc->realize =3D icp_kvm_realize;
> -    dc->unrealize =3D icp_kvm_unrealize;
>      icpc->pre_save =3D icp_get_kvm_state;
>      icpc->post_load =3D icp_set_kvm_state;
>      icpc->cpu_setup =3D icp_kvm_cpu_setup;
> +    icpc->reset =3D icp_kvm_reset;
>  }
> =20
>  static const TypeInfo icp_kvm_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index a3073f90533a..40a506eacfb4 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -69,6 +69,7 @@ struct ICPStateClass {
>      void (*pre_save)(ICPState *s);
>      int (*post_load)(ICPState *s, int version_id);
>      void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
> +    void (*reset)(ICPState *icp);
>  };
> =20
>  struct ICPState {
>=20
