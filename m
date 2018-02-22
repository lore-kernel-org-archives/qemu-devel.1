Received: from eggs.gnu.org ([2001:4830:134:3::10]:59909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eoigM-0007gb-DZ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 23:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eoigI-0004l8-Al
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 23:40:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eoigH-0004iO-Vy
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 23:40:30 -0500
Date: Thu, 22 Feb 2018 12:40:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180222044013.GC18962@xz-mi>
References: <2837d007-760a-f2c1-c8cd-6f7d4f6f0bbd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2837d007-760a-f2c1-c8cd-6f7d4f6f0bbd@web.de>
Subject: Re: [Qemu-devel] [PATCH] intel-iommu: Accept 64-bit writes to FEADDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Lloret, Luis" <luis_lloret@mentor.com>

On Sat, Feb 17, 2018 at 12:26:19PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Xen is doing this [1] and currently triggers an abort.
> 
> [1] http://xenbits.xenproject.org/gitweb/?p=xen.git;a=blob;f=xen/drivers/passthrough/vtd/iommu.c;h=daaed0abbdd06b6ba3d948ea103aadf02651e83c;hb=refs/heads/master#l1108
> 
> Reported-by: Luis Lloret <luis_lloret@mentor.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/i386/intel_iommu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2e841cde27..b61d0da270 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2129,7 +2129,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>  
>      /* Fault Event Address Register, 32-bit */
>      case DMAR_FEADDR_REG:
> -        assert(size == 4);
> +        /*
> +         * While the register is 32-bit only, some guests (Xen...) write to it
> +         * with 64-bit. Ignore the upper part, that's likely what the hardware
> +         * does as well (plus the upper part is not used by our model anyway).
> +         */
> +        assert(size >= 4);
>          vtd_set_long(s, addr, val);
>          break;

(Sorry for the late response due to Chinese Spring Festival)

I agree with the problem there, but do we still better provide a
conditional vtd_set_quad()?  Since from the spec 10.4.13 the upper 32
bits may still be used when x2apic (Extended Interrupt Mode) is
enabled?

Thanks,

-- 
Peter Xu
