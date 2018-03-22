Received: from eggs.gnu.org ([2001:4830:134:3::10]:37083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ez2N9-0002F1-8Z
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ez2N4-0005tm-Fq
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:43:23 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-5-vsementsov@virtuozzo.com>
	<8b6eccd8-90ee-3475-5005-df9f59f59709@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f3f02fac-35d9-2a4d-0fef-ba66f75aa929@virtuozzo.com>
Date: Thu, 22 Mar 2018 18:43:08 +0300
MIME-Version: 1.0
In-Reply-To: <8b6eccd8-90ee-3475-5005-df9f59f59709@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

21.03.2018 20:33, Eric Blake wrote:
> On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block.json | 27 +++++++++++++++++++++++++++
>> =C2=A0 blockdev-nbd.c=C2=A0 | 23 +++++++++++++++++++++++
>> =C2=A0 2 files changed, 50 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index c694524002..4afbbcd7b7 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -269,6 +269,33 @@
>> =C2=A0=C2=A0=C2=A0 'data': {'name': 'str', '*mode': 'NbdServerRemoveMode=
'} }
>> =C2=A0 =C2=A0 ##
>> +# @nbd-server-add-bitmap:
>> +#
>> +# Export dirty bitmap through selected export. Bitmaps are searched=20
>> for in
>> +# device attached to the export and in all its backings. Exported=20
>> bitmap
>> +# is locked until NBD export is removed.
>
> Expose a dirty bitmap associated with the selected export.=C2=A0 The bitm=
ap=20
> search starts at the device attached to the export, and includes all=20
> backing files.=C2=A0 The exported bitmap is then locked until the NBD=20
> export is removed.
>
>> +#
>> +# @name: Export name.
>> +#
>> +# @bitmap: Bitmap name to search.
>
> s/search./search for./
>
>> +#
>> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (default @bitmap)
>
> Maybe mention that the client must use NBD_OPT_SET_META_CONTEXT with a=20
> query of "qemu-dirty-bitmap:NAME" (where NAME matches=20
> bitmap-export-name) to access the exposed bitmap.=C2=A0 (May need to be=20
> adjusted by my suggestion to use just the namespace "qemu:")

ok

>
>> +#
>> +#
>> +# Returns: error on one of the following conditions:
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - the ser=
ver is not running
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - export =
is not found
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitmap =
is not found
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitmap =
is disabled
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - bitmap =
is locked
>
> Do we really need to list all the error conditions?=C2=A0 My worry is tha=
t=20
> a list this specific might go stale, compared to the obvious default=20
> that the command succeeds only if it was able to expose the bitmap and=20
> that the error message is specific enough for a human to figure out=20
> what to fix if it failed.


Hmm, I've just doing it similar with other commands in the file. Is=20
there any requirements on this part of qapi documentation? I can write=20
only "# Returns: nothing on success" line, is it appropriate?=20
blockdev-mirror do so, but other commands tries to describe errors.=20
Looks like we lack some specified format for return code description=20
like we have for parameters..

>
>> +#
>> +# Since: 2.13
>> +##
>> +=C2=A0 { 'command': 'nbd-server-add-bitmap',
>> +=C2=A0=C2=A0=C2=A0 'data': {'name': 'str', 'bitmap': 'str', '*bitmap-ex=
port-name':=20
>> 'str'} }
>> +
>


--=20
Best regards,
Vladimir
