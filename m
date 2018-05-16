Received: from eggs.gnu.org ([2001:4830:134:3::10]:56968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ3mA-0003UU-PC
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ3m9-0007fq-Cr
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:15:58 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-7-jsnow@redhat.com>
	<7e72e02f-856b-520e-4499-fb4978dfa22b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0cf72eca-78bf-a20c-ad2c-e093f5b7936a@redhat.com>
Date: Wed, 16 May 2018 17:15:49 -0400
MIME-Version: 1.0
In-Reply-To: <7e72e02f-856b-520e-4499-fb4978dfa22b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 06/12] qapi: add bitmap info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/14/2018 10:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2018 04:25, John Snow wrote:
>> Add some of the necessary scaffolding for reporting bitmap information=
.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json | 60
>> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>> =C2=A0 1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index c50517bff3..8f33f41ce7 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -33,6 +33,61 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'date-sec': 'int', 'date-nsec': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
>> =C2=A0 +##
>> +# @BitmapTypeEnum:
>> +#
>> +# An enumeration of possible serialized bitmap types.
>> +#
>> +# @dirty-tracking: This bitmap records information on dirty
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 segments within the file.
>> +#
>> +# @unknown: This bitmap is of an unknown or reserved type.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum': 'BitmapTypeEnum', 'data': [ 'dirty-tracking', 'unknown' ] }
>> +
>> +##
>> +# @BitmapFlagEnum:
>> +#
>> +# An enumeration of possible flags for serialized bitmaps.
>> +#
>> +# @in-use: This bitmap is considered to be in-use, and may now be
>> inconsistent.
>> +#
>> +# @auto: This bitmap must reflect any and all changes to the file it
>> describes.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The type of this bitmap m=
ust be @DirtyTrackingBitmap.
>=20
> logical, but I don't see this restriction in the spec. May be we need t=
o
> update the spec
>=20
1: auto

"The bitmap must reflect all changes of the virtual disk by any
application that would write to this qcow2 file (including writes,
snapshot switching, etc.). The type of this bitmap must be 'dirty
tracking bitmap'."

Actually, this looks correct now that I'm looking at the spec again.
I've used a terser phrasing but I think it's correct.

>> +#
>> +# @extra-data-compatible: This bitmap has extra information
>> associated with it.
>=20
> no, this flag means, that extra data is compatible. So, if you don't
> know what is this extra data, you can read and modify the bitmap,
> leaving this data as is. If this flag is unset, and there are some extr=
a
> data, bitmap must not be used.
>=20
> Finally, this spec should be consistent (or, may be better, duplicate)
> spec from docs/interop/qcow2.txt..

I might suggest a rewrite of this portion of the spec as it's a little
unclear to me.

I've given this portion a rewrite.

>> +#
>> +# @unknown: This bitmap has unknown or reserved properties.
>=20
> Better is only "reserved flags" (not unknown and not properties), they
> are reserved by spec.
>=20
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum': 'BitmapFlagEnum', 'data': [ 'in-use', 'auto',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'extra-data-compatible',
>> 'unknown' ] }
>> +
>> +##
>> +# @BitmapInfo:
>> +#
>> +# @name: The name of the bitmap.
>> +#
>> +# @type: The type of bitmap.
>> +#
>> +# @granularity: Bitmap granularity, in bytes.
>> +#
>> +# @count: Overall bitmap dirtiness, in bytes.
>> +#
>> +# @flags: Bitmap flags, if any.
>> +#
>> +# Since: 2.13
>> +#
>> +##
>> +{ 'struct': 'BitmapInfo',
>> +=C2=A0 'data': { 'name': 'str', 'type': 'BitmapTypeEnum', 'granularit=
y':
>> 'int',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'c=
ount': 'int', '*flags': ['BitmapFlagEnum']
>=20
> may be worth add 'has-extra-data'
>=20
>> +=C2=A0 }
>> +}
>> +
>> =C2=A0 ##
>> =C2=A0 # @ImageInfoSpecificQCow2EncryptionBase:
>> =C2=A0 #
>> @@ -69,6 +124,8 @@
>> =C2=A0 # @encrypt: details about encryption parameters; only set if im=
age
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
s encrypted (since 2.10)
>> =C2=A0 #
>> +# @bitmaps: list of image bitmaps (since 2.13)
>> +#
>> =C2=A0 # Since: 1.7
>> =C2=A0 ##
>> =C2=A0 { 'struct': 'ImageInfoSpecificQCow2',
>> @@ -77,7 +134,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*lazy-refcounts': 'bool',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*corrupt': 'bool',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 'int',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*encrypt': 'ImageInfoSpecificQCow2Enc=
ryption'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*encrypt': 'ImageInfoSpecificQCow2Enc=
ryption',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*bitmaps': ['BitmapInfo']
>> =C2=A0=C2=A0=C2=A0 } }
>> =C2=A0 =C2=A0 ##
>=20
>=20
