Received: from eggs.gnu.org ([2001:4830:134:3::10]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqtDv-0000Wt-Fz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqtDr-0008Fd-04
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:20:11 -0500
References: <20180223184700.28854-1-mark.cave-ayland@ilande.co.uk>
	<ad6019e6-cc8f-f485-8e0e-9040a18704c8@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d6f6d263-132d-f15b-3048-917624c0bf6d@redhat.com>
Date: Tue, 27 Feb 2018 23:19:57 -0500
MIME-Version: 1.0
In-Reply-To: <ad6019e6-cc8f-f485-8e0e-9040a18704c8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] macio: fix NULL pointer dereference when
 issuing IDE trim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org



On 02/26/2018 03:56 AM, Anton Nefedov wrote:
>=20
>=20
> On 23/2/2018 9:47 PM, Mark Cave-Ayland wrote:
>> Commit ef0e64a983 "ide: pass IDEState to trim AIO callback" changed th=
e
>> IDE trim callback from using a BlockBackend to an IDEState but forgot
>> to update
>> the dma_blk_io() call in hw/ide/macio.c accordingly.
>>
>=20
> I somehow missed this whole macio part in that series :(
>=20

It's my mistake entirely.

>> Without this fix qemu-system-ppc segfaults when issuing an IDE trim
>> command on
>> any of the PPC Mac machines (easily triggered by running the Debian
>> installer).
>>
>> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Reviewed-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> ..but there should also be a fix-up for
> 947858b "ide: abort TRIM operation for invalid range"
> which apparently lacks a few steps on the invalid range errorpath for
> macio. I'll look into that.
>=20

I'm unfortunately a little preoccupied right now, please CC me
(hopefully before 2.12 freeze!) and I'll get this squared away for next
release.

>> ---
>> =C2=A0 hw/ide/macio.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
>> index 2e043ef1ea..d3a85cba3b 100644
>> --- a/hw/ide/macio.c
>> +++ b/hw/ide/macio.c
>> @@ -187,7 +187,7 @@ static void pmac_ide_transfer_cb(void *opaque, int
>> ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IDE_DMA_TRIM:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bus->dma->ai=
ocb =3D dma_blk_io(blk_get_aio_context(s->blk),
>> &s->sg,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset, 0x1, ide_issue_trim,
>> s->blk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset, 0x1, ide_issue_trim, s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pmac_ide_transfer_cb, io,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 DMA_DIRECTION_TO_DEVICE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>
>=20

In the meantime, I'm going to stage this for tomorrow so Mark doesn't
have to deal with a broken tree.

--js
