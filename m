Received: from eggs.gnu.org ([2001:4830:134:3::10]:44967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEeTB-0005q7-Oi
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEeT7-0001lp-2P
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cEeT6-0001li-Pz
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:49:16 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
Date: Wed, 7 Dec 2016 16:49:01 +0100
MIME-Version: 1.0
In-Reply-To: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VGjI1NCst6hUrkJOqEuqOusvb9MMi6FMD"
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
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VGjI1NCst6hUrkJOqEuqOusvb9MMi6FMD
From: Max Reitz <mreitz@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mst@redhat.com
Message-ID: <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 07.12.2016 03:29, Gonglei wrote:
> Common practice with sensitive information (key material, passwords,
> etc). Prevents sensitive information from being exposed by accident lat=
er in
> coredumps, memory disclosure bugs when heap memory is reused, etc.
>=20
> Sensitive information is sometimes also held in mlocked pages to preven=
t
> it being swapped to disk but that's not being done here.
>=20
> Let's zeroize the memory of CryptoDevBackendSymOpInfo structure pointed=

> for key material security.
>=20
> [v2: Stefan perfects the commit message, thanks]
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

As far as I'm aware, other projects usually have a special memset
variation for doing this. That is because compilers may choose to
"optimize" memset(p, ...) + free(p) to just the free(p). Having a
special zeroizing function that the compiler cannot drop would prevent
this. (By the way, C11 provides this functionality with memset_s().)

We are not using free() but g_free(), so the danger of a compiler
detecting the pattern and "optimizing" it is probably much lower, but
still, the possibility exists.

Max


--VGjI1NCst6hUrkJOqEuqOusvb9MMi6FMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhIL3kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZYQH/0ki1sxmHe88ikWDKgJ8dqLrUwl67x3A
q7b7pEyUbM+HXUTOZOjTVSZZiDeh2+MSKbn0ynoutFScO3PtdG2VH5eAtXzJYy4z
xJdFhVT84dG5Rb8xECLnpvOGrrkxLZJiAR9Olc3+W/HFLJqHCL6UokzV3QCri0pU
hgjsIn1hC6rrIya2A6127X5kKFnjZPh1b1H31NxdOu2GzOAIFB1Fqg5klbrXj/kU
bEA+Eoflt6Mkwt8p6fX2xr+EuH9D/zCV988qwS/IBzWS7bSr1TLuP5Wj7KRmdg6P
NvCxMY2Pcl/ysb2W8MJ4DPx1jhThrjA+3cYtYRWpUU73P4dC2XDZxOY=
=2vWI
-----END PGP SIGNATURE-----

--VGjI1NCst6hUrkJOqEuqOusvb9MMi6FMD--
