Received: from eggs.gnu.org ([2001:4830:134:3::10]:45526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dsSFg-0007jb-BB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dsSFd-00011c-6w
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:24:12 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:23711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dsSFc-0000uC-O0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:24:09 -0400
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170914131955.380099a8@bahia.lan>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <5c139703-11ee-e7e2-9db2-201a208bf1d0@huawei.com>
Date: Thu, 14 Sep 2017 13:23:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170914131955.380099a8@bahia.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 9/14/2017 1:19 PM, Greg Kurz wrote:
> On Thu, 14 Sep 2017 06:40:06 -0400
> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
>
>> This patch factors out code to use the ThrottleLimits
>> strurcture.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/block-core.json | 78 +++-------------------------------------------------
>
> Uhhh... what happened here ? Where did the lines go ? I've never reviewed this
> patch before...

I did rebase the code on 2.10
Now I am using the ThrottleLimits structure that was introduced IN 2.10.
This is same as the IOThrottle structure.
So, many things got changed in this version.

-Pradeep

>
>>  1 file changed, 4 insertions(+), 74 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index bb11815..d0ccfda 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1826,84 +1826,13 @@
>>  #
>>  # @device: Block device name (deprecated, use @id instead)
>>  #
>> -# @id: The name or QOM path of the guest device (since: 2.8)
>> -#
>> -# @bps: total throughput limit in bytes per second
>> -#
>> -# @bps_rd: read throughput limit in bytes per second
>> -#
>> -# @bps_wr: write throughput limit in bytes per second
>> -#
>> -# @iops: total I/O operations per second
>> -#
>> -# @iops_rd: read I/O operations per second
>> -#
>> -# @iops_wr: write I/O operations per second
>> -#
>> -# @bps_max: total throughput limit during bursts,
>> -#                     in bytes (Since 1.7)
>> -#
>> -# @bps_rd_max: read throughput limit during bursts,
>> -#                        in bytes (Since 1.7)
>> -#
>> -# @bps_wr_max: write throughput limit during bursts,
>> -#                        in bytes (Since 1.7)
>> -#
>> -# @iops_max: total I/O operations per second during bursts,
>> -#                      in bytes (Since 1.7)
>> -#
>> -# @iops_rd_max: read I/O operations per second during bursts,
>> -#                         in bytes (Since 1.7)
>> -#
>> -# @iops_wr_max: write I/O operations per second during bursts,
>> -#                         in bytes (Since 1.7)
>> -#
>> -# @bps_max_length: maximum length of the @bps_max burst
>> -#                            period, in seconds. It must only
>> -#                            be set if @bps_max is set as well.
>> -#                            Defaults to 1. (Since 2.6)
>> -#
>> -# @bps_rd_max_length: maximum length of the @bps_rd_max
>> -#                               burst period, in seconds. It must only
>> -#                               be set if @bps_rd_max is set as well.
>> -#                               Defaults to 1. (Since 2.6)
>> -#
>> -# @bps_wr_max_length: maximum length of the @bps_wr_max
>> -#                               burst period, in seconds. It must only
>> -#                               be set if @bps_wr_max is set as well.
>> -#                               Defaults to 1. (Since 2.6)
>> -#
>> -# @iops_max_length: maximum length of the @iops burst
>> -#                             period, in seconds. It must only
>> -#                             be set if @iops_max is set as well.
>> -#                             Defaults to 1. (Since 2.6)
>> -#
>> -# @iops_rd_max_length: maximum length of the @iops_rd_max
>> -#                                burst period, in seconds. It must only
>> -#                                be set if @iops_rd_max is set as well.
>> -#                                Defaults to 1. (Since 2.6)
>> -#
>> -# @iops_wr_max_length: maximum length of the @iops_wr_max
>> -#                                burst period, in seconds. It must only
>> -#                                be set if @iops_wr_max is set as well.
>> -#                                Defaults to 1. (Since 2.6)
>> -#
>> -# @iops_size: an I/O size in bytes (Since 1.7)
>> -#
>>  # @group: throttle group name (Since 2.4)
>>  #
>>  # Since: 1.1
>>  ##
>>  { 'struct': 'BlockIOThrottle',
>> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
>> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
>> -            '*bps_max': 'int', '*bps_rd_max': 'int',
>> -            '*bps_wr_max': 'int', '*iops_max': 'int',
>> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>> -            '*iops_size': 'int', '*group': 'str' } }
>> +  'base': 'ThrottleLimits',
>> +  'data': { '*device': 'str', '*group': 'str' } }
>>
>>  ##
>>  # @ThrottleLimits:
>> @@ -1913,6 +1842,7 @@
>>  # transaction. All fields are optional. When setting limits, if a field is
>>  # missing the current value is not changed.
>>  #
>> +# @id:                     device id
>>  # @iops-total:             limit total I/O operations per second
>>  # @iops-total-max:         I/O operations burst
>>  # @iops-total-max-length:  length of the iops-total-max burst period, in seconds
>> @@ -1942,7 +1872,7 @@
>>  # Since: 2.11
>>  ##
>>  { 'struct': 'ThrottleLimits',
>> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
>> +  'data': { '*id' : 'str', '*iops-total' : 'int', '*iops-total-max' : 'int',
>>              '*iops-total-max-length' : 'int', '*iops-read' : 'int',
>>              '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
>>              '*iops-write' : 'int', '*iops-write-max' : 'int',
>
