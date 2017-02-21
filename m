Received: from eggs.gnu.org ([2001:4830:134:3::10]:46235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cg0nO-00072X-KN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cg0nL-0001NM-At
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:07:18 -0500
Received: from [45.249.212.188] (port=2931 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cg0nK-0001L7-11
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:07:15 -0500
References: <1487577721-31084-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487577721-31084-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<d3be835a-fd51-8ca5-27f9-e29fc63c1c98@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58ABAEB5.7000704@huawei.com>
Date: Tue, 21 Feb 2017 11:06:29 +0800
MIME-Version: 1.0
In-Reply-To: <d3be835a-fd51-8ca5-27f9-e29fc63c1c98@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] net/colo: fix memory double free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com

On 2017/2/21 10:25, Zhang Chen wrote:
>
>
> On 02/20/2017 04:01 PM, zhanghailiang wrote:
>> The 'primary_list' and 'secondary_list' members of struct Connection
>> is not allocated through dynamically g_queue_new(), but we free it by using
>> g_queue_free(), which will lead to a double-free bug.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>    net/colo.c | 2 --
>>    1 file changed, 2 deletions(-)
>>
>> diff --git a/net/colo.c b/net/colo.c
>> index 6a6eacd..7d5c423 100644
>> --- a/net/colo.c
>> +++ b/net/colo.c
>> @@ -147,9 +147,7 @@ void connection_destroy(void *opaque)
>>        Connection *conn = opaque;
>>
>>        g_queue_foreach(&conn->primary_list, packet_destroy, NULL);
>> -    g_queue_free(&conn->primary_list);
>>        g_queue_foreach(&conn->secondary_list, packet_destroy, NULL);
>> -    g_queue_free(&conn->secondary_list);
>
> I think we need use g_queue_clear () here.
>

Ha, you are right, my original modification will introduce memory leak.
Will fix in next version.

> void
> g_queue_clear (GQueue *queue);
> Removes all the elements in queue . If queue elements contain
> dynamically-allocated memory, they should be freed first.
>
> Thanks
> Zhang Chen
>
>>        g_slice_free(Connection, conn);
>>    }
>>
>
