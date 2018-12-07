Received: from eggs.gnu.org ([2001:4830:134:3::10]:40160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJyv-0003vM-DC
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJyt-0000Dz-RN
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:32:05 -0500
References: <1544176849-899477-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<5c525644-cc38-9d0b-c591-6d75315e25cc@redhat.com>
	<d3507d7b-1bfe-0ae6-fd83-693272785f0d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46df3ce6-c091-93e4-10c4-4d71687eadc4@redhat.com>
Date: Fri, 7 Dec 2018 11:31:42 -0600
MIME-Version: 1.0
In-Reply-To: <d3507d7b-1bfe-0ae6-fd83-693272785f0d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>, John Snow <jsnow@redhat.com>

On 12/7/18 11:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.12.2018 19:20, Eric Blake wrote:
>> On 12/7/18 4:00 AM, Andrey Shinkevich wrote:
>>> +++ b/block/qcow2.c
>>> @@ -4270,6 +4270,12 @@ static ImageInfoSpecific *qcow2_get_specific_i=
nfo(BlockDriverState *bs)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .refcount_bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D s->refcount_bi=
ts,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s->qcow_version =3D=3D 3) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapInfoList *bitm=
aps;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps =3D qcow2_get_bit=
map_info_list(bs, &local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report_err(local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Ouch. Calling error_report_err() doesn't always work in QMP context; b=
etter would be to plumb Error **errp back up to the caller, if getting th=
is specific information can fail and we want the overall query-block to f=
ail.=C2=A0 Or, we could decide that failure to get bitmap info is non-fat=
al, and that it was just a best-effort attempt to get more info, where we=
 then ignore the failure, rather than trying to report it incorrectly.
>=20
> Oh, yes, you are right. Strange, but  bdrv_get_specific_info lacks errp=
. error_abort us used above for crypto info errors.

And thus we should probably fix that - but it doesn't have to be part of=20
this series.

>=20
> Querying bitmaps needs disk access so it really may fail, and it may be=
 sad to fail get any information because of repeating some disk/qcow2 err=
or, so it's better not to abort and even not to fail qmp command here.
>=20

>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*encrypt': 'ImageInfoSpecificQCow2En=
cryption'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*encrypt': 'ImageInfoSpecificQCow2En=
cryption',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*bitmaps': ['Qcow2BitmapInfo']
>>
>> Hmm. You're omitting this field both if there are 0 bitmaps, and when =
it was a version 2 image. Is it worth including this field as a 0-length =
array when there are no bitmaps but when the image format is new enough t=
o support them, or are we happy with the idea of only including the field=
 when it has at least one bitmap?=C2=A0 The difference is whether the cal=
ling app can explicitly learn that there are no bitmaps (0-length reply) =
vs. the ambiguity of omitting it from the reply (missing might mean no bi=
tmaps, or an error in trying to report the bitmaps, or an older qemu that=
 didn't know how to report bitmaps).
>=20
> Hmm, I don't like overusing .has_bitmaps as a sign of error, at least i=
t would be very weird to document such behavior, and a undocumented trick=
 it is not really useful.
> Hmm, if we want something like this I'd prefer .has_bitmaps to be false=
 only in case of error, so for v2 we'll have empty array. It's simpler to=
 document.

I'm happy with v2 images reporting a 0-length array instead of omitting=20
the field, especially if that means we can simply have:

old qemu: field always omitted because we didn't compute it
new qemu: field omitted if we hit an error computing it
           otherwise present (but possibly 0 length) and accurate

>=20
> Or we need separate cant_load_bitmaps: bool, or bitmaps should be enum =
of ( ['Qcow2BitmapInfo'] , {'error': 'str'} ), do we have something like =
this already in QAPI? This is the question about partial success of info-=
exporting commands.

No, I don't see a reason to over-engineer things; query-block is already=20
a behemoth without trying to jam in more details about whether=20
info-exporting hit partial failure.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
