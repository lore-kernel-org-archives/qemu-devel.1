Received: from eggs.gnu.org ([2001:4830:134:3::10]:34119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dvWHo-0005lU-F1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 18:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dvWHl-0008AB-9d
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 18:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dvWHl-00088B-2v
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 18:19:01 -0400
References: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <905d94b3-291b-0e55-e234-97fc2c85b6a6@redhat.com>
Date: Sat, 23 Sep 2017 00:18:51 +0200
MIME-Version: 1.0
In-Reply-To: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com

On 09/22/17 14:18, Mark Cave-Ayland wrote:
> Whilst the underlying PCI bridge implementation supports 32-bit PCI IO
> accesses, unfortunately they are truncated at the legacy 64K limit.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci/pci_bridge.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 17feae5..a47d257 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -379,7 +379,8 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
>      sec_bus->address_space_mem = &br->address_space_mem;
>      memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
>      sec_bus->address_space_io = &br->address_space_io;
> -    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io", 65536);
> +    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
> +                       UINT32_MAX);
>      br->windows = pci_bridge_region_init(br);
>      QLIST_INIT(&sec_bus->child);
>      QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
> 

Based on the commit message, I assume this change is guest-visible. If
so, should it be made dependent on a compat property, so that it doesn't
cause problems with migration?

Thanks,
Laszlo
