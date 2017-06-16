Received: from eggs.gnu.org ([2001:4830:134:3::10]:37327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLrzA-0004s2-9K
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLrz5-0006ih-6R
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLrz5-0006hm-0V
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:12:23 -0400
Date: Fri, 16 Jun 2017 17:12:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170616171149-mutt-send-email-mst@kernel.org>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615163813.7255-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-pci: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

On Thu, Jun 15, 2017 at 05:38:09PM +0100, Stefan Hajnoczi wrote:
> Old kvm.ko versions only supported a tiny number of ioeventfds so
> virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> 
> Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> qtest or TCG mode.
> 
> This patch makes -device virtio-blk-pci,iothread=iothread0 work even
> when KVM is disabled.
> 
> I have tested that virtio-blk-pci works under TCG both with and without
> iothread.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Do you want to merge this with the rest of the patchset,
or should I?

> ---
>  hw/virtio/virtio-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..9f55476 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1740,7 +1740,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>      bool pcie_port = pci_bus_is_express(pci_dev->bus) &&
>                       !pci_bus_is_root(pci_dev->bus);
>  
> -    if (!kvm_has_many_ioeventfds()) {
> +    if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
>          proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>      }
>  
> -- 
> 2.9.4
