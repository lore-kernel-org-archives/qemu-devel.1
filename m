Received: from eggs.gnu.org ([2001:4830:134:3::10]:59937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjriX-00066Q-VV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjriW-0000Nh-QV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:14:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjriW-0000NP-Hl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:14:12 -0500
References: <148856193073.554.6631259860971664030.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
Date: Fri, 3 Mar 2017 12:14:10 -0600
MIME-Version: 1.0
In-Reply-To: <148856193073.554.6631259860971664030.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g5JALjRvHUCcnLQIMEG6ieHQU3G0pmnXd"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g5JALjRvHUCcnLQIMEG6ieHQU3G0pmnXd
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
Subject: Re: [PATCH] 9pfs: fix vulnerability in openat_dir() and
 local_unlinkat_common()
References: <148856193073.554.6631259860971664030.stgit@bahia>
In-Reply-To: <148856193073.554.6631259860971664030.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 11:25 AM, Greg Kurz wrote:
> We should pass O_NOFOLLOW otherwise openat() will follow symlinks and m=
ake
> QEMU vulnerable.
>=20
> O_PATH was used as an optimization: the fd returned by openat_dir() is =
only
> passed to openat() actually, so we don't really need to reach the under=
lying
> filesystem.
>=20
> O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() wil=
l
> return a fd, forcing us to do some other syscall to detect we have a
> symlink. Also, O_PATH doesn't exist in glibc 2.13 and older.

But the very next use of openat(fd, ) should fail with EBADF if fd is
not a directory, so you don't need any extra syscalls.  I agree that we
_need_ O_NOFOLLOW, but I'm not yet convinced that we must avoid O_PATH
where it works.

I'm in the middle of writing a test program to probe kernel behavior and
demonstrate (at least to myself) whether there are scenarios where
O_PATH makes it possible to open something where omitting it did not,
while at the same time validating that O_NOFOLLOW doesn't cause problems
if a symlink-fd is returned instead of a directory fd, based on our
subsequent use of that fd in a *at call.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--g5JALjRvHUCcnLQIMEG6ieHQU3G0pmnXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubJyAAoJEKeha0olJ0Nq5TIH/iE7MTmNY33Us3PF9UoiDiIr
N01tzyCpgChrM2EPH6OY2auzP1HIBMzfNz/mA5rpqZTRrsu64jAZNQyvql25Hbzf
jPaqT+0Z1KDWjLdsXrcr2Y+UURKJekQXfMw40eC30sfNnffJgJmr7uqAwGPl3JYm
cO1vnogyojMQLpQ1H9QXtQjq3t1uBfa3yZAhr8G/cuU4WThaKrhF9PMEB9UqM26D
AEoYPBQ8jBBYppXWZ5KaSX+wsPJxiZuY5FLVPeR8TG532bXkOb9Lv9s2RpgCWOKk
MlRyqrjBHKoM9uWNhHDz/4AiwLwbQiPqaytlgEzfQjEelR9cOHEkFacSsOX90dU=
=+Vnu
-----END PGP SIGNATURE-----

--g5JALjRvHUCcnLQIMEG6ieHQU3G0pmnXd--
