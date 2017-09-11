Received: from eggs.gnu.org ([2001:4830:134:3::10]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drMfe-0003bX-O3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drMfa-0001e8-Oe
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:14:30 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:53871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drMfa-0001ca-H5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:14:26 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E461493212
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 13:14:24 +0200 (CEST)
Date: Mon, 11 Sep 2017 13:14:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911131418.11a1645d@bahia.lan>
In-Reply-To: <20170911110037.6567-1-lvivier@redhat.com>
References: <20170911110037.6567-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rJO2cWbgwY6PYHQHQ0nuvVQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/rJO2cWbgwY6PYHQHQ0nuvVQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 13:00:37 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
> fixes the problem for i386, do the same for ppc.
>=20
> Running QEMU with
>     qemu-system-ppc64 -M none -nographic -m 256
> and executing
>     dump-guest-memory /dev/null 0 8192
> results in segfault
>=20
> Fix by checking if we have CPU.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/arch_dump.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index 8e9397aa58..dcb7b19950 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -224,17 +224,22 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const struct GuestPhysBlockList *guest_phys_blocks)
>  {
> -    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> -
>      info->d_machine =3D PPC_ELF_MACHINE;
>      info->d_class =3D ELFCLASS;
> =20
> -    if ((*pcc->interrupts_big_endian)(cpu)) {
> -        info->d_endian =3D ELFDATA2MSB;
> +    if (first_cpu) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +        if ((*pcc->interrupts_big_endian)(cpu)) {
> +            info->d_endian =3D ELFDATA2MSB;
> +        } else {
> +            info->d_endian =3D ELFDATA2LSB;
> +        }
>      } else {
> -        info->d_endian =3D ELFDATA2LSB;
> +        info->d_endian =3D ELFDATA2MSB;
>      }
> +
>      /* 64KB is the max page size for pseries kernel */
>      if (strncmp(object_get_typename(qdev_get_machine()),
>                  "pseries-", 8) =3D=3D 0) {


--Sig_/rJO2cWbgwY6PYHQHQ0nuvVQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbZwCgAKCRAC/DrrAQHb
wkeZAKClmTBjcwDdgnnZn9/lQdDfDL4xmACdGPnKPpAQUKMVKcI1ywuZT8fJ0Yw=
=tskm
-----END PGP SIGNATURE-----

--Sig_/rJO2cWbgwY6PYHQHQ0nuvVQ--
