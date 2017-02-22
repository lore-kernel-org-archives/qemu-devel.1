Received: from eggs.gnu.org ([2001:4830:134:3::10]:33642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgSSm-0001L3-Sf
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgSSj-0001YL-Pr
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:39:52 -0500
Received: from [59.151.112.132] (port=50271 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgSSj-0001Y1-Dl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:39:49 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-2-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <64778d09-a3a2-357e-f914-916a294b1c00@cn.fujitsu.com>
Date: Wed, 22 Feb 2017 16:39:02 +0800
MIME-Version: 1.0
In-Reply-To: <1487735198-127300-2-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] net/colo: fix memory double free
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 02/22/2017 11:46 AM, zhanghailiang wrote:
> The 'primary_list' and 'secondary_list' members of struct Connection
> is not allocated through dynamically g_queue_new(), but we free it by using
> g_queue_free(), which will lead to a double-free bug.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

> ---
>   net/colo.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/colo.c b/net/colo.c
> index 6a6eacd..8cc166b 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -147,9 +147,9 @@ void connection_destroy(void *opaque)
>       Connection *conn = opaque;
>   
>       g_queue_foreach(&conn->primary_list, packet_destroy, NULL);
> -    g_queue_free(&conn->primary_list);
> +    g_queue_clear(&conn->primary_list);
>       g_queue_foreach(&conn->secondary_list, packet_destroy, NULL);
> -    g_queue_free(&conn->secondary_list);
> +    g_queue_clear(&conn->secondary_list);
>       g_slice_free(Connection, conn);
>   }
>   

-- 
Thanks
Zhang Chen
