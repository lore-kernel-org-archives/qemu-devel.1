Received: from eggs.gnu.org ([2001:4830:134:3::10]:38051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dB107-0007zO-RN
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dB102-0004T2-QK
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:36:35 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:54324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dB102-0004Rl-KG
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:36:30 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 983383B463
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 17:36:22 +0200 (CEST)
References: <149503190026.11264.1637374942003022823.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <277caf96-fb8e-1b8b-944b-58425383a02b@kaod.org>
Date: Wed, 17 May 2017 17:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <149503190026.11264.1637374942003022823.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xics_kvm: cache already enabled vCPU ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 05/17/2017 04:38 PM, Greg Kurz wrote:
> Since commit a45863bda90d ("xics_kvm: Don't enable KVM_CAP_IRQ_XICS if
> already enabled"), we were able to re-hotplug a vCPU that had been hot-
> unplugged ealier, thanks to a boolean flag in ICPState that we set when
> enabling KVM_CAP_IRQ_XICS.
>=20
> This could work because the lifecycle of all ICPState objects was the
> same as the machine. Commit 5bc8d26de20c ("spapr: allocate the ICPState
> object from under sPAPRCPUCore") broke this assumption and now we alway=
s
> pass a freshly allocated ICPState object (ie, with the flag unset) to
> icp_kvm_cpu_setup().
>=20
> This cause re-hotplug to fail with:
>=20
> Unable to connect CPU8 to kernel XICS: Device or resource busy
>=20
> Let's fix this by caching all the vCPU ids for which KVM_CAP_IRQ_XICS w=
as
> enabled. This also drops the now useless boolean flag from ICPState.
>=20
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>=20

Thanks,

C.=20

> ---
>  hw/intc/xics_kvm.c    |   27 ++++++++++++++++++++-------
>  include/hw/ppc/xics.h |    1 -
>  2 files changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index dd93531ae376..dd7f29846235 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -42,6 +42,14 @@
> =20
>  static int kernel_xics_fd =3D -1;
> =20
> +typedef struct KVMEnabledICP {
> +    unsigned long vcpu_id;
> +    QLIST_ENTRY(KVMEnabledICP) node;
> +} KVMEnabledICP;
> +
> +static QLIST_HEAD(, KVMEnabledICP)
> +    kvm_enabled_icps =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_icps);
> +
>  /*
>   * ICP-KVM
>   */
> @@ -121,6 +129,8 @@ static void icp_kvm_reset(void *dev)
>  static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> +    KVMEnabledICP *enabled_icp;
> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
>      int ret;
> =20
>      if (kernel_xics_fd =3D=3D -1) {
> @@ -132,18 +142,21 @@ static void icp_kvm_cpu_setup(ICPState *icp, Powe=
rPCCPU *cpu)
>       * which was hot-removed earlier we don't have to renable
>       * KVM_CAP_IRQ_XICS capability again.
>       */
> -    if (icp->cap_irq_xics_enabled) {
> -        return;
> +    QLIST_FOREACH(enabled_icp, &kvm_enabled_icps, node) {
> +        if (enabled_icp->vcpu_id =3D=3D vcpu_id) {
> +            return;
> +        }
>      }
> =20
> -    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_f=
d,
> -                              kvm_arch_vcpu_id(cs));
> +    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_f=
d, vcpu_id);
>      if (ret < 0) {
> -        error_report("Unable to connect CPU%ld to kernel XICS: %s",
> -                     kvm_arch_vcpu_id(cs), strerror(errno));
> +        error_report("Unable to connect CPU%ld to kernel XICS: %s", vc=
pu_id,
> +                     strerror(errno));
>          exit(1);
>      }
> -    icp->cap_irq_xics_enabled =3D true;
> +    enabled_icp =3D g_malloc(sizeof(*enabled_icp));
> +    enabled_icp->vcpu_id =3D vcpu_id;
> +    QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
>  }
> =20
>  static void icp_kvm_realize(DeviceState *dev, Error **errp)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index d6cb51f3ad5d..a3073f90533a 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -81,7 +81,6 @@ struct ICPState {
>      uint8_t pending_priority;
>      uint8_t mfrr;
>      qemu_irq output;
> -    bool cap_irq_xics_enabled;
> =20
>      XICSFabric *xics;
>  };
>=20
