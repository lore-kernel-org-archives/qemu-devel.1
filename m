Received: from eggs.gnu.org ([2001:4830:134:3::10]:60471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1e7jVx-0007Z4-KE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1e7jVw-0007VA-KA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:52:09 -0400
MIME-Version: 1.0
In-Reply-To: <1508914283-2531-1-git-send-email-wang.guang55@zte.com.cn>
References: <1508914283-2531-1-git-send-email-wang.guang55@zte.com.cn>
From: Xie Changlong <xiechanglong.d@gmail.com>
Date: Thu, 26 Oct 2017 22:52:06 +0800
Message-ID: <CAOk4XWrCceEep-PU2tJ+Kax+Bp=C0=eLPqTCBw564DCj4wO3jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] replication: Fix replication open fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Guang <wang.guang55@zte.com.cn>, Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>
Cc: Zhang Hailiang <zhang.zhanghailiang@huawei.com>, zhangckid@gmail.com, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Wang Yong <wang.yong155@zte.com.cn>

=E5=9C=A8 10/25/2017 2:51 PM, Wang Guang =E5=86=99=E9=81=93:
> replication_child_perm request write
> permissions for all child which will lead bdrv_check_perm fail.
> replication_child_perm() should request write
> permissions only if it is writable itself.
>
> Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
> Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>

Thanks, this patch fixs the problem in
http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03358.html.

Reviewed-by: Xie Changlong <xiechanglong@cmss.chinamobile.com>

> ---
>   block/replication.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/block/replication.c b/block/replication.c
> index 3a4e682..1c95d67 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -161,10 +161,13 @@ static void replication_child_perm(BlockDriverState=
 *bs, BdrvChild *c,
>                                      uint64_t perm, uint64_t shared,
>                                      uint64_t *nperm, uint64_t *nshared)
>   {
> -    *nperm =3D *nshared =3D BLK_PERM_CONSISTENT_READ \
> -                        | BLK_PERM_WRITE \
> -                        | BLK_PERM_WRITE_UNCHANGED;
> -
> +    *nperm =3D BLK_PERM_CONSISTENT_READ;
> +    if ((bs->open_flags & (BDRV_O_INACTIVE | BDRV_O_RDWR)) =3D=3D BDRV_O=
_RDWR) {
> +        *nperm |=3D BLK_PERM_WRITE;
> +    }
> +    *nshared =3D BLK_PERM_CONSISTENT_READ \
> +               | BLK_PERM_WRITE \
> +               | BLK_PERM_WRITE_UNCHANGED;
>       return;
>   }
>
>

--=20
Thanks
     -Xie
