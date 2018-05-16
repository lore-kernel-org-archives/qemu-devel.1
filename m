Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIxCQ-0006B2-Jm
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIxCH-0004uA-59
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:14:38 -0400
Date: Wed, 16 May 2018 15:14:24 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180516141424.GH2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-4-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-4-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/8] xen: remove other open-coded use of
 libxengnttab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, May 04, 2018 at 08:26:02PM +0100, Paul Durrant wrote:
> Now that helpers are available in xen_backend, use them throughout all
> Xen PV backends.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
> index 20c43a6..73d6f1b 100644
> --- a/hw/net/xen_nic.c
> +++ b/hw/net/xen_nic.c
> @@ -160,9 +160,8 @@ static void net_tx_packets(struct XenNetDev *netdev)
>                            (txreq.flags & NETTXF_more_data)      ? " more_data"      : "",
>                            (txreq.flags & NETTXF_extra_info)     ? " extra_info"     : "");
>  
> -            page = xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
> -                                           netdev->xendev.dom,
> -                                           txreq.gref, PROT_READ);
> +            page = xen_be_map_grant_refs(&netdev->xendev,
> +                                         &txreq.gref, 1, PROT_READ);

xen_be_map_grant_ref instead?

>              if (page == NULL) {
>                  xen_pv_printf(&netdev->xendev, 0,
>                                "error: tx gref dereference failed (%d)\n",
> @@ -183,7 +182,7 @@ static void net_tx_packets(struct XenNetDev *netdev)
>                  qemu_send_packet(qemu_get_queue(netdev->nic),
>                                   page + txreq.offset, txreq.size);
>              }
> -            xengnttab_unmap(netdev->xendev.gnttabdev, page, 1);
> +            xen_be_unmap_grant_ref(&netdev->xendev, page);
>              net_tx_response(netdev, &txreq, NETIF_RSP_OKAY);
>          }
>          if (!netdev->tx_work) {
> @@ -254,9 +253,8 @@ static ssize_t net_rx_packet(NetClientState *nc, const uint8_t *buf, size_t size
>      memcpy(&rxreq, RING_GET_REQUEST(&netdev->rx_ring, rc), sizeof(rxreq));
>      netdev->rx_ring.req_cons = ++rc;
>  
> -    page = xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
> -                                   netdev->xendev.dom,
> -                                   rxreq.gref, PROT_WRITE);
> +    page = xen_be_map_grant_refs(&netdev->xendev, &rxreq.gref, 1,
> +                                 PROT_WRITE);

xen_be_map_grant_ref instead?

With that fix:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
