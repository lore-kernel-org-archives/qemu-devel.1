Received: from eggs.gnu.org ([2001:4830:134:3::10]:49666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQpG7-0001JP-UR
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQpG6-00045Q-Ni
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:55:15 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:49019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gQpG5-00040K-UC
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:55:14 -0500
Date: Sun, 25 Nov 2018 18:54:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181125075403.GC2251@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-3-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20181121181347.24035-3-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/3] kvm-all: Introduce
 kvm_set_singlestep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 04:13:46PM -0200, Fabiano Rosas wrote:
> This will be used in a future patch to implement an
> architecture-specific single step mechanism for POWER.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  accel/kvm/kvm-all.c  | 10 ++++++++++
>  exec.c               |  1 +
>  include/sysemu/kvm.h |  4 ++++
>  target/arm/kvm.c     |  4 ++++
>  target/i386/kvm.c    |  4 ++++
>  target/mips/kvm.c    |  4 ++++
>  target/ppc/kvm.c     |  4 ++++
>  target/s390x/kvm.c   |  4 ++++
>  8 files changed, 35 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4880a05399..4fb7199a15 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2313,6 +2313,11 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned=
 long reinject_trap)
>      return data.err;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +    kvm_arch_set_singlestep(cs, enabled);
> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> @@ -2439,6 +2444,11 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ul=
ong addr,
>  void kvm_remove_all_breakpoints(CPUState *cpu)
>  {
>  }
> +
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +}

You could use stubs to avoid having to put this empty implementation
in every arch.

It also seems like it might be a good idea to report an error here,
rather than having set single step silently do nothing on arches which
don't support it yet.

>  #endif /* !KVM_CAP_SET_GUEST_DEBUG */
> =20
>  static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
> diff --git a/exec.c b/exec.c
> index bb6170dbff..55614822c3 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1233,6 +1233,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
>      if (cpu->singlestep_enabled !=3D enabled) {
>          cpu->singlestep_enabled =3D enabled;
>          if (kvm_enabled()) {
> +            kvm_set_singlestep(cpu, enabled);
>              kvm_update_guest_debug(cpu, 0);
>          } else {
>              /* must flush all the translated code to avoid inconsistenci=
es */
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 97d8d9d0d5..a01a8d58dd 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -259,6 +259,8 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong=
 addr,
>  void kvm_remove_all_breakpoints(CPUState *cpu);
>  int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
> =20
> +void kvm_set_singlestep(CPUState *cpu, int enabled);
> +
>  int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>  int kvm_on_sigbus(int code, void *addr);
> =20
> @@ -431,6 +433,8 @@ void kvm_arch_remove_all_hw_breakpoints(void);
> =20
>  void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *=
dbg);
> =20
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
> +
>  bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
> =20
>  int kvm_check_extension(KVMState *s, unsigned int extension);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 44dd0ce6ce..dd8e43ab7e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -670,6 +670,10 @@ int kvm_arch_process_async_events(CPUState *cs)
>      return 0;
>  }
> =20
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>  /* The #ifdef protections are until 32bit headers are imported and can
>   * be removed once both 32 and 64 bit reach feature parity.
>   */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f524e7d929..ba56f2ee1f 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3521,6 +3521,10 @@ static int kvm_handle_debug(X86CPU *cpu,
>      return ret;
>  }
> =20
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>  void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *=
dbg)
>  {
>      const uint8_t type_code[] =3D {
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 8e72850962..8035262131 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -119,6 +119,10 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, stru=
ct kvm_sw_breakpoint *bp)
>      return 0;
>  }
> =20
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>  static inline int cpu_mips_io_interrupts_pending(MIPSCPU *cpu)
>  {
>      CPUMIPSState *env =3D &cpu->env;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f81327d6cd..9d0b4f1f3f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1551,6 +1551,10 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>      nb_hw_breakpoint =3D nb_hw_watchpoint =3D 0;
>  }
> =20
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *d=
bg)
>  {
>      int n;
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26adfe..4bde183458 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -975,6 +975,10 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>      hw_breakpoints =3D NULL;
>  }
> =20
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>  void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *=
dbg)
>  {
>      int i;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv6VRsACgkQbDjKyiDZ
s5K+tQ/+P9NUw66PneELWuWhVQ21cMxNGC6+jkcXYhAqBJgipe8OZit0WMLmbHr7
lXwBK3wZxbu48zveazoC7JhOL2Hh7nS+U4h2q9Zu7xYJKp3RrlrmsMMRwFkmsx2M
Q3xKGdHvjoj7VUUsFM6ecc9wZ674xfG5l+ibLPXOoDXmJt4RK84wSlKOaNPr3D3o
VPN14pqQzkNYTuXTtViSvIkQu96xGSytv/zuh1k/4ko9NZcONbUPB4ufapnG/UBt
4e8IBHMZ8lf1yhpK4xVQmBm+j59uBI94dxJS/3NsO8pao/VsdXBS+TPKh6+lT5hX
xEEtISKozvdvMO8yVoLx9r53y//8LMwk2b93o7ZmJpnTMX1T9vi/hfVJIl96qwpQ
vRsANT1JzdcnCviYqKaqVrio3KF+OjSXjp8Y3VKOmTggUksjvuLltalYKkNdOYfT
POEF4xIPsJmxae2MKeD//9nEJ87l5flsRd1Ow/I+TEW6La/mygTnnE5QrHHybxJ6
C7O4QRBRrdRT1aAt2aQnYDLjcarvZT1VytjYaesWVbxmaygOtAfasGrerHNDz9Mi
N42p30PwvGT1vE5dBwHGQnEgo7VKq82fA8lS4g3/b+YvnIa2r1sVlYMtrOkVItP2
UmZpRMIjpz4y9fSeeBnwfhgbNJG0KL9Z2eRHSDeoqHcRBKZsW5c=
=f6md
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
