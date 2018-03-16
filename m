Received: from eggs.gnu.org ([2001:4830:134:3::10]:53463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewuFz-0000JK-JZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewuFv-0005T7-DJ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:39:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ewuFv-0005Sx-7d
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:39:07 -0400
References: <1520010495-58172-1-git-send-email-anton.nefedov@virtuozzo.com>
	<be2cf515-ddf8-74ef-7854-319329ee9209@ilande.co.uk>
	<b73a9767-1a49-9e51-dc79-41a3547df969@ilande.co.uk>
From: John Snow <jsnow@redhat.com>
Message-ID: <b72b4a98-8d54-1ae2-f110-8203200140d6@redhat.com>
Date: Fri, 16 Mar 2018 14:38:50 -0400
MIME-Version: 1.0
In-Reply-To: <b73a9767-1a49-9e51-dc79-41a3547df969@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ide: fix invalid TRIM range abortion for
 macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>



On 03/16/2018 07:20 AM, Mark Cave-Ayland wrote:
> On 05/03/18 21:54, Mark Cave-Ayland wrote:
>=20
>> On 02/03/18 17:08, Anton Nefedov wrote:
>>
>>> commit 947858b0 "ide: abort TRIM operation for invalid range"
>>> is incorrect for macio; just ide_dma_error() without doing a callback
>>> is not enough for that errorpath.
>>>
>>> Instead, pass -EINVAL to the callback and handle it there
>>> (see related motivation for read/write in 58ac32113).
>>>
>>> It will however catch possible EINVAL from the block layer too.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> ---
>>> =C2=A0 hw/ide/core.c | 17 +++++++++--------
>>> =C2=A0 1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index 257b429..54510d4 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -402,7 +402,6 @@ typedef struct TrimAIOCB {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockAIOCB *aiocb;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, j;
>>> -=C2=A0=C2=A0=C2=A0 bool is_invalid;
>>> =C2=A0 } TrimAIOCB;
>>> =C2=A0 static void trim_aio_cancel(BlockAIOCB *acb)
>>> @@ -430,11 +429,8 @@ static void ide_trim_bh_cb(void *opaque)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TrimAIOCB *iocb =3D opaque;
>>> -=C2=A0=C2=A0=C2=A0 if (iocb->is_invalid) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ide_dma_error(iocb->s);
>>> -=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->common.cb(iocb->com=
mon.opaque, iocb->ret);
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 iocb->common.cb(iocb->common.opaque, iocb->ret);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_bh_delete(iocb->bh);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->bh =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_aio_unref(iocb);
>>> @@ -462,7 +458,7 @@ static void ide_issue_trim_cb(void *opaque, int r=
et)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ide_sect_range_ok(s, sector, count=
)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->is_invalid =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->ret =3D -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -502,7 +498,6 @@ BlockAIOCB *ide_issue_trim(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->qiov =3D qiov;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->i =3D -1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->j =3D 0;
>>> -=C2=A0=C2=A0=C2=A0 iocb->is_invalid =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ide_issue_trim_cb(iocb, 0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return &iocb->common;
>>> =C2=A0 }
>>> @@ -848,6 +843,12 @@ static void ide_dma_cb(void *opaque, int ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ECANCELED) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EINVAL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ide_dma_error(s);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ide_handle=
_rw_error(s, -ret,
>>> ide_dma_cmd_to_retry(s->dma_cmd))) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 s->bus->dma->aiocb =3D NULL;
>>>
>>
>> Hi Anton,
>>
>> Thanks for this. I applied this patch to git master with my macio
>> patch at
>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06076.html
>> and it allowed to continue all the way through the Debian installer
>> for the PPC g3beige machine so I believe it is working.
>>
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Hi John,
>=20
> I know that you're busy, but just wondering if you have managed to
> review these 2 TRIM patches? They are a candidate for 2.12 since they
> prevent a qemu-system-ppc segfault on Mac machines when issuing IDE TRI=
M
> commands.
>=20
>=20
> ATB,
>=20
> Mark.

Will send a PR once it looks as if Peter Maydell has caught up with all
of the last-minute PR panic for soft freeze -- they're not forgotten, I
promise!

Thank you for checking in on me.

--John
