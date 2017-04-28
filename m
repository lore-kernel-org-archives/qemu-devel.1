Received: from eggs.gnu.org ([2001:4830:134:3::10]:49278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d479D-0006MM-NE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d479C-0008Kk-Cx
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:45:27 -0400
References: <149336968270.4566.7770744042249761246.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9833cd8-2f64-21d5-3bfc-9d91c178b8aa@redhat.com>
Date: Fri, 28 Apr 2017 09:45:23 -0500
MIME-Version: 1.0
In-Reply-To: <149336968270.4566.7770744042249761246.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AxDJ4ooQIuEKxjcp8gvlwBUXXmV4JdnrX"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: local: fix unlink of alien files in
 mapped-file mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxDJ4ooQIuEKxjcp8gvlwBUXXmV4JdnrX
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <f9833cd8-2f64-21d5-3bfc-9d91c178b8aa@redhat.com>
Subject: Re: [PATCH] 9pfs: local: fix unlink of alien files in mapped-file
 mode
References: <149336968270.4566.7770744042249761246.stgit@bahia.lan>
In-Reply-To: <149336968270.4566.7770744042249761246.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 03:54 AM, Greg Kurz wrote:
> When trying to remove a file from a directory, both created in non-mapp=
ed
> mode, the file remains and EBADF is returned to the guest.
>=20
> This is a regression introduced by commit "df4938a6651b 9pfs: local:
> unlinkat: don't follow symlinks" when fixing CVE-2016-9602. It changed =
the
> way we unlink the metadata file from
>=20
>     ret =3D remove("$dir/.virtfs_metadata/$name");
>     if (ret < 0 && errno !=3D ENOENT) {
>          /* Error out */
>     }
>     /* Ignore absence of metadata */
>=20
> to
>=20
>     fd =3D openat("$dir/.virtfs_metadata")
>     unlinkat(fd, "$name")

Yep, failure to check for errors. Is this something Coverity can flag?

>=20
> We just need to check the return of openat() and ignore ENOENT, in orde=
r
> to restore the behaviour we had with remove().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index f3ebca4f7a56..4e9823b08e74 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -983,12 +983,20 @@ static int local_unlinkat_common(FsContext *ctx, =
int dirfd, const char *name,
>           * .virtfs_metadata directory.
>           */
>          map_dirfd =3D openat_dir(dirfd, VIRTFS_META_DIR);
> -        ret =3D unlinkat(map_dirfd, name, 0);
> -        close_preserve_errno(map_dirfd);
> -        if (ret < 0 && errno !=3D ENOENT) {
> +        if (map_dirfd !=3D -1) {
> +            ret =3D unlinkat(map_dirfd, name, 0);
> +            close_preserve_errno(map_dirfd);
> +            if (ret < 0 && errno !=3D ENOENT) {
> +                /*
> +                 * We didn't had the .virtfs_metadata file. May be fil=
e created
> +                 * in non-mapped mode ?. Ignore ENOENT.

This is code motion (in fact, the second time you've moved this
comment), but you might as well fix the poor grammar while you are here:

We didn't have the .virtfs_metadata file. Maybe the file was created in
non-mapped mode? Ignore ENOENT.

> +                 */
> +                goto err_out;
> +            }
> +        } else if (errno !=3D ENOENT) {
>              /*
> -             * We didn't had the .virtfs_metadata file. May be file cr=
eated
> -             * in non-mapped mode ?. Ignore ENOENT.
> +             * We didn't had the parent .virtfs_metadata directory. Ma=
y be
> +             * file created in non-mapped mode ?. Ignore ENOENT.

And certainly fix the grammar of your new comment (no need to
copy-and-paste the poor wording):

We didn't have the parent .virtfs_metadata directory. Maybe the file was
created in non-mapped mode? Ignore ENOENT.

But the code fix is correct, and a comment wording change is minor
enough that you can add my:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AxDJ4ooQIuEKxjcp8gvlwBUXXmV4JdnrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA1WDAAoJEKeha0olJ0NqEqEH/igXWbk2HqAi+ZDjhlZknOW0
lyXpPcuSLvX1GlUemQgHk0/uKgoi9hSEq7ogUakD3swrnaXZM9Fwt+3of92ni0f0
H2rqEH2CrFG3nlwJa87NdoKwNo1n8B8+ByU3FFLoGm8nCd6wu7q6C39j0QpMdBIA
IqwJucPswwQT5s09NtS1lT90Y/eNMNseOIYY8cP+ny8kvzSX9f6X52EZ6TxsoRGx
Mrlz5FU8e1WYbhicgOOoWfSbQSMwkK1werYY3cW4WV99+zZ4u5PpT9K9tM1KyRVv
nklk7/SmtJyjC9PRPf2E33svCzXzNf8KwtsdeY88ID0Oua1x2YDCwy60haCdLho=
=w2Vh
-----END PGP SIGNATURE-----

--AxDJ4ooQIuEKxjcp8gvlwBUXXmV4JdnrX--
