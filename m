Received: from eggs.gnu.org ([2001:4830:134:3::10]:33422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daDx4-0007Zc-Io
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daDwz-00083h-Rh
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:29:38 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daDwz-00083B-M8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:29:33 -0400
Received: by mail-pg0-x242.google.com with SMTP id 125so2759738pgi.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:29:33 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100555881.27487.6700589734222986048.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <98e260fa-cb10-3d02-e240-7d7bc2a61fd2@ozlabs.ru>
Date: Wed, 26 Jul 2017 14:29:26 +1000
MIME-Version: 1.0
In-Reply-To: <150100555881.27487.6700589734222986048.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 06/26] spapr_pci:
 parent the MSI memory region to the PHB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 26/07/17 03:59, Greg Kurz wrote:
> This memory region should be owned by the PHB. This ensures the PHB
> cannot be finalized as long as the the region is guest visible, or
> used by a CPU or a device.

Out of curiosity - does it really ensure this? Passing a parent to
memory_region_init_io() adds a reference to a child (i.e. "msi" region),
not to the PHB object. It is probably a good thing to have an owner for
every MR anyway, I am just not sure about the commit log, what does not
work if you do not do this?


> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 3fe7f3145467..4e4165b44b9a 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1703,7 +1703,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      }
>  #endif
>  
> -    memory_region_init_io(&sphb->msiwindow, NULL, &spapr_msi_ops, spapr,
> +    memory_region_init_io(&sphb->msiwindow, OBJECT(sphb), &spapr_msi_ops, spapr,
>                            "msi", msi_window_size);
>      memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
>                                  &sphb->msiwindow);
> 
> 


-- 
Alexey
