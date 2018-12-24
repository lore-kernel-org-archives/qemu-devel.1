Received: from eggs.gnu.org ([208.118.235.92]:54701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gbS90-0002eI-Ip
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gbS8z-0001DO-QU
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:27:50 -0500
MIME-Version: 1.0
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-2-npes87184@gmail.com>
In-Reply-To: <20181223025939.15775-2-npes87184@gmail.com>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 24 Dec 2018 13:27:38 -0200
Message-ID: <CAENf94KwPCMqT2kbakgG27JQ13c9299Ok5F0xT7ik1wQwe1+0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Looks good to me.

Reviewed-by: Julio Faracco <jcfaracco@gmail.com>

Em dom, 23 de dez de 2018 =C3=A0s 01:04, yuchenlin <npes87184@gmail.com>
escreveu:

> There is a possible hang in original binary search implementation. That i=
s
> if chunk1 =3D 4, chunk2 =3D 5, chunk3 =3D 4, and we go else case.
>
> The chunk1 will be still 4, and so on.
>
> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  block/dmg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/block/dmg.c b/block/dmg.c
> index 50e91aef6d..0e05702f5d 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -572,14 +572,14 @@ static inline uint32_t search_chunk(BDRVDMGState *s=
,
> uint64_t sector_num)
>  {
>      /* binary search */
>      uint32_t chunk1 =3D 0, chunk2 =3D s->n_chunks, chunk3;
> -    while (chunk1 !=3D chunk2) {
> +    while (chunk1 <=3D chunk2) {
>          chunk3 =3D (chunk1 + chunk2) / 2;
>          if (s->sectors[chunk3] > sector_num) {
> -            chunk2 =3D chunk3;
> +            chunk2 =3D chunk3 - 1;
>          } else if (s->sectors[chunk3] + s->sectorcounts[chunk3] >
> sector_num) {
>              return chunk3;
>          } else {
> -            chunk1 =3D chunk3;
> +            chunk1 =3D chunk3 + 1;
>          }
>      }
>      return s->n_chunks; /* error */
> --
> 2.17.1
>
>
>
