Received: from eggs.gnu.org ([209.51.188.92]:52503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi7-0008At-TY
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi6-0005ah-E9
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:03 -0500
Date: Mon, 18 Feb 2019 10:14:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217231455.GB2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023078871.1011724.3083923389814185598.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <155023078871.1011724.3083923389814185598.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:39:48PM +0100, Greg Kurz wrote:
> The pre_save(), post_load() and synchronize_state() methods of the
> ICPStateClass type are really KVM only things. Make that obvious
> by dropping the indirections and directly calling the KVM functions
> instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

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
>      monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
> @@ -252,25 +252,23 @@ static void icp_irq(ICSState *ics, int server, int =
nr, uint8_t priority)
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
> @@ -83,14 +83,14 @@ static void do_icp_synchronize_state(CPUState *cpu, r=
un_on_cpu_data arg)
>      icp_get_kvm_state(arg.host_ptr);
>  }
> =20
> -static void icp_synchronize_state(ICPState *icp)
> +void icp_synchronize_state(ICPState *icp)
>  {
>      if (icp->cs) {
>          run_on_cpu(icp->cs, do_icp_synchronize_state, RUN_ON_CPU_HOST_PT=
R(icp));
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
> @@ -178,10 +178,6 @@ static void icp_kvm_class_init(ObjectClass *klass, v=
oid *data)
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp6u8ACgkQbDjKyiDZ
s5IbWhAAmhOqUSHWdrnig6CAipIdQCeSoYEO29wmvWyvdiGgxnGAnPy7Y0N9epBz
Vsre8xcCR6fj3MUfNASe80Z0w2WyM33NwzZe7GDkvNsD1eieRKYb5jbGhhbyngM2
GZOcMjhkKDvdblBi9GFnVeDJcTJLXVaikp1nj78sJItySDvy66jBpJiGoRKPraSd
X2zzvgEZqpdt66px25qyyLQEDcQqy5za6yKyYjjgmvugiK+3ep7lzVi+0n9XzmeT
9pc1/CAdMW9bqPBd6RHmlhfCZsYyL+ZbtrUU03BBecgKfY/ElWeeRP5fjKMM9Irp
COmq0mLKKI5l7oy2L8CO9iCX7Ako/F5KINm+1hnBRIaRtke2PZM5vRECZqh/ufmI
HY8sqbN44KnWUJl8KWfEhePIt45CaEj4CYzWpl3I6HsQdTpnaa7//Yr7Sc7KOGVH
ONoLRBe/aG7mJ7A9/00/tD0SokxXkUtOAgQDG2zoJnefjZAiZqBJfdQK7lkqmQmE
oENl8+2RcYWxnHx0xtN7xWGa66EpgE1DZ1blkORetFb6VuQC9z1eqKvfe6BMryeT
wpR/SS928tUHWANbwGLmvai32eiRFbUmH3oVCJxG+eBauLFqs88AnZQhP/6EbcYo
ZKv2wxVwZ4vJjZeLQkqzml5Lz9jx97DiRp1vhula6WqZrpiYYNU=
=xUp5
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
