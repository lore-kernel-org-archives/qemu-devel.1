Received: from eggs.gnu.org ([2001:4830:134:3::10]:52463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXlV-0007tZ-Ez
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXlU-0000XO-6Y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:39:41 -0400
References: <20170809160212.29976-1-stefanha@redhat.com>
	<20170809160212.29976-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2974850-fa11-c598-66c1-2cb1089bdb24@redhat.com>
Date: Wed, 9 Aug 2017 15:39:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170809160212.29976-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s6KjhoHGE3vp6FG0qxa5BOCgCS8PJxijm"
Subject: Re: [Qemu-devel] [PATCH 1/2] IDE: Do not flush empty CDROM drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6KjhoHGE3vp6FG0qxa5BOCgCS8PJxijm
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <f2974850-fa11-c598-66c1-2cb1089bdb24@redhat.com>
Subject: Re: [PATCH 1/2] IDE: Do not flush empty CDROM drives
References: <20170809160212.29976-1-stefanha@redhat.com>
 <20170809160212.29976-2-stefanha@redhat.com>
In-Reply-To: <20170809160212.29976-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 11:02 AM, Stefan Hajnoczi wrote:
> The block backend changed in a way that flushing empty CDROM drives now=

> crashes.  Amend IDE to avoid doing so until the root problem can be
> addressed for 2.11.
>=20
> Original patch by John Snow <jsnow@redhat.com>.
>=20
> Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/ide/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64d3a..bea39536b0 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -1063,7 +1063,15 @@ static void ide_flush_cache(IDEState *s)
>      s->status |=3D BUSY_STAT;
>      ide_set_retry(s);
>      block_acct_start(blk_get_stats(s->blk), &s->acct, 0, BLOCK_ACCT_FL=
USH);
> -    s->pio_aiocb =3D blk_aio_flush(s->blk, ide_flush_cb, s);
> +
> +    if (blk_bs(s->blk)) {
> +        s->pio_aiocb =3D blk_aio_flush(s->blk, ide_flush_cb, s);
> +    } else {
> +        /* XXX blk_aio_flush() crashes when blk_bs(blk) is NULL, remov=
e this
> +         * temporary workaround when blk_aio_*() functions handle NULL=
 blk_bs.
> +         */
> +        ide_flush_cb(s, 0);
> +    }
>  }
> =20
>  static void ide_cfata_metadata_inquiry(IDEState *s)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s6KjhoHGE3vp6FG0qxa5BOCgCS8PJxijm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLcv0ACgkQp6FrSiUn
Q2rl4wf+Lv9cZe+v+uHaiqWhXpqHnig9ZEZ6FEcaXEyuffLUnKeB/PlEEOpIzR4I
WuLxbBDQ1kEUuA9b0ZHDHziFENwyhwSAwmHX9e0yqkJXO3HRKBL4Y7joahGYGedF
ipZoyFlHucYWcAbjTCcrdB6kKhq87YhaWkbqzXrF0AxUaxe/OaGXWmfL7eoa+nBg
X25bcHtt/UmrfqJoEFFMLg6Jfoqg5j8kjyU4iYJP5vwTYtN8flzuVl4A+sQ70SyU
VWan6wwP4OuMxiMiEJhmHS9U5d7idcVHC8aJ0V/KEnrnBdqxEtZy9S2jY6i5wDEC
V8Df+yuicoyjmsvq4Uali1DFuFKHLA==
=h1f8
-----END PGP SIGNATURE-----

--s6KjhoHGE3vp6FG0qxa5BOCgCS8PJxijm--
