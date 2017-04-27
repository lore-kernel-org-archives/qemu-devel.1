Received: from eggs.gnu.org ([2001:4830:134:3::10]:34092)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d3onL-0001VO-De
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d3onI-0001gh-Ei
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:09:39 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:58862 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d3onI-0001fs-57
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:09:36 -0400
From: Peter Lieven <pl@kamp.de>
Message-Id: <BF634842-A623-4A75-BA50-E3EF5133C714@kamp.de>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Date: Thu, 27 Apr 2017 21:09:33 +0200
In-Reply-To: <1493195595-4809-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1493195595-4809-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v3 1/1] qemu-img: wait for
 convert coroutines to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com


> Am 26.04.2017 um 10:33 schrieb Anton Nefedov =
<anton.nefedov@virtuozzo.com>:
>=20
> On error path (like i/o error in one of the coroutines), it's required =
to
>  - wait for coroutines completion before cleaning the common =
structures
>  - reenter dependent coroutines so they ever finish
>=20
> Introduced in 2d9187bc65.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
> qemu-img.c | 26 +++++++++++---------------
> 1 file changed, 11 insertions(+), 15 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index bbe1574..8c50379 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1761,13 +1761,13 @@ static void coroutine_fn =
convert_co_do_copy(void *opaque)
>         qemu_co_mutex_lock(&s->lock);
>         if (s->ret !=3D -EINPROGRESS || s->sector_num >=3D =
s->total_sectors) {
>             qemu_co_mutex_unlock(&s->lock);
> -            goto out;
> +            break;
>         }
>         n =3D convert_iteration_sectors(s, s->sector_num);
>         if (n < 0) {
>             qemu_co_mutex_unlock(&s->lock);
>             s->ret =3D n;
> -            goto out;
> +            break;
>         }
>         /* save current sector and allocation status to local =
variables */
>         sector_num =3D s->sector_num;
> @@ -1792,7 +1792,6 @@ static void coroutine_fn convert_co_do_copy(void =
*opaque)
>                 error_report("error while reading sector %" PRId64
>                              ": %s", sector_num, strerror(-ret));
>                 s->ret =3D ret;
> -                goto out;
>             }
>         } else if (!s->min_sparse && status =3D=3D BLK_ZERO) {
>             status =3D BLK_DATA;
> @@ -1801,22 +1800,20 @@ static void coroutine_fn =
convert_co_do_copy(void *opaque)
>=20
>         if (s->wr_in_order) {
>             /* keep writes in order */
> -            while (s->wr_offs !=3D sector_num) {
> -                if (s->ret !=3D -EINPROGRESS) {
> -                    goto out;
> -                }
> +            while (s->wr_offs !=3D sector_num && s->ret =3D=3D =
-EINPROGRESS) {
>                 s->wait_sector_num[index] =3D sector_num;
>                 qemu_coroutine_yield();
>             }
>             s->wait_sector_num[index] =3D -1;
>         }
>=20
> -        ret =3D convert_co_write(s, sector_num, n, buf, status);
> -        if (ret < 0) {
> -            error_report("error while writing sector %" PRId64
> -                         ": %s", sector_num, strerror(-ret));
> -            s->ret =3D ret;
> -            goto out;
> +        if (s->ret =3D=3D -EINPROGRESS) {
> +            ret =3D convert_co_write(s, sector_num, n, buf, status);
> +            if (ret < 0) {
> +                error_report("error while writing sector %" PRId64
> +                             ": %s", sector_num, strerror(-ret));
> +                s->ret =3D ret;
> +            }
>         }
>=20
>         if (s->wr_in_order) {
> @@ -1837,7 +1834,6 @@ static void coroutine_fn convert_co_do_copy(void =
*opaque)
>         }
>     }
>=20
> -out:
>     qemu_vfree(buf);
>     s->co[index] =3D NULL;
>     s->running_coroutines--;
> @@ -1899,7 +1895,7 @@ static int convert_do_copy(ImgConvertState *s)
>         qemu_coroutine_enter(s->co[i]);
>     }
>=20
> -    while (s->ret =3D=3D -EINPROGRESS) {
> +    while (s->running_coroutines) {
>         main_loop_wait(false);
>     }
>=20
> --=20
> 2.7.4
>=20
>=20

Reviewed-by: Peter Lieven <pl@kamp.de <mailto:pl@kamp.de>>

Peter
