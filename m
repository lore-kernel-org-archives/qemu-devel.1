Received: from eggs.gnu.org ([2001:4830:134:3::10]:33353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGad5-00086b-CG
	for qemu-devel@nongnu.org; Wed, 09 May 2018 21:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGad4-0007jI-HG
	for qemu-devel@nongnu.org; Wed, 09 May 2018 21:44:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180508212718.1482663-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd2e5501-5829-4034-b91d-33c150e0ffc6@amsat.org>
Date: Wed, 9 May 2018 22:44:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180508212718.1482663-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="OdCa8l2xnSa0yZmjIlObzRlKHYcQl9ZV4"
Subject: Re: [Qemu-devel] [PATCH] iscsi: Avoid potential for get_status
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OdCa8l2xnSa0yZmjIlObzRlKHYcQl9ZV4
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd2e5501-5829-4034-b91d-33c150e0ffc6@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] iscsi: Avoid potential for get_status
 overflow
References: <20180508212718.1482663-1-eblake@redhat.com>
In-Reply-To: <20180508212718.1482663-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2018 06:27 PM, Eric Blake wrote:
> Detected by Coverity: Multiplying two 32-bit int and assigning
> the result to a 64-bit number is a risk of overflow.  Prior to
> the conversion to byte-based interfaces, the block layer took
> care of ensuring that a status request never exceeded 2G in
> the driver; but after that conversion, the block layer expects
> drivers to deal with any size request (the driver can always
> truncate the request size back down, as long as it makes
> progress).  So, in the off-chance that someone makes a large
> request, we are at the mercy of whether iscsi_get_lba_status_task()
> will cap things to at most INT_MAX / iscsilun->block_size when
> it populates lbasd->num_blocks; since I could not easily audit
> that, it's better to be safe than sorry by just forcing a 64-bit
> multiply.

:)

>=20
> Fixes: 92809c36
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  block/iscsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 35423ded03b..a6311b9a320 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -732,7 +732,7 @@ retry:
>          goto out_unlock;
>      }
>=20
> -    *pnum =3D lbasd->num_blocks * iscsilun->block_size;
> +    *pnum =3D (int64_t) lbasd->num_blocks * iscsilun->block_size;
>=20
>      if (lbasd->provisioning =3D=3D SCSI_PROVISIONING_TYPE_DEALLOCATED =
||
>          lbasd->provisioning =3D=3D SCSI_PROVISIONING_TYPE_ANCHORED) {
>=20


--OdCa8l2xnSa0yZmjIlObzRlKHYcQl9ZV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrzo+UACgkQ4+MsLN6t
wN5iTxAAohqPQdyCkQ6pA40NtSIYOSU41XbB2SIE/kFig97eRkxWth1fnApWd0YO
Z9EKqzH0spkEY3Noi4epJiXfo3sQaOnersDREz1+JnEBjO8Ap1sheh7w3609XFzU
Z/Rb50JT/cBmULrp4vP937PQ8NuN1BgW4aEbPbuGw0JbiYOjoYNImu2oawu6czBq
mrpWnnAHP0ESCNOJ+JDFCSepba31IlNqK5U5vbONcWGnJk7BZpY5Pd1hLkwNuDmj
OyA+WrO0Y+7Qs9DP0rpQpqhzRTv2K7xX+Nkkl5Frc4ZDCxyOOhV0k9g9/O+oTB4o
E+CrsRmzxXFIYZXOHswHdMbYWywsH3wGx42JuebSRBCeOM6lXXKaVWiN9g5pjzlr
0Rrl8KFIcB5g52O5y/dBiYVh/z9FryMBvdgU0sZnXwMrj7652+XiwdNVkVH7/xQg
AZ8ZtGExj8idoc2up/CYaWghV4Cf1bntCcOy7IIwZRliiOVDgv6FaiPfQ+AHilU9
+hs0cncoOrA6KxJIBTUjmrne1/TiUJwpAIHCsNCdkQGbgDh0E5U+L2LW1ebmvQlG
XeZuwRMjNeS0fg1Q0MUK/ml0+h3De4vprcf/hr2WG1t4vQjrrJtAwnKQ6K/YK2bZ
Lo+pqDnXgl02xPGZFaES/SIPtFSVGiSBDvRVNcLh8u+oX6G2vuQ=
=QpQ2
-----END PGP SIGNATURE-----

--OdCa8l2xnSa0yZmjIlObzRlKHYcQl9ZV4--
