Received: from eggs.gnu.org ([2001:4830:134:3::10]:44037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cafht-0000uD-8T
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cafhp-0001Wv-95
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:35:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cafhp-0001Wa-3D
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:35:29 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
	<58983015.40300@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0b5891cc-0170-0773-a4b2-31cf3ff2b6d7@redhat.com>
Date: Mon, 6 Feb 2017 17:35:17 +0800
MIME-Version: 1.0
In-Reply-To: <58983015.40300@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, lizhijian@cn.fujitsu.com



On 2017=E5=B9=B402=E6=9C=8806=E6=97=A5 16:13, Hailiang Zhang wrote:
> On 2017/2/3 11:47, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 22:05, zhanghailiang wrote:
>>> The original 'timer_check_lock' mutex lock of struct CompareState
>>> is used to protect the 'conn_list' queue and its child queues which
>>> are 'primary_list' and 'secondary_list', which is a little abused
>>> and confusing
>>>
>>> To make it clearer, we rename 'timer_check_lock' to 'conn_list_lock'
>>> which is used to protect 'conn_list' queue, use another 'conn_lock'
>>> to protect 'primary_list' and 'secondary_list'.
>>>
>>> Besides, fix some missing places which need these mutex lock.
>>>
>>> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
>>
>> Instead of sticking to such kind of mutex, I think it's time to make
>> colo timer run in colo thread (there's a TODO in the code).
>>
>
> Er, it seems that, we still need these mutex locks even we make colo
> timer and colo thread run in the same thread, because we may access
> the connect/primary/secondary list from colo (migratioin) thread
> concurrently.

Just make sure I understand the issue, why need it access the list?

>
> Besides, it seems to be a little complex to make colo timer run in colo
> compare thread, and it is not this series' goal.=20

Seems not by just looking at how it was implemented in main loop, but=20
maybe I was wrong.

> This series is preparing
> work for integrating COLO compare with COLO frame and it is prerequisit=
e.
>
> So, we may consider implementing it later in another series.
> Zhang Chen, what's your opinion ?

The problem is this patch make things even worse, it introduces one more=20
mutex.

Thanks

>
>
> Thanks,
> Hailiang
>
>> Thought?
>>
>> Thanks
>>
>> .
>>
>
