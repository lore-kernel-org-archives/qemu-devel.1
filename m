Received: from eggs.gnu.org ([2001:4830:134:3::10]:50556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebnu0-0007Nd-04
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebntv-0000Dm-Vk
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:37:16 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
Message-ID: <79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
Date: Wed, 17 Jan 2018 16:36:50 +0300
MIME-Version: 1.0
In-Reply-To: <4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

15.01.2018 20:47, Vladimir Sementsov-Ogievskiy wrote:
> 15.01.2018 18:09, Eric Blake wrote:
>> On 01/12/2018 03:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 09.01.2018 22:52, Eric Blake wrote:
>>>> On 12/07/2017 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Add command for export removing. It is needed for cases when we
>>>>> don't want to keep export after the operation on it was completed.
>>>>> The other example is temporary node, created with blockdev-add.
>>>>> If we want to delete it we should firstly remove corresponding
>>>>> NBD export.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy 
>>>>> <vsementsov@virtuozzo.com>
>>>>> ---
>>>> Do we want a third mode in the middle, where the server starts 
>>>> replying
>>>> to all existing clients with ESHUTDOWN errors for all new requests
>>>> rather than abruptly disconnecting (no new I/O, but no forced 
>>>> disconnect
>>>> and pending in-flight transactions can still complete gracefully)?
>>> looks interesting. what about the following naming?
>>>
>>> @mode: possible values:
>>>                hide - just hide server from new clients, maintain
>>> existing connections,
>>>                            remove after all clients disconnected
>>>                soft - like hide, but answer with ESHUTDOWN for all
>>> further requests from
>>>                            existing connections
>>>                hard - hard disconnect all clients and remove server
>>>                (default: soft)
>> Or even a fourth mode that causes an immediate error return without
>> state change if there are any connected clients, but otherwise removes
>> the server.
>>
>>> new corresponding states of nbd export:
>>> hidden, shutting_down
>>>
>>> and we allow transitions:
>>>
>>> normal_execution -> hidden
>>> normal_execution -> shutting_down
>>> normal_execution -> exit
>>> hidden -> shutting_down
>>> hidden -> exit
>>> shutting_down -> exit
>> Seems reasonable.  Are you planning on tackling a respin of this series
>> incorporating that idea?
>>
>
> yes, will do.
>
>

Discussed with Nikolay.
For now we actually need only one mode: hard.
In near future we _may be_ will need your proposed fourth mode (what 
about "safe" name for it ?)

I was going to implement all 4 modes, but now I doubt, isn't it too 
hastily, to introduce 3 new modes to the
interface, which we (personally) do not need. May be it is better to 
start from one or two modes.

Finally what do you think, Eric? Which modes do you need?

ps: I've created hmp version for 2/6, it will be in v2.
  also, I'm going to add query-nbd-server, which should list all exports

also, about HMP: If I understand correctly, people use it because 
writing qmp command by hand is not very comfortable.
I have a script (for managing libvirt guest, but it can be adopted for 
qemu or even used for qemu monitor), which allows
me run qmp commands on vms as easy as:

|qmp VMNAME query-block-jobs or qmp VMNAME nbd-server-remove name exp1 
mode hard or even |

|qmp VMNAME blockdev-add id disk driver qcow2 cache {writeback true 
direct true} aio native discard unmap file {driver file filename 
/tmp/somedisk} |||

-- 
Best regards,
Vladimir
