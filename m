Received: from eggs.gnu.org ([2001:4830:134:3::10]:54743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYqYy-0006pL-JV
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYqYv-0004Hw-Bs
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:23:36 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:60143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYqYv-00041t-1m
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:23:33 -0400
Received: from player699.ha.ovh.net (unknown [10.109.122.92])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id C4580C7C43
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 12:23:24 +0200 (CEST)
Date: Fri, 29 Jun 2018 12:23:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180629122311.2bf6c3b5@bahia.lan>
In-Reply-To: <20180629051822.GM3422@umbus.fritz.box>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018093372.336571.7266716996862582164.stgit@bahia>
	<20180629051822.GM3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/lWSv4xtEX9YKCtzld60J35u";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/lWSv4xtEX9YKCtzld60J35u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jun 2018 15:18:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 28, 2018 at 12:15:33PM +0200, Greg Kurz wrote:
> > It is unsafe to rely on *_enabled() helpers before the accelerator has
> > been initialized, ie, accel_init_machine() has succeeded, because they
> > always return false. But it is still possible to end up calling them
> > indirectly by inadvertance, and cause QEMU to misbehave.
> >=20
> > This patch causes QEMU to abort if we try to check for an accelerator
> > before it has been set up. This will help to catch bugs earlier.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I think this is a good idea, but it has pretty widereaching impact, so
> it can't go through my tree.  You'll need to send this separately to
> the list.
>=20

Ok, and BTW a v2 is needed. See below.

> > ---
> >  accel/accel.c          |    7 +++++++
> >  include/qemu-common.h  |    3 ++-
> >  include/sysemu/accel.h |    1 +
> >  include/sysemu/kvm.h   |    3 ++-
> >  qom/cpu.c              |    1 +
> >  stubs/Makefile.objs    |    1 +
> >  stubs/accel.c          |   14 ++++++++++++++
> >  target/i386/hax-all.c  |    2 +-
> >  target/i386/whpx-all.c |    2 +-
> >  9 files changed, 30 insertions(+), 4 deletions(-)
> >  create mode 100644 stubs/accel.c
> >=20
> > diff --git a/accel/accel.c b/accel/accel.c
> > index 966b2d8f536c..27900aac9cc5 100644
> > --- a/accel/accel.c
> > +++ b/accel/accel.c
> > @@ -51,6 +51,13 @@ static AccelClass *accel_find(const char *opt_name)
> >      return ac;
> >  }
> > =20
> > +bool assert_accelerator_initialized(bool allowed)
> > +{
> > +    assert(current_machine !=3D NULL);
> > +    assert(current_machine->accelerator !=3D NULL);
> > +    return allowed;
> > +}
> > +
> >  static int accel_init_machine(AccelClass *acc, MachineState *ms)
> >  {
> >      ObjectClass *oc =3D OBJECT_CLASS(acc);
> > diff --git a/include/qemu-common.h b/include/qemu-common.h
> > index 85f4749aefb7..01d5e4d97dbf 100644
> > --- a/include/qemu-common.h
> > +++ b/include/qemu-common.h
> > @@ -82,7 +82,8 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
> >  extern bool tcg_allowed;
> >  void tcg_exec_init(unsigned long tb_size);
> >  #ifdef CONFIG_TCG
> > -#define tcg_enabled() (tcg_allowed)
> > +#include "sysemu/accel.h"
> > +#define tcg_enabled() (assert_accelerator_initialized(tcg_allowed))
> >  #else
> >  #define tcg_enabled() 0
> >  #endif
> > diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> > index 637358f43014..76965cb69cc9 100644
> > --- a/include/sysemu/accel.h
> > +++ b/include/sysemu/accel.h
> > @@ -71,5 +71,6 @@ void configure_accelerator(MachineState *ms);
> >  void accel_register_compat_props(AccelState *accel);
> >  /* Called just before os_setup_post (ie just before drop OS privs) */
> >  void accel_setup_post(MachineState *ms);
> > +bool assert_accelerator_initialized(bool allowed);
> > =20
> >  #endif
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 0b64b8e06786..ac4dbb2d6d6d 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -18,6 +18,7 @@
> >  #include "qom/cpu.h"
> >  #include "exec/memattrs.h"
> >  #include "hw/irq.h"
> > +#include "sysemu/accel.h"
> > =20

This header should only be included if we actually need it...

> >  #ifdef NEED_CPU_H
> >  # ifdef CONFIG_KVM
> > @@ -46,7 +47,7 @@ extern bool kvm_direct_msi_allowed;
> >  extern bool kvm_ioeventfd_any_length_allowed;
> >  extern bool kvm_msi_use_devid;
> > =20
> > -#define kvm_enabled()           (kvm_allowed)

... ie, here (like we do with TCG).

> > +#define kvm_enabled()           (assert_accelerator_initialized(kvm_al=
lowed))
> >  /**
> >   * kvm_irqchip_in_kernel:
> >   *
> > diff --git a/qom/cpu.c b/qom/cpu.c
> > index 92599f35413b..65a8f03a66a4 100644
> > --- a/qom/cpu.c
> > +++ b/qom/cpu.c
> > @@ -23,6 +23,7 @@
> >  #include "qemu-common.h"
> >  #include "qom/cpu.h"
> >  #include "sysemu/hw_accel.h"
> > +#include "sysemu/accel.h"

This change is a leftover from an intermediate version of this patch.

I plan to keep your R-b since these changes are minor.

> >  #include "qemu/notify.h"
> >  #include "qemu/log.h"
> >  #include "exec/log.h"
> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > index 53d3f32cb258..2d5142287525 100644
> > --- a/stubs/Makefile.objs
> > +++ b/stubs/Makefile.objs
> > @@ -43,3 +43,4 @@ stub-obj-y +=3D xen-common.o
> >  stub-obj-y +=3D xen-hvm.o
> >  stub-obj-y +=3D pci-host-piix.o
> >  stub-obj-y +=3D ram-block.o
> > +stub-obj-y +=3D accel.o
> > diff --git a/stubs/accel.c b/stubs/accel.c
> > new file mode 100644
> > index 000000000000..4f480f2d3f29
> > --- /dev/null
> > +++ b/stubs/accel.c
> > @@ -0,0 +1,14 @@
> > +/*
> > + * accel stubs
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "sysemu/accel.h"
> > +
> > +bool assert_accelerator_initialized(bool allowed)
> > +{
> > +    return allowed;
> > +}
> > diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> > index d2e512856bb8..7c78bd7d094d 100644
> > --- a/target/i386/hax-all.c
> > +++ b/target/i386/hax-all.c
> > @@ -57,7 +57,7 @@ static int hax_arch_get_registers(CPUArchState *env);
> > =20
> >  int hax_enabled(void)
> >  {
> > -    return hax_allowed;
> > +    return assert_accelerator_initialized(hax_allowed);
> >  }
> > =20
> >  int valid_hax_tunnel_size(uint16_t size)
> > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> > index 6b42096698ee..e7f6bc5958e7 100644
> > --- a/target/i386/whpx-all.c
> > +++ b/target/i386/whpx-all.c
> > @@ -1422,7 +1422,7 @@ static int whpx_accel_init(MachineState *ms)
> > =20
> >  int whpx_enabled(void)
> >  {
> > -    return whpx_allowed;
> > +    return assert_accelerator_initialized(whpx_allowed);
> >  }
> > =20
> >  static void whpx_accel_class_init(ObjectClass *oc, void *data)
> >  =20
>=20


--Sig_/lWSv4xtEX9YKCtzld60J35u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAls2CI8ACgkQcdTV5YIv
c9b6Vg//SPY/CVW8Qk3caeDkGkIgVW1mcfAhk9kOBFAaNIybTXakhj1jdXoS36wd
MrQYHxkGdaXpgTGFmrjF0FuFjn2+1jQWwRSvbO9/5NMtHS0fYfE32bdxiDs17OQs
bi0lVIpFMn59v0DDQKbgmL1XGQ5UoysO1kH/u9jM2Kl7V+sp0IIOl/6W7Xryw4xU
/T840rzk/UzPLQNlWpqDxhlLaId9F7qJ4/6kO4WYZQWhHUJdf+zmWOLBwCLCCEV+
ybUwS18s+6wihR1CI27f4rZAIwhQ1Go3DQOPkKURzpj+3AnCJ9IpgKk/wJfIJTa0
IAUyM3VBk9gmX6uzgyQAuMqvXs9Qdn4jarIk/IeYwGYvMF15jLF7ZsB9tkpS8Cxi
8vs4RU2Nko+D8FJY/aLHQDVvRcmf9riYlAoOHlYFpBZH+CTaQqMmalewhEjMBqnc
SuqdoL+1MAiaLQV8hvD/6ZyCtm+77lNyq1FEVgPtYbxP/Q7twhnbPBn/6Dbox0tj
+37yFsztDv/c1eiqonurrtk8AgYTWD5JcXwfNsQTw/ld8BotUMf4+a1pJX/Pd8sz
meenlWmjpNc2ObiCi99cmfqfzeTud9cFqSLKslwWwdj0VqTUrp+6ZiiSG9NldFb2
zuF1TimY6dVWmUXdWV58t543YiTw/qCTdMvrNLKzs03Tj1TTerg=
=7fd4
-----END PGP SIGNATURE-----

--Sig_/lWSv4xtEX9YKCtzld60J35u--
