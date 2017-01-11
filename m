Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPPO-0007lQ-8I
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPPK-0001sZ-9s
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:22:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRPPK-0001s9-2B
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:22:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A6824DB8A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:22:06 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-13-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c4d7bfd-ee95-6a14-0240-82e90008a520@redhat.com>
Date: Wed, 11 Jan 2017 14:22:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-13-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AGTp8q1jt7VckM7VsKcsd7wjUHukbg4bt"
Subject: Re: [Qemu-devel] [PATCH 12/40] char-win: do not override chr_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGTp8q1jt7VckM7VsKcsd7wjUHukbg4bt
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <9c4d7bfd-ee95-6a14-0240-82e90008a520@redhat.com>
Subject: Re: [PATCH 12/40] char-win: do not override chr_free
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> For some unclear reason to me, char-file does not have chr_free on
> win32. Since we want to switch to instance finalizer instead of class
> chr_free, we should be able to run the base WinChardev class finalizer
> in any case. Use a boolean to skip free to ease the transition to
> instance finalizer.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-char.c b/qemu-char.c
> index ad8e5e7ebf..1954dec9b8 100644
> --- a/qemu-char.c
> +++ b/qemu-char.c
> @@ -2122,6 +2122,8 @@ typedef struct {
> =20
>      /* Protected by the Chardev chr_write_lock.  */
>      OVERLAPPED osend;
> +    /* FIXME: file/console do not finalize */
> +    BOOL skip_free;

Do we really need the glib type, or is bool sufficient?

>  } WinChardev;
> =20
>  #define TYPE_CHARDEV_WIN "chardev-win"
> @@ -2152,6 +2154,10 @@ static void win_chr_free(Chardev *chr)
>  {
>      WinChardev *s =3D WIN_CHARDEV(chr);
> =20
> +    if (s->skip_free) {
> +        return;
> +    }
> +
>      if (s->hsend) {
>          CloseHandle(s->hsend);
>          s->hsend =3D NULL;
> @@ -2432,6 +2438,7 @@ static void qemu_chr_open_win_file(Chardev *chr, =
HANDLE fd_out)
>  {
>      WinChardev *s =3D WIN_CHARDEV(chr);
> =20
> +    s->skip_free =3D true;

Particularly since you assign it the bool true, rather than the glib TRUE=
=2E

With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--AGTp8q1jt7VckM7VsKcsd7wjUHukbg4bt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdpPsAAoJEKeha0olJ0NqAekH/2RtFnz7FYP4buwvckQ0nVSr
CB1PdLB8uboXtH4/3aiKjluTfzVl8XH2FyvALFV7usXNVUBJyIZd0BNZt2EvMvfB
B33UVncdz/fntR8vpkVrQarSbaQ6R7vQOZoNanhiT4+60sSpG4nCCv8rUuzO44MI
jxlpbNTa88e41O82XCrJrLDFu1VGZNKUX2Ebi8n7XmtPSFHDUWrrOHKo4J0m/9Pu
pSscNWWFK3S+/g15quidkZwig1wSbtV+oZ5ZTwpJoWRckVtYFpau7Jt+dOaFvm4q
OWe/tyePUyIyZUQrzxQ8tudUAdH2QmgZ9znCs8ZqmcChSR/G9u2cQC1DqDI8gu8=
=dIBF
-----END PGP SIGNATURE-----

--AGTp8q1jt7VckM7VsKcsd7wjUHukbg4bt--
