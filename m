Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEkA-0008UA-V7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 02:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEk9-0002X9-Sw
	for qemu-devel@nongnu.org; Thu, 18 May 2017 02:17:02 -0400
Date: Thu, 18 May 2017 15:56:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170518055628.GB13465@umbus.fritz.box>
References: <149503190026.11264.1637374942003022823.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <149503190026.11264.1637374942003022823.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] xics_kvm: cache already enabled vCPU ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 04:38:20PM +0200, Greg Kurz wrote:
> Since commit a45863bda90d ("xics_kvm: Don't enable KVM_CAP_IRQ_XICS if
> already enabled"), we were able to re-hotplug a vCPU that had been hot-
> unplugged ealier, thanks to a boolean flag in ICPState that we set when
> enabling KVM_CAP_IRQ_XICS.
>=20
> This could work because the lifecycle of all ICPState objects was the
> same as the machine. Commit 5bc8d26de20c ("spapr: allocate the ICPState
> object from under sPAPRCPUCore") broke this assumption and now we always
> pass a freshly allocated ICPState object (ie, with the flag unset) to
> icp_kvm_cpu_setup().
>=20
> This cause re-hotplug to fail with:
>=20
> Unable to connect CPU8 to kernel XICS: Device or resource busy
>=20
> Let's fix this by caching all the vCPU ids for which KVM_CAP_IRQ_XICS was
> enabled. This also drops the now useless boolean flag from ICPState.
>=20
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

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
> @@ -132,18 +142,21 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerP=
CCPU *cpu)
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
> -    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
> -                              kvm_arch_vcpu_id(cs));
> +    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,=
 vcpu_id);
>      if (ret < 0) {
> -        error_report("Unable to connect CPU%ld to kernel XICS: %s",
> -                     kvm_arch_vcpu_id(cs), strerror(errno));
> +        error_report("Unable to connect CPU%ld to kernel XICS: %s", vcpu=
_id,
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHTeMAAoJEGw4ysog2bOSu4gQAJKdr9q2xF6KYoYfoZbPw8BG
mKH1frDHR6/ZPhgeaSmK3t5wev5jY+kioiUzESaPnYoK93mSWjxYnJdqwDt4EA2s
P8cnrigZuc4m9m/9caNxWKOIucqsDhF6AoFlYBkWVryIW5slbnmwTvjRPDkEuOW3
uj/fu16EM0cMP6U2cPIU+SiRm72hVDQB/SXvl4F7OfH6Ii9I/i5z5EFA+LORYJgy
7GcL4ELbHuylpQweuZNqkmM+BlnZ+AkNWODJzt9SAMaQSGHXqpEEATsMSLs2zhMn
SdKkJxhtIbgLqptlgIhP5m26T7WyH5H9eWtbD8d1r3LZYwYJAmfEGOsJM2d1xzHF
+Eb64vfR1toSsgx2kSJ40aTfqBnzktcmIjI4oIE98hmNGvyFhuoRzR99TnV/8wJd
erJh9zK3QDn06cviZC1mi5xdAo5kawrpM9UFHA8VLI0t8Mq8seJY9YQumhzRZhjG
XU93hY6uEFzp9qSGM0lAy72SdpENrx1Ljgc2dRGRcKnEuLev2jgNeUxGdAhWFCOQ
+0vaIlnqKusaWhZem/mLwqWnWqlaHr0YfI6seJmRbNvrgtmX/FnU4Wf9akFLI4Z3
a13M44jE+4W+Qew68zmMYK1+mnGUoeEzD4yVe6EAzSQt6NQK+VGuQGk7/G3Pt1X6
91d5feP0bgtiylR2aXhC
=vU3m
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
