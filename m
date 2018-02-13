Received: from eggs.gnu.org ([2001:4830:134:3::10]:42054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldRH-0002Wg-RB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldRE-0004O1-V7
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:28:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eldRE-0004MB-Pr
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:28:12 -0500
Date: Tue, 13 Feb 2018 18:27:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180213182739-mutt-send-email-mst@kernel.org>
References: <20180213050837.40964-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213050837.40964-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, f4bug@amsat.org, wangxinxin.wang@huawei.com, lidonglin@huawei.com

On Tue, Feb 13, 2018 at 01:08:37PM +0800, linzhecheng wrote:
> g_free() was moved from vhost_net_cleanup in commit e6bcb1b, so we should
> free net after vhost_net_cleanup
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Looks like this needs a Fixes: tag and CC stable - is that right?

> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index cb45512506..d024573e45 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -109,6 +109,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
>  err:
>      if (net) {
>          vhost_net_cleanup(net);
> +        g_free(net);
>      }
>      vhost_user_stop(i, ncs);
>      return -1;
> -- 
> 2.12.2.windows.2
> 
