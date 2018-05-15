Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fIbQW-0003BS-5d
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fIbQV-00033z-5t
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:59:44 -0400
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1525791496-125188-2-git-send-email-anton.nefedov@virtuozzo.com>
	<d61d47db-a121-a3e3-5bd8-312af5511991@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <7bb6f859-6b8c-7d70-d691-703c040ca9be@virtuozzo.com>
Date: Tue, 15 May 2018 17:59:30 +0300
MIME-Version: 1.0
In-Reply-To: <d61d47db-a121-a3e3-5bd8-312af5511991@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@virtuozzo.com, berto@igalia.com



On 15/5/2018 5:35 PM, Eric Blake wrote:
> On 05/08/2018 09:58 AM, Anton Nefedov wrote:
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 820f512..a22ddef 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1098,6 +1098,15 @@ static BlockDriver bdrv_mirror_top =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_child_perm=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D bdrv_mirror_top_child_perm,
>> =C2=A0 };
>> +static void mirror_top_set_supported_flags(BlockDriverState *bs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 bs->supported_write_flags =3D BDRV_REQ_FUA &
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->backing->bs->supported_w=
rite_flags;
>> +=C2=A0=C2=A0=C2=A0 bs->supported_zero_flags =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BDRV_REQ_FUA | BDRV_REQ_MAY=
_UNMAP) &
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->backing->bs->supported_z=
ero_flags;
>> +}
>> +
>=20
> This is a pretty short static function...
>=20
>> =C2=A0 static void mirror_start_job(const char *job_id, BlockDriverState=
 *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int creation_flags, BlockDriverState=20
>> *target,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *replaces, int64_t speed,
>> @@ -1163,6 +1172,8 @@ static void mirror_start_job(const char *job_id,=20
>> BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 mirror_top_set_supported_flags(mirror_top_bs);
>=20
> ...with exactly one caller.=C2=A0 Wouldn't it be easier to just inline it=
?
>=20

idk, I felt mirror_start_job() was quite massive already, even
considering there are just a few new lines.
