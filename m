Received: from eggs.gnu.org ([2001:4830:134:3::10]:38399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDYBn-0008O1-NC
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDYBi-0000IG-5M
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDYBh-0000H8-SM
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:27:02 -0400
References: <6ace537dec6122d5bd07e600b9ab9b6c@whitewinterwolf.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b6ca5dc-724e-49b0-1665-80f7aa82f584@redhat.com>
Date: Wed, 24 May 2017 10:26:58 -0500
MIME-Version: 1.0
In-Reply-To: <6ace537dec6122d5bd07e600b9ab9b6c@whitewinterwolf.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hDFdgXRsFbMfGpbBrf6m6WOl9dDPq9Q1V"
Subject: Re: [Qemu-devel] Monitor file path length limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon <qemu.bugs@whitewinterwolf.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDFdgXRsFbMfGpbBrf6m6WOl9dDPq9Q1V
From: Eric Blake <eblake@redhat.com>
To: Simon <qemu.bugs@whitewinterwolf.com>, qemu-devel@nongnu.org
Message-ID: <2b6ca5dc-724e-49b0-1665-80f7aa82f584@redhat.com>
Subject: Re: [Qemu-devel] Monitor file path length limitation
References: <6ace537dec6122d5bd07e600b9ab9b6c@whitewinterwolf.com>
In-Reply-To: <6ace537dec6122d5bd07e600b9ab9b6c@whitewinterwolf.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 10:16 AM, Simon wrote:
> Hello,
>=20
> It seems that the monitor file path length is limited to about 100
> characters (107 to be precise).

Welcome to the joy of Unix socket (AF_UNIX) files.  The kernel imposes a
hard length limit on sockaddr_un.sun_path[] (see 'man 7 unix') - and it
is indeed 107 characters plus a NUL terminator.

> -monitor
> 'unix:/home/user/vmtools/test/out/foobar.iso/foobar.iso_A/foobar.iso_B/=
foobar.iso_C/foobar.iso_D/foobar.iso_E/monitor.sock,server,nowait'
>=20
>=20
> With this command Qemu does not produce any warning or error message bu=
t
> create the socket file "mon" instead of the expected "monitor.sock".

Ideally, qemu should be telling you your path is too long to be created
as a unix socket, and failing up front, rather than silently truncating
and perhaps doing the wrong thing.

> Is there a clean way to work around this limitation?

Don't use longer path names than the kernel supports.

>=20
> As a side-note, is there any technical reason for such a limitation?

Yes, but you'll have to ask kernel folks for the reason.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hDFdgXRsFbMfGpbBrf6m6WOl9dDPq9Q1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJaZDAAoJEKeha0olJ0NqMKkH/jxeM2eBKahfXh0YTiMssjl0
N3fcT38GQti5THPE3w+rqCwrUAELSY8lY1hSFm3zN3rXhfNodLCB2U1rtUgvuZaj
6aj08i152bA8MurgBSFbNYUkci48ws8hh1SH3NmP4kZf4B90qZ6PeEZiUdS3j18X
gJcpflaxBgzLA+8Dd39Lq9TFB+0jdec9/M2XR2EWuE/GIYCUcJh8f9sGrnhZ+9/j
nEmzDG48+939BLscNjzBrrfUI0cWLJLm34+9IIAlDRv9pcxYUbrJWZ7p5HWBbHWs
SxaXRTiTb8omtK/xOTKN+S3QQ/m9ogC3aJbdo+kPLLK/Iz/UU3VnH5v9LKJnEZw=
=5rBg
-----END PGP SIGNATURE-----

--hDFdgXRsFbMfGpbBrf6m6WOl9dDPq9Q1V--
