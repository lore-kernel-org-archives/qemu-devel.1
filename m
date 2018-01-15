Received: from eggs.gnu.org ([2001:4830:134:3::10]:47189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eb762-0003Mv-5V
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eb75x-0007nK-AD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:54:50 -0500
References: <20180110190909.20652-1-marcel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5ea6ecb8-8866-b396-2c45-bac340a400e7@redhat.com>
Date: Mon, 15 Jan 2018 16:54:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180110190909.20652-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci-bridge: fix QEMU crash because of
 pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, zuban32s@gmail.com, mst@redhat.com

On 01/10/18 20:09, Marcel Apfelbaum wrote:
> If we try to use more pcie_root_ports then available slots
> and an IO hint is passed to the port, QEMU crashes because
> we try to init the "IO hint" capability even if the device
> is not created.
> Fix it by checking for error before adding the capability,
> so QEMU can fail gracefully.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

In your opinion, can we add:

Cc: qemu-stable@nongnu.org
Fixes: 226263fb5cdaa4a4a95f1680fabbc9dd2123fd67

?

(Not sure if a stable branch is already open for 2.11. Commit
226263fb5cdaa appeared in 2.11.)

Ah, I'm silly. You CC'd stable up-front. :)

So, what about the Fixes tag?

> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index ad4e6aa7ff..0e2f2e8bf1 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -74,8 +74,13 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>      PCIDevice *d = PCI_DEVICE(dev);
>      GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
>      PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
> +    Error *local_err = NULL;
>  
> -    rpc->parent_realize(dev, errp);
> +    rpc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  
>      int rc = pci_bridge_qemu_reserve_cap_init(d, 0, grp->bus_reserve,
>              grp->io_reserve, grp->mem_reserve, grp->pref32_reserve,
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
