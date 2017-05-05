Received: from eggs.gnu.org ([2001:4830:134:3::10]:59269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6b77-0002Bu-DA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6b72-0001oQ-EX
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:09:33 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:12897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6b72-0001iw-5g
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:09:28 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
	<25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
	<c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
	<04bf2bd9-54af-161f-6fc6-e0fcd5c05406@huawei.com>
	<34550398-7d98-cc5c-8646-f6399f3833a6@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <93fd1eb1-5a19-f385-0fe2-8db0be91dc5a@huawei.com>
Date: Fri, 5 May 2017 13:09:14 +0200
MIME-Version: 1.0
In-Reply-To: <34550398-7d98-cc5c-8646-f6399f3833a6@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 5/4/2017 5:19 PM, Eric Blake wrote:
> On 05/04/2017 10:12 AM, Pradeep Jagadeesh wrote:
>
>>>>>> +    IOThrottle throttle = {
>>>>>> +        .has_id = true,
>>>>>> +        .id = (char *) qdict_get_str(qdict, "id"),
>>>>>> +        .bps = qdict_get_int(qdict, "bps"),
>>>>>> +        .bps_rd = qdict_get_int(qdict, "bps_rd"),
>>>>>> +        .bps_wr = qdict_get_int(qdict, "bps_wr"),
>>>>>> +        .iops = qdict_get_int(qdict, "iops"),
>>>>>> +        .iops_rd = qdict_get_int(qdict, "iops_rd"),
>>>>>> +        .iops_wr = qdict_get_int(qdict, "iops_wr"),
>>>>>
>>>>> Again, don't you need to be setting .has_bps=true and so on?
>>>> Same as above. I have not set any max burst values here, because I
>>>> wanted to keep it in line with the block device.
>>>> May be there is a room to enable these max values in both in future.
>>>
>>> I don't think you were getting the point of my question. Since 'bps' is
>>> an optional member of struct IOThrottle, you have to set 'has_bps' at
>>> the same time to make it obvious that 'bps' should affect things.
>>>
>> I need some more clarifications here.
>> I did not understand what do you mean by an optional parameter?
>> You mean I need to set "has_*" for all the parameters?
>
> Yes, any optional parameter (one named '*foo' in the .json file) has a
> counterpart has_foo boolean, which should be set to true when the
> parameter is in use (and thus making it obvious when it is set to false
> that it is not in use).
OK, but here the id is only with * (Optional), others are not. Still 
need them to set?

>
>>> I understand that you aren't setting 'bps_max', nor it's counterpart
>>> 'has_bps_max', and that's not what I was asking about.
>>>
>>>
>>>>>> +++ b/qapi/iothrottle.json
>>>>>> @@ -3,6 +3,7 @@
>>>>>>  ##
>>>>>>  # == QAPI IOThrottle definitions
>>>>>>  ##
>>>>>> +##
>>>>>>  # @IOThrottle:
>>>>>
>>>>> This looks like a spurious change
>>>> You mean the below sentence is not required?
>>>
>>> No, the above addition of a second ## is not required.
>> If I remove that I will get the compilation error.
>> I think the parser needs that.
>
> If the parser chokes without it, then that implies patch 1 is broken,
> and the fix should be squashed there for full bisectability.  Either
> way, it looks like a spurious change when it is occurring in patch 3.
>
Yes, I reordered the patches and fixed this issue.

-Pradeep
