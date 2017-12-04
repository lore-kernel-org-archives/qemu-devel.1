Received: from eggs.gnu.org ([2001:4830:134:3::10]:58501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eLmb0-0006sS-30
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eLmaz-0002lY-DQ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:59:26 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-13-eblake@redhat.com>
	<fd6ad85b-ea0c-0941-4402-4b8306a87533@virtuozzo.com>
	<922a4b71-664a-0316-1aa7-f56e0cc7f1ae@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <58dfb296-58e5-5eab-8de2-fe9d52e49205@virtuozzo.com>
Date: Mon, 4 Dec 2017 11:59:09 +0300
MIME-Version: 1.0
In-Reply-To: <922a4b71-664a-0316-1aa7-f56e0cc7f1ae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 12/20] qed: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

01.12.2017 02:17, Eric Blake wrote:
> On 11/30/2017 04:27 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 12.10.2017 21:59, Eric Blake wrote:
>>> We are gradually moving away from sector-based interfaces, towards
>>> byte-based.=C2=A0 Update the qed driver accordingly, taking the opportu=
nity
>>> to inline qed_is_allocated_cb() into its lone caller (the callback
>>> used to be important, until we switched qed to coroutines). There is
>>> no intent to optimize based on the want_zero flag for this format.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQEDState *s =3D bs->opaque;
>>> -=C2=A0=C2=A0=C2=A0 size_t len =3D (size_t)nb_sectors * BDRV_SECTOR_SIZ=
E;
>>> -=C2=A0=C2=A0=C2=A0 QEDIsAllocatedCB cb =3D {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bs =3D bs,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pos =3D (uint64_t)sector_n=
um * BDRV_SECTOR_SIZE,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .status =3D BDRV_BLOCK_OFFS=
ET_MASK,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pnum =3D pnum,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .file =3D file,
>>> -=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 size_t len;
>>
>> size_t len =3D bytes;
>>
>
> Or rather, size_t len =3D MIN(bytes, SIZE_MAX); thanks to 32-bit platform=
s.

ok, this is even better

>
>> with that:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>>> +=C2=A0=C2=A0=C2=A0 int status;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEDRequest request =3D { .l2_table =3D N=
ULL };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->table_lock);
>>> -=C2=A0=C2=A0=C2=A0 ret =3D qed_find_cluster(s, &request, cb.pos, &len,=
 &offset);
>>> -=C2=A0=C2=A0=C2=A0 qed_is_allocated_cb(&cb, ret, offset, len);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D qed_find_cluster(s, &request, pos, &len, &o=
ffset);
>>
>> len is in-out parameter, you can't use it uninitialized.
>
> Good catch.
>


--=20
Best regards,
Vladimir
