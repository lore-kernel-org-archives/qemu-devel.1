Received: from eggs.gnu.org ([2001:4830:134:3::10]:34571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d3J2T-0005yR-FZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d3J2Q-0005c3-9j
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:15:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d3J2Q-0005al-2z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:15:06 -0400
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<5e7f11a4-83d4-e363-6f80-a749c206c190@redhat.com>
	<590056FC.1020105@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c51412a3-54dd-1b04-ce4b-bcafc28a349a@redhat.com>
Date: Wed, 26 Apr 2017 17:14:53 +0800
MIME-Version: 1.0
In-Reply-To: <590056FC.1020105@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v2 01/18] net/colo: Add
 notifier/callback related helpers for filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: xuquan8@huawei.com, Li Zhijian <lizhijian@cn.fujitsu.com>, zhangchen.fnst@cn.fujitsu.com, quintela@redhat.com



On 2017=E5=B9=B404=E6=9C=8826=E6=97=A5 16:14, Hailiang Zhang wrote:
> On 2017/4/25 19:40, Jason Wang wrote:
>>
>> On 2017=E5=B9=B404=E6=9C=8822=E6=97=A5 16:35, zhanghailiang wrote:
>>> We will use this notifier to help COLO to notify filter object
>>> to do something, like do checkpoint, or process failover event.
>>>
>>> Cc: Jason Wang<jasowang@redhat.com>
>>> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
>>> Signed-off-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>
>>> Signed-off-by: Li Zhijian<lizhijian@cn.fujitsu.com>
>>> ---
>>>    net/colo.c | 105=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    net/colo.h |  19 +++++++++++
>>>    2 files changed, 124 insertions(+)
>> Went through this series and I feel that the code duplicates (at least
>> part) functionality of IOThread (iothread.c) . So I come to an idea=20
>> that,
>> switch to use IOThread for COLO comparing thread then you can use aio =
bh
>> to do the inter process communication.
>>
>> Thoughts?
>
> Interesting idea, but after investigation, we found it will make=20
> things quite complex
> if we use iothread for net compare (Actually, i don't think we can use=20
> it directly for COLO),
> It seems to be special for block, you can see some codes call block=20
> helpers.

You mean iothread_stop_all() which was called by main()? It looks just=20
use to change aio context back to main context. And I don't think you=20
need to care about that.

> Besides, we still have to realize a way to communicate with COLO frame=20
> for filters  (I mean patch 16/17/18),
> even we use it after reconstruct those iothread part. ;)
>

I think you can use bh, and e.g go through all the filter in the bh.

Thanks

> Thanks,
> Hailiang
>
>> Thanks
>>
>> .
>>
>
>
>
