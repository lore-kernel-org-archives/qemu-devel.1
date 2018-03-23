Received: from eggs.gnu.org ([2001:4830:134:3::10]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ezRe5-0006vJ-5c
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ezRe0-0006l3-QH
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:42:33 -0400
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<1518116908-10852-12-git-send-email-mst@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <41774c00-7462-f2b0-9314-3b3d7e0f9fb0@redhat.com>
Date: Fri, 23 Mar 2018 19:42:07 +0100
MIME-Version: 1.0
In-Reply-To: <1518116908-10852-12-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/26] pci-bridge/i82801b11: clear bridge
 registers on platform reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, qemu-stable@nongnu.org

Michael, Peter,

On 02/08/18 20:09, Michael S. Tsirkin wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> The "i82801b11-bridge" device model is a descendant of "base-pci-bridge"
> (TYPE_PCI_BRIDGE). However, unlike other similar devices, such as
> 
> - pci-bridge,
> - pcie-pci-bridge,
> - PCIE Root Port,
> - xio3130 switch upstream and downstream ports,
> - dec-21154-p2p-bridge,
> - pbm-bridge,
> - xilinx-pcie-root,
> 
> "i82801b11-bridge" does not clear the bridge specific registers at
> platform reset.
> 
> This is a problem because devices on "i82801b11-bridge" continue to
> respond to config space cycles after platform reset, when addressed with
> the bus number that was previously programmed into the secondary bus
> number register of "i82801b11-bridge". This error breaks OVMF's search for
> extra (PXB) root buses, for example.
> 
> The device class reset method for "i82801b11-bridge" is currently NULL;
> set it directly to pci_bridge_reset(), like the last three bridge models
> in the above listing do.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: qemu-stable@nongnu.org
> Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1541839
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/pci-bridge/i82801b11.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> index cb522bf..ebf7f5f 100644
> --- a/hw/pci-bridge/i82801b11.c
> +++ b/hw/pci-bridge/i82801b11.c
> @@ -98,6 +98,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
>      k->realize = i82801b11_bridge_realize;
>      k->config_write = pci_bridge_write_config;
>      dc->vmsd = &i82801b11_bridge_dev_vmstate;
> +    dc->reset = pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>  
> 

this patch didn't get included in the 2.11.1 round-up:

http://mid.mail-archive.com/20180206191515.25830-1-mdroth@linux.vnet.ibm.com

(The patch was posted, CC stable, between Mike's round-up set and the
actual 2.11.1 release.)

Can we please make sure that the commit doesn't miss the 2.11.2 bus?
2.12 is still a month out, and without this patch, rebooting an UEFI
guest OS (with OVMF) hangs, on certain VM configs (see the commit message).

(Apologies if there is a "queue" or "next" branch for stable releases --
in that case I should have probably checked that branch before sending
this email.)

The commit hash on the master branch is
ed247f40db84c8bd4bb7d10948702cd47cc4d5ae; it's part of v2.12.0-rc0.

Thanks!
Laszlo
