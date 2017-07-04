Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSORD-0006sC-03
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSOR9-0000pN-0X
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:04:23 -0400
References: <20170704135454.13467-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <417cce4a-de1e-e8f5-96a9-a73d0fbe3446@redhat.com>
Date: Tue, 4 Jul 2017 16:04:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170704135454.13467-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Only report host/guest IOMMU page
 size mismatches on KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org, agraf@suse.de, aik@ozlabs.ru
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 04.07.2017 15:54, David Gibson wrote:
> We print a warning if the spapr IOMMU isn't configured to support a page
> size matching the host page size backing RAM.  When that's the case we need
> more complex logic to translate VFIO mappings, which is slower.
> 
> But, it's not so slow that it would be at all noticeable against the
> general slowness of TCG.  So, only warn when using KVM.  This removes some
> noisy and unhelpful warnings from make check on hosts with page sizes
> which typically differ from those on POWER (e.g. Sparc).
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index cc1588d..a52dcf8 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1745,7 +1745,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* DMA setup */
> -    if ((sphb->page_size_mask & qemu_getrampagesize()) == 0) {
> +    if (((sphb->page_size_mask & qemu_getrampagesize()) == 0)
> +        && kvm_enabled()) {

Since you've put me on CC: ... too much parenthesis for my taste ;-)

Apart from that,

Reviewed-by: Thomas Huth <thuth@redhat.com>
