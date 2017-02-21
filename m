Received: from eggs.gnu.org ([2001:4830:134:3::10]:37774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg09f-0000wo-Hh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg09c-0007XP-Ch
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:26:15 -0500
Received: from [59.151.112.132] (port=4847 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg09c-0007Tl-0I
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:26:12 -0500
References: <1487577721-31084-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487577721-31084-2-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <d3be835a-fd51-8ca5-27f9-e29fc63c1c98@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 10:25:13 +0800
MIME-Version: 1.0
In-Reply-To: <1487577721-31084-2-git-send-email-zhang.zhanghailiang@huawei.com>
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
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 02/20/2017 04:01 PM, zhanghailiang wrote:
> The 'primary_list' and 'secondary_list' members of struct Connection
> is not allocated through dynamically g_queue_new(), but we free it by using
> g_queue_free(), which will lead to a double-free bug.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/net/colo.c b/net/colo.c
> index 6a6eacd..7d5c423 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -147,9 +147,7 @@ void connection_destroy(void *opaque)
>       Connection *conn = opaque;
>   
>       g_queue_foreach(&conn->primary_list, packet_destroy, NULL);
> -    g_queue_free(&conn->primary_list);
>       g_queue_foreach(&conn->secondary_list, packet_destroy, NULL);
> -    g_queue_free(&conn->secondary_list);

I think we need use g_queue_clear () here.

void
g_queue_clear (GQueue *queue);
Removes all the elements in queue . If queue elements contain 
dynamically-allocated memory, they should be freed first.

Thanks
Zhang Chen

>       g_slice_free(Connection, conn);
>   }
>   

-- 
Thanks
Zhang Chen
