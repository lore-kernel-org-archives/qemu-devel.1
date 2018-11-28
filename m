Received: from eggs.gnu.org ([2001:4830:134:3::10]:49371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRzab-0008RL-CG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRzaX-0002HI-BW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gRzaX-0002F4-4e
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:09:09 -0500
References: <cover.1542384802.git.xiezhide@huawei.com>
	<a4bc041444fd76d5da1d8e5321007f416df4ab84.1542384802.git.xiezhide@huawei.com>
	<87ftvlh7us.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a77a48a-7160-8282-7c8f-de0b6dfe68f3@redhat.com>
Date: Wed, 28 Nov 2018 07:09:05 -0600
MIME-Version: 1.0
In-Reply-To: <87ftvlh7us.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/6] fsdev-throttle-qmp: Rename the
 ThrottleLimits member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, xiezhide <xiezhide@huawei.com>
Cc: berto@igalia.com, qemu-devel@nongnu.org, groug@kaod.org, zengcanfu@huawei.com, aneesh.kumar@linux.vnet.ibm.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

On 11/28/18 3:25 AM, Markus Armbruster wrote:
> xiezhide <xiezhide@huawei.com> writes:
> 
>> Rename the ThrottleLimits member names and modify related code
>>
>> Signed-off-by: xiezhide <xiezhide@huawei.com>
>> ---
>>   qapi/block-core.json |  70 +++++++++++-----------
>>   util/throttle.c      | 163 +++++++++++++++++++++++++--------------------------
>>   2 files changed, 116 insertions(+), 117 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index d4fe710..4ffaaea 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json

>>   ##
>>   { 'struct': 'ThrottleLimits',
>> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',

>> +  'data': { '*iops' : 'int', '*iops_max' : 'int',
>> +            '*iops_max_length' : 'int', '*iops_rd' : 'int',
>> +            '*iops_rd_max' : 'int', '*iops_rd_max_length' : 'int',
>> +            '*iops_wr' : 'int', '*iops_wr_max' : 'int',
>> +            '*iops_wr_max_length' : 'int', '*bps' : 'int',
>> +            '*bps_max' : 'int', '*bps_max_length' : 'int',
>> +            '*bps_rd' : 'int', '*bps_rd_max' : 'int',
>> +            '*bps_rd_max_length' : 'int', '*bps_wr' : 'int',
>> +            '*bps_wr_max' : 'int', '*bps_wr_max_length' : 'int',
>> +            '*iops_size' : 'int' } }
> 
> Compatibility break.  Why is that okay?

Grepping qapi/qapi-introspection.c shows 0 hits for either 
ThrottleLimits or for iops-total, so there are no QMP commands affected. 
There might, however, be command line and/or QOM paths affected, which 
is harder to audit since those don't affect instrospection.

> 
> Even if it is, you still run afoul of docs/devel/qapi-code-gen.txt:
> 
>      Command names, and member names within a type, should be all lower
>      case with words separated by a hyphen.  However, some existing older
>      commands and complex types use underscore; when extending such
>      expressions, consistency is preferred over blindly avoiding
>      underscore.
> 
> The exception doesn't apply here.

Ah, but it does, because we are refactoring code to share a common QAPI 
struct in a later patch, where we need this exact naming to avoid 
breaking that command.

So the REAL problem with this commit is that the commit message does not 
give enough details, either why this is safe (because it does not impact 
existing QMP commands) or needed (because we will be using it to rewrite 
an existing QMP command that needs this spelling).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
