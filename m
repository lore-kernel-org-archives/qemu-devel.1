Received: from eggs.gnu.org ([2001:4830:134:3::10]:41432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drQMZ-0007Ev-Ao
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drQMV-00030V-53
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:11:03 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:36735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drQMU-0002ze-SS
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:10:59 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1056193640
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:10:57 +0200 (CEST)
Date: Mon, 11 Sep 2017 17:08:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911170804.0ee06c00@bahia.lan>
In-Reply-To: <20170911142056.15643-3-lvivier@redhat.com>
References: <20170911142056.15643-1-lvivier@redhat.com>
	<20170911142056.15643-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/x60EAfplRCPZUs_wUeQDKkr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/3] hmp: fix
 "dump-quest-memory" segfault (arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/x60EAfplRCPZUs_wUeQDKkr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 16:20:55 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
> fixes the problem for i386, do the same for arm.
>=20
> Running QEMU with
>     qemu-system-aarch64 -M none -nographic -m 256
> and executing
>     dump-guest-memory /dev/null 0 8192
> results in segfault
>=20
> Fix by checking if we have CPU.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  target/arm/arch_dump.c | 52 +++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 34 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index 1a9861f69b..1f58cff256 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -273,8 +273,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f,=
 CPUState *cs,
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const GuestPhysBlockList *guest_phys_blocks)
>  {
> -    ARMCPU *cpu =3D ARM_CPU(first_cpu);
> -    CPUARMState *env =3D &cpu->env;
>      GuestPhysBlock *block;
>      hwaddr lowest_addr =3D ULLONG_MAX;
> =20
> @@ -290,13 +288,32 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>          }
>      }
> =20
> -    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> -        info->d_machine =3D EM_AARCH64;
> -        info->d_class =3D ELFCLASS64;
> -        info->page_size =3D (1 << 16); /* aarch64 max pagesize */
> -        if (lowest_addr !=3D ULLONG_MAX) {
> -            info->phys_base =3D lowest_addr;
> +    if (first_cpu) {
> +        ARMCPU *cpu =3D ARM_CPU(first_cpu);
> +        CPUARMState *env =3D &cpu->env;
> +        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> +            info->d_machine =3D EM_AARCH64;
> +            info->d_class =3D ELFCLASS64;
> +            info->page_size =3D (1 << 16); /* aarch64 max pagesize */
> +            if (lowest_addr !=3D ULLONG_MAX) {
> +                info->phys_base =3D lowest_addr;
> +            }
> +        } else {
> +            info->d_machine =3D EM_ARM;
> +            info->d_class =3D ELFCLASS32;
> +            info->page_size =3D (1 << 12);
> +            if (lowest_addr < UINT_MAX) {
> +                info->phys_base =3D lowest_addr;
> +            }
>          }
> +
> +        /* We assume the relevant endianness is that of EL1; this is rig=
ht
> +         * for kernels, but might give the wrong answer if you're trying=
 to
> +         * dump a hypervisor that happens to be running an opposite-endi=
an
> +         * kernel.
> +         */
> +        info->d_endian =3D (env->cp15.sctlr_el[1] & SCTLR_EE) !=3D 0
> +                         ? ELFDATA2MSB : ELFDATA2LSB;
>      } else {
>          info->d_machine =3D EM_ARM;
>          info->d_class =3D ELFCLASS32;
> @@ -304,25 +321,24 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>          if (lowest_addr < UINT_MAX) {
>              info->phys_base =3D lowest_addr;
>          }
> +        info->d_endian =3D ELFDATA2LSB;
>      }
> =20
> -    /* We assume the relevant endianness is that of EL1; this is right
> -     * for kernels, but might give the wrong answer if you're trying to
> -     * dump a hypervisor that happens to be running an opposite-endian
> -     * kernel.
> -     */
> -    info->d_endian =3D (env->cp15.sctlr_el[1] & SCTLR_EE) !=3D 0
> -                     ? ELFDATA2MSB : ELFDATA2LSB;
> -
>      return 0;
>  }
> =20
>  ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
>  {
> -    ARMCPU *cpu =3D ARM_CPU(first_cpu);
> -    CPUARMState *env =3D &cpu->env;
> +    ARMCPU *cpu;
> +    CPUARMState *env;
>      size_t note_size;
> =20
> +    if (first_cpu =3D=3D NULL) {
> +        return 0;
> +    }
> +

Looking at the function's code, it seems that env is only needed if
class !=3D ELFCLASS64... I guess that all the code dealing with first_cpu
should go to the else block.

> +    cpu =3D ARM_CPU(first_cpu);
> +    env =3D &cpu->env;
>      if (class =3D=3D ELFCLASS64) {
>          note_size =3D AARCH64_PRSTATUS_NOTE_SIZE;
>          note_size +=3D AARCH64_PRFPREG_NOTE_SIZE;

--Sig_/x60EAfplRCPZUs_wUeQDKkr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbam1AAKCRAC/DrrAQHb
wq51AKCUGYdv7AWaWJ5Fp5PFPoriMJSQcQCeJ+WJpvkZez/BY1LLYHgzDZUPwa0=
=TXlL
-----END PGP SIGNATURE-----

--Sig_/x60EAfplRCPZUs_wUeQDKkr--
