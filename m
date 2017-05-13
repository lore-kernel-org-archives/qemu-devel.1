Received: from eggs.gnu.org ([2001:4830:134:3::10]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eWj-0001nn-KZ
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eWg-0006SN-Ej
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:24:37 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eWg-0006Rb-A3
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:24:34 -0400
Received: by mail-qt0-x241.google.com with SMTP id a46so11034571qte.0
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 14:24:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80a52ceb-6e69-f4ee-04c7-1219bb7947c1@amsat.org>
Date: Sat, 13 May 2017 18:24:29 -0300
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 01/12] net: Add vnet_hdr_len related
 arguments in NetClientState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

Hi Zhang

On 05/11/2017 10:41 PM, Zhang Chen wrote:
> Add vnet_hdr_len and using_vnet_hdr arguments in NetClientState
> that make othermodule get real vnet_hdr_len easily.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>  include/net/net.h | 2 ++
>  net/net.c         | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 99b28d5..70edfc0 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -100,6 +100,8 @@ struct NetClientState {
>      unsigned int queue_index;
>      unsigned rxfilter_notify_enabled:1;
>      int vring_enable;
> +    bool using_vnet_hdr;
> +    int vnet_hdr_len;
>      QTAILQ_HEAD(NetFilterHead, NetFilterState) filters;
>  };
>
> diff --git a/net/net.c b/net/net.c
> index 0ac3b9e..a00a0c9 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -472,6 +472,7 @@ void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
>          return;
>      }
>
> +    nc->using_vnet_hdr = enable;
>      nc->info->using_vnet_hdr(nc, enable);
>  }
>
> @@ -491,6 +492,7 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
>          return;
>      }
>
> +    nc->vnet_hdr_len = len;
>      nc->info->set_vnet_hdr_len(nc, len);
>  }
>

For what it's worth, now having those fields in NetClientState it is 
possible to remove a deref to NetClientInfo in qemu_has_vnet_hdr() and 
qemu_has_vnet_hdr_len().

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
