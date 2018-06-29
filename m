Received: from eggs.gnu.org ([2001:4830:134:3::10]:57588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqm-0001Hw-GY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqk-0001ps-Sm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:40 -0400
Date: Fri, 29 Jun 2018 15:18:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629051822.GM3422@umbus.fritz.box>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018093372.336571.7266716996862582164.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
In-Reply-To: <153018093372.336571.7266716996862582164.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH 3/3] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 12:15:33PM +0200, Greg Kurz wrote:
> It is unsafe to rely on *_enabled() helpers before the accelerator has
> been initialized, ie, accel_init_machine() has succeeded, because they
> always return false. But it is still possible to end up calling them
> indirectly by inadvertance, and cause QEMU to misbehave.
>=20
> This patch causes QEMU to abort if we try to check for an accelerator
> before it has been set up. This will help to catch bugs earlier.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I think this is a good idea, but it has pretty widereaching impact, so
it can't go through my tree.  You'll need to send this separately to
the list.

> ---
>  accel/accel.c          |    7 +++++++
>  include/qemu-common.h  |    3 ++-
>  include/sysemu/accel.h |    1 +
>  include/sysemu/kvm.h   |    3 ++-
>  qom/cpu.c              |    1 +
>  stubs/Makefile.objs    |    1 +
>  stubs/accel.c          |   14 ++++++++++++++
>  target/i386/hax-all.c  |    2 +-
>  target/i386/whpx-all.c |    2 +-
>  9 files changed, 30 insertions(+), 4 deletions(-)
>  create mode 100644 stubs/accel.c
>=20
> diff --git a/accel/accel.c b/accel/accel.c
> index 966b2d8f536c..27900aac9cc5 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -51,6 +51,13 @@ static AccelClass *accel_find(const char *opt_name)
>      return ac;
>  }
> =20
> +bool assert_accelerator_initialized(bool allowed)
> +{
> +    assert(current_machine !=3D NULL);
> +    assert(current_machine->accelerator !=3D NULL);
> +    return allowed;
> +}
> +
>  static int accel_init_machine(AccelClass *acc, MachineState *ms)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(acc);
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 85f4749aefb7..01d5e4d97dbf 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -82,7 +82,8 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
>  extern bool tcg_allowed;
>  void tcg_exec_init(unsigned long tb_size);
>  #ifdef CONFIG_TCG
> -#define tcg_enabled() (tcg_allowed)
> +#include "sysemu/accel.h"
> +#define tcg_enabled() (assert_accelerator_initialized(tcg_allowed))
>  #else
>  #define tcg_enabled() 0
>  #endif
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 637358f43014..76965cb69cc9 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -71,5 +71,6 @@ void configure_accelerator(MachineState *ms);
>  void accel_register_compat_props(AccelState *accel);
>  /* Called just before os_setup_post (ie just before drop OS privs) */
>  void accel_setup_post(MachineState *ms);
> +bool assert_accelerator_initialized(bool allowed);
> =20
>  #endif
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 0b64b8e06786..ac4dbb2d6d6d 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -18,6 +18,7 @@
>  #include "qom/cpu.h"
>  #include "exec/memattrs.h"
>  #include "hw/irq.h"
> +#include "sysemu/accel.h"
> =20
>  #ifdef NEED_CPU_H
>  # ifdef CONFIG_KVM
> @@ -46,7 +47,7 @@ extern bool kvm_direct_msi_allowed;
>  extern bool kvm_ioeventfd_any_length_allowed;
>  extern bool kvm_msi_use_devid;
> =20
> -#define kvm_enabled()           (kvm_allowed)
> +#define kvm_enabled()           (assert_accelerator_initialized(kvm_allo=
wed))
>  /**
>   * kvm_irqchip_in_kernel:
>   *
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 92599f35413b..65a8f03a66a4 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -23,6 +23,7 @@
>  #include "qemu-common.h"
>  #include "qom/cpu.h"
>  #include "sysemu/hw_accel.h"
> +#include "sysemu/accel.h"
>  #include "qemu/notify.h"
>  #include "qemu/log.h"
>  #include "exec/log.h"
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 53d3f32cb258..2d5142287525 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -43,3 +43,4 @@ stub-obj-y +=3D xen-common.o
>  stub-obj-y +=3D xen-hvm.o
>  stub-obj-y +=3D pci-host-piix.o
>  stub-obj-y +=3D ram-block.o
> +stub-obj-y +=3D accel.o
> diff --git a/stubs/accel.c b/stubs/accel.c
> new file mode 100644
> index 000000000000..4f480f2d3f29
> --- /dev/null
> +++ b/stubs/accel.c
> @@ -0,0 +1,14 @@
> +/*
> + * accel stubs
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/accel.h"
> +
> +bool assert_accelerator_initialized(bool allowed)
> +{
> +    return allowed;
> +}
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856bb8..7c78bd7d094d 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -57,7 +57,7 @@ static int hax_arch_get_registers(CPUArchState *env);
> =20
>  int hax_enabled(void)
>  {
> -    return hax_allowed;
> +    return assert_accelerator_initialized(hax_allowed);
>  }
> =20
>  int valid_hax_tunnel_size(uint16_t size)
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 6b42096698ee..e7f6bc5958e7 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1422,7 +1422,7 @@ static int whpx_accel_init(MachineState *ms)
> =20
>  int whpx_enabled(void)
>  {
> -    return whpx_allowed;
> +    return assert_accelerator_initialized(whpx_allowed);
>  }
> =20
>  static void whpx_accel_class_init(ObjectClass *oc, void *data)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1wR4ACgkQbDjKyiDZ
s5JQVRAAjVTczTLfKKEBe2oSZwwHXvLNrzeX88Y4Qm8jplCppjDfQAhJg7ovMb9z
yLZcoWWd5vJGhAkYEU6z0HDJVRUjlkP1K/MX/rZoVFPwv+1I4ONEhKft+8T4M5Fu
HHZQ0/Gs/TR+jsRRJJYMdxGtlFMyNtDGtxzrDNQbyjE40448AX18h8r6a4Oi+9QX
llwjNU8SGAfzOOkFkmoRjjwAT1FtD/5n5XV7Gb2PnDkeOgIs9eJDhs/aVmngEAyi
NsjxBemzu1W/O/9rMa86/KGkTftyO25zFXuFnlqBWfLrriLcqinjlYSbx1YQ2L0R
U2Txf+IqpwmPcW/i9kLBEeuPLXijWn1HLnTCLoL5JTd+B5zAnd830MsVJFDWLJKM
jtosM8lQwkEJu5dJs9kDw5cdzvIgAdaaLCsHrX/EDzGcoOgB72Gcs0WADHGqLbRG
NdyN4SBVVX9bN3WfjiCVe/qFRWkqaZjfRs3qUl/nnwFJ7HcW1b1zMm5cPJ7EwIPd
nQmOHqqFv6Svp4AYNNgTeDliGUzibxbLNrfEIqwoXZjuhDubv/4MjAACYJDLV7XB
xNIKm7hGl6t2dUQboSk4+NSPAg+TMxYfQJu5ed3VbKglpt+A7Q5cUqd3M8uUcocj
kkJa7xJ+z+JXZJrG+iyduCaS87XDsZUDW51qWzj8x5tX/5Fsx9s=
=qSPA
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
