Received: from eggs.gnu.org ([209.51.188.92]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghyuT-00038X-Nv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghyuT-0005NU-0s
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:39:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghyuS-0005N3-O5
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:39:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFC1D58E5B
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 15:39:47 +0000 (UTC)
References: <20190111082043.31412-1-bsd@redhat.com>
	<20190111082043.31412-2-bsd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2770d0ef-fcce-e796-5038-bf92e3dfbdbf@redhat.com>
Date: Fri, 11 Jan 2019 09:39:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190111082043.31412-2-bsd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SBcqFISqUu85cvQlK4XOH8kC7WeRNLJKw"
Subject: Re: [Qemu-devel] [PATCH 1/2 v2] usb-mtp: Reallocate buffer in
 multiples of MTP_WRITE_BUF_SZ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SBcqFISqUu85cvQlK4XOH8kC7WeRNLJKw
From: Eric Blake <eblake@redhat.com>
To: Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Message-ID: <2770d0ef-fcce-e796-5038-bf92e3dfbdbf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v2] usb-mtp: Reallocate buffer in
 multiples of MTP_WRITE_BUF_SZ
References: <20190111082043.31412-1-bsd@redhat.com>
 <20190111082043.31412-2-bsd@redhat.com>
In-Reply-To: <20190111082043.31412-2-bsd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 2:20 AM, Bandan Das wrote:
> This is a "pre-patch" to breaking up the write buffer for
> MTP writes. Instead of allocating a mtp buffer equal to size
> sent by the initiator, we start with a small size and reallocate
> multiples (of that small size) as needed.
>=20
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index b19b576278..a0d98c93ee 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -152,7 +152,6 @@ struct MTPData {
>      bool         first;
>      /* Used for >4G file sizes */
>      bool         pending;
> -    uint64_t     cached_length;
>      int          fd;
>  };
> =20
> @@ -244,6 +243,7 @@ typedef struct {
> =20
>  #define MTP_MANUFACTURER  "QEMU"
>  #define MTP_PRODUCT       "QEMU filesharing"
> +#define MTP_WRITE_BUF_SZ  512000

Why not a power of two?  Perhaps use units.h and spell it (512 * KiB) ?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SBcqFISqUu85cvQlK4XOH8kC7WeRNLJKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4uLwACgkQp6FrSiUn
Q2qHZwgApOGWepD7AqYsJpOwmpAjBFWvFSZ4f7rLQShy+HSofCJseLWqmxfRkeld
pAY9pdKAiCo4F8mIY9mweVugkh7YOJgY7Zlt4zqIu1gbdXL32cKOzmleEX+PzLYP
D19+t3l4054kolCt09sYPxsIuAF7YGIQif8MbyiNsIuENQLj2qVx2qz2XTEn5FLE
AV+T/6yh9oMvHBf5YSi/QWLUR6FPa5HK3h73uXqTNbepVsfavE7dKQrnB81GMI0K
WPFwTcGPL0SBrPA675sUqh3Dyv1efU4OkAxl4XnFixzkWV62DiaH08edr7sKVDU9
Pb8gKmctFUHJqpPtLV56MEUWTc30rg==
=XP2S
-----END PGP SIGNATURE-----

--SBcqFISqUu85cvQlK4XOH8kC7WeRNLJKw--
