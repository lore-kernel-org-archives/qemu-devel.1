Received: from eggs.gnu.org ([209.51.188.92]:37434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gucxF-00008H-IF
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gucxD-0007QV-LQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:50:57 -0500
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:36811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gucxC-0007Hd-7t
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:50:55 -0500
Received: from player791.ha.ovh.net (unknown [10.109.146.76])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1CC8A15C030
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:50:44 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023079461.1011724.12644984391500635645.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bb071621-e6ab-8f91-fdfc-7ee1edf3199b@kaod.org>
Date: Fri, 15 Feb 2019 13:50:40 +0100
MIME-Version: 1.0
In-Reply-To: <155023079461.1011724.12644984391500635645.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] xics: Handle KVM ICP reset from the
 common code
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

On 2/15/19 12:39 PM, Greg Kurz wrote:
> The KVM ICP reset handler simply writes the ICP state to KVM. This
> doesn't need the overkill parent_reset logic we have today. Call
> icp_set_kvm_state() from the base ICP reset function instead.
>=20
> Since there are no other users for ICPStateClass::parent_reset, and
> it isn't currently expected to change, drop it as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics.c        |   12 ++++--------
>  hw/intc/xics_kvm.c    |   11 -----------
>  include/hw/ppc/xics.h |    1 -
>  3 files changed, 4 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 988b53abd17d..822d367e6388 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -289,7 +289,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>      },
>  };
> =20
> -static void icp_reset(DeviceState *dev)
> +static void icp_reset_handler(void *dev)							=09
>  {
>      ICPState *icp =3D ICP(dev);
> =20
> @@ -299,13 +299,10 @@ static void icp_reset(DeviceState *dev)
> =20
>      /* Make all outputs are deasserted */
>      qemu_set_irq(icp->output, 0);
> -}
> =20
> -static void icp_reset_handler(void *dev)
> -{
> -    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> -
> -    dc->reset(dev);
> +    if (kvm_irqchip_in_kernel()) {
> +        icp_set_kvm_state(ICP(dev));
> +    }
>  }
> =20
>  static void icp_realize(DeviceState *dev, Error **errp)
> @@ -370,7 +367,6 @@ static void icp_class_init(ObjectClass *klass, void=
 *data)
> =20
>      dc->realize =3D icp_realize;
>      dc->unrealize =3D icp_unrealize;
> -    dc->reset =3D icp_reset;
>  }
> =20
>  static const TypeInfo icp_info =3D {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 7efa99b8b434..80321e9b75ab 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -115,15 +115,6 @@ int icp_set_kvm_state(ICPState *icp)
>      return 0;
>  }
> =20
> -static void icp_kvm_reset(DeviceState *dev)
> -{
> -    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> -
> -    icpc->parent_reset(dev);
> -
> -    icp_set_kvm_state(ICP(dev));
> -}
> -
>  static void icp_kvm_realize(DeviceState *dev, Error **errp)
>  {
>      ICPState *icp =3D ICP(dev);
> @@ -176,8 +167,6 @@ static void icp_kvm_class_init(ObjectClass *klass, =
void *data)
> =20
>      device_class_set_parent_realize(dc, icp_kvm_realize,
>                                      &icpc->parent_realize);
> -    device_class_set_parent_reset(dc, icp_kvm_reset,
> -                                  &icpc->parent_reset);
>  }
> =20
>  static const TypeInfo icp_kvm_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 3236ccec924c..e33282a576d0 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -65,7 +65,6 @@ struct ICPStateClass {
>      DeviceClass parent_class;
> =20
>      DeviceRealize parent_realize;
> -    DeviceReset parent_reset;
>  };
> =20
>  struct ICPState {
>=20
