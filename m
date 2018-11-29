Received: from eggs.gnu.org ([2001:4830:134:3::10]:53353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSIAp-0001CM-Jt
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSIAh-0001hN-Tq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:59:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSIAf-0001ff-5A
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:59:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1542384802.git.xiezhide@huawei.com>
	<a4bc041444fd76d5da1d8e5321007f416df4ab84.1542384802.git.xiezhide@huawei.com>
	<87ftvlh7us.fsf@dusky.pond.sub.org>
	<1a77a48a-7160-8282-7c8f-de0b6dfe68f3@redhat.com>
Date: Thu, 29 Nov 2018 09:59:33 +0100
In-Reply-To: <1a77a48a-7160-8282-7c8f-de0b6dfe68f3@redhat.com> (Eric Blake's
	message of "Wed, 28 Nov 2018 07:09:05 -0600")
Message-ID: <875zwgcl8q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: xiezhide <xiezhide@huawei.com>, berto@igalia.com, qemu-devel@nongnu.org, zengcanfu@huawei.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

Eric Blake <eblake@redhat.com> writes:

> On 11/28/18 3:25 AM, Markus Armbruster wrote:
>> xiezhide <xiezhide@huawei.com> writes:
>>
>>> Rename the ThrottleLimits member names and modify related code
>>>
>>> Signed-off-by: xiezhide <xiezhide@huawei.com>
>>> ---
>>>   qapi/block-core.json |  70 +++++++++++-----------
>>>   util/throttle.c      | 163 +++++++++++++++++++++++++--------------------------
>>>   2 files changed, 116 insertions(+), 117 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index d4fe710..4ffaaea 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>
>>>   ##
>>>   { 'struct': 'ThrottleLimits',
>>> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
>
>>> +  'data': { '*iops' : 'int', '*iops_max' : 'int',
>>> +            '*iops_max_length' : 'int', '*iops_rd' : 'int',
>>> +            '*iops_rd_max' : 'int', '*iops_rd_max_length' : 'int',
>>> +            '*iops_wr' : 'int', '*iops_wr_max' : 'int',
>>> +            '*iops_wr_max_length' : 'int', '*bps' : 'int',
>>> +            '*bps_max' : 'int', '*bps_max_length' : 'int',
>>> +            '*bps_rd' : 'int', '*bps_rd_max' : 'int',
>>> +            '*bps_rd_max_length' : 'int', '*bps_wr' : 'int',
>>> +            '*bps_wr_max' : 'int', '*bps_wr_max_length' : 'int',
>>> +            '*iops_size' : 'int' } }
>>
>> Compatibility break.  Why is that okay?
>
> Grepping qapi/qapi-introspection.c shows 0 hits for either
> ThrottleLimits or for iops-total, so there are no QMP commands
> affected.

I see.

>           There might, however, be command line and/or QOM paths
> affected, which is harder to audit since those don't affect
> instrospection.

Yet another argument for QAPIfication...

Let's check.  git-grep ThrottleLimits finds:

* block/throttle-groups.c: getter and setter for QOM class
  "throttle-group" property "limits".  This class is user-creatable.
  Therefore, this is an externally visible interface.

  The question is whether it's a *stable* interface.  The status of QOM
  properties in that regard is not clear to me.  If I remember
  correctly, we treated it as "just for debugging and such" at least
  initially.  But is that still a defensible position?  It ceases to be
  one as soon as you need QOM properties to do something users ought to
  be able to do.  Like configuring stuff that is meant to be configured.
  If that's the case, we need to examine the situation, and clarify our
  ABI promises.  Recommend a separate thread.

* util/throttle.c: Functions to convert to and from ThrottleConfig.  The
  conversion to ThrottleConfig uses hardcoded member names in error
  messages.  Relevant only insofar we need to remember to change them
  when we rename members.

>> Even if it is, you still run afoul of docs/devel/qapi-code-gen.txt:
>>
>>      Command names, and member names within a type, should be all lower
>>      case with words separated by a hyphen.  However, some existing older
>>      commands and complex types use underscore; when extending such
>>      expressions, consistency is preferred over blindly avoiding
>>      underscore.
>>
>> The exception doesn't apply here.
>
> Ah, but it does, because we are refactoring code to share a common
> QAPI struct in a later patch, where we need this exact naming to avoid
> breaking that command.
>
> So the REAL problem with this commit is that the commit message does
> not give enough details, either why this is safe (because it does not
> impact existing QMP commands) or needed (because we will be using it
> to rewrite an existing QMP command that needs this spelling).

Yes, the commit message needs to make explain why the change is useful,
and why it is safe.
