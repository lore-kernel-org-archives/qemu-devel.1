Received: from eggs.gnu.org ([209.51.188.92]:49223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goA4b-0007Z2-2z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goA4a-000083-CG
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1goA4a-0008Us-2r
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:47:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3417C58E22
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 16:47:43 +0000 (UTC)
References: <20190128142410.11584-1-bsd@redhat.com>
	<20190128142410.11584-2-bsd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6587b190-16d8-c7d7-af9c-f5f221ca79a5@redhat.com>
Date: Mon, 28 Jan 2019 10:47:41 -0600
MIME-Version: 1.0
In-Reply-To: <20190128142410.11584-2-bsd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Bmlip3XvGjyX7Q0Hy7lnHE4XhAw9SHyk"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] usb-mtp: Reallocate buffer in
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
--2Bmlip3XvGjyX7Q0Hy7lnHE4XhAw9SHyk
From: Eric Blake <eblake@redhat.com>
To: Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Message-ID: <6587b190-16d8-c7d7-af9c-f5f221ca79a5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] usb-mtp: Reallocate buffer in
 multiples of MTP_WRITE_BUF_SZ
References: <20190128142410.11584-1-bsd@redhat.com>
 <20190128142410.11584-2-bsd@redhat.com>
In-Reply-To: <20190128142410.11584-2-bsd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 8:24 AM, Bandan Das wrote:
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
> index 68c5eb8eaa..2f3536a26d 100644
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

Why a non-power-of-2 instead of using units.h and writing (512 * KiB)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2Bmlip3XvGjyX7Q0Hy7lnHE4XhAw9SHyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPMi0ACgkQp6FrSiUn
Q2ov/AgAg3tn2dfHpdgR58wJW6qBYktXS+LBM0tIdYhK5GG1UnietMcTgY//GJg5
0NFy/iEoegClF/RYkG394Yu1bfWI3H9A3xGxopkfRgdCBW1Ru+cnEhoWS2IRpRTW
053tC9lnQMv4v7WQQISxjwQ9nBZ1ghNuFtqzBclUFasB7KOuqeUFO0SYkzEC+Y+C
0Ks0By/duqs0AZezaiaetLXYh6RcTBwU6yqRzW+8SQLIrKupoLeX9I4UNPixneXS
FRmsvnsXK2UnCHk4Z3cAlI+O6tO2shEQ/DVcr+FLYlR5b2UTu6Nq0BSx+JjFuI5G
da8pCrcG5cD6DfXFfJxP7tEz2QISzw==
=mXX0
-----END PGP SIGNATURE-----

--2Bmlip3XvGjyX7Q0Hy7lnHE4XhAw9SHyk--
