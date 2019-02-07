Received: from eggs.gnu.org ([209.51.188.92]:48684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlSA-0000tq-Dl
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlS4-0007qG-Sx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:19:02 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a86c84f-4455-5d87-be76-dd503142ebe2@redhat.com>
Date: Thu, 7 Feb 2019 09:18:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GDsSihanaaTSYm1AYSRVgMruWIWKWuW8R"
Subject: Re: [Qemu-devel] [PATCH v3 10/17] block/qed: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GDsSihanaaTSYm1AYSRVgMruWIWKWuW8R
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <4a86c84f-4455-5d87-be76-dd503142ebe2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/17] block/qed: use qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-11-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qed-table.c | 16 +++-------------
>  block/qed.c       | 31 +++++++++----------------------
>  2 files changed, 12 insertions(+), 35 deletions(-)
>=20

> @@ -921,11 +915,7 @@ static int coroutine_fn qed_copy_from_backing_file=
(BDRVQEDState *s,
>          return 0;
>      }
> =20
> -    iov =3D (struct iovec) {
> -        .iov_base =3D qemu_blockalign(s->bs, len),
> -        .iov_len =3D len,
> -    };
> -    qemu_iovec_init_external(&qiov, &iov, 1);
> +    qemu_iovec_init_buf(&qiov, qemu_blockalign(s->bs, len), len);
> =20
>      ret =3D qed_read_backing_file(s, pos, &qiov, &backing_qiov);
> =20
> @@ -946,7 +936,7 @@ static int coroutine_fn qed_copy_from_backing_file(=
BDRVQEDState *s,
>      }
>      ret =3D 0;
>  out:
> -    qemu_vfree(iov.iov_base);
> +    qemu_vfree(qemu_iovec_get_buf(&qiov));

Matching my comments on 7/17, a separate variable to hold the allocated
buffer may mean that you don't need qemu_iovec_get_buf().

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GDsSihanaaTSYm1AYSRVgMruWIWKWuW8R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcTEAACgkQp6FrSiUn
Q2pmPwf/YGEACpwOKy0B0Rm0eIKMtpW9Yc4rwS/B7ZUTFeIgkvpf8U53KERzgH0r
r8Kfv9BLSQWfhW7Ky8eWDMCrRN27HMgE1E3EvxVVS8JvHbm2xOhafeYmZhciVQJH
I6UNTsBBowZWdr2fdRvZeE9MDpICHEcfODOyb/mMrrvT2rdv3pnlGLGhW9S2k1ob
gYAx95T6mzBlkyq2imdXlJXxicRrAluMqvgWfkB1UxhfuAuHRxKlGI8vHBJJsDPc
s0KakzapZfbnODLi1kf8ahcvsIIPY177Tw9Q6r64U+SRQ50DruLz5CdKxNozWHiv
q4A4+HDofAqtCQtx1ed/DLAzj6sH6g==
=WYmj
-----END PGP SIGNATURE-----

--GDsSihanaaTSYm1AYSRVgMruWIWKWuW8R--
