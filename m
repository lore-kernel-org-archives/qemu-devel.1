Received: from eggs.gnu.org ([2001:4830:134:3::10]:52669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ei0E2-00058Y-Cw
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 10:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ei0E1-0007EW-9R
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 10:59:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
Date: Sat, 03 Feb 2018 16:59:22 +0100
In-Reply-To: <b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com> (Eric Blake's
	message of "Mon, 22 Jan 2018 14:55:56 -0600")
Message-ID: <87tvuyf4it.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

Eric Blake <eblake@redhat.com> writes:

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
>>             'timed_stats': ['BlockDeviceTimedStats'] } }
>>  
>>  ##
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

Indeed.  You could make this a flat union, similar to BlockdevOptions:

{ 'union': 'BlockDriverStats':
  'base': { 'driver': 'BlockdevDriver' },
  'discriminator': 'driver',
  'data': {
      'file': 'BlockDriverStatsFile',
      ... } }

However: 

>> +
>> +##
>>  # @BlockStats:
>>  #
>>  # Statistics of a virtual block device or a block backing device.
>> @@ -785,6 +819,8 @@
>>  #
>>  # @stats:  A @BlockDeviceStats for the device.
>>  #
>> +# @driver-stats: Optional driver-specific statistics. (Since 2.12)
>> +#
>>  # @parent: This describes the file block device if it has one.
>>  #          Contains recursively the statistics of the underlying
>>  #          protocol (e.g. the host file for a qcow2 image). If there is
>> @@ -798,6 +834,7 @@
>>  { 'struct': 'BlockStats',
>>    'data': {'*device': 'str', '*node-name': 'str',
>>             'stats': 'BlockDeviceStats',
>> +           '*driver-stats': 'BlockDriverStats',

You're adding a union of driver-specific stats to a struct of generic
stats.  That's unnecessarily complicated.  Instead, turn the struct of
generic stats into a flat union, like this:

{ 'union': 'BlockStats',
  'base': { ... the generic stats, i.e. the members of BlockStats
            before this patch ...
            'driver': 'BlockdevDriver' }
  'discriminator': 'driver',
  'data': {
      'file': 'BlockDriverStatsFile',
      ... } }

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

My proposal peels off yet another level of nesting.
