Received: from eggs.gnu.org ([2001:4830:134:3::10]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBqEt-0006YX-LY
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBqEq-0002HA-ID
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:19:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBqEq-0002H1-88
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:19:12 -0400
References: <149520423435.7495.2756710723268429379.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea69f777-6b99-1e39-7e5b-4decde958769@redhat.com>
Date: Fri, 19 May 2017 17:19:10 -0500
MIME-Version: 1.0
In-Reply-To: <149520423435.7495.2756710723268429379.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lNSAkUe34FOvapkmMWW8FHl42FPx2XAVA"
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix virtfs-proxy-helper cwd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lNSAkUe34FOvapkmMWW8FHl42FPx2XAVA
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Message-ID: <ea69f777-6b99-1e39-7e5b-4decde958769@redhat.com>
Subject: Re: [PATCH] fsdev: fix virtfs-proxy-helper cwd
References: <149520423435.7495.2756710723268429379.stgit@bahia.lan>
In-Reply-To: <149520423435.7495.2756710723268429379.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 09:30 AM, Greg Kurz wrote:
> Since chroot() doesn't change the current directory, it is indeed a goo=
d
> practice to chdir() to the target directory and then then chroot(), or
> to chroot() to the target directory and then chdir("/").
>=20
> The current code does neither of them actually. Let's go for the latter=
=2E
>=20
> This doesn't fix any security issue since all of this takes place befor=
e
> the helper begins to process requests.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  fsdev/virtfs-proxy-helper.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

You are correct that failing to sanitize the current working directory
alongside a chroot() can lead to escaped access outside of the new
smaller root.

Aside: chdir() is annoying in multi-threaded apps - it is global state,
rather than thread-local.  A multi-threaded app should therefore either
never change the current working directory, or else never rely on the
current working directory.  But if I'm not mistaken, virtfs-proxy-helper
is an independent helper app, not qemu proper, so the use of
chdir/chroot is not affecting other threads.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lNSAkUe34FOvapkmMWW8FHl42FPx2XAVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZH29eAAoJEKeha0olJ0NqvCsH/A5UFrM+BKQaDF+Mijm89Jnp
gJZA3Q1Qjv8wVqhIhjN5oRZ63OjrnEli3kexgv9UfiI+LKmDfkznY9gbAN4YRtgj
kHOPRd8mxFSXZwfpxmNjFR7Z2Jyt6GOzNVfL85BNt3j5gcnXg0zZRJg/Hw7R9J7/
44XCtQHSaLyIsXPlNm+9sPoGwrrDZZpr7OI7iSiGdPQTRiWz9vbEe2/psN/MtmWa
mlGsdFgjNc0wERkNXjAsQP6kIxZr8GiuzUzA8PyXwx18R/ldv83xy9HjYbGczz27
IdWPrvLMSd5G6km4IcbeMMqa8P+a5FnMNABLXqzNZXXI0YnVzJujwnAeypUJlG0=
=S4lB
-----END PGP SIGNATURE-----

--lNSAkUe34FOvapkmMWW8FHl42FPx2XAVA--
