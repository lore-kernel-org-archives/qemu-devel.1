Received: from eggs.gnu.org ([2001:4830:134:3::10]:47979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dXpSn-0008CF-Om
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dXpSj-0003yz-RB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:56:29 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:34839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1dXpSj-0003yG-HE
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:56:25 -0400
Date: Wed, 19 Jul 2017 09:56:12 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170719135612.GF5722@char.us.oracle.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500470414-7911-3-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500470414-7911-3-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] pci: enable RedHat pci bridges to
 reserve more buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 19, 2017 at 04:20:14PM +0300, Aleksandr Bezzubikov wrote:
> In case of RedHat PCI bridges reserve additional buses, which number is provided

It is "Red Hat"
> in a vendor-specific capability.

And perhaps also a #define ?
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  src/fw/pciinit.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index 08221e6..b6f3a01 100644
> --- a/src/fw/pciinit.c
> +++ b/src/fw/pciinit.c
> @@ -578,9 +578,17 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
>          pci_bios_init_bus_rec(secbus, pci_bus);
>  
>          if (subbus != *pci_bus) {
> +            u16 vendor = pci_config_readw(bdf, PCI_VENDOR_ID);
> +            u8 res_bus = 0;
> +            if (vendor == 0x1b36) {
> +                u8 cap = pci_find_capability_bdf(bdf, PCI_CAP_ID_VNDR, 0);
> +                if (cap) {
> +                    res_bus = pci_config_readb(bdf, cap + 16);
> +                }
> +            }
>              dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
> -                    subbus, *pci_bus);
> -            subbus = *pci_bus;
> +                    subbus, *pci_bus + res_bus);
> +            subbus = *pci_bus + res_bus;
>          } else {
>              dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
>          }
> -- 
> 2.7.4
> 
> 
