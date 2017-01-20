Received: from eggs.gnu.org ([2001:4830:134:3::10]:55330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUb7q-0005YG-Es
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUb7p-0001bj-Fg
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:29:14 -0500
References: <1484905570-10520-1-git-send-email-pl@kamp.de>
	<1484905570-10520-2-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a67a7cd-6303-3b44-4542-6f9472e3abde@redhat.com>
Date: Fri, 20 Jan 2017 09:29:04 -0600
MIME-Version: 1.0
In-Reply-To: <1484905570-10520-2-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Co31sWV5Muf7WTtw1S6knt52Jp0t95wrK"
Subject: Re: [Qemu-devel] [PATCH 1/2] block/nfs: fix NULL pointer
 dereference in URI parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Co31sWV5Muf7WTtw1S6knt52Jp0t95wrK
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com,
 jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <9a67a7cd-6303-3b44-4542-6f9472e3abde@redhat.com>
Subject: Re: [PATCH 1/2] block/nfs: fix NULL pointer dereference in URI
 parsing
References: <1484905570-10520-1-git-send-email-pl@kamp.de>
 <1484905570-10520-2-git-send-email-pl@kamp.de>
In-Reply-To: <1484905570-10520-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 03:46 AM, Peter Lieven wrote:
> parse_uint_full wants to put the parsed value into the
> variabled passed via its second argument which is NULL.

s/variabled/variable/

>=20
> Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/nfs.c b/block/nfs.c
> index a564340..baaecff 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -108,12 +108,13 @@ static int nfs_parse_uri(const char *filename, QD=
ict *options, Error **errp)
>      qdict_put(options, "path", qstring_from_str(uri->path));
> =20
>      for (i =3D 0; i < qp->n; i++) {
> +        unsigned long long val;
>          if (!qp->p[i].value) {
>              error_setg(errp, "Value for NFS parameter expected: %s",
>                         qp->p[i].name);
>              goto out;
>          }
> -        if (parse_uint_full(qp->p[i].value, NULL, 0)) {
> +        if (parse_uint_full(qp->p[i].value, &val, 0)) {

Reviewed-by: Eric Blake <eblake@redhat.com>

>              error_setg(errp, "Illegal value for NFS parameter: %s",

Not your fault, but I'm always wary of "Illegal" in an error message -
the user isn't breaking any laws :)  Better is "Invalid", but such a
cleanup can be a separate tree-wide patch for qemu-trivial, if someone
wants it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Co31sWV5Muf7WTtw1S6knt52Jp0t95wrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgizAAAoJEKeha0olJ0Nq/fQH/1jkOu4etHgUCPLovTiTSJNI
1042jWFvt9oV619Z5LxsMGGYr2mqiOg+ZyKQjjkKOCdVP+sDkP0zexIz5ZwLpb8N
+M40+0qn8do6qmrldYM3IdwducSJpIE0OCWHaXnSweyhssKpMt/mYHpVvHpHwcwy
UxK6wdNgY5AJfcM9goZfFjjrmYOV5wy62sGij6514UVovSwiIEni7ZNgWxwgd+9r
D9KIaUcIUbtOc9LQ6YnPeNUrll+2Ji1Za/OXf+GTsUmDz3UXSulB9qjiie/bHIq6
ULnFxFEHSDPl0ldpMUPru94mqsje8iYbXySXE4IYLYZu3WUW55++ZP2ZifRn4K4=
=85H6
-----END PGP SIGNATURE-----

--Co31sWV5Muf7WTtw1S6knt52Jp0t95wrK--
