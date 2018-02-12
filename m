Received: from eggs.gnu.org ([2001:4830:134:3::10]:53663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elH7t-00063T-Lg
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elH7s-0001xO-Jv
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:38:45 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
	<87tvuyf4it.fsf@dusky.pond.sub.org>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <8639a69c-ca85-d11b-7aaa-e67ffb660991@virtuozzo.com>
Date: Mon, 12 Feb 2018 19:38:34 +0300
MIME-Version: 1.0
In-Reply-To: <87tvuyf4it.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com



On 3/2/2018 6:59 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 01/19/2018 06:50 AM, Anton Nefedov wrote:
>>> +
>>> +##
>>> +# @BlockDriverStats:
>>> +#
>>> +# Statistics of a block driver (driver-specific)
>>> +#
>>> +# Since: 2.12
>>> +##
>>> +{ 'union': 'BlockDriverStats',
>>> +  'data': {
>>> +      'file': 'BlockDriverStatsFile'
>>> +  } }
>>
>> Markus has been adamant that we add no new "simple unions" (unions with
>> a 'discriminator' field) - because they are anything but simple in the
>> long run.
> 
> Indeed.  You could make this a flat union, similar to BlockdevOptions:
> 
> { 'union': 'BlockDriverStats':
>    'base': { 'driver': 'BlockdevDriver' },
>    'discriminator': 'driver',
>    'data': {
>        'file': 'BlockDriverStatsFile',
>        ... } }
> 
> However:
> 
>>> +
>>> +##
>>>   # @BlockStats:
>>>   #
>>>   # Statistics of a virtual block device or a block backing device.
>>> @@ -785,6 +819,8 @@
>>>   #
>>>   # @stats:  A @BlockDeviceStats for the device.
>>>   #
>>> +# @driver-stats: Optional driver-specific statistics. (Since 2.12)
>>> +#
>>>   # @parent: This describes the file block device if it has one.
>>>   #          Contains recursively the statistics of the underlying
>>>   #          protocol (e.g. the host file for a qcow2 image). If there is
>>> @@ -798,6 +834,7 @@
>>>   { 'struct': 'BlockStats',
>>>     'data': {'*device': 'str', '*node-name': 'str',
>>>              'stats': 'BlockDeviceStats',
>>> +           '*driver-stats': 'BlockDriverStats',
> 
> You're adding a union of driver-specific stats to a struct of generic
> stats.  That's unnecessarily complicated.  Instead, turn the struct of
> generic stats into a flat union, like this:
> 
> { 'union': 'BlockStats',
>    'base': { ... the generic stats, i.e. the members of BlockStats
>              before this patch ...
>              'driver': 'BlockdevDriver' }
>    'discriminator': 'driver',
>    'data': {
>        'file': 'BlockDriverStatsFile',
>        ... } }
> 
>> ...[1] You are using it alongside a struct that already uses '-'
>> (node-name), so you should use dashes.
>>
>> So, the difference between your proposal (a simple union) and using a
>> "flat union", on the wire, is yours:
>>
>> "return": { ..., "driver-stats": { "type": "file", "data": {
>> "discard_nb_ok: ... } } }
>>
>> vs. a flat union:
>>
>> "return": { ..., "driver-stats": { "driver": "file", "discard-nb-ok":
>> ... } }
>>
>> where you can benefit from less nesting and a saner discriminator name.
> 
> My proposal peels off yet another level of nesting.
> 

The output is better indeed, thanks; a little drawback is now we need to
pass the whole BlockStats to the driver so it fills its stats.

e.g. the interface:

     void (*bdrv_get_stats)(BlockDriverState *bs, BlockStats *stats);

And that BlockdevDriver subset type (or a generator patch) still seems
to be needed

   { 'enum' : 'BlockdevDriverWithStats',
     'data' : [ 'file' ] }
