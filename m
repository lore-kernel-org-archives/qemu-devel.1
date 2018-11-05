Received: from eggs.gnu.org ([2001:4830:134:3::10]:59008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSQo-0004y3-1T
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 19:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSQn-0007nF-Bg
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 19:07:50 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-7-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3037dd84-e7b9-b786-4594-107ae737af2c@redhat.com>
Date: Mon, 5 Nov 2018 01:07:29 +0100
MIME-Version: 1.0
In-Reply-To: <1539981546-10596-7-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1b7hK4RbWsTJGTOWSe6zwXiszGF83XndR"
Subject: Re: [Qemu-devel] [PATCH v4 6/8] block: dump_qlist() may dereference
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1b7hK4RbWsTJGTOWSe6zwXiszGF83XndR
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <3037dd84-e7b9-b786-4594-107ae737af2c@redhat.com>
Subject: Re: [PATCH v4 6/8] block: dump_qlist() may dereference a Null pointer
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
 <1539981546-10596-7-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-7-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.18 22:39, Liam Merwick wrote:
> A NULL 'list' passed into function dump_qlist() isn't correctly
> validated and can be passed to qlist_first() where it is dereferenced.
>=20
> Given that dump_qlist() is static, and callers already do the right
> thing, just add an assert to catch future potential bugs (plus the
> added benefit of suppressing a warning from a static analysis tool
> and removing this noise will help us better find real issues).

But can't you fix the tool?  My opinion is still that large parts of our
code do not assert that some parameter is not NULL, and I think it isn't
a good idea to make them assert that.  I don't know what makes this
function special, and I wonder why it is special to your tool -- as I've
said in the last version, dump_qdict() is basically the same in this
regard.  I wonder why your tool doesn't mind that.

Can you not whitelist something as false positives?  I know we have a
lot of those in Coverity, and we just mark them as such, and that's it.

Finally, one could argue that the nonnull GCC function attribute would
be a better fit, actually.

But overall, I just don't think it's a good idea to start changing the
code to accommodate for false positives in static analyzers, because in
my experience the number of false positives only rises with time.

Max

> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qapi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
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



--1b7hK4RbWsTJGTOWSe6zwXiszGF83XndR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvficIACgkQ9AfbAGHV
z0DRwggAscGHLVjWu9ziktfuPCemBLbChpnY8+SCuF9CXz+tA1zY88+F+J0uj4k5
PQZ9THKhoam9j7llsoN5XP6S+0D2p4+TNqPp2onMVl+ZR4RHffd9W2gl+i3hTh7t
+R4oYkF8o6ujcO3Is3sHaOe8YvdxIB8+3fQ6F2aDTKrJfm4TIlvMX763DiXZGObi
/g7gioZXDD/s3oHQSG/iQwsT4UcZ3BXq7dBxNzqXucQuARkT1zyqDKYBpQ3mXGMe
rh1ZYBs+NE2OjPEC1kMYIZ3FBT+LglJqD6USTDAf1ChOra7mknHrmLRI0DbbqUax
JG9pmm0ZqfYv2wBWrVROGbfLEGU+4w==
=VNbK
-----END PGP SIGNATURE-----

--1b7hK4RbWsTJGTOWSe6zwXiszGF83XndR--
