Received: from eggs.gnu.org ([2001:4830:134:3::10]:54184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drmWW-0000UR-Nn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drmWR-0004Zh-PB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:50:48 -0400
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:50969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drmWR-0004Xw-08
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:50:43 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8925093A4F
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 16:50:41 +0200 (CEST)
Date: Tue, 12 Sep 2017 16:50:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170912165028.11ab5489@bahia.lan>
In-Reply-To: <20170912140149.7692-3-lvivier@redhat.com>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/YIvikDq8zcY.vXy0KTjgMs/";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] hmp: fix "dump-quest-memory"
 segfault (arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

--Sig_/YIvikDq8zcY.vXy0KTjgMs/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Sep 2017 16:01:48 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Running QEMU with
>     qemu-system-aarch64 -M none -nographic -m 256
> and executing
>     dump-guest-memory /dev/null 0 8192
> results in segfault
>=20
> Fix by checking if we have CPU, and exit with
> error if there is no CPU:
>=20
>     (qemu) dump-guest-memory /dev/null
>     this feature or command is not currently supported
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/arm/arch_dump.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index 1a9861f69b..9e5b2fb31c 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -273,11 +273,18 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction =
f, CPUState *cs,
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const GuestPhysBlockList *guest_phys_blocks)
>  {
> -    ARMCPU *cpu =3D ARM_CPU(first_cpu);
> -    CPUARMState *env =3D &cpu->env;
> +    ARMCPU *cpu;
> +    CPUARMState *env;
>      GuestPhysBlock *block;
>      hwaddr lowest_addr =3D ULLONG_MAX;
> =20
> +    if (first_cpu =3D=3D NULL) {
> +        return -1;
> +    }
> +
> +    cpu =3D ARM_CPU(first_cpu);
> +    env =3D &cpu->env;
> +
>      /* Take a best guess at the phys_base. If we get it wrong then crash
>       * will need '--machdep phys_offset=3D<phys-offset>' added to its co=
mmand
>       * line, which isn't any worse than assuming we can use zero, but be=
ing


--Sig_/YIvikDq8zcY.vXy0KTjgMs/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbf0NAAKCRAC/DrrAQHb
wvwVAKCisrHB4G8tqrBeOEOPkbKZ9SJm6ACgp5XA/YUNgvi4CHc/X5FTe3KwHMM=
=nu4D
-----END PGP SIGNATURE-----

--Sig_/YIvikDq8zcY.vXy0KTjgMs/--
