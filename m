Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6IQk-0005Y6-HT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6IQg-0000V6-E7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:12:34 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:12809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d6IQg-0000PU-10
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:12:30 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
	<25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
	<c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <04bf2bd9-54af-161f-6fc6-e0fcd5c05406@huawei.com>
Date: Thu, 4 May 2017 17:12:01 +0200
MIME-Version: 1.0
In-Reply-To: <c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
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

On 5/3/2017 6:32 PM, Eric Blake wrote:
> On 05/03/2017 10:40 AM, Pradeep Jagadeesh wrote:
>> On 5/3/2017 12:13 AM, Eric Blake wrote:
>>> On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
>>>> This patchset enables qmp interfaces for the fsdev
>>>> devices. This provides two interfaces one
>>>> for querying info of all the fsdev devices. The second one
>>>> to set the IO limits for the required fsdev device.
>>>>
>>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>>> ---
>>>
>
>>>> +void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error
>>>> **errp)
>>>> +{
>>>> +    ThrottleConfig cfg;
>>>> +
>>>> +    throttle_config_init(&cfg);
>>>> +    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
>>>> +    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
>>>> +    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
>>>> +
>>>> +    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
>>>> +    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
>>>> +    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
>>>> +
>>>> +    if (arg->has_bps_max) {
>>>> +        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
>>>> +    }
>>>
>>> Should the bulk of this be replaced by a call to a common IOThrottle
>>> helper function, rather than open-coded duplication?
>> If we can reduce the duplicate code with a helper function its a good
>> idea. But I can not think of any ways of doing it. Any suggestions?
>
> In fact, you did exactly that in patch 3/4, which I argue should be
> rebased to occur in front of this patch to minimize the churn (in other
> words, when you add fsdev_set_io_throttle(), it should directly call the
> qmp_set_io_throttle() helper).
>
OK, done.
>
>>>> +void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
>>>> +{
>>>> +    Error *err = NULL;
>>>> +    IOThrottle throttle = {
>>>> +        .has_id = true,
>>>> +        .id = (char *) qdict_get_str(qdict, "id"),
>>>> +        .bps = qdict_get_int(qdict, "bps"),
>>>> +        .bps_rd = qdict_get_int(qdict, "bps_rd"),
>>>> +        .bps_wr = qdict_get_int(qdict, "bps_wr"),
>>>> +        .iops = qdict_get_int(qdict, "iops"),
>>>> +        .iops_rd = qdict_get_int(qdict, "iops_rd"),
>>>> +        .iops_wr = qdict_get_int(qdict, "iops_wr"),
>>>
>>> Again, don't you need to be setting .has_bps=true and so on?
>> Same as above. I have not set any max burst values here, because I
>> wanted to keep it in line with the block device.
>> May be there is a room to enable these max values in both in future.
>
> I don't think you were getting the point of my question. Since 'bps' is
> an optional member of struct IOThrottle, you have to set 'has_bps' at
> the same time to make it obvious that 'bps' should affect things.
>
I need some more clarifications here.
I did not understand what do you mean by an optional parameter?
You mean I need to set "has_*" for all the parameters?
> I understand that you aren't setting 'bps_max', nor it's counterpart
> 'has_bps_max', and that's not what I was asking about.
>
>
>>>> +++ b/qapi/iothrottle.json
>>>> @@ -3,6 +3,7 @@
>>>>  ##
>>>>  # == QAPI IOThrottle definitions
>>>>  ##
>>>> +##
>>>>  # @IOThrottle:
>>>
>>> This looks like a spurious change
>> You mean the below sentence is not required?
>
> No, the above addition of a second ## is not required.
If I remove that I will get the compilation error.
I think the parser needs that.

-Pradeep
>
