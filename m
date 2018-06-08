Received: from eggs.gnu.org ([2001:4830:134:3::10]:44701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJOx-0005IP-5J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJOw-0002Xx-3V
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:34:07 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180608123208.54033-1-vsementsov@virtuozzo.com>
Message-ID: <de1884cb-00e0-8042-3eef-d81ac32d9c0e@virtuozzo.com>
Date: Fri, 8 Jun 2018 18:33:54 +0300
MIME-Version: 1.0
In-Reply-To: <20180608123208.54033-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block/qcow2: save dirty_bitmaps_loaded
 during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

08.06.2018 15:32, Vladimir Sementsov-Ogievskiy wrote:
> This variable was introduced to handle reopens. We need it on the
> following qcow2_do_open, to don't try load bitmaps again.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 549fee9b69..29f7eab576 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2178,6 +2178,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(=
BlockDriverState *bs,
>       QDict *options;
>       Error *local_err =3D NULL;
>       int ret;
> +    bool dirty_bitmaps_loaded =3D s->dirty_bitmaps_loaded;
>  =20
>       /*
>        * Backing files are read-only which makes all of their metadata im=
mutable,
> @@ -2190,6 +2191,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(=
BlockDriverState *bs,
>       qcow2_close(bs);
>  =20
>       memset(s, 0, sizeof(BDRVQcow2State));
> +    s->dirty_bitmaps_loaded =3D dirty_bitmaps_loaded;
>       options =3D qdict_clone_shallow(bs->options);
>  =20
>       flags &=3D ~BDRV_O_INACTIVE;

Haha, this breaks 169 test.. Because, logic around dirty_bitmaps_loaded,=20
which is fixed here, actually breaks it.

context:

static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int flags, Error **errp)
{

[...]

 =C2=A0=C2=A0=C2=A0 if (s->dirty_bitmaps_loaded) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* It's some kind of reopen. Th=
ere are no known cases where we=20
need to
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reload bitmaps in such =
a situation, so it's safer to skip them.
*
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Moreover, if we have so=
me readonly bitmaps and we are=20
reopening for
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * rw we should reopen bit=
maps correspondingly.
*/
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_has_readonly_bitmaps(b=
s) &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !bdrv_i=
s_read_only(bs) && !(bdrv_get_flags(bs) &=20
BDRV_O_INACTIVE))
{
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcow2_r=
eopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
}
 =C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_updated =3D qcow2_load_d=
irty_bitmaps(bs, &local_err);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->dirty_bitmaps_loaded =3D tru=
e;
 =C2=A0=C2=A0=C2=A0 }

[...]

- First time, we go into "else" block, but there no bitmaps yet, as=20
target is opened before source closed. On second time, we go into "if"=20
block, but there is nothing to reopen.

I'll resend the patch, with additional fixing.

--=20
Best regards,
Vladimir
