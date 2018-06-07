Received: from eggs.gnu.org ([2001:4830:134:3::10]:54218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQwYM-0001vR-SG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQwYI-0001rU-Ag
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:10:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
	<87tvuyf4it.fsf@dusky.pond.sub.org>
	<959271ee-c39e-09ab-9f9a-90d97d34f4f5@virtuozzo.com>
Date: Thu, 07 Jun 2018 17:09:58 +0200
In-Reply-To: <959271ee-c39e-09ab-9f9a-90d97d34f4f5@virtuozzo.com> (Anton
	Nefedov's message of "Thu, 7 Jun 2018 17:32:04 +0300")
Message-ID: <87wovar5tl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

Anton Nefedov <anton.nefedov@virtuozzo.com> writes:

> On 3/2/2018 6:59 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 01/19/2018 06:50 AM, Anton Nefedov wrote:
>>>> A block driver can provide a callback to report driver-specific
>>>> statistics.
>>>>
>>>> file-posix driver now reports discard statistics
>>>>
>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
> [..]
>>>> +##
>>>> +# @BlockDriverStats:
>>>> +#
>>>> +# Statistics of a block driver (driver-specific)
>>>> +#
>>>> +# Since: 2.12
>>>> +##
>>>> +{ 'union': 'BlockDriverStats',
>>>> +  'data': {
>>>> +      'file': 'BlockDriverStatsFile'
>>>> +  } }
>>>
>>> Markus has been adamant that we add no new "simple unions" (unions with
>>> a 'discriminator' field) - because they are anything but simple in the
>>> long run.
>>
>> Indeed.  You could make this a flat union, similar to BlockdevOptions:
>>
>> { 'union': 'BlockDriverStats':
>>    'base': { 'driver': 'BlockdevDriver' },
>>    'discriminator': 'driver',
>>    'data': {
>>        'file': 'BlockDriverStatsFile',
>>        ... } }
>>
>> However:
>>
>>>> +
>>>> +##
>>>>   # @BlockStats:
>>>>   #
>>>>   # Statistics of a virtual block device or a block backing device.
>>>> @@ -785,6 +819,8 @@
>>>>   #
>>>>   # @stats:  A @BlockDeviceStats for the device.
>>>>   #
>>>> +# @driver-stats: Optional driver-specific statistics. (Since 2.12)
>>>> +#
>>>>   # @parent: This describes the file block device if it has one.
>>>>   #          Contains recursively the statistics of the underlying
>>>>   #          protocol (e.g. the host file for a qcow2 image). If there is
>>>> @@ -798,6 +834,7 @@
>>>>   { 'struct': 'BlockStats',
>>>>     'data': {'*device': 'str', '*node-name': 'str',
>>>>              'stats': 'BlockDeviceStats',
>>>> +           '*driver-stats': 'BlockDriverStats',
>>
>> You're adding a union of driver-specific stats to a struct of generic
>> stats.  That's unnecessarily complicated.  Instead, turn the struct of
>> generic stats into a flat union, like this:
>>
>> { 'union': 'BlockStats',
>>    'base': { ... the generic stats, i.e. the members of BlockStats
>>              before this patch ...
>>              'driver': 'BlockdevDriver' }
>>    'discriminator': 'driver',
>>    'data': {
>>        'file': 'BlockDriverStatsFile',
>>        ... } }
>>
>
> hi,
>
> (resurrecting this series now that there is no-more-dummy-enums patchset
> https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06836.html )
>
> If we introduce BlockdevDriver as a discriminator as Markus suggests
> above, we need some way to define its value.
> I guess one would be to check blk->bs->drv->format_name but it won't
> always work; often it's even blk->bs == NULL.

There is no blk->bs, at least not if blk is a BlockBackend *.

I figure the problem you're trying to describe is query-blockstats
running into BlockBackends that aren't associated with a
BlockDriverState (blk->root is null), and thus aren't associated with a
BlockDriver.  Correct?

> I guess we could add a default ('unspecified'?) to BlockdevDriver enum?

This part I understand, but...

> But I'd rather leave an optional BlockDriverStats union (but make it
> flat). Only the drivers that provide these stats will need to set
> BlockdevDriver field. What do you think?

I'm not sure I got this part.  Care to sketch the QAPI schema snippet?
