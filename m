Received: from eggs.gnu.org ([209.51.188.92]:54366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBDZe-0006T1-HF
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBDZc-00065d-JY
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:11:10 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:45652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hBDZb-0005xk-0v
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:11:07 -0400
Received: from player687.ha.ovh.net (unknown [10.109.143.189])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id DCBF81E173D
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 09:11:04 +0200 (CEST)
Date: Tue, 2 Apr 2019 09:10:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190402091055.016165b6@bahia.lan>
In-Reply-To: <20190402054028.20926-4-david@gibson.dropbear.id.au>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
	<20190402054028.20926-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-4.1 3/5] pcie: Remove redundant test in
 pcie_mmcfg_data_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org

On Tue,  2 Apr 2019 16:40:26 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> This function has an explicit test for accesses above the device's config
> size, in which case it returns ~0x0.  But pci_host_config_read_common()
> which it is about to call already has checks against the config space
> limit and likewise returns ~0x0 in that case.  So, remove the redundant
> test.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/pci/pcie_host.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> index 553db56778..8f4435838e 100644
> --- a/hw/pci/pcie_host.c
> +++ b/hw/pci/pcie_host.c
> @@ -70,11 +70,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
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

It looks good but what about pcie_mmcfg_data_write(), which follows
the same pattern ?
