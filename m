Received: from eggs.gnu.org ([2001:4830:134:3::10]:45279)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1e0kxU-0003yb-B4
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 04:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1e0kxT-0001Gu-GR
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 04:59:44 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-64-f4bug@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <4a9cb605-62ab-8688-7ad1-ecc403f4140d@gmx.com>
Date: Sat, 7 Oct 2017 10:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-64-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5wUuci6lESiEEXMii1BURpKUJriaXT3xl"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 63/88] bsd-user/syscall: fix
 a memory leak on EFAULT, use g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5wUuci6lESiEEXMii1BURpKUJriaXT3xl
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>
Message-ID: <4a9cb605-62ab-8688-7ad1-ecc403f4140d@gmx.com>
Subject: Re: [Qemu-trivial] [PATCH 63/88] bsd-user/syscall: fix a memory leak
 on EFAULT, use g_new()
References: <20171006235023.11952-1-f4bug@amsat.org>
 <20171006235023.11952-64-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-64-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.10.2017 01:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Kamil are you interested in maintaining bsd-user? :)
> =20

Long term yes, short term I'm occupied full-time on getting modern
debuggers as fully-functional and as fully-featured on NetBSD as possible=
=2E

( http://blog.netbsd.org/tnf/entry/eurobsdcon_2017_paris_report )

>  bsd-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index 66492aaf5d..9120cea61e 100644
> --- a/bsd-user/syscall.c
> +++ b/bsd-user/syscall.c
> @@ -227,7 +227,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, =
int32_t namelen, abi_ulong ol
>      void *hnamep, *holdp, *hnewp =3D NULL;
>      size_t holdlen;
>      abi_ulong oldlen =3D 0;
> -    int32_t *snamep =3D g_malloc(sizeof(int32_t) * namelen), *p, *q, i=
;
> +    int32_t *snamep, *p, *q, i;
>      uint32_t kind =3D 0;
> =20
>      if (oldlenp)
> @@ -239,6 +239,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, =
int32_t namelen, abi_ulong ol
>      if (!(holdp =3D lock_user(VERIFY_WRITE, oldp, oldlen, 0)))
>          return -TARGET_EFAULT;
>      holdlen =3D oldlen;
> +    snamep =3D g_new(int32_t, namelen);
>      for (p =3D hnamep, q =3D snamep, i =3D 0; i < namelen; p++, i++)
>         *q++ =3D tswap32(*p);
>      oidfmt(snamep, namelen, NULL, &kind);
>=20



--5wUuci6lESiEEXMii1BURpKUJriaXT3xl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlnYlPEMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs580P/R4UGhLsw7rNIVILJmo/7ML7qn9Q0grlNzy9cmg/
ME2XjTmLHV/4YTT46nIIPYOzsyeR03CUT5PyI5XVMrLobZsjHoJmLA5ancvJdhDP
bLl1wborBKdv/CQ45wnui8KY9gCzg4/SZvKvvpTVOqO6ROVvRVSDalNnGzbaxdbC
/ZwmD0BqdhvkA76MrcH9EkzqRSYcWlqQlEJLClZZ2ZUuCFH/K7j36dhQiDf/5Twb
9aVUxFSDoZBJExJM4O4qjK8xtyHH+m1C9h0vBinuM2Gk1745Yse7bN7SGfwdiHEE
MQvjOhSqLOT96h22DTNm3bllkQPygl2nZeKivsioRDxF/mMLwaxmNYIDcqWsanJA
xDwZNRgolWfPAEorwYo2ZB9eal04eEaAFc7ie3j9hc6KQV5m6daynkDzRuwyasti
nhmJKTjFz8zt0TRSe5IB563Es1MuqL4LZbTcY5GoXSl97HihEkadnTTsI65zA7Hi
OFGCsd/6IvmEifFhrh11l6C9Oo8tx0ANDRQ7KdlU57pSP1SwsAC5UclhCjqqkxYm
aVFZhc9g6FxjF9dpkpQuLxBy6HogzGaQZcKraUw+jV8rKk099y5QyP7qSNi5C0+D
9h3as580G9/gYaZG+Cw2oDs3fZZcndJa5OFdtwxoFQhLGO5i7nJfPceQjnTBzkit
gTse
=55vP
-----END PGP SIGNATURE-----

--5wUuci6lESiEEXMii1BURpKUJriaXT3xl--
