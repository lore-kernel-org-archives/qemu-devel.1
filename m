Received: from eggs.gnu.org ([209.51.188.92]:39795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0hS6-0007K4-LS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0hIM-00041M-2p
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:41:51 -0500
Date: Mon, 4 Mar 2019 16:50:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304055018.GM7792@umbus.fritz.box>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
	<20190228225759.21328-3-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HVCoas+krw6dou6l"
Content-Disposition: inline
In-Reply-To: <20190228225759.21328-3-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 2/5] kvm-all: Introduce
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexey Kardashevskiy <aik@ozlabs.ru>


--HVCoas+krw6dou6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 07:57:56PM -0300, Fabiano Rosas wrote:
> For single stepping (via KVM) of a guest vcpu to work, KVM needs not
> only to support the SET_GUEST_DEBUG ioctl but to also recognize the
> KVM_GUESTDBG_SINGLESTEP bit in the control field of the
> kvm_guest_debug struct.
>=20
> This patch adds support for querying the single step capability so
> that QEMU can decide what to do for the platforms that do not have
> such support.
>=20
> This will allow architecture-specific implementations of a fallback
> mechanism for single stepping in cases where KVM does not support it.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  accel/kvm/kvm-all.c             | 16 ++++++++++++++++
>  accel/stubs/kvm-stub.c          |  4 ++++
>  exec.c                          |  2 +-
>  include/sysemu/kvm.h            |  3 +++
>  stubs/Makefile.objs             |  1 +
>  stubs/kvm-arch-set-singlestep.c |  8 ++++++++
>  6 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/kvm-arch-set-singlestep.c
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index fd92b6f375..d3ac5a9e5c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2267,6 +2267,13 @@ bool kvm_arm_supports_user_irq(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
>  }
> =20
> +/* Whether the KVM_SET_GUEST_DEBUG ioctl supports single stepping */
> +int kvm_has_guestdbg_singlestep(void)
> +{
> +    /* return kvm_check_extension(kvm_state, KVM_CAP_GUEST_DEBUG_SSTEP);=
 */

I don't see a KVM_CAP_GUEST_DEBUG_SSTEP in either the qemu or kernel
trees.  Where does that come from?

> +    return 0;
> +}
> +
>  #ifdef KVM_CAP_SET_GUEST_DEBUG
>  struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
>                                                   target_ulong pc)
> @@ -2316,6 +2323,15 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned=
 long reinject_trap)
>      return data.err;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +    if (kvm_has_guestdbg_singlestep()) {
> +        kvm_update_guest_debug(cs, 0);
> +    } else {
> +        kvm_arch_set_singlestep(cs, enabled);
> +    }
> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 02d5170031..69bd07f50e 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -79,6 +79,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned lon=
g reinject_trap)
>      return -ENOSYS;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> diff --git a/exec.c b/exec.c
> index 518064530b..8817513e26 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1236,7 +1236,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
>      if (cpu->singlestep_enabled !=3D enabled) {
>          cpu->singlestep_enabled =3D enabled;
>          if (kvm_enabled()) {
> -            kvm_update_guest_debug(cpu, 0);
> +            kvm_set_singlestep(cpu, enabled);
>          } else {
>              /* must flush all the translated code to avoid inconsistenci=
es */
>              /* XXX: only flush what is necessary */
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index a6d1cd190f..e1ef2f5b99 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -214,6 +214,7 @@ int kvm_has_pit_state2(void);
>  int kvm_has_many_ioeventfds(void);
>  int kvm_has_gsi_routing(void);
>  int kvm_has_intx_set_mask(void);
> +int kvm_has_guestdbg_singlestep(void);
> =20
>  int kvm_init_vcpu(CPUState *cpu);
>  int kvm_cpu_exec(CPUState *cpu);
> @@ -246,6 +247,7 @@ bool kvm_memcrypt_enabled(void);
>   */
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
> =20
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
> =20
>  #ifdef NEED_CPU_H
>  #include "cpu.h"
> @@ -258,6 +260,7 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong=
 addr,
>                            target_ulong len, int type);
>  void kvm_remove_all_breakpoints(CPUState *cpu);
>  int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
> +void kvm_set_singlestep(CPUState *cs, int enabled);
> =20
>  int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>  int kvm_on_sigbus(int code, void *addr);
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 269dfa5832..884f9b2268 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -12,6 +12,7 @@ stub-obj-y +=3D get-vm-name.o
>  stub-obj-y +=3D iothread.o
>  stub-obj-y +=3D iothread-lock.o
>  stub-obj-y +=3D is-daemonized.o
> +stub-obj-y +=3D kvm-arch-set-singlestep.o
>  stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
>  stub-obj-y +=3D machine-init-done.o
>  stub-obj-y +=3D migr-blocker.o
> diff --git a/stubs/kvm-arch-set-singlestep.c b/stubs/kvm-arch-set-singles=
tep.c
> new file mode 100644
> index 0000000000..ba6e0323d6
> --- /dev/null
> +++ b/stubs/kvm-arch-set-singlestep.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled)
> +{
> +    warn_report("KVM does not support single stepping");
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HVCoas+krw6dou6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8vJoACgkQbDjKyiDZ
s5LxYQ/8CgC6cTgKbRbwItlb4aRx1wjbBv76wf5q0RTsiMJTT96TTeOTwoN1K788
ZASxZG5o9bt7wo6AJYZBp7E/yb5QulwjLK5E4kgStpXqPyVpUI0hSYoPaACldI/v
5XvBKStZET+qZxsOtK5I4ZEYeycWm0NsIgucpkaUm25O9kI1lrqtqsmdOAtrC12e
7e2Si2DRNlrlINc2PiAPQujkv92MXx9QA1/+YWInGBpmMl5MJDc0rbqnlRb0gEpx
MYQEs2TVUY85tMBGQQ6e9+4M0GkIRJQhufdQr2jHYvLynvWjs0aPoA1c5MsJwSbf
V5Qr1nymJGH5j5pkYqICM0t7ux5E258EFrEkGBgzo57bbUqaSdXfr9lwtQQtAxTZ
hESBSQJEVcRnG0ejWoKs0QrpnLbCvO8aZCPVOSAW7PbGlF8WBCPXRpvTYXtmrsnV
xsY18YknuK52DgeGrcDIasolNxtUaLUsYN35U9jLbFj2P3Dr0/5kDMsMBQcQN8y7
NZVkdsPNLuli+4+PFbXl/67YEBO5dYbt6iAuWeD48I3KAFhg5cY/kIboMeooG0cD
n5ltkYmry+RRT074HPWi/x8NwQQpCI5P/J6+Kpi/0Xiwf3G5NAnAHeb2X1wVUlm6
NYVzKp774KqyFL5hDBgqcnU+wTylmBRlIMB7b+Ss3/1Gmje0wjQ=
=nGhn
-----END PGP SIGNATURE-----

--HVCoas+krw6dou6l--
