Received: from eggs.gnu.org ([2001:4830:134:3::10]:48002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cqGNc-0005cT-QT
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cqGNX-0003Hs-Ch
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:47:04 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:8509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cqGNW-0003EE-PF
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:46:59 -0400
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
Date: Tue, 21 Mar 2017 10:44:32 +0100
MIME-Version: 1.0
In-Reply-To: <a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org


Hi Eric,

Thanks for having a look at the patch. My answers are inline.

> On 03/20/2017 08:07 AM, Pradeep Jagadeesh wrote:
>> This patchset enables qmp interfaces for the 9pfs
>> devices (fsdev).This provides two interfaces one
>
> Space between English sentences, after '.'
OK
>
>> for querying all the 9pfs devices info. The second one
>> to set the IO limits for the required 9pfs device.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>
>> +++ b/qapi-schema.json
>> @@ -81,6 +81,9 @@
>>  # QAPI block definitions
>>  { 'include': 'qapi/block.json' }
>>
>> +# QAPI 9pfs definitions
>> +{ 'include': 'qapi/9pfs.json' }
>> +
>>  # QAPI event definitions
>>  { 'include': 'qapi/event.json' }
>>
>> diff --git a/qapi/9pfs.json b/qapi/9pfs.json
>> new file mode 100644
>> index 0000000..c068474
>> --- /dev/null
>> +++ b/qapi/9pfs.json
>> @@ -0,0 +1,169 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# == QAPI 9p definitions
>> +##
>> +
>> +# QAPI common definitions
>> +{ 'include': 'common.json' }
>> +
>> +##
>> +# @fs9p_set_io_throttle:
>> +#
>> +# Change I/O limits for a 9p/fsdev device.
>> +#
>> +# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) device
>
> This says 2.9...
I meant that, the qemu cli io throttle facility for 9p/fsdev is enabled 
in 2.9.But the qmp interfaces are from 2.10.
>
>> +#
>> +# I/O limits can be disabled by setting all of them to 0.
>> +#
>> +# Returns: Nothing on success
>> +#          If @device is not a valid 9p device, DeviceNotFound
>> +#
>> +# Since: 2:10
>
> ...but this says 2:10 (typo, should be 2.10).  No need to mention the
> version twice, especially if one of them is wrong (keep the Since: line).
OK, mentioned above.
>
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "fs9p_set_io_throttle",
>> +#      "arguments": { "device": "ide0-1-0",
>> +#                     "bps": 1000000,
>> +#                     "bps_rd": 0,
>> +#                     "bps_wr": 0,
>> +#                     "iops": 0,
>> +#                     "iops_rd": 0,
>> +#                     "iops_wr": 0,
>> +#                     "bps_max": 8000000,
>> +#                     "bps_rd_max": 0,
>> +#                     "bps_wr_max": 0,
>> +#                     "iops_max": 0,
>> +#                     "iops_rd_max": 0,
>> +#                     "iops_wr_max": 0,
>> +#                     "bps_max_length": 60,
>> +#                     "iops_size": 0 } }
>> +# <- { "returns": {} }
>> +##
>> +{ 'command': 'fs9p_set_io_throttle', 'boxed': true,
>> +  'data': 'FS9PIOThrottle' }
>
> New commands and members should be named with '-' rather than '_' as the
> word separator, so this should be 'fs9p-set-io-throttle', 'bps-rd', etc.
OK, I will change.

>> +##
>> +# @FS9PIOThrottle:
>> +#
>> +# A set of parameters describing block
>> +#
>> +# @device: Block device name
>> +#
>> +# @bps: total throughput limit in bytes per second
>> +#
>> +# @bps_rd: read throughput limit in bytes per second
>> +#
>> +# @bps_wr: write throughput limit in bytes per second
>> +#
>> +# @iops: total I/O operations per second
>> +#
>> +# @iops_rd: read I/O operations per second
>> +#
>> +# @iops_wr: write I/O operations per second
>> +#
>> +# @bps_max: total throughput limit during bursts,
>> +#                     in bytes (Since 1.7)
>
> You're introducing this struct in 2.10, so this member is not since 1.7.
>  Either that, or you're copying-and-pasting when you should be sharing
> code and reusing an existing struct.
Hmm..copied the block devices code, I will correct it.
I thought of reusing the code, but the whole struct from block devices 
can not be used, as there is one member called "group" that is not used 
in case of 9p. Also this needs lot of changes even in case of block 
devices. Because I may need to rename the structure as IOThrottle or 
something like that.
Shall I reuse the code and avoid setting the group member in case of 9p?
What do you think?
>
>
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'FS9PIOThrottle',
>> +  'data': { '*device': 'str', 'bps': 'int', 'bps_rd': 'int',
>> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
>> +            '*bps_max': 'int', '*bps_rd_max': 'int',
>> +            '*bps_wr_max': 'int', '*iops_max': 'int',
>> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>> +            '*iops_size': 'int' } }
>
> If you reuse an existing struct that uses _ instead of -, then that
> explains your naming.  But in that case, why do you need to declare a
> new (copied) struct, instead of just reusing the existing one?
>
Explained in above comment.
>> +
>> +##
>> +# @query-9pfs-io-throttle:
>> +#
>> +# Return a list of information about each iothread
>> +#
>> +# Returns: @FS9PIOIOThrottle
>> +#
>> +# Since: 2.10
>> +#
>> +# Example:
>> +#
>> +# -> { "Execute": "query-9pfs-io-throttle" }
>> +# <- { "returns" : [
>> +#          {
>> +#             "device": "ide0-hd0",
>> +#              "bps":1000000,
>> +#              "bps_rd":0,
>> +#              "bps_wr":0,
>> +#              "iops":1000000,
>> +#              "iops_rd":0,
>> +#              "iops_wr":0,
>> +#              "bps_max": 8000000,
>> +#              "bps_rd_max": 0,
>> +#              "bps_wr_max": 0,
>
> You are not consistent on whether to include a space after ':'.  The
> easiest way to get this right is to paste actual output from pretty qmp
> mode.
I will fix this.
>
>> +#              "iops_max": 0,
>> +#              "iops_rd_max": 0,
>> +#              "iops_wr_max": 0,
>> +#              "bps_max_length": 0,
>> +#              "bps_rd_max_length": 0,
>> +#              "bps_wr_max_length": 0,
>> +#              "iops_max_length": 0,
>> +#              "iops_rd_max_length": 0,
>> +#              "iops_wr_max_length": 0,
>> +#              "iops_size": 0,
>> +#            }
>
> This is not valid JSON. No trailing commas.
Will fix
>
>> +#          ]
>> +#      }
>> +#
>> +##
>> +{ 'command': 'query-9pfs-io-throttle', 'returns': [ 'FS9PIOThrottle' ] }
>> +
>>
>
