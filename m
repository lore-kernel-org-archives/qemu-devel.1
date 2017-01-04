Received: from eggs.gnu.org ([2001:4830:134:3::10]:44551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOs3M-0001T2-Lh
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOs3J-0008EL-FY
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOs3J-0008Dc-6e
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:20:53 -0500
References: <356610769.5581597.1483558443751.JavaMail.zimbra@oxygem.tv>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c44e2bb-f7b5-36a9-eed0-ba9a3bd7ed21@redhat.com>
Date: Wed, 4 Jan 2017 14:20:49 -0600
MIME-Version: 1.0
In-Reply-To: <356610769.5581597.1483558443751.JavaMail.zimbra@oxygem.tv>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="slmRn25FoxaidtOXxFUjkJpMkVTD7qh2R"
Subject: Re: [Qemu-devel] drive_mirror to nbd with tls ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--slmRn25FoxaidtOXxFUjkJpMkVTD7qh2R
From: Eric Blake <eblake@redhat.com>
To: Alexandre DERUMIER <aderumier@odiso.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Daniel P. Berrange"
 <berrange@redhat.com>
Message-ID: <7c44e2bb-f7b5-36a9-eed0-ba9a3bd7ed21@redhat.com>
Subject: Re: [Qemu-devel] drive_mirror to nbd with tls ?
References: <356610769.5581597.1483558443751.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <356610769.5581597.1483558443751.JavaMail.zimbra@oxygem.tv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 01:34 PM, Alexandre DERUMIER wrote:
> Hi,
>=20
> I'm currently trying to implemented drive_mirror to nbd with tls.
>=20
> It's working fine without tls,  but with tls enabled on target,
>=20
> I don't known how to pass tls-creds to drive_mirror nbd uri ? =20

Unfortunately, drive-mirror is not set up for structured specifications
(it can only take a URI), and at the same time, NBD requires the use of
structured specification (along the lines of 'blockdev-add' in qemu 2.8)
to specify TLS parameters.  In other words, it's intentional that there
is no NBD URI that you can write that allows TLS.  So for any earlier
versions of qemu, you're stuck.

But for qemu 2.8, we have the new blockdev-mirror (well, that command
was added in qemu 2.6, but you couldn't use NBD through blockdev-add
back then); so the correct way is to create a BDS that targets the NBD
server using 'blockdev-add' to specify the NBD parameters, then use
blockdev-mirror to mirror to that BDS.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--slmRn25FoxaidtOXxFUjkJpMkVTD7qh2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbVkhAAoJEKeha0olJ0Nq4XcH/ROC4sPjqp7lvmmUplBmMmyh
L0qAH9/xCCEy3S4uys5i1kTwNDoHCaRPTvlWHS2yFZWZdIZ6IwdZXSmPMyYgxxNI
8O8756O1d8qVR9unPZN1Tdw49BFRCeyieaFcOM9uMvxktKBTfsXMSyT1y5aFT0FX
O6TXM8Z1n2PM78EEs9PCrVJ+YbTP+juaGxpNBxl7GVSps7PPF+Q1SkjL/KVRCXkt
mLzfkVpWSaIcVKWnZUEy+3FdWNBoNP/aH96Yzxt5g+Z/aWqMP0L/WGuDIO5AbSAl
0X3DrCZu2MrK1XPCqOm5OCFIl0PsWAib91R2/O/0KvgVP352toCELvAM5JWrHZ8=
=nSW0
-----END PGP SIGNATURE-----

--slmRn25FoxaidtOXxFUjkJpMkVTD7qh2R--
