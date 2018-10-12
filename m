Received: from eggs.gnu.org ([2001:4830:134:3::10]:36510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAzGy-0005XC-UX
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAzGw-0006k9-A0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:22:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAzGw-0006je-0u
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:22:38 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-7-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4732da2-c0d2-c6d9-fac4-1969758b1ff9@redhat.com>
Date: Fri, 12 Oct 2018 17:22:34 +0200
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-7-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Otld3wEMfhRfEdL1goXrg6iNLGhBQfODV"
Subject: Re: [Qemu-devel] [PATCH v3 6/8] block: dump_qlist() may dereference
 a Null pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Otld3wEMfhRfEdL1goXrg6iNLGhBQfODV
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Message-ID: <a4732da2-c0d2-c6d9-fac4-1969758b1ff9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/8] block: dump_qlist() may dereference a
 Null pointer
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
 <1535739372-24454-7-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-7-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.08.18 20:16, Liam Merwick wrote:
> A NULL 'list' passed into function dump_qlist() isn't correctly
> validated and can be passed to qlist_first() where it is dereferenced.
>=20
> Given that dump_qlist() is static, and callers already do the right
> thing, just add an assert to catch future potential bugs.
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qapi.c | 2 ++
>  1 file changed, 2 insertions(+)

I don't disagree, but I don't see why the program just wouldn't crash if
someone passed a NULL pointer.  And I don't quite see why anyone would
pass a NULL pointer.

Of course it's reasonable to just add an assert() to reinforce the
contract; but we have so many functions that just take a pointer that
they assume to be non-NULL and then immediately dereference it.  Nearly
every blk_* function takes a BlockBackend that is always assumed to be
non-NULL, for instance, and I don't really want to put assert()s into
all of them.  Or another example: dump_qobject() and dump_qdict() do
exactly the same -- if we added an assertion in dump_qlist(), we would
actually have to add the very same assertions there, too.

So I don't really object this patch (because it's not wrong), but I
don't think it's very useful.

Max

> diff --git a/block/qapi.c b/block/qapi.c
> index c66f949db839..e81be604217c 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -740,6 +740,8 @@ static void dump_qlist(fprintf_function func_fprint=
f, void *f, int indentation,
>      const QListEntry *entry;
>      int i =3D 0;
> =20
> +    assert(list);
> +
>      for (entry =3D qlist_first(list); entry; entry =3D qlist_next(entr=
y), i++) {
>          QType type =3D qobject_type(entry->value);
>          bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTY=
PE_QLIST);
>=20



--Otld3wEMfhRfEdL1goXrg6iNLGhBQfODV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAvDoACgkQ9AfbAGHV
z0Aupgf/RfBHVhYB0loXNZjA1DnIbGQeUTvAdZCMotO7lNnNWhEsbUu/NjuuzVLO
CIw9et4E0HWTH1sGR1b9J1f4TeiOwreJhFKSYBu9kFxWg8Jf6QrMU1RWQXHd5xhO
gBnvvsTiLOY59uWuO6Vi89ssqPcj+cTXMC401OwlVT/X1wlSSxNM3nYwWepURPW+
wOhZXDau2KGj5QcIAB6UORV0VaJ7c2F2qGsDE0iywOunaIzEbk2cej/zoqfTl3A1
2aC4skVk+CgLVz1qWYQEsFWz/7RkLqVNRo3lEjtoNmgupfdS/0doZ+l3Pz0sSLgl
PO3uYpBh1zaRTmLuUoYp2LfyogfF+g==
=Q1st
-----END PGP SIGNATURE-----

--Otld3wEMfhRfEdL1goXrg6iNLGhBQfODV--
