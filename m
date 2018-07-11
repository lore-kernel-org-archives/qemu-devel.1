Received: from eggs.gnu.org ([2001:4830:134:3::10]:52064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFDG-0001yE-PW
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFDC-0007iN-PU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:31:22 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:41452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFDC-0007iD-Hd
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:31:18 -0400
Received: by mail-qk0-x231.google.com with SMTP id d22-v6so13499875qkc.8
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:31:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <153077727052.29574.3126128933689774889.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <019c6a27-f0ea-5948-94a7-8c668c6281fc@amsat.org>
Date: Wed, 11 Jul 2018 10:31:08 -0300
MIME-Version: 1.0
In-Reply-To: <153077727052.29574.3126128933689774889.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="TpyCGeSOfI2UGbetfjBgiVN4tTE5PNmKx"
Subject: Re: [Qemu-devel] [PATCH v3] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TpyCGeSOfI2UGbetfjBgiVN4tTE5PNmKx
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <019c6a27-f0ea-5948-94a7-8c668c6281fc@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3] accel: forbid early use of kvm_enabled()
 and friends
References: <153077727052.29574.3126128933689774889.stgit@bahia.lan>
In-Reply-To: <153077727052.29574.3126128933689774889.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2018 04:54 AM, Greg Kurz wrote:
> It is unsafe to rely on *_enabled() helpers before the accelerator has
> been initialized, ie, accel_init_machine() has succeeded, because they
> always return false. But it is still possible to end up calling them
> indirectly by inadvertance, and cause QEMU to misbehave.
>=20
> This patch causes QEMU to abort if we try to check for any accelerator
> before accel_init_machine() was called. This will help to catch bugs
> earlier.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>=20
> Current master (SHA1 2a018f6e9878) has such a kvm_enabled() misuse that=

> triggers the assert:
>=20
> https://travis-ci.org/gkurz/qemu/jobs/400059821#L8709
>=20
> The fix for the misuse is available, waiting to be merged:
>=20
> https://patchwork.ozlabs.org/patch/938077/
>=20
> v3: - use an inline function
>     - convert all accelerators
>     - dropped David's R-b
>=20
> v2: - dropped change in qom/cpu.c (useless header inclusion)
>     - only #include "sysemu/kvm.h" if we actually need it
>     - added David's R-b from v1 because changes in v2 are minor
> ---
>  accel/accel.c             |    4 ++++
>  include/hw/xen/xen.h      |    3 ++-
>  include/qemu-common.h     |    3 ++-
>  include/sysemu/accel.h    |    8 ++++++++
>  include/sysemu/hvf.h      |    3 ++-
>  include/sysemu/kvm.h      |    3 ++-
>  include/sysemu/qtest.h    |    3 ++-
>  stubs/Makefile.objs       |    1 +
>  stubs/accel.c             |   12 ++++++++++++
>  target/i386/hax-all.c     |    2 +-
>  target/i386/whpx-all.c    |    2 +-
>  tests/ptimer-test-stubs.c |    2 ++
>  12 files changed, 39 insertions(+), 7 deletions(-)
>  create mode 100644 stubs/accel.c
>=20
> diff --git a/accel/accel.c b/accel/accel.c
> index 966b2d8f536c..bbd890abd7ae 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -68,6 +68,8 @@ static int accel_init_machine(AccelClass *acc, Machin=
eState *ms)
>      return ret;
>  }
> =20
> +AccelState *current_accelerator;
> +
>  void configure_accelerator(MachineState *ms)
>  {
>      const char *accel;
> @@ -116,6 +118,8 @@ void configure_accelerator(MachineState *ms)
>      if (init_failed) {
>          error_report("Back to %s accelerator", acc->name);
>      }
> +
> +    current_accelerator =3D ms->accelerator;
>  }
> =20
>  void accel_register_compat_props(AccelState *accel)
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index 7efcdaa8fe92..5a1664f4948f 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -25,9 +25,10 @@ extern bool xen_domid_restrict;
> =20
>  extern bool xen_allowed;
> =20
> +#include "sysemu/accel.h"
>  static inline bool xen_enabled(void)
>  {
> -    return xen_allowed;
> +    return assert_accelerator_initialized(xen_allowed);
>  }
> =20
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
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
> index 637358f43014..843334ae5229 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -72,4 +72,12 @@ void accel_register_compat_props(AccelState *accel);=

>  /* Called just before os_setup_post (ie just before drop OS privs) */
>  void accel_setup_post(MachineState *ms);
> =20
> +extern AccelState *current_accelerator;
> +
> +static inline bool assert_accelerator_initialized(bool allowed)
> +{
> +    assert(current_accelerator !=3D NULL);
> +    return allowed;
> +}
> +
>  #endif
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 241118845c52..62bdc9ff9b3d 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -26,7 +26,8 @@ extern int hvf_disabled;
>  #include "hw/hw.h"
>  uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>                                   int reg);
> -#define hvf_enabled() !hvf_disabled
> +#include "sysemu/accel.h"
> +#define hvf_enabled() assert_accelerator_initialized(!hvf_disabled)
>  #else
>  #define hvf_enabled() 0
>  #define hvf_get_supported_cpuid(func, idx, reg) 0
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 0b64b8e06786..5a2e59e99128 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -46,7 +46,8 @@ extern bool kvm_direct_msi_allowed;
>  extern bool kvm_ioeventfd_any_length_allowed;
>  extern bool kvm_msi_use_devid;
> =20
> -#define kvm_enabled()           (kvm_allowed)
> +#include "sysemu/accel.h"
> +#define kvm_enabled()           (assert_accelerator_initialized(kvm_al=
lowed))
>  /**
>   * kvm_irqchip_in_kernel:
>   *
> diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
> index 70aa40aa72e9..12ef4f9d86e7 100644
> --- a/include/sysemu/qtest.h
> +++ b/include/sysemu/qtest.h
> @@ -18,9 +18,10 @@
> =20
>  extern bool qtest_allowed;
> =20
> +#include "sysemu/accel.h"
>  static inline bool qtest_enabled(void)
>  {
> -    return qtest_allowed;
> +    return assert_accelerator_initialized(qtest_allowed);
>  }
> =20
>  bool qtest_driver(void);
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
> index 000000000000..22821743ff85
> --- /dev/null
> +++ b/stubs/accel.c
> @@ -0,0 +1,12 @@
> +/*
> + * accel stubs
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/accel.h"
> +
> +/* assert_accelerator_initialized() requires a non-null value */
> +AccelState *current_accelerator =3D (AccelState *) 0xdeadbeef;
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856bb8..7c78bd7d094d 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -57,7 +57,7 @@ static int hax_arch_get_registers(CPUArchState *env);=

> =20
>  int hax_enabled(void)
>  {
> -    return hax_allowed;
> +    return assert_accelerator_initialized(hax_allowed);
>  }
> =20
>  int valid_hax_tunnel_size(uint16_t size)
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 57e53e1f1f40..9e3dd922c2e3 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1468,7 +1468,7 @@ static int whpx_accel_init(MachineState *ms)
> =20
>  int whpx_enabled(void)
>  {
> -    return whpx_allowed;
> +    return assert_accelerator_initialized(whpx_allowed);
>  }
> =20
>  static void whpx_accel_class_init(ObjectClass *oc, void *data)
> diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
> index ca5cc3b13bb3..95510d85c04f 100644
> --- a/tests/ptimer-test-stubs.c
> +++ b/tests/ptimer-test-stubs.c
> @@ -33,6 +33,8 @@ int64_t ptimer_test_time_ns;
>  /* Do not artificially limit period - see hw/core/ptimer.c.  */
>  int use_icount =3D 1;
>  bool qtest_allowed;
> +/* assert_accelerator_initialized() requires a non-null value */
> +AccelState *current_accelerator =3D (AccelState *) 0xdeadbeef;
> =20
>  void timer_init_tl(QEMUTimer *ts,
>                     QEMUTimerList *timer_list, int scale,
>=20
>=20


--TpyCGeSOfI2UGbetfjBgiVN4tTE5PNmKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltGBpwACgkQ4+MsLN6t
wN5yig//XvgEfhCyjUPGGEHT6RLhpyYPacNK95zdY2MLI9vbZTh6KImqyIcVYhU4
v4bXg0OvG9LjLOBGq2BT0BscpCQQlPmddVaoNy009nqhWCRTvd7eZXD9Vbq07DpG
wpoVtIWP5/CvSJ6ReAtOFn42pkMMEHZePW7fyK4fqzPoSBbiuO0MKwQ1Xqt7e0JL
v7kulEDctbmSdhb0sFvzVeWVERU7HmkH/RFzPBabbJo1FAmiC/Tocyks08xO5b3z
tKho+/dUusyCXMftsLq3HueLW4hWtKbnP1unZ7fFotOQgDT0XoEgQ97FXQiyRL5e
hCDXlSvQaL6x1/P+v2Mw8F0Q0sh9ZDNgWCwAMT4bJm6bdokuOFSZ+ydSiOgdrcoa
fEBgamVmkbXD4CDNjskQGq+lYNITdjtUDtpVwI2h+ImzWLs1n1NfRgAxzRcHTfyj
+NcMJaanWHyPvUNQS05C8LyDtC8mKUNz2/W0TMdm2e4J7tyZwMjOY8huDqjylRPq
cOfo4s60c5+rSWqHBi8y2PCiosUNNyakuzgjS2rm8WTB5fr0DrfkWGPntJSw7Rm/
q3/E9KC/DVqeyR6anF59gJEARYf/9xgPLPIk7grJFqD6j33cdcCplG6JNrwQXFtu
y4sx2EgiPQyRMVzf3T7/tEuehelSmcQ66HDJ8XQ+PgeGrl4sSqQ=
=/PY1
-----END PGP SIGNATURE-----

--TpyCGeSOfI2UGbetfjBgiVN4tTE5PNmKx--
