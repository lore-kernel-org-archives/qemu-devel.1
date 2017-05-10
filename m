Received: from eggs.gnu.org ([2001:4830:134:3::10]:51014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8VXi-0005Vw-5N
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8VXh-0008NU-FB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:36:54 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-6-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aeb8c806-9c6b-fcd8-6c2a-cd4098946ff9@redhat.com>
Date: Wed, 10 May 2017 19:36:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170510143205.32013-6-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ElcTBBKOUtVs6NmLdBieESX60Rg1prnxO"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] curl: convert CURLAIOCB
 to byte values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ElcTBBKOUtVs6NmLdBieESX60Rg1prnxO
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <aeb8c806-9c6b-fcd8-6c2a-cd4098946ff9@redhat.com>
Subject: Re: [Qemu-block] [PATCH 5/7] curl: convert CURLAIOCB to byte values
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-6-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2017 16:32, Paolo Bonzini wrote:
> This is in preparation for the conversion from bdrv_aio_readv to
> bdrv_co_preadv, and it also requires changing some of the size_t values=

> to uint64_t.  This was broken before for disks > 2TB, but now it would
> break at 4GB.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/curl.c b/block/curl.c
> index 4b4d5a2389..3e288f2bc7 100644
> --- a/block/curl.c
> +++ b/block/curl.c

[...]

> @@ -788,7 +788,7 @@ static int curl_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
>      }
>  #endif
> =20
> -    s->len =3D (size_t)d;
> +    s->len =3D d;

On a very personal level, I'd rather have an explicit cast when
converting floating point values to integers. Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

On a very surprised level: Why does curl return the content length as a
double?! I can't think of a reason where that might be a good idea. If
your integer no longer fits into a uin64_t, the double will be inexact,
so it pretty much is useless, too...

> =20
>      if ((!strncasecmp(s->url, "http://", strlen("http://"))
>          || !strncasecmp(s->url, "https://", strlen("https://")))


--ElcTBBKOUtVs6NmLdBieESX60Rg1prnxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkTT64SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaKkIAIsmU/NL4TkeSOnBeEhLYn1R0ZSNlurP
qpRrwM5dTPC91fk6OwQvxFy5cNrg4GUDUBYVPG8E9NLo39DNlmeTpqLsGbLeLiQu
fG+dq137+Vrh9Ja1kK/ygx+eRwPaeZ9JyaUEOtIH6ihGVudIhKXdKuJSkaB5BsNo
WdDKskJ3svkincOZjhZH1zNU8zO/4Mz8dA+pni24IPWI5KJaOBG3QGtOIMPJiRJv
Jqxud0wjdOzKIsHAeEQjOZvm5zuxNczKiy7kY2ovlXwYIdf82fpobmgW66H65vAQ
g0sYRtIZ8ydbSPSD9x6kIP/Zed/cflD5nNZ7O10cJ+Gg+SEziScADmA=
=xy+q
-----END PGP SIGNATURE-----

--ElcTBBKOUtVs6NmLdBieESX60Rg1prnxO--
