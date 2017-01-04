Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsQh-0006QZ-2G
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsQg-0003Zx-87
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:45:03 -0500
References: <586CB62C.6080504@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7c4fd91-1374-7371-1ff9-533a8e916f2a@redhat.com>
Date: Wed, 4 Jan 2017 14:44:53 -0600
MIME-Version: 1.0
In-Reply-To: <586CB62C.6080504@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nV93M8lNRrRFfDtiVIsWPNAFBBwL5kMUH"
Subject: Re: [Qemu-devel] NBD handshake may block qemu main thread when
 socket delays or has packet loss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Fangyi (C)" <eric.fangyi@huawei.com>, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com
Cc: wu.wubin@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, subo7@huawei.com, lina.lulina@huawei.com, "jiangxiaoqing (C)" <sochin.jiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nV93M8lNRrRFfDtiVIsWPNAFBBwL5kMUH
From: Eric Blake <eblake@redhat.com>
To: "Fangyi (C)" <eric.fangyi@huawei.com>, kwolf@redhat.com,
 mreitz@redhat.com, pbonzini@redhat.com
Cc: wu.wubin@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 subo7@huawei.com, lina.lulina@huawei.com,
 "jiangxiaoqing (C)" <sochin.jiang@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7c4fd91-1374-7371-1ff9-533a8e916f2a@redhat.com>
Subject: Re: NBD handshake may block qemu main thread when socket delays or
 has packet loss
References: <586CB62C.6080504@huawei.com>
In-Reply-To: <586CB62C.6080504@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 02:45 AM, Fangyi (C) wrote:
>     As we all know, socket is in blocking mode when nbd is negotiating
> with the other end. If the network is poor because of delay or packet
> loss, socket read or write will return very slowly. The mainloop events=

> won't be handled in time util nbd handshake ends.

I wonder if Paolo's work to improve NBD coroutine usage after handshakes
can be leveraged here?

https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03224.html

>=20
>     Any advices to solve the problem?

At any rate, it sounds like someone will have to patch NBD code to use
coroutines instead of blocking for the handshake portion (and that's
true in general - ANY operation that can block should probably be
refactored into aio or coroutines so that the main loop can remain
responsive).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nV93M8lNRrRFfDtiVIsWPNAFBBwL5kMUH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbV7FAAoJEKeha0olJ0Nq0WUH/2FUy6FXY0ETD5PKR/Oz63Or
fldfdFNUdfw8mgthnQlSOL3IrJR/hjgf9wgplmf5AHMRS6d254D6KPkZZ6DFh00h
603zlHPQ1qWMmd1ZtV1nx8vFlcrQCO67Srmek/MF2OK/PeETYZPzokkI4XEIF3Ah
e9hlo2quHnXnYCkBP9WHXb0Hxtfpt8USg44JO5ZGJUa8b0zDixvGyZQFSWIKIOA9
dnd0vbblv8ycNG5g8FVQacfQYYw1+qdJOO5k6trMqZcy+YslQpricBuMtX3CcGCb
uWO7j2vRRpq2POQ+3EFn81ZIR/TQqjMKzuHvndgDbOh2euvBIc09y/Ggfclp44M=
=JjJT
-----END PGP SIGNATURE-----

--nV93M8lNRrRFfDtiVIsWPNAFBBwL5kMUH--
