Received: from eggs.gnu.org ([2001:4830:134:3::10]:55446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1cGiUj-0000cA-JI
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1cGiUe-0008OV-OY
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:31:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:33775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1cGiUe-0008N4-Fo
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:31:24 -0500
Date: Mon, 12 Dec 2016 16:16:50 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20161212081650.GA13155@gmail.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
	<1481020588-4245-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481020588-4245-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/13] intel_iommu: allocate new key
 when creating new address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, alex.williamson@redhat.com, jasowang@redhat.com, yi.liu@intel.com

On Tue, Dec 06, 2016 at 06:36:16PM +0800, Peter Xu wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> We use the pointer to stack for key for new address space, this will
> break hash table searching, fixing by g_malloc() a new key instead.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 708770e..92e4064 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2426,12 +2426,13 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      VTDAddressSpace *vtd_dev_as;
>  
>      if (!vtd_bus) {
> +        uintptr_t *new_key = g_malloc(sizeof(*new_key));
> +        *new_key = (uintptr_t)bus;
>          /* No corresponding free() */
>          vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
>                              X86_IOMMU_PCI_DEVFN_MAX);
>          vtd_bus->bus = bus;
> -        key = (uintptr_t)bus;
> -        g_hash_table_insert(s->vtd_as_by_busptr, &key, vtd_bus);
> +        g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
Hi Peter,
Your fix seems to answer an issue I encountered back in Oct. The symptom is: use the same bus value to
searcha previous inserted entry in s->vtd_as_by_busptr, the result is not found.

really grt fix. could explain it a bit on why this change would fix the issue?

Regards,
Yi L
>      }
>  
>      vtd_dev_as = vtd_bus->dev_as[devfn];
> -- 
> 2.7.4
> 
> 
