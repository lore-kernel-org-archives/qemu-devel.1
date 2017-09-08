Received: from eggs.gnu.org ([2001:4830:134:3::10]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqIRJ-0003bz-2k
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqIRF-0002mZ-W5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:31:17 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:51600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqIRF-0002lf-PT
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:31:13 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2C7E174BAD
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 14:31:12 +0200 (CEST)
Date: Fri, 8 Sep 2017 14:31:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170908143104.417c9995@bahia>
In-Reply-To: <1504541267-36954-5-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-5-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/7lOn1gUJ5FGIQx5lcuyD9vW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v10 4/6] hmp: create a throttle
 initialization function for code reusability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/7lOn1gUJ5FGIQx5lcuyD9vW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Sep 2017 12:07:45 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch creates a throttle initialization function to maximize the
> code reusability. The same code is also used by fsdev.
>=20

s/is also/will also be/

> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hmp.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/hmp.c b/hmp.c
> index fd80dce..2dbfb80 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1758,20 +1758,27 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
> =20
> +static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *qdi=
ct)
> +{
> +    iot->bps =3D qdict_get_int(qdict, "bps");
> +    iot->bps_rd =3D qdict_get_int(qdict, "bps_rd");
> +    iot->bps_wr =3D qdict_get_int(qdict, "bps_wr");
> +    iot->iops =3D qdict_get_int(qdict, "iops");
> +    iot->iops_rd =3D qdict_get_int(qdict, "iops_rd");
> +    iot->iops_wr =3D qdict_get_int(qdict, "iops_wr");
> +}
> +
>  void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> +    IOThrottle *iothrottle;
>      BlockIOThrottle throttle =3D {
>          .has_device =3D true,
>          .device =3D (char *) qdict_get_str(qdict, "device"),
> -        .bps =3D qdict_get_int(qdict, "bps"),
> -        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
> -        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
> -        .iops =3D qdict_get_int(qdict, "iops"),
> -        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
> -        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
>      };
> =20
> +    iothrottle =3D qapi_BlockIOThrottle_base(&throttle);
> +    hmp_initialize_io_throttle(iothrottle, qdict);
>      qmp_block_set_io_throttle(&throttle, &err);
>      hmp_handle_error(mon, &err);
>  }


--Sig_/7lOn1gUJ5FGIQx5lcuyD9vW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbKNiAAKCRAC/DrrAQHb
wgpWAKCTo2UwAoCAupW77c/9q2aW0CA5PQCfespWYIJm4Voz7g3oMFS16iOHoTE=
=B7oE
-----END PGP SIGNATURE-----

--Sig_/7lOn1gUJ5FGIQx5lcuyD9vW--
