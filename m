Received: from eggs.gnu.org ([2001:4830:134:3::10]:32926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZvwY-0002M7-CC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZvwX-0002Gc-Bt
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:48:10 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
Date: Fri, 12 Jan 2018 12:47:55 +0300
MIME-Version: 1.0
In-Reply-To: <74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

09.01.2018 22:52, Eric Blake wrote:
> On 12/07/2017 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add command for export removing. It is needed for cases when we
>> don't want to keep export after the operation on it was completed.
>> The other example is temporary node, created with blockdev-add.
>> If we want to delete it we should firstly remove corresponding
>> NBD export.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block.json     | 18 ++++++++++++++++++
>>   include/block/nbd.h |  3 ++-
>>   blockdev-nbd.c      | 29 ++++++++++++++++++++++++++++-
>>   nbd/server.c        | 25 ++++++++++++++++++++++---
>>   4 files changed, 70 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 503d4b287b..f83485c325 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -228,6 +228,24 @@
>>     'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
>>  =20
>>   ##
>> +# @nbd-server-remove:
>> +#
>> +# Remove NBD export by name.
>> +#
>> +# @name: Export name.
>> +#
>> +# @force: Whether active connections to the export should be closed. If=
 this
>> +#         parameter is false the export only becomes hidden from client=
s (new
>> +#         connections are impossible), and would be automatically freed=
 after
>> +#         all clients are disconnected (default false).
> Unstated, but if the parameter is true, existing clients are forcefully
> disconnected, possibly losing pending transactions.
>
> Do we want a third mode in the middle, where the server starts replying
> to all existing clients with ESHUTDOWN errors for all new requests
> rather than abruptly disconnecting (no new I/O, but no forced disconnect
> and pending in-flight transactions can still complete gracefully)?

looks interesting. what about the following naming?

@mode: possible values:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hide - just hide server from new clients, maintain=20
existing connections,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 remove after all clients disconnected
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 soft - like hide, but answer with ESHUTDOWN for all=20
further requests from
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 existi=
ng connections
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hard - hard disconnect all clients and remove server
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (default: soft)

new corresponding states of nbd export:
hidden, shutting_down

and we allow transitions:

normal_execution -> hidden
normal_execution -> shutting_down
normal_execution -> exit
hidden -> shutting_down
hidden -> exit
shutting_down -> exit


>
>> +#
>> +# Returns: error if the server is not running or export is not found.
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'command': 'nbd-server-remove', 'data': {'name': 'str', '*force': 'bo=
ol'} }
>> +
> If we're okay with just the bool parameter, then this patch looks good;
> but if we want a third mode, then we want '*force' to be an enum type.
> So tentative:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>


--=20
Best regards,
Vladimir
