Received: from eggs.gnu.org ([2001:4830:134:3::10]:34676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1ceNlN-0003ho-DJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1ceNlH-000189-3W
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:14:29 -0500
Date: Thu, 16 Feb 2017 16:13:41 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <887093105.8854266.1487258021988.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <CAKZcxgfA6YvAOZfngyf0QC5iF1WwGK86DcXPJPwBOr_XFfzMuA@mail.gmail.com>
References: <20170216084318.11122-1-jazeltq@gmail.com>
	<20170216090002.12511-1-jazeltq@gmail.com>
	<D7075812-8210-4092-8ED4-BB6FAC4E612C@gmail.com>
	<CAKZcxgfA6YvAOZfngyf0QC5iF1WwGK86DcXPJPwBOr_XFfzMuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v5] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jazeltq <jazeltq@gmail.com>
Cc: Tiger Hu <hufh2004@gmail.com>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, dillaman <dillaman@redhat.com>, Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, ceph-devel <ceph-devel@vger.kernel.org>, tianqing <tianqing@unitedstack.com>

>>No yet. I just test on one qemu-kvm vm. It works fine.=20
>>The performance may need more time.=20
>>Any one can test on this patch if you do fast....=20

Hi, I would like to bench it with small 4k read/write.

On the ceph side,do we need this PR ? :
https://github.com/ceph/ceph/pull/13447


----- Mail original -----
De: "jazeltq" <jazeltq@gmail.com>
=C3=80: "Tiger Hu" <hufh2004@gmail.com>
Cc: "Josh Durgin" <jdurgin@redhat.com>, "Jeff Cody" <jcody@redhat.com>, "di=
llaman" <dillaman@redhat.com>, "Kevin Wolf" <kwolf@redhat.com>, mreitz@redh=
at.com, qemu-block@nongnu.org, "qemu-devel" <qemu-devel@nongnu.org>, "ceph-=
devel" <ceph-devel@vger.kernel.org>, "tianqing" <tianqing@unitedstack.com>
Envoy=C3=A9: Jeudi 16 F=C3=A9vrier 2017 15:03:52
Objet: Re: [RFC v5] RBD: Add support readv,writev for rbd

No yet. I just test on one qemu-kvm vm. It works fine.=20
The performance may need more time.=20
Any one can test on this patch if you do fast....=20

2017-02-16 20:07 GMT+08:00 Tiger Hu <hufh2004@gmail.com>:=20
> Tianqing,=20
>=20
> Do we have any performance data for this patch? Thanks.=20
>=20
> Tiger=20
>> =E5=9C=A8 2017=E5=B9=B42=E6=9C=8816=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=885=
:00=EF=BC=8Cjazeltq@gmail.com =E5=86=99=E9=81=93=EF=BC=9A=20
>>=20
>> From: tianqing <tianqing@unitedstack.com>=20
>>=20
>> Rbd can do readv and writev directly, so wo do not need to transform=20
>> iov to buf or vice versa any more.=20
>>=20
>> Signed-off-by: tianqing <tianqing@unitedstack.com>=20
>> ---=20
>> block/rbd.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------=20
>> 1 file changed, 42 insertions(+), 7 deletions(-)=20
>>=20
>> diff --git a/block/rbd.c b/block/rbd.c=20
>> index a57b3e3..75ae1d6 100644=20
>> --- a/block/rbd.c=20
>> +++ b/block/rbd.c=20
>> @@ -47,7 +47,7 @@=20
>> */=20
>>=20
>> /* rbd_aio_discard added in 0.1.2 */=20
>> -#if LIBRBD_VERSION_CODE >=3D LIBRBD_VERSION(0, 1, 2)=20
>> +#if LIBRBD_VERSION_CODE >=3D LIBRBD_VERSION(12, 0, 0)=20
>> #define LIBRBD_SUPPORTS_DISCARD=20
>> #else=20
>> #undef LIBRBD_SUPPORTS_DISCARD=20
>> @@ -73,7 +73,12 @@ typedef struct RBDAIOCB {=20
>> BlockAIOCB common;=20
>> int64_t ret;=20
>> QEMUIOVector *qiov;=20
>> +/* Note:=20
>> + * The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h.=20
>> + */=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> char *bounce;=20
>> +#endif=20
>> RBDAIOCmd cmd;=20
>> int error;=20
>> struct BDRVRBDState *s;=20
>> @@ -83,7 +88,9 @@ typedef struct RADOSCB {=20
>> RBDAIOCB *acb;=20
>> struct BDRVRBDState *s;=20
>> int64_t size;=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> char *buf;=20
>> +#endif=20
>> int64_t ret;=20
>> } RADOSCB;=20
>>=20
>> @@ -426,11 +433,21 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)=20
>> }=20
>> } else {=20
>> if (r < 0) {=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> memset(rcb->buf, 0, rcb->size);=20
>> +#else=20
>> + iov_memset(acb->qiov->iov, acb->qiov->niov, 0, 0, acb->qiov->size);=20
>> +#endif=20
>> acb->ret =3D r;=20
>> acb->error =3D 1;=20
>> } else if (r < rcb->size) {=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> memset(rcb->buf + r, 0, rcb->size - r);=20
>> +#else=20
>> + iov_memset(acb->qiov->iov, acb->qiov->niov,=20
>> + r, 0, acb->qiov->size - r);=20
>> +#endif=20
>> +=20
>> if (!acb->error) {=20
>> acb->ret =3D rcb->size;=20
>> }=20
>> @@ -441,10 +458,12 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)=20
>>=20
>> g_free(rcb);=20
>>=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> if (acb->cmd =3D=3D RBD_AIO_READ) {=20
>> qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);=20
>> }=20
>> qemu_vfree(acb->bounce);=20
>> +#endif=20
>> acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));=20
>>=20
>> qemu_aio_unref(acb);=20
>> @@ -655,8 +674,10 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *=
bs,=20
>> RBDAIOCB *acb;=20
>> RADOSCB *rcb =3D NULL;=20
>> rbd_completion_t c;=20
>> - char *buf;=20
>> int r;=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> + char *buf =3D NULL;=20
>> +#endif=20
>>=20
>> BDRVRBDState *s =3D bs->opaque;=20
>>=20
>> @@ -664,6 +685,8 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *b=
s,=20
>> acb->cmd =3D cmd;=20
>> acb->qiov =3D qiov;=20
>> assert(!qiov || qiov->size =3D=3D size);=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> +=20
>> if (cmd =3D=3D RBD_AIO_DISCARD || cmd =3D=3D RBD_AIO_FLUSH) {=20
>> acb->bounce =3D NULL;=20
>> } else {=20
>> @@ -672,19 +695,21 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState =
*bs,=20
>> goto failed;=20
>> }=20
>> }=20
>> - acb->ret =3D 0;=20
>> - acb->error =3D 0;=20
>> - acb->s =3D s;=20
>> -=20
>> if (cmd =3D=3D RBD_AIO_WRITE) {=20
>> qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);=20
>> }=20
>> -=20
>> buf =3D acb->bounce;=20
>> +#endif=20
>> + acb->ret =3D 0;=20
>> + acb->error =3D 0;=20
>> + acb->s =3D s;=20
>>=20
>> rcb =3D g_new(RADOSCB, 1);=20
>> +=20
>> rcb->acb =3D acb;=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> rcb->buf =3D buf;=20
>> +#endif=20
>> rcb->s =3D acb->s;=20
>> rcb->size =3D size;=20
>> r =3D rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, =
&c);=20
>> @@ -694,10 +719,18 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState =
*bs,=20
>>=20
>> switch (cmd) {=20
>> case RBD_AIO_WRITE:=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> r =3D rbd_aio_write(s->image, off, size, buf, c);=20
>> +#else=20
>> + r =3D rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);=20
>> +#endif=20
>> break;=20
>> case RBD_AIO_READ:=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> r =3D rbd_aio_read(s->image, off, size, buf, c);=20
>> +#else=20
>> + r =3D rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);=20
>> +#endif=20
>> break;=20
>> case RBD_AIO_DISCARD:=20
>> r =3D rbd_aio_discard_wrapper(s->image, off, size, c);=20
>> @@ -719,7 +752,9 @@ failed_completion:=20
>> rbd_aio_release(c);=20
>> failed:=20
>> g_free(rcb);=20
>> +#ifndef LIBRBD_SUPPORTS_IOVEC=20
>> qemu_vfree(acb->bounce);=20
>> +#endif=20
>> qemu_aio_unref(acb);=20
>> return NULL;=20
>> }=20
>> --=20
>> 2.10.2=20
>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=
=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20



--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
