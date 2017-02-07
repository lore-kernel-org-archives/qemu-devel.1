Received: from eggs.gnu.org ([2001:4830:134:3::10]:34507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cb11g-00081c-Pc
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cb11c-0007LU-QB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:21:24 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:62598)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cb11b-0007GA-Lt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:21:20 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
	<58983015.40300@huawei.com>
	<0b5891cc-0170-0773-a4b2-31cf3ff2b6d7@redhat.com>
	<589859CA.5030903@huawei.com>
	<3c6e13ab-4f5a-fbe3-ef95-196c6b3e59c9@redhat.com>
	<58997D40.60604@huawei.com>
	<e8c2510f-f755-3ec1-f085-e3053480b772@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5899831D.30005@huawei.com>
Date: Tue, 7 Feb 2017 16:19:41 +0800
MIME-Version: 1.0
In-Reply-To: <e8c2510f-f755-3ec1-f085-e3053480b772@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: reconstruct the mutex
 lock usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com

On 2017/2/7 15:57, Jason Wang wrote:
>
>
> On 2017年02月07日 15:54, Hailiang Zhang wrote:
>> Hi Jason,
>>
>> On 2017/2/6 20:53, Jason Wang wrote:
>>>
>>>
>>> On 2017年02月06日 19:11, Hailiang Zhang wrote:
>>>> On 2017/2/6 17:35, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2017年02月06日 16:13, Hailiang Zhang wrote:
>>>>>> On 2017/2/3 11:47, Jason Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2017年01月24日 22:05, zhanghailiang wrote:
>>>>>>>> The original 'timer_check_lock' mutex lock of struct CompareState
>>>>>>>> is used to protect the 'conn_list' queue and its child queues which
>>>>>>>> are 'primary_list' and 'secondary_list', which is a little abused
>>>>>>>> and confusing
>>>>>>>>
>>>>>>>> To make it clearer, we rename 'timer_check_lock' to
>>>>>>>> 'conn_list_lock'
>>>>>>>> which is used to protect 'conn_list' queue, use another 'conn_lock'
>>>>>>>> to protect 'primary_list' and 'secondary_list'.
>>>>>>>>
>>>>>>>> Besides, fix some missing places which need these mutex lock.
>>>>>>>>
>>>>>>>> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
>>>>>>>
>>>>>>> Instead of sticking to such kind of mutex, I think it's time to make
>>>>>>> colo timer run in colo thread (there's a TODO in the code).
>>>>>>>
>>>>>>
>>>>>> Er, it seems that, we still need these mutex locks even we make colo
>>>>>> timer and colo thread run in the same thread, because we may access
>>>>>> the connect/primary/secondary list from colo (migratioin) thread
>>>>>> concurrently.
>>>>>
>>>>> Just make sure I understand the issue, why need it access the list?
>>>>>
>>>>>>
>>>>>> Besides, it seems to be a little complex to make colo timer run in
>>>>>> colo
>>>>>> compare thread, and it is not this series' goal.
>>>>>
>>>>> Seems not by just looking at how it was implemented in main loop, but
>>>>> maybe I was wrong.
>>>>>
>>>>>> This series is preparing
>>>>>> work for integrating COLO compare with COLO frame and it is
>>>>>> prerequisite.
>>>>>>
>>>>>> So, we may consider implementing it later in another series.
>>>>>> Zhang Chen, what's your opinion ?
>>>>>
>>>>> The problem is this patch make things even worse, it introduces one
>>>>> more
>>>>> mutex.
>>>>>
>>>>
>>>> Hmm, for most cases, we need to get these two locks at the same time.
>>>> We can use one lock to protect conn_list/primary_list/secondary_list,
>>>> (We need to get this lock before operate all these lists, as you can
>>>> see
>>>> in patch 2, while do checkpoint, we may operate these lists in
>>>> COLO checkpoint thread concurrently.)
>>>>
>>>> But for the original codes, we didn't got timer_check_lock in
>>>> packet_enqueue() while operate conn_list/primary_list/secondary_list,
>>>> and didn't got this lock in colo_compare_connection while operate
>>>> secondary_list either.
>>>>
>>>> So, is it OK to use the conn_lock instead of timer_check_lock, and
>>>> add the lock where it is need ?
>>>
>>> I'd like to know if timer were run in colo thread (this looks as simple
>>> as a g_timeout_source_new() followed by a g_source_attach()), why do we
>>> still need a mutex. And if we need it now but plan to remove it in the
>>> future, I'd like to use big lock to simplify the codes.
>>>
>>
>> After investigated your above suggestion, I think it works by using
>> g_timeout_source_new() and g_source_attach(), but I'm not sure
>> if it is a good idea to use the big lock to protect the possible
>> concurrent cases which seem to only happen between COLO migration
>> thread and COLO compare thread, any further suggestions ?
>
> I think I need first understand why migration thread need to access the
> list?
>

Er, sorry to confuse you here, to be exactly, it is COLO checkpoint thread,
we reuse the migration thread to realize checkpoint process for COLO,
Because qemu enters into COLO state after a complete migration, so we reuse it.

While do checkpoint, we need to release all the buffered packets that have not
yet been compared, so we need to access the list in COLO checkpoint thread.

Thanks.

> Thanks
>
>>
>> Thanks,
>> Hailiang
>>
>>
>>> Thanks
>>>
>>>>
>>>> Thanks.
>>>> Hailiang
>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Hailiang
>>>>>>
>>>>>>> Thought?
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> .
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>>
>>> .
>>>
>>
>
>
> .
>
