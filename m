Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cHiel-0000Fn-8s
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 21:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cHiei-0007R5-7e
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 21:53:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cHiei-0007MX-1F
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 21:53:56 -0500
Date: Fri, 16 Dec 2016 10:53:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161216025345.GA5938@pxdev.xzpeter.org>
References: <1478502595-8484-1-git-send-email-jasowang@redhat.com>
	<1478502595-8484-3-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478502595-8484-3-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3 02/10] intel_iommu: name vtd address
 space with devfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Nov 07, 2016 at 03:09:47PM +0800, Jason Wang wrote:
> To avoid duplicated name and ease debugging.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1655a65..5272c30 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2323,6 +2323,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      uintptr_t key = (uintptr_t)bus;
>      VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
>      VTDAddressSpace *vtd_dev_as;
> +    char name[128];
>  
>      if (!vtd_bus) {
>          /* No corresponding free() */
> @@ -2336,6 +2337,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      vtd_dev_as = vtd_bus->dev_as[devfn];
>  
>      if (!vtd_dev_as) {
> +        snprintf(name, sizeof(name), "intel_iommu_devfn_%d", devfn);

Better with bus number as well? ;)

Like: "%02x:%02x.%x" for (bus, dev, fn).

Thanks,

-- peterx
