Received: from eggs.gnu.org ([209.51.188.92]:37063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gucvi-0007iD-G2
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gucve-0005DC-Fl
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:49:21 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:47840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gucve-00054C-2C
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:49:18 -0500
Received: from player795.ha.ovh.net (unknown [10.109.159.90])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3006411B295
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:49:09 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023078871.1011724.3083923389814185598.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fa4e799b-5205-fd28-1369-2a347e07f5a3@kaod.org>
Date: Fri, 15 Feb 2019 13:49:03 +0100
MIME-Version: 1.0
In-Reply-To: <155023078871.1011724.3083923389814185598.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] xics: Explicitely call KVM ICP
 methods from the common code
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
> The pre_save(), post_load() and synchronize_state() methods of the
> ICPStateClass type are really KVM only things. Make that obvious
> by dropping the indirections and directly calling the KVM functions
> instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics.c        |   24 +++++++++++-------------
>  hw/intc/xics_kvm.c    |   12 ++++--------
>  include/hw/ppc/xics.h |    9 +++++----
>  3 files changed, 20 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 16e8ffa2aaf7..988b53abd17d 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -37,18 +37,18 @@
>  #include "qapi/visitor.h"
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
> +#include "sysemu/kvm.h"
> =20
>  void icp_pic_print_info(ICPState *icp, Monitor *mon)
>  {
> -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
>      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> =20
>      if (!icp->output) {
>          return;
>      }
> =20
> -    if (icpc->synchronize_state) {
> -        icpc->synchronize_state(icp);
> +    if (kvm_irqchip_in_kernel()) {
> +        icp_synchronize_state(icp);
>      }
> =20
>      monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x=
\n",
> @@ -252,25 +252,23 @@ static void icp_irq(ICSState *ics, int server, in=
t nr, uint8_t priority)
>      }
>  }
> =20
> -static int icp_dispatch_pre_save(void *opaque)
> +static int icp_pre_save(void *opaque)
>  {
>      ICPState *icp =3D opaque;
> -    ICPStateClass *info =3D ICP_GET_CLASS(icp);
> =20
> -    if (info->pre_save) {
> -        info->pre_save(icp);
> +    if (kvm_irqchip_in_kernel()) {
> +        icp_get_kvm_state(icp);
>      }
> =20
>      return 0;
>  }
> =20
> -static int icp_dispatch_post_load(void *opaque, int version_id)
> +static int icp_post_load(void *opaque, int version_id)
>  {
>      ICPState *icp =3D opaque;
> -    ICPStateClass *info =3D ICP_GET_CLASS(icp);
> =20
> -    if (info->post_load) {
> -        return info->post_load(icp, version_id);
> +    if (kvm_irqchip_in_kernel()) {
> +        return icp_set_kvm_state(icp);
>      }
> =20
>      return 0;
> @@ -280,8 +278,8 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>      .name =3D "icp/server",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .pre_save =3D icp_dispatch_pre_save,
> -    .post_load =3D icp_dispatch_post_load,
> +    .pre_save =3D icp_pre_save,
> +    .post_load =3D icp_post_load,
>      .fields =3D (VMStateField[]) {
>          /* Sanity check */
>          VMSTATE_UINT32(xirr, ICPState),
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index dff13300504c..7efa99b8b434 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -54,7 +54,7 @@ static QLIST_HEAD(, KVMEnabledICP)
>  /*
>   * ICP-KVM
>   */
> -static void icp_get_kvm_state(ICPState *icp)
> +void icp_get_kvm_state(ICPState *icp)
>  {
>      uint64_t state;
>      int ret;
> @@ -83,14 +83,14 @@ static void do_icp_synchronize_state(CPUState *cpu,=
 run_on_cpu_data arg)
>      icp_get_kvm_state(arg.host_ptr);
>  }
> =20
> -static void icp_synchronize_state(ICPState *icp)
> +void icp_synchronize_state(ICPState *icp)
>  {
>      if (icp->cs) {
>          run_on_cpu(icp->cs, do_icp_synchronize_state, RUN_ON_CPU_HOST_=
PTR(icp));
>      }
>  }
> =20
> -static int icp_set_kvm_state(ICPState *icp, int version_id)
> +int icp_set_kvm_state(ICPState *icp)
>  {
>      uint64_t state;
>      int ret;
> @@ -121,7 +121,7 @@ static void icp_kvm_reset(DeviceState *dev)
> =20
>      icpc->parent_reset(dev);
> =20
> -    icp_set_kvm_state(ICP(dev), 1);
> +    icp_set_kvm_state(ICP(dev));
>  }
> =20
>  static void icp_kvm_realize(DeviceState *dev, Error **errp)
> @@ -178,10 +178,6 @@ static void icp_kvm_class_init(ObjectClass *klass,=
 void *data)
>                                      &icpc->parent_realize);
>      device_class_set_parent_reset(dc, icp_kvm_reset,
>                                    &icpc->parent_reset);
> -
> -    icpc->pre_save =3D icp_get_kvm_state;
> -    icpc->post_load =3D icp_set_kvm_state;
> -    icpc->synchronize_state =3D icp_synchronize_state;
>  }
> =20
>  static const TypeInfo icp_kvm_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index fad786e8b22d..3236ccec924c 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -66,10 +66,6 @@ struct ICPStateClass {
> =20
>      DeviceRealize parent_realize;
>      DeviceReset parent_reset;
> -
> -    void (*pre_save)(ICPState *icp);
> -    int (*post_load)(ICPState *icp, int version_id);
> -    void (*synchronize_state)(ICPState *icp);
>  };
> =20
>  struct ICPState {
> @@ -203,4 +199,9 @@ void icp_resend(ICPState *ss);
>  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
>                     Error **errp);
> =20
> +/* KVM */
> +void icp_get_kvm_state(ICPState *icp);
> +int icp_set_kvm_state(ICPState *icp);
> +void icp_synchronize_state(ICPState *icp);
> +
>  #endif /* XICS_H */
>=20
