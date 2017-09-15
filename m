Received: from eggs.gnu.org ([2001:4830:134:3::10]:46620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsgrC-0005WO-MV
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsgrB-0002ZR-E7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:59:54 -0400
Date: Fri, 15 Sep 2017 11:00:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915010021.GC5250@umbus.fritz.box>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541713284.1616.15291547955159941369.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <150541713284.1616.15291547955159941369.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/3] kvm: check KVM_CAP_NR_VCPUS with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 09:25:32PM +0200, Greg Kurz wrote:
1;4803;0c> On a modern server-class ppc host with the following CPU topolog=
y:
>=20
> Architecture:          ppc64le
> Byte Order:            Little Endian
> CPU(s):                32
> On-line CPU(s) list:   0,8,16,24
> Off-line CPU(s) list:  1-7,9-15,17-23,25-31
> Thread(s) per core:    1
>=20
> If both KVM PR and KVM HV loaded and we pass:
>=20
>         -machine pseries,accel=3Dkvm,kvm-type=3DPR -smp 8
>=20
> We expect QEMU to warn that this exceeds the number of online CPUs:
>=20
> Warning: Number of SMP cpus requested (8) exceeds the recommended
>  cpus supported by KVM (4)
> Warning: Number of hotpluggable cpus requested (8) exceeds the
>  recommended cpus supported by KVM (4)
>=20
> but nothing is printed...
>=20
> This happens because on ppc the KVM_CAP_NR_VCPUS capability is VM
> specific  ndreally depends on the KVM type, but we currently use it
> as a global capability. And KVM returns a fallback value based on
> KVM HV being present. Maybe KVM on POWER shouldn't presume anything
> as long as it doesn't have a VM, but in all cases, we should call
> KVM_CREATE_VM first and use KVM_CAP_NR_VCPUS as a VM capability.
>=20
> This patch hence changes kvm_recommended_vcpus() accordingly and
> moves the sanity checking of smp_cpus after the VM creation.
>=20
> It is okay for the other archs that also implement KVM_CAP_NR_VCPUS,
> ie, mips, s390, x86 and arm, because they don't depend on the VM
> being created or not.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/kvm/kvm-all.c |   45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 323c567cfb68..d10534de2da1 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1533,7 +1533,7 @@ static void kvm_irqchip_create(MachineState *machin=
e, KVMState *s)
>   */
>  static int kvm_recommended_vcpus(KVMState *s)
>  {
> -    int ret =3D kvm_check_extension(s, KVM_CAP_NR_VCPUS);
> +    int ret =3D kvm_vm_check_extension(s, KVM_CAP_NR_VCPUS);
>      return (ret) ? ret : 4;
>  }
> =20
> @@ -1623,27 +1623,6 @@ static int kvm_init(MachineState *ms)
>          s->nr_slots =3D 32;
>      }
> =20
> -    /* check the vcpu limits */
> -    soft_vcpus_limit =3D kvm_recommended_vcpus(s);
> -    hard_vcpus_limit =3D kvm_max_vcpus(s);
> -
> -    while (nc->name) {
> -        if (nc->num > soft_vcpus_limit) {
> -            fprintf(stderr,
> -                    "Warning: Number of %s cpus requested (%d) exceeds "
> -                    "the recommended cpus supported by KVM (%d)\n",
> -                    nc->name, nc->num, soft_vcpus_limit);
> -
> -            if (nc->num > hard_vcpus_limit) {
> -                fprintf(stderr, "Number of %s cpus requested (%d) exceed=
s "
> -                        "the maximum cpus supported by KVM (%d)\n",
> -                        nc->name, nc->num, hard_vcpus_limit);
> -                exit(1);
> -            }
> -        }
> -        nc++;
> -    }
> -
>      kvm_type =3D qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>      if (mc->kvm_type) {
>          type =3D mc->kvm_type(kvm_type);
> @@ -1678,6 +1657,28 @@ static int kvm_init(MachineState *ms)
>      }
> =20
>      s->vmfd =3D ret;
> +
> +    /* check the vcpu limits */
> +    soft_vcpus_limit =3D kvm_recommended_vcpus(s);
> +    hard_vcpus_limit =3D kvm_max_vcpus(s);
> +
> +    while (nc->name) {
> +        if (nc->num > soft_vcpus_limit) {
> +            fprintf(stderr,
> +                    "Warning: Number of %s cpus requested (%d) exceeds "
> +                    "the recommended cpus supported by KVM (%d)\n",
> +                    nc->name, nc->num, soft_vcpus_limit);
> +
> +            if (nc->num > hard_vcpus_limit) {
> +                fprintf(stderr, "Number of %s cpus requested (%d) exceed=
s "
> +                        "the maximum cpus supported by KVM (%d)\n",
> +                        nc->name, nc->num, hard_vcpus_limit);
> +                exit(1);
> +            }
> +        }
> +        nc++;
> +    }
> +
>      missing_cap =3D kvm_check_extension_list(s, kvm_required_capabilites=
);
>      if (!missing_cap) {
>          missing_cap =3D
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7JiQACgkQbDjKyiDZ
s5LpcBAAzLMRLQU40O6N1LrNm1poDsi7uR3vX/sM1Mf3kA36TaS/7NjoCwSCQvcp
+BpgIuLk9/4Tm7X4HJ/rjcYqyAWgo5L+a2AC3609hv2MozX0ZYC0vB4zHDC+2bcC
cGdm4YA0RWgckKIa35cI7NmQVSAyJgf39XPNW1ad9QkJwtUFd/pPpt7XCV/9P/Qa
jk0LJv49z+oT8JPdTim692b1QIG+9R1bIW2pON8i+7Mk1lu4voo1F2RLGrB3w2TC
BTlGagcAVT3qYIjjgdTeXo4VJpJbjfF5ctSWrwlRmy8cmCFqUkn3PVJhhI8yvY8a
zlBnabfN7uzQL1aGjiFVf+dJukLakJ4FH0ZEXkhLFMv3QaCVBL6N+/CUDeZEqPQy
hqBDHo5GAt38m+UwauwBFtTnm3YSI0m1qzoyRNiXwZs3WPHfa194aQvMPQKHp2F0
nvihqke9jtS8S+z13SLrn6FpgmNKSVRYMMD3ZRdDK8TOqOoU+m/bvU/aGs8Z+k19
2bcT4D/8HSLDBdS/3YMfmT7IltGiXI6lgBCBKklr5P7luD3os59mml6JEAvReHds
P2amg+Q/JghrEteQFVrJQHse1HLsyxczM9ZWoQwGi3EJt330kkbeX+ePVaMmAPwl
LyOqEgHnxw4QDLSDIhDJ9sPHOYiPfV3C4u6k7DB+lNAw3KNTyOE=
=+2Sm
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
