Received: from eggs.gnu.org ([2001:4830:134:3::10]:52035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcYio-0000TQ-Pr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcYin-0007Xf-JE
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:09:06 -0400
References: <20180705074638.770905-1-vsementsov@virtuozzo.com>
	<20180705074638.770905-2-vsementsov@virtuozzo.com>
	<2da7c234-6157-18d5-139b-2d4d5480c6b9@redhat.com>
	<7707136c-2b10-9882-6cf1-69aff3226bcd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <547c33fc-24be-17e1-465e-8a933ebf1e47@virtuozzo.com>
Date: Mon, 9 Jul 2018 19:08:50 +0300
MIME-Version: 1.0
In-Reply-To: <7707136c-2b10-9882-6cf1-69aff3226bcd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: disallow
 BDRV_REQ_NO_SERIALISING for write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, pl@kamp.de, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

07.07.2018 00:46, Eric Blake wrote:
> On 07/06/2018 04:32 PM, Eric Blake wrote:
>> On 07/05/2018 02:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Before commit 9ded4a01149 "backup: Use copy offloading",
>>> BDRV_REQ_NO_SERIALISING was used for only one case: read in
>>> copy-on-write operation during backup. Also, the flag was handled only
>>> on read path (in bdrv_co_preadv and bdrv_aligned_preadv).
>>>
>>> After 9ded4a01149, flag is used for not waiting serializing operations
>>> on backup target (in same case of copy-on-write operation). This
>>> behavior change is unsubstantiated and potentially dangerous, let's
>>> drop it.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 include/block/block.h | 13 +++++++++++++
>>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 7 ++++++-
>>> =C2=A0 2 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>
>> Commenting only on the grammar:
>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index e5c7759a0c..a06a4d27de 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>> @@ -50,6 +50,19 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * opened with BDRV_O_UNMAP.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_MAY_UNMAP=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x4,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* The BDRV_REQ_NO_SERIALISING means that we don't =
want to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * wait_serialising_requests(), when reading.
>>
>> Either:
>>
>> /* BDRV_REQ_NO_SERALISING means that...
>>
>> or
>>
>> /* The BDRV_REQ_NO_SERIALISING flag means that...
>>
>> s/want to/want/
>
> Or, after reading patch 3/4,
>
> BDRV_REQ_NO_SERAILISING bypasses request serialisation during reads.
>
> (where the counterpart starts:
>
> BDRV_REQ_SERIALISING forces request serialisation during writes.
> )

hmm. "bypasses request serialisation during reads" - it's not quite=20
right, I think.
NO_SERIALISING means only that we will not wait for other requests.=20
However, our request may be serialising itself, so other requests will=20
wait for it (which, actually don't really make sense, because they will=20
have to wait for original write operation too, which starts before read=20
and finishes after it). So, it's funny, but currently, all=20
"NO_SERIALISING" requests are strictly serialising in fact (except that=20
they intersect with original writes (but in fact, are done before them).

>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This flag is used for backup copy on write =
operation, when=20
>>> we need to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * read old data before write (write notifier =
triggered). It is=20
>>> ok, due to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we already waited for serializing requests =
in initiative=20
>>> write (see
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_aligned_pwritev), and it is necessary =
for the case when=20
>>> initiative
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * write is serializing itself (we'll dead loc=
k waiting it).
>>
>> It is okay since we already waited for other serializing requests in=20
>> the initiating write (see bdrv_aligned_pwritev), and it is necessary=20
>> since the initiating write is already serializing (without the flag,=20
>> the read would deadlock waiting for the write to complete).
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The described case is the only usage for th=
e flag for now,=20
>>> so, it is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * supported only for read operation and restr=
icted for write.
>>
>> This last sentence is rather wordy; I'm fine with just:
>>
>> The flag is only valid during read operations.
>
> Or even just drop this last paragraph, since the first sentence of the=20
> comment already stated it was only for reads.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_NO_SERIALISING=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x8,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_FUA=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x10,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_WRITE_COMPRESSED=C2=A0=C2=A0 =
=3D 0x20,
>>
>> We're inconsistent on which flags we document; it might be nice to=20
>> have a comment for each of them.=C2=A0 But not necessarily this patch's=
=20
>> problem.
>>
>


--=20
Best regards,
Vladimir
