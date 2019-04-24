Received: from eggs.gnu.org ([209.51.188.92]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hJKNr-0008Uq-WE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hJKNp-0003EY-W5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:04:31 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:58042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hJKNk-00035f-1u
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:04:27 -0400
Received: from player750.ha.ovh.net (unknown [10.108.54.67])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B7E7D1E3EBC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 18:04:10 +0200 (CEST)
Date: Wed, 24 Apr 2019 18:04:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190424180401.67985be2@bahia.lan>
In-Reply-To: <20190424041959.4087-2-david@gibson.dropbear.id.au>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pcie: Remove redundant test in
 pcie_mmcfg_data_{read, write}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, clg@kaod.org, qemu-ppc@nongnu.org

On Wed, 24 Apr 2019 14:19:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> These functions have an explicit test for accesses above the device's
> config size.  But pci_host_config_{read,write}_common() which they're
> about to call already have checks against the config space limit and
> do the right thing.  So, remove the redundant tests.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/pci/pcie_host.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> index 553db56778..1ee4945a6d 100644
> --- a/hw/pci/pcie_host.c
> +++ b/hw/pci/pcie_host.c
> @@ -47,11 +47,6 @@ static void pcie_mmcfg_data_write(void *opaque, hwaddr mmcfg_addr,
>      }
>      addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
>      limit = pci_config_size(pci_dev);
> -    if (limit <= addr) {
> -        /* conventional pci device can be behind pcie-to-pci bridge.
> -           256 <= addr < 4K has no effects. */
> -        return;
> -    }
>      pci_host_config_write_common(pci_dev, addr, limit, val, len);
>  }
>  
> @@ -70,11 +65,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
>      }
>      addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
>      limit = pci_config_size(pci_dev);
> -    if (limit <= addr) {
> -        /* conventional pci device can be behind pcie-to-pci bridge.
> -           256 <= addr < 4K has no effects. */
> -        return ~0x0;
> -    }
>      return pci_host_config_read_common(pci_dev, addr, limit, len);
>  }
>  
