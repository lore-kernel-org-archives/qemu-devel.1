Received: from eggs.gnu.org ([2001:4830:134:3::10]:35392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXTUw-0006i3-97
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXTUr-0000a3-I2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:06:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
	<20181130144705.77454-10-anton.nefedov@virtuozzo.com>
	<8736r1bou7.fsf@dusky.pond.sub.org>
	<9567be7b-f372-ef64-72f4-4ba2a361b9b9@virtuozzo.com>
Date: Thu, 13 Dec 2018 17:05:30 +0100
In-Reply-To: <9567be7b-f372-ef64-72f4-4ba2a361b9b9@virtuozzo.com> (Anton
	Nefedov's message of "Thu, 13 Dec 2018 15:20:51 +0000")
Message-ID: <87pnu5mmyd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "famz@redhat.com" <famz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "jsnow@redhat.com" <jsnow@redhat.com>

Anton Nefedov <anton.nefedov@virtuozzo.com> writes:

> On 13/12/2018 3:20 PM, Markus Armbruster wrote:
>> I'm reviewing just the QAPI schema today.
>> 
>> Anton Nefedov <anton.nefedov@virtuozzo.com> writes:
>> 
>>> A block driver can provide a callback to report driver-specific
>>> statistics.
>>>
>>> file-posix driver now reports discard statistics
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
[...]
>>> @@ -892,6 +927,8 @@
>>>   #
>>>   # @stats:  A @BlockDeviceStats for the device.
>>>   #
>>> +# @driver-specific: Optional driver-specific stats. (Since 4.0)
>>> +#
>>>   # @parent: This describes the file block device if it has one.
>>>   #          Contains recursively the statistics of the underlying
>>>   #          protocol (e.g. the host file for a qcow2 image). If there is
>>> @@ -905,6 +942,7 @@
>>>   { 'struct': 'BlockStats',
>>>     'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
>>>              'stats': 'BlockDeviceStats',
>>> +           '*driver-specific': 'BlockStatsSpecific',
>>>              '*parent': 'BlockStats',
>>>              '*backing': 'BlockStats'} }
>>>   
>> 
>> Feels awkward.
>> 
>> When is @driver-specific present?  Exactly when the driver is 'file' or
>> 'host_device'?  If that's correct, then turning BlockStats into a union
>> would be clearer and reduce parenthesises on the wire:
>> 
>> { 'union': 'BlockStats',
>>    'base': {
>>        'driver': 'BlockdevDriver',
>>        ... all the other existing members of BlockStats ... }
>>    'discriminator': 'driver',
>>    'data': {
>>        'file': 'BlockStatsSpecificFile',
>>        'host_device': 'BlockStatsSpecificFile' } }
>> 
>> [...]
>> 
>
> this series drags for quite a while - we already discussed this :)
> In short: Blockdev does not always have driver, so it's either this
> or adding weird BlockdevDriver values like "none".
>
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01845.html

You're right.
