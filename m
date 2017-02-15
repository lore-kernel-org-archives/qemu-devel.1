Received: from eggs.gnu.org ([2001:4830:134:3::10]:41540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdq4p-0005AS-Mz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdq4m-0001Pf-GB
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:16:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdq4m-0001Oi-9n
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:16:16 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
	<58983015.40300@huawei.com>
	<0b5891cc-0170-0773-a4b2-31cf3ff2b6d7@redhat.com>
	<589859CA.5030903@huawei.com>
	<3c6e13ab-4f5a-fbe3-ef95-196c6b3e59c9@redhat.com>
	<58997D40.60604@huawei.com>
	<e8c2510f-f755-3ec1-f085-e3053480b772@redhat.com>
	<5899831D.30005@huawei.com>
	<2e301620-0362-f43e-9194-e438f2091546@redhat.com>
	<58A26C35.9070309@huawei.com>
	<3b158bac-a92d-be3d-88a9-8c23a0d065dd@redhat.com>
	<58A2B2D5.4060902@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2a355a3-74ed-4503-9a8d-c606af2c7d6e@redhat.com>
Date: Wed, 15 Feb 2017 11:16:10 +0800
MIME-Version: 1.0
In-Reply-To: <58A2B2D5.4060902@huawei.com>
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
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com



On 2017=E5=B9=B402=E6=9C=8814=E6=97=A5 15:33, Hailiang Zhang wrote:
> On 2017/2/14 12:08, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B402=E6=9C=8814=E6=97=A5 10:32, Hailiang Zhang wrote:
>>>>>
>>>>
>>>
>>> Hi Jason,
>>>
>>>> I think the better way is notify the comparing thread and let it do=20
>>>> the
>>>> releasing. You probably need similar mechanism to notify from=20
>>>> comparing
>>>> thread to checkpoint thread.
>>>>
>>>
>>> It seems that there is no available APIs in glib to notify a thread=20
>>> which
>>> are run coroutine to do something (idle source ?). What about using
>>> anonymous pipe
>>> as the GPollFD to communicate between colo comparing thread and colo
>>> thread ?
>>>
>>> Any ideas ?
>>>
>>> Hailiang
>>
>> Haven't thought this deeply. But I think you can try event notifier
>> first which was designed for such kind of notification.
>>
>
> Hmm, It is quite same with what i said above except it uses the
> return value of eventfd as the GPollFD.
> The things here are more complex especially if there are more than
> one vNIC, which each is corresponding to one compare thread.
>
> How about using g_source_attach(), g_source_attach(), g_source_remove()=
,
> g_source_set_callback() and g_source_set_priority() to control the=20
> process
> of releasing packets dynamically ? Which we call g_source_attach()
> to add the coroutine of releasing packets when do checkpoint, and remov=
e
> it once finishing the checkpoint process.

I'm not sure I get the idea, maybe you can post patch for early review.

>
> About colo comparing thread notifies colo thread, i think we can use
> qemu_cond_wait(),qemu_cond_broadcast(), just like what we do in
> pause_all_vcpus().

Yes, agree.

Thanks

>
> Thanks.
> Hailiang
>
>> Thanks
>>
>> .
>>
>
>
