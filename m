Received: from eggs.gnu.org ([2001:4830:134:3::10]:50956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1edwkw-0004Cs-5Y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1edwkp-0004EO-MW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:28:45 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <0ef02c21-bfd0-eb67-78bb-4728a8384cdb@virtuozzo.com>
Date: Tue, 23 Jan 2018 14:28:24 +0300
MIME-Version: 1.0
In-Reply-To: <b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com



On 22/1/2018 11:55 PM, Eric Blake wrote:
> On 01/19/2018 06:50 AM, Anton Nefedov wrote:
>> A block driver can provide a callback to report driver-specific
>> statistics.
>>
>> file-posix driver now reports discard statistics
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
> 
>> +++ b/qapi/block-core.json
>> @@ -774,6 +774,40 @@
>>              'timed_stats': ['BlockDeviceTimedStats'] } }
>>   
>>   ##
>> +# @BlockDriverStatsFile:
>> +#
>> +# File driver statistics
>> +#
>> +# @discard_nb_ok: The number of succeeded discard operations performed by
>> +#                 the driver.
>> +#
>> +# @discard_nb_failed: The number of failed discard operations performed by
>> +#                     the driver.
>> +#
>> +# @discard_bytes_ok: The number of bytes discarded by the driver.
>> +#
>> +# Since 2.12
>> +##
>> +{ 'struct': 'BlockDriverStatsFile',
>> +  'data': {
>> +      'discard_nb_ok': 'int',
>> +      'discard_nb_failed': 'int',
>> +      'discard_bytes_ok': 'int'
>> +  } }
> 
> New interfaces should prefer '-' over '_', where possible (a reason for
> using '_' is if the fields are alongside pre-existing fields that
> already used '_').  Let's see how this gets used...[1]
> 
>> +
>> +##
>> +# @BlockDriverStats:
>> +#
>> +# Statistics of a block driver (driver-specific)
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'union': 'BlockDriverStats',
>> +  'data': {
>> +      'file': 'BlockDriverStatsFile'
>> +  } }
> 
> Markus has been adamant that we add no new "simple unions" (unions with
> a 'discriminator' field) - because they are anything but simple in the
> long run.
> 
>> +
>> +##
>>   # @BlockStats:
>>   #
>>   # Statistics of a virtual block device or a block backing device.
>> @@ -785,6 +819,8 @@
>>   #
>>   # @stats:  A @BlockDeviceStats for the device.
>>   #
>> +# @driver-stats: Optional driver-specific statistics. (Since 2.12)
>> +#
>>   # @parent: This describes the file block device if it has one.
>>   #          Contains recursively the statistics of the underlying
>>   #          protocol (e.g. the host file for a qcow2 image). If there is
>> @@ -798,6 +834,7 @@
>>   { 'struct': 'BlockStats',
>>     'data': {'*device': 'str', '*node-name': 'str',
>>              'stats': 'BlockDeviceStats',
>> +           '*driver-stats': 'BlockDriverStats',
> 
> ...[1] You are using it alongside a struct that already uses '-'
> (node-name), so you should use dashes.
> 
> So, the difference between your proposal (a simple union) and using a
> "flat union", on the wire, is yours:
> 
> "return": { ..., "driver-stats": { "type": "file", "data": {
> "discard_nb_ok: ... } } }
> 
> vs. a flat union:
> 
> "return": { ..., "driver-stats": { "driver": "file", "discard-nb-ok":
> ... } }
> 
> where you can benefit from less nesting and a saner discriminator name.
> 

Right, forgot about those unions.. Will fix.

(I guess I will need an extra enum, like BlockdevDriverWithStats with a
single 'file' member, otherwise it seems to require to define data for
each BlockdevDriver type)

/Anton
