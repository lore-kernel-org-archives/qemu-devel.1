Received: from eggs.gnu.org ([2001:4830:134:3::10]:51092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZkCc-0007QU-QX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZkCY-0001N4-U2
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dZkCY-00019j-Mu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:43:38 -0400
Date: Mon, 24 Jul 2017 23:43:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170724234138-mutt-send-email-mst@kernel.org>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-7-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500761743-1669-7-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/6] hw/pci: add hint capabilty for
 additional bus reservation to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org

On Sun, Jul 23, 2017 at 01:15:43AM +0300, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  hw/pci-bridge/pcie_root_port.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index b0e49e1..ca92d85 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -106,6 +106,11 @@ static void rp_realize(PCIDevice *d, Error **errp)
>      pcie_aer_root_init(d);
>      rp_aer_vector_update(d);
>  
> +    rc = pci_bridge_help_cap_init(d, 0, p->bus_reserve, 0, 0, 0, errp);
> +    if (rc < 0) {
> +        goto err;
> +    }
> +
>      return;
>  
>  err:

It looks like this will add the capability unconditionally to all
pcie root ports. Two issues with it:
1. you can't add vendor properties to devices where vendor is
   not qemu as they might have their own concept of what it does.
2. this will break compatibility with old machine types,
   need to disable for these

> -- 
> 2.7.4
