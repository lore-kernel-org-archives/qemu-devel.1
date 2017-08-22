Received: from eggs.gnu.org ([2001:4830:134:3::10]:60257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djxp0-0002To-Hj
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 21:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djxox-0000KF-SG
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 21:17:34 -0400
References: <20170821155005.16885-1-otubo@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <45e8e004-5a55-07a3-190b-c01106af5de4@cn.fujitsu.com>
Date: Tue, 22 Aug 2017 09:19:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170821155005.16885-1-otubo@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] filter-mirror: segfault when specifying
 non existent device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, mjt@tls.msk.ru



On 08/21/2017 11:50 PM, Eduardo Otubo wrote:
> When using filter-mirror like the example below where the interface
> 'ndev0' does not exist on the host, QEMU crashes into segmentation
> fault.
>
>   $ qemu-system-x86_64 -S -machine pc -netdev user,id=ndev0 -object filter-mirror,id=test-object,netdev=ndev0
>
> This happens because the function filter_mirror_setup() does not checks
> if the device actually exists and still keep on processing calling
> qemu_chr_find(). This patch fixes this issue.
>
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>

Looks good for me.

Reviewed-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>

Thanks
Zhang Chen

> ---
>   net/filter-mirror.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 90e2c92337..e18a4b16a0 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -213,14 +213,22 @@ static void filter_mirror_setup(NetFilterState *nf, Error **errp)
>       MirrorState *s = FILTER_MIRROR(nf);
>       Chardev *chr;
>   
> +    if (s->outdev == NULL) {
> +        goto err;
> +    }
> +
>       chr = qemu_chr_find(s->outdev);
> +
>       if (chr == NULL) {
> -        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> -                  "Device '%s' not found", s->outdev);
> -        return;
> +        goto err;
>       }
>   
>       qemu_chr_fe_init(&s->chr_out, chr, errp);
> +
> +err:
> +    error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Device '%s' not found",
> +              nf->netdev_id);
> +    return;
>   }
>   
>   static void redirector_rs_finalize(SocketReadState *rs)

-- 
Thanks
Zhang Chen
