Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drPI3-0001ws-H1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drPHz-0006ec-Fp
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:02:19 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:57355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drPHz-0006cZ-9n
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:02:15 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2B738931B8
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 16:02:09 +0200 (CEST)
Date: Mon, 11 Sep 2017 16:02:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911160202.56e47324@bahia.lan>
In-Reply-To: <20170911132627.9505-1-cohuck@redhat.com>
References: <20170911132627.9505-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_d/o3WA_pvzo6hzKO94Q4eP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] dump: do not dump non-existent guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

--Sig_/_d/o3WA_pvzo6hzKO94Q4eP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 15:26:27 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> It does not really make sense to dump memory that is not there.
>=20
> Moreover, that fixes a segmentation fault when calling dump-guest-memory
> with no filter for a machine with no memory defined.
>=20
> New behaviour is:
>=20
> (qemu) dump-guest-memory /dev/null
> dump: no guest memory to dump
> (qemu) dump-guest-memory /dev/null 0 4096
> dump: no guest memory to dump
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>=20
> Another unmaintained file. Joy. cc:ing some more-or-less random folks.
>=20
> ---
>  dump.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/dump.c b/dump.c
> index a79773d0f7..d2093e141b 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -1536,6 +1536,12 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
>      fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
>  #endif
> =20
> +    /* it does not make sense to dump non-existent memory */
> +    if (!s->total_size) {
> +        error_setg(errp, "dump: no guest memory to dump");
> +        goto cleanup;
> +    }
> +
>      s->start =3D get_start_block(s);
>      if (s->start =3D=3D -1) {
>          error_setg(errp, QERR_INVALID_PARAMETER, "begin");


--Sig_/_d/o3WA_pvzo6hzKO94Q4eP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbaXWgAKCRAC/DrrAQHb
wnuUAJ90pNOHBC/b/tyBw344AtjgGfHKQwCfakuGJierQ1kx8+rys3gai2scT9Y=
=xYe+
-----END PGP SIGNATURE-----

--Sig_/_d/o3WA_pvzo6hzKO94Q4eP--
