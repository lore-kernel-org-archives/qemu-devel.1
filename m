Received: from eggs.gnu.org ([2001:4830:134:3::10]:47553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0XQ-0005Yf-GD
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0XK-0005M3-N3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cF0XK-0005Lh-EJ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:23:06 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
Date: Thu, 8 Dec 2016 09:23:01 -0600
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6K6hD5gPDnGV2EUDPDm5hhlDHkJkvbph7"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6K6hD5gPDnGV2EUDPDm5hhlDHkJkvbph7
From: Eric Blake <eblake@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Max Reitz
 <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Message-ID: <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
 <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 08:28 PM, Gonglei (Arei) wrote:

>> As far as I'm aware, other projects usually have a special memset
>> variation for doing this. That is because compilers may choose to
>> "optimize" memset(p, ...) + free(p) to just the free(p). Having a
>=20
> Actually, I googled this, but I didn't find a definite answer. And
>=20
> The Linux kernel uses kzfree instead of memset + kfree (mm/slab_common.=
c).

If we're worried about cleaning things without allowing the compiler a
chance to optimize, then writing our own qemu_zfree() wrapper may indeed
make sense.  But that won't cover the case in Daniel's earlier patch
(referenced elsewhere in this thread), as that was zeroizing stack
memory (before it went out of scope) rather than heap memory (before
free).  So you'd still need some sort of 'write this memory no matter
what' primitive that would be directly usable on stack memory and
indirectly used as part of the qemu_zfree() wrapper.

But I wouldn't worry about it for now, unless someone proves we actually
have a compiler optimizing away the cleanups.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6K6hD5gPDnGV2EUDPDm5hhlDHkJkvbph7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSXrVAAoJEKeha0olJ0NqULsIAJg+/zEce1r4CAkd32pR3LMW
Y0IY1Dc/z345ibuDFv/E3eBK1IHNRn31oda/9AZXg38nbyD3rjBTaBf/x5nBIb41
PvZoffBGrMFyaAtf8PvAZLw0SQioAquPcHA0J4nsDGA7M9sTqjjhTRtmC9Fzqim9
+ASXVIIOlOagFPOGeocJYRDgY63qjhrWA9RV68plhwVsDOb9MpJqRB1JfnwFd0ZA
LBt447VwWPzLrCcpXaoVGejEatqHhEqeeMy8qA8Ggi1n8v88Lkte4wvtCTL1ceTt
Azm1p1SSYNRDxxMXBGLtEZM04b+vZhHte6+SbGtELQ350SFG92IIh7UqWS1MpAM=
=xNVH
-----END PGP SIGNATURE-----

--6K6hD5gPDnGV2EUDPDm5hhlDHkJkvbph7--
