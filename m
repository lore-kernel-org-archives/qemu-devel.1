Received: from eggs.gnu.org ([2001:4830:134:3::10]:49020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gM7iG-0004LH-Ct
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gM7iC-00050e-9p
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:36:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gM7iC-0004ye-0v
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:36:48 -0500
Date: Mon, 12 Nov 2018 16:36:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181112083634.GC20675@xz-x1>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-3-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541764187-10732-3-git-send-email-yu.c.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Nov 09, 2018 at 07:49:46PM +0800, Yu Zhang wrote:
> A 5-level paging capable VM may choose to use 57-bit IOVA address width.
> E.g. guest applications like DPDK prefer to use its VA as IOVA when
> performing VFIO map/unmap operations, to avoid the burden of managing the
> IOVA space.

Since you mentioned about DPDK... I'm just curious that whether have
you tested the patchset with the 57bit-enabled machines with DPDK VA
mode running in the guest? That would be something nice to mention in
the cover letter if you have.

[...]

> @@ -3264,11 +3286,19 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>          }
>      }
>  
> -    /* Currently only address widths supported are 39 and 48 bits */
> +    /* Currently address widths supported are 39, 48, and 57 bits */
>      if ((s->aw_bits != VTD_AW_39BIT) &&
> -        (s->aw_bits != VTD_AW_48BIT)) {
> -        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
> -                   VTD_AW_39BIT, VTD_AW_48BIT);
> +        (s->aw_bits != VTD_AW_48BIT) &&
> +        (s->aw_bits != VTD_AW_57BIT)) {
> +        error_setg(errp, "Supported values for x-aw-bits are: %d, %d, %d",
> +                   VTD_AW_39BIT, VTD_AW_48BIT, VTD_AW_57BIT);
> +        return false;
> +    }
> +
> +    if ((s->aw_bits == VTD_AW_57BIT) &&
> +        !(host_has_la57() && guest_has_la57())) {
> +        error_setg(errp, "Do not support 57-bit DMA address, unless both "
> +                         "host and guest are capable of 5-level paging.\n");

Is there any context (or pointer to previous discussions would work
too) on explaining why we don't support some scenarios like
host_paw=48,guest_paw=48,guest_gaw=57?

Thanks,

-- 
Peter Xu
