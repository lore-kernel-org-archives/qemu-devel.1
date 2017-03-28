Received: from eggs.gnu.org ([2001:4830:134:3::10]:53144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cspIH-0004K9-OJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cspIE-0001nd-Du
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:28:09 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:9495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cspIE-0001n3-1f
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:28:06 -0400
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<63a3057f-59a2-ec92-2df8-af33ec152394@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <3d9a09b5-56f5-a3f9-fdb3-7c20ade3924f@huawei.com>
Date: Tue, 28 Mar 2017 13:27:38 +0200
MIME-Version: 1.0
In-Reply-To: <63a3057f-59a2-ec92-2df8-af33ec152394@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2 v1] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>, "Daniel P.Berrange" <berrange@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 3/23/2017 3:32 PM, Eric Blake wrote:
> On 03/23/2017 07:20 AM, Pradeep Jagadeesh wrote:
>> This patchset enables qmp interfaces for the 9pfs
>> devices (fsdev). This provides two interfaces one
>
> s/interfaces/interfaces,/
>
> Also, I just noticed you are using trailing spaces in your commit
> message (not fatal, but unusual).
>
Will fix.
>> for querying all the 9pfs devices info. The second one
>> to set the IO limits for the required 9pfs device.
>
> When sending a multi-patch series, please remember to include the 0/2
> cover letter ('git config format.coverletter auto' can help here).
OK, I will have a look.
>
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>>  Makefile                    |  5 ++-
>>  fsdev/qemu-fsdev-throttle.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>>  fsdev/qemu-fsdev-throttle.h | 11 ++++++
>>  fsdev/qemu-fsdev.c          | 38 +++++++++++++++++-
>>  fsdev/qemu-fsdev.h          |  2 +-
>>  hmp-commands-info.hx        | 18 +++++++++
>>  hmp-commands.hx             | 18 +++++++++
>>  hmp.c                       | 74 ++++++++++++++++++++++++++++++++++
>>  hmp.h                       |  5 +++
>>  qapi-schema.json            |  6 +++
>>  qapi/fsdev.json             | 87 ++++++++++++++++++++++++++++++++++++++++
>>  qapi/iothrottle.json        | 93 +++++++++++++++++++++++++++++++++++++++++++
>>  qmp.c                       | 14 +++++++
>>  13 files changed, 464 insertions(+), 3 deletions(-)
>
> That's a big patch to review in one go. Does it make sense to break it
> down into smaller chunks?
>
>>  create mode 100644 qapi/fsdev.json
>>  create mode 100644 qapi/iothrottle.json
>>
>> v0 -> v1:
>>
>>    Addressed the comments by Erik Blake, Greg Kurz and Daniel P.Berrange
>
> It's Eric, but you're not the first (and probably not the last) to get
> it wrong.
:) will remember.
>
>>    Mainly renaming the functions and removing the redundant code
>>
>> diff --git a/Makefile b/Makefile
>> index 73e0c12..c33b46d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -413,7 +413,10 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>>                 $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
>>                 $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.json \
>>                 $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
>> -               $(SRC_PATH)/qapi/trace.json
>> +               $(SRC_PATH)/qapi/trace.json  $(SRC_PATH)/qapi/iothrottle.json
>
> Why two spaces?
>
Will fix it.
>
>> +++ b/qapi-schema.json
>> @@ -78,9 +78,15 @@
>>  # QAPI crypto definitions
>>  { 'include': 'qapi/crypto.json' }
>>
>> +# QAPI IOThrottle definitions
>> +{ 'include': 'qapi/iothrottle.json' }
>> +
>>  # QAPI block definitions
>>  { 'include': 'qapi/block.json' }
>>
>> +# QAPI fsdev definitions
>> +{ 'include': 'qapi/fsdev.json' }
>> +
>
> Adding two new files definitely feels like something that could be
> split. Also, is it possible that existing code could take advantage of
> qapi/iothrottle.json, rather than it just being additional code?
I will check and remove unnecessary includes.
>
>>  # QAPI event definitions
>>  { 'include': 'qapi/event.json' }
>>
>> diff --git a/qapi/fsdev.json b/qapi/fsdev.json
>> new file mode 100644
>> index 0000000..7fb3c25
>> --- /dev/null
>> +++ b/qapi/fsdev.json
>> @@ -0,0 +1,87 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# == QAPI fsdev definitions
>> +##
>> +
>> +# QAPI common definitions
>> +{ 'include': 'common.json' }
>> +{ 'include': 'iothrottle.json' }
>
> Is this really necessary? Given that the top level already included
> these, I think it serves more as a documentation purpose than something
> you actually need.
Not really, will fix this.
>
>> +
>> +##
>> +# @fsdev_set_io_throttle:
>> +#
>> +# Change I/O limits for a 9p/fsdev device.
>> +#
>> +# I/O limits can be enabled by setting throttle vaue to non-zero numbers.
>
> s/vaue/value/
ok
>
>> +#
>> +# I/O limits can be disabled by setting all of them to 0.
>> +#
>> +# Returns: Nothing on success
>> +#          If @device is not a valid fsdev device, DeviceNotFound
>> +#
>> +# Since: 2.10
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "fsdev_set_io_throttle",
>
> Please name this fsdev-set-io-throttle.  New commands should favor the
> use of '-' rather than '_'.
>
>
ok
>> +##
>> +# @query-fsdev-io-throttle:
>> +#
>> +# Return a list of information about fsdev device
>> +#
>> +# Returns: @FsdevIOIOThrottle
>
> Typo in the type name, should be merely IOThrottle
ok
>
>> +#
>> +# Since: 2.10
>> +#
>> +# Example:
>> +#
>> +# -> { "Execute": "query-fsdev-io-throttle" }
>
>> +#
>> +##
>> +{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'IOThrottle' ] }
>> +
>> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
>> new file mode 100644
>> index 0000000..f7b615d
>> --- /dev/null
>> +++ b/qapi/iothrottle.json
>> @@ -0,0 +1,93 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# == QAPI IOThrottle definitions
>> +##
>> +
>> +# QAPI common definitions
>> +{ 'include': 'common.json' }
>
> Again, is this necessary?
Removed.
>
>
>> +# @iops_size: an I/O size in bytes (Since 1.7)
>> +#
>> +#
>> +# Since: 2.10
>
> It's weird to state that this struct is since 2.10, but its members are
> since 1.7.  Either you should list a 'since' for when the members of the
> struct were first useful (0.14.0), or eliminate all the (since ...) tags
> on the members and keep the overall struct at 2.10.  I'd lean towards
> the former, at least if BlockDeviceInfo is properly refactored to
> inherit from this type.
Some members of this structure have Since, not all of them. So, shall I 
remove since tag from all?

As of now I used as it is from BlockIOThrottle. Not changed any since tags.

OK, I will try to refactor the BlockDeviceInfo using this structure.
>
>> +##
>> +{ 'struct': 'IOThrottle',
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
> So yeah, you definitely need to split this patch.  Your FIRST patch
> should be the creation of IOThrottle, and fixing BlockDeviceInfo to
> inherit from it; then a later patch would be the introduction of the
> fsdev throttle commands that are additional clients of the new
> IOThrottle type.
OK
>
>
