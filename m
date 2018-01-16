Received: from eggs.gnu.org ([2001:4830:134:3::10]:54975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebHb9-0005Ty-6x
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebHb6-0000N1-1Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:07:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebHb5-0000Mk-RM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:07:35 -0500
Date: Tue, 16 Jan 2018 05:07:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116050627-mutt-send-email-mst@kernel.org>
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
	<20180112145658.17121-5-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112145658.17121-5-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-net: notify backend with number
 of queue pairs setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com

On Fri, Jan 12, 2018 at 03:56:58PM +0100, Maxime Coquelin wrote:
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  hw/net/virtio-net.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 38674b08aa..b8908c98ed 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -561,6 +561,7 @@ static int peer_detach(VirtIONet *n, int index)
>  
>  static void virtio_net_set_queues(VirtIONet *n)
>  {
> +    NetClientState *nc = qemu_get_queue(n->nic);
>      int i;
>      int r;
>  
> @@ -568,6 +569,10 @@ static void virtio_net_set_queues(VirtIONet *n)
>          return;
>      }
>  
> +    if (get_vhost_net(nc->peer)) {
> +        vhost_net_set_queue_num(nc->peer, n->curr_queues);
> +    }
> +
>      for (i = 0; i < n->max_queues; i++) {
>          if (i < n->curr_queues) {
>              r = peer_attach(n, i);

Seems wrong to me.
curr_queues isn't the max # of queues configured as the documentation says.
It's the number of queues currently in use by driver.


> -- 
> 2.14.3
