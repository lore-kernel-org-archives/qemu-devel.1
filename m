Received: from eggs.gnu.org ([2001:4830:134:3::10]:35891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZwDy-000523-Vn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZwDu-0004rM-Vp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:38:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fZwDu-0004r2-ND
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:38:22 -0400
Received: by mail-wm0-x244.google.com with SMTP id i139-v6so8455420wmf.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 03:38:22 -0700 (PDT)
Date: Mon, 2 Jul 2018 11:38:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702103819.GA2155@stefanha-x1.localdomain>
References: <1529053904-12607-1-git-send-email-dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <1529053904-12607-1-git-send-email-dimastep@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH v1] qemu-pr-helper: garbage response
 structure can be used to write data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 12:11:44PM +0300, Dima Stepanov wrote:
> The prh_co_entry() routine handles requests. The first part is to read a
> request by calling the prh_read_request() routine, if:
>   1. scsi_cdb_xfer(req->cdb) call returns 0, and
>   2. req->cdb[0] =3D=3D PERSISTENT_RESERVE_IN, then
> The resp->result field will be uninitialized. As a result the resp.sz
> field will be also uninitialized in the prh_co_entry() function.
> The second part is to send the response by calling the
> prh_write_response() routine:
>   1. For the PERSISTENT_RESERVE_IN command, and
>   2. resp->result =3D=3D GOOD (previous successful reply or just luck), t=
hen
> There is a probability that the following assert will not be trigered:
>   assert(resp->sz <=3D req->sz && resp->sz <=3D sizeof(client->data));
> As a result some uninitialized response will be sent.
>=20
> The fix is to initialize the response structure to CHECK_CONDITION and 0
> values before calling the prh_read_request() routine.
>=20
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  scsi/qemu-pr-helper.c | 2 ++
>  1 file changed, 2 insertions(+)

CCing Paolo Bonzini, SCSI maintainer.

You can use scripts/get_maintainer.pl -f scsi/qemu-pr-helper.c to find
relevant people to CC on a patch.

>=20
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index d0f8317..85878c2 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -768,6 +768,8 @@ static void coroutine_fn prh_co_entry(void *opaque)
>          PRHelperResponse resp;
>          int sz;
> =20
> +        resp.result =3D CHECK_CONDITION;
> +        resp.sz =3D 0;
>          sz =3D prh_read_request(client, &req, &resp, &local_err);
>          if (sz < 0) {
>              break;
> --=20
> 2.7.4
>=20
>=20

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOgCbAAoJEJykq7OBq3PIMGYH/Ai2/MIMy6f/TCfh7ymsJG3k
adX7U8pJv6KBtwSrIz614Tr5ksczPVSnvVeCTS07uDNMBRpsaFN3K/7Xpdsq+QcS
bvJnEGYjP/pQbSO46VpHzgRBExaHZsLUPQT7DDwEGR5WaiHeKxSm8XxiUZZGq0Ya
ehowImVWS0916pGD8mw0evK/md0PDJUwMrHrrlcI63BzkiYqsjlvDK5whDjfLtKB
iCB654bybR/FAmTTOpgPPXmD0dMtRZOzN96J82/Nn4stPtQdOGtZPALUYiT2O/ZJ
xMH7Ix76fwc+i/P8og+5soBNy29NLjHYcfeuXU8XgMWSy/LuFUGQ2x7X5je9oDk=
=QEm+
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
