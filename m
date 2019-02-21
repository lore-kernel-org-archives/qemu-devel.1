Received: from eggs.gnu.org ([209.51.188.92]:52485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwnf6-00080F-Hx
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwnbB-0007dH-KJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:37:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
	<20181130144705.77454-10-anton.nefedov@virtuozzo.com>
	<8736r1bou7.fsf@dusky.pond.sub.org>
	<9567be7b-f372-ef64-72f4-4ba2a361b9b9@virtuozzo.com>
Date: Thu, 21 Feb 2019 13:36:56 +0100
In-Reply-To: <9567be7b-f372-ef64-72f4-4ba2a361b9b9@virtuozzo.com> (Anton
	Nefedov's message of "Thu, 13 Dec 2018 15:20:51 +0000")
Message-ID: <87k1htiahj.fsf@dusky.pond.sub.org>
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
>>> ---
>>>   qapi/block-core.json      | 38 ++++++++++++++++++++++++++++++++++++++
>>>   include/block/block.h     |  1 +
>>>   include/block/block_int.h |  1 +
>>>   block.c                   |  9 +++++++++
>>>   block/file-posix.c        | 32 ++++++++++++++++++++++++++++++++
>>>   block/qapi.c              |  5 +++++
>>>   6 files changed, 86 insertions(+)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 959358ccc4..b100e852c7 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -877,6 +877,41 @@
>>>              '*x_wr_latency_histogram': 'BlockLatencyHistogramInfo',
>>>              '*x_flush_latency_histogram': 'BlockLatencyHistogramInfo' } }
>>>   
>>> +##
>>> +# @BlockStatsSpecificFile:
>>> +#
>>> +# File driver statistics
>>> +#
>>> +# @discard-nb-ok: The number of succeeded discard operations performed by
>> 
>> successful discard operations
>> 
>
> Fixed.
>
>>> +#                 the driver.
>>> +#
>>> +# @discard-nb-failed: The number of failed discard operations performed by
>>> +#                     the driver.
>>> +#
>>> +# @discard-bytes-ok: The number of bytes discarded by the driver.
>>> +#
>>> +# Since: 4.0
>>> +##
>>> +{ 'struct': 'BlockStatsSpecificFile',
>>> +  'data': {
>>> +      'discard-nb-ok': 'int',
>>> +      'discard-nb-failed': 'int',
>>> +      'discard-bytes-ok': 'int' } }
>> 
>> Should these be unsigned?
>> 
>> For what it's worth, similar counters nearby are also 'int'.
>> 
>
> And I just added these symmetrically.
> Probably shouldn't have - let these be uint64.
>
>>> +
>>> +##
>>> +# @BlockStatsSpecific:
>>> +#
>>> +# Block driver specific statistics
>>> +#
>>> +# Since: 4.0
>>> +##
>>> +{ 'union': 'BlockStatsSpecific',
>>> +  'base': { 'driver': 'BlockdevDriver' },
>>> +  'discriminator': 'driver',
>>> +  'data': {
>>> +      'file': 'BlockStatsSpecificFile',
>>> +      'host_device': 'BlockStatsSpecificFile' } }
>>> +
>>>   ##
>>>   # @BlockStats:
>>>   #
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

With the comment tweak:
Acked-by: Markus Armbruster <armbru@redhat.com>
