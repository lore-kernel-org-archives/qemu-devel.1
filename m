Received: from eggs.gnu.org ([2001:4830:134:3::10]:48657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRfF-0001zY-OH
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRfB-0006LQ-Mm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:53:53 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRfB-0006KJ-I5
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:53:49 -0500
Received: by mail-qk0-x244.google.com with SMTP id s198so4920864qke.5
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 19:53:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180213025306.16736-1-linzhecheng@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11266f1b-1001-4ddc-173b-7d079b3cc221@amsat.org>
Date: Tue, 13 Feb 2018 00:53:45 -0300
MIME-Version: 1.0
In-Reply-To: <20180213025306.16736-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, wangxinxin.wang@huawei.com, lidonglin@huawei.com, mst@redhat.com

Hi Linzhecheng,

On 02/12/2018 11:53 PM, linzhecheng wrote:
> fix memory leak
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index cb45512506..d024573e45 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -109,6 +109,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
>  err:
>      if (net) {
>          vhost_net_cleanup(net);
> +        g_free(net);

I think this g_free() belongs to vhost_net_cleanup() in net/vhost_net.c:

void vhost_net_cleanup(struct vhost_net *net)
{
    vhost_dev_cleanup(&net->dev);
    g_free(net);
}

Regards,

Phil.

>      }
>      vhost_user_stop(i, ncs);
>      return -1;
> 
