Received: from eggs.gnu.org ([209.51.188.92]:38964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud40-0003M7-Kx
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud3z-0002Uu-Ni
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:57:56 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:35650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gud3z-0002DZ-G6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:57:55 -0500
Received: from player168.ha.ovh.net (unknown [10.109.146.19])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 56BAE1FC667
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:57:46 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023082407.1011724.1983100830860273401.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <993a01dd-704e-7496-800d-8e9a602c6447@kaod.org>
Date: Fri, 15 Feb 2019 13:57:42 +0100
MIME-Version: 1.0
In-Reply-To: <155023082407.1011724.1983100830860273401.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/10] xics: Handle KVM ICS reset from the
 "simple" ICS code
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
> The KVM ICS reset handler simply writes the ICS state to KVM. This
> doesn't need the overkill parent_reset logic we have today. Also
> we want to use the same ICS type for the KVM and non-KVM case with
> pseries.
>=20
> Call icp_set_kvm_state() from the "simple" ICS reset function.

A part from the kvmppc_ prefix,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c     |    4 ++++
>  hw/intc/xics_kvm.c |   18 ------------------
>  2 files changed, 4 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index ae5d5ea135b8..49401745c410 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -553,6 +553,10 @@ static void ics_simple_reset(DeviceState *dev)
>      ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> =20
>      icsc->parent_reset(dev);
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_set_kvm_state(ICS_BASE(dev));
> +    }
>  }
> =20
>  static void ics_simple_reset_handler(void *dev)
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 642351e5790f..e7b8d4c29ce6 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -280,20 +280,6 @@ void ics_kvm_set_irq(void *opaque, int srcno, int =
val)
>      }
>  }
> =20
> -static void ics_kvm_reset(DeviceState *dev)
> -{
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> -
> -    icsc->parent_reset(dev);
> -
> -    ics_set_kvm_state(ICS_KVM(dev));
> -}
> -
> -static void ics_kvm_reset_handler(void *dev)
> -{
> -    ics_kvm_reset(dev);
> -}
> -
>  static void ics_kvm_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_KVM(dev);
> @@ -305,8 +291,6 @@ static void ics_kvm_realize(DeviceState *dev, Error=
 **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    qemu_register_reset(ics_kvm_reset_handler, ics);
>  }
> =20
>  static void ics_kvm_class_init(ObjectClass *klass, void *data)
> @@ -316,8 +300,6 @@ static void ics_kvm_class_init(ObjectClass *klass, =
void *data)
> =20
>      device_class_set_parent_realize(dc, ics_kvm_realize,
>                                      &icsc->parent_realize);
> -    device_class_set_parent_reset(dc, ics_kvm_reset,
> -                                  &icsc->parent_reset);
>  }
> =20
>  static const TypeInfo ics_kvm_info =3D {
>=20
