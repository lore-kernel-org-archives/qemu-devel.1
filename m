Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxZP-0005XA-7L
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxZL-0004bl-9L
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:38:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQxZL-0004bW-0l
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:38:35 -0500
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
Date: Tue, 10 Jan 2017 08:38:27 -0600
MIME-Version: 1.0
In-Reply-To: <148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PubOgvmSkeguoME6dOvb5HJmpcb5L3H31"
Subject: Re: [Qemu-devel] [PATCH 1/7] 9pfs: restrict open to regular files
 and directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PubOgvmSkeguoME6dOvb5HJmpcb5L3H31
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Message-ID: <b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
Subject: Re: [PATCH 1/7] 9pfs: restrict open to regular files and directories
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 08:32 AM, Greg Kurz wrote:
> It really does not make sense for the 9P server to open anything else b=
ut
> a regular file or a directory.
>=20
> Malicious code in a guest could for example create a named pipe, associ=
ate
> it to a valid fid and pass it to the server in a RLOPEN message. This w=
ould
> cause QEMU to hang in open(), waiting for someone to open the other end=
 of
> the pipe.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index fa58877570f6..edd7b97270e3 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1462,7 +1462,7 @@ static void coroutine_fn v9fs_open(void *opaque)
>              goto out;
>          }
>          err +=3D offset;
> -    } else {
> +    } else if (S_ISREG(stbuf.st_mode)) {
>          if (s->proto_version =3D=3D V9FS_PROTO_2000L) {

TOCTTOU race.  You are checking the stat() results and only then calling
open(), rather than calling open() first and validating fstat().  That
means the guest can STILL cause you to open() a pipe by changing the
file type in between the stat and the open.

I think you need to rework this patch to open() first, then validate
(closing the fd if necessary); the open can be done with O_NONBLOCK to
avoid hanging on a pipe.  Yes, that's more annoying, but that's life
with TOCTTOU races.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PubOgvmSkeguoME6dOvb5HJmpcb5L3H31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdPHjAAoJEKeha0olJ0NqEkkH/2Rwe71ug3RPsKvaNIqXuJ40
Cgo7KAwWtaJIwRwfmGtuhcFg2rLXO4fEfzUVTk2M2spEcFAKJQPRX1jO1uhW7YRB
12rSPVEntEJajO+d3kQ3i7TblevE5bkKIlFQHq3d8FuM7I9mIPQyA8LYy9r4B1v8
V735tFJh4/fe0l/opaOPYkVF/GAJN3p5MeXchf+CMOjIuIl2EJnQJE6XyfqSqXcw
HUESUNHa/exvUUARQxmNxiZ9wFS/Fx5BYzKR+8B35beBDnr4OrqC8sXRDyumWpkl
2o7Sjpz4beG3KwHm3w8g27TLziCPWpKCV/q8j7xQIhBLuik2cJI2adZ9XFokubA=
=wlYa
-----END PGP SIGNATURE-----

--PubOgvmSkeguoME6dOvb5HJmpcb5L3H31--
