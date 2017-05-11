Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tp2-0006iJ-UV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8toy-0004zU-0J
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:32:24 -0400
Date: Thu, 11 May 2017 15:32:16 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511193216.GE24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 02/16] block-backend: Add
 blk_request_perm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:42PM +0800, Fam Zheng wrote:
> This function tries to request, if not granted yet, for the given
> permissions.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 12 ++++++++++++
>  include/sysemu/block-backend.h |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 7405024..6bdd9ce 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -629,6 +629,18 @@ void blk_resume_after_migration(Error **errp)
>      }
>  }
> =20
> +int blk_request_perm(BlockBackend *blk, uint64_t perm, Error **errp)
> +{
> +    uint64_t blk_perm, shared_perm;
> +
> +    blk_get_perm(blk, &blk_perm, &shared_perm);
> +    if ((blk_perm & perm) =3D=3D perm) {
> +        return 0;
> +    }
> +    blk_perm |=3D perm;
> +    return blk_set_perm(blk, blk_perm, shared_perm, errp);
> +}

I'm slightly confused about why this function is needed.  blk_set_perm()
doesn't do quite the right thing?

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLxAAAoJEJykq7OBq3PIiJAH/38WA/hpa5rRaTfeZF2goY3S
WIq0LtBFea0/J2KiGbhzot8+7llT80WATmSczZBvRnx7zg+EgEhzrPZmPjPr3rt6
dElweaHk0+doJNYSXKHlr5GLK15WUDLfqyI8fimVaTORn1j8TMjLvQS2yqoxT9Ya
HxUfzNhEA64znK4qUyI+ct3Thdc+egfFQ609dkgA9ZaJxXbG3//1cSkCQBOasBa9
dpBR6jrBeDuC1yXq8vndtqzy+7OH5Ji4pTn0B17Tjqe+tHWFKigMapquwzfTDXUL
4yVYfyjBTxqxaqAT8Cer1dNsEBxt60REvLy1b8UbKaqX2XsKmqczXhCEtIjzfNY=
=1/WX
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
