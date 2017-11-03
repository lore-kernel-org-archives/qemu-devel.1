Received: from eggs.gnu.org ([2001:4830:134:3::10]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAkiA-0007nr-A9
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 18:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAki7-0002K5-0r
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 18:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAki6-0002J9-Mk
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 18:45:10 -0400
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0e4e71e-981e-eec1-c996-74655079a860@redhat.com>
Date: Fri, 3 Nov 2017 17:45:07 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k7Xm3A4Wv3ew0sl6OGE4v4xJ9BftF1Wvu"
Subject: [Qemu-devel] structured reply behavior for read of 0 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, nbd list <nbd@other.debian.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k7Xm3A4Wv3ew0sl6OGE4v4xJ9BftF1Wvu
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 nbd list <nbd@other.debian.org>
Message-ID: <d0e4e71e-981e-eec1-c996-74655079a860@redhat.com>
Subject: structured reply behavior for read of 0 bytes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As currently written, structured reply is documented as:

> NBD_REPLY_TYPE_OFFSET_DATA (1)
>=20
> This chunk type is in the content chunk category. length MUST be at lea=
st 9. It represents the contents of length - 8 bytes of the file, startin=
g at the absolute offset from the start of the export.

which implies that the data size must be non-zero. But clients can
request a read of size 0 (the spec doesn't forbid it, but neither does
it define special semantics for it), and the existing qemu
implementation as of qemu commit f140e300 sends
NBD_REPLY_TYPE_OFFSET_DATA with length of 8 and no data payload if the
client requests a 0-byte read.  Should we specifically allow this
particular answer, or should a 0-length read be answered solely by
NBD_REPLY_TYPE_NONE, meaning that qemu's current behavior needs a tweak?
 Either way, I probably need another tweak to the NBD spec for
structured reads.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k7Xm3A4Wv3ew0sl6OGE4v4xJ9BftF1Wvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln88XMACgkQp6FrSiUn
Q2q5YQf/SJKaFo+1K0uWaA06GpQeajT5uz+rPC4hRKnE/E11DLJdFq3k7f6DL3Pw
AY8ScLdoxQitcJSD2pPR3mvButVpl0dJcLwwYGyegKvqDV0k0c1FScDrw/L5Al0v
PZSu4k+rOrPjUdYya8XEkeP3slNg4COtlpvVWtFIcvnBughjWboqbW/qCIBfs27u
bZX1DdSz06db4Rki5/s9dSv/dg4Ncjke3E2c9CuTURzBAj3ckVZK/nsUiiBXD9x0
3HMJa/Pf6L72tgJYRLusAAcSFI0bDcdvdRM/S5TLYVIGBHkimQSIaUgdgP0z/JHV
0zHTmI+F8vRaGkViTN6rS8JIFfDJBw==
=bWp/
-----END PGP SIGNATURE-----

--k7Xm3A4Wv3ew0sl6OGE4v4xJ9BftF1Wvu--
