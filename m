Received: from eggs.gnu.org ([2001:4830:134:3::10]:38104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gcD-0007Dj-08
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gcA-0007Dn-9n
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6gcA-0007Dg-0n
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:01:58 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399504137.29022.4985100698645275511.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c8abd95-b490-1b71-b467-4f00d6ce121d@redhat.com>
Date: Fri, 5 May 2017 12:01:55 -0500
MIME-Version: 1.0
In-Reply-To: <149399504137.29022.4985100698645275511.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fps9NA2dcMRoxDTPJQbuCjBiJmSLJO1Hm"
Subject: Re: [Qemu-devel] [PATCH 3/5] 9pfs: local: simplify file opening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fps9NA2dcMRoxDTPJQbuCjBiJmSLJO1Hm
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>
Message-ID: <3c8abd95-b490-1b71-b467-4f00d6ce121d@redhat.com>
Subject: Re: [PATCH 3/5] 9pfs: local: simplify file opening
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399504137.29022.4985100698645275511.stgit@bahia.lan>
In-Reply-To: <149399504137.29022.4985100698645275511.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 09:37 AM, Greg Kurz wrote:
> All paths in the virtfs directory now start with "./" (except the virtf=
s
> root itself which is exactly ".").
>=20
> We hence don't need to skip leading '/' characters anymore, nor to hand=
le
> the empty path case. Also, since virtfs will only ever be supported on
> linux+glibc hosts, we can use strchrnul() and come up with a much simpl=
ier
> code to walk through the path elements. And we don't need to dup() the
> passed directory fd.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    5 -----
>  hw/9pfs/9p-util.c  |   26 ++++++++++----------------
>  2 files changed, 10 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 92262f3c3e37..bb6e296df317 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -54,11 +54,6 @@ int local_open_nofollow(FsContext *fs_ctx, const cha=
r *path, int flags,
>  {
>      LocalData *data =3D fs_ctx->private;
> =20
> -    /* All paths are relative to the path data->mountfd points to */
> -    while (*path =3D=3D '/') {
> -        path++;
> -    }

Is it worth adding any assert()s in place of the deleted code?

Otherwise looks okay.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fps9NA2dcMRoxDTPJQbuCjBiJmSLJO1Hm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDLADAAoJEKeha0olJ0Nqqc8H/jhf38LAHCZzYicm+s0yBWDC
3xNYJkuAXX5cjKTzule+obcuPK/TrpluKXaKWJNHfIzZgMniS/ihO+1WzROBbn6I
a9Pnug7UsPckM3XLXQ48B09/USHvhkgZlIxk/zu5fV8prLu6gbnQkYIzUQf9SwKq
BWIiJwDKSj56Iy+UJm83XGQpBp9VnmdaB+b2GByGQ+mxnphE4+I92Mnuxe1JLvtK
l8EW05gLyjfOmd8haj3gGbtksvSv3D9KBsGLELJtWitUoUxJN6Or+pQHs9k7tfQx
M8QW1m12F7QwtOKMB4JtOGYrNB4X5ZQI2KkV+pif+Iwz2JBOi2LquXwtktCiZaE=
=HotE
-----END PGP SIGNATURE-----

--fps9NA2dcMRoxDTPJQbuCjBiJmSLJO1Hm--
