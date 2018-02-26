Received: from eggs.gnu.org ([2001:4830:134:3::10]:42289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eq8w0-0007JC-1g
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 21:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eq8vw-0005BB-Ul
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 21:54:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eq8vw-0005AW-Q4
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 21:54:32 -0500
Date: Mon, 26 Feb 2018 10:54:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180226025418.GO18962@xz-mi>
References: <2837d007-760a-f2c1-c8cd-6f7d4f6f0bbd@web.de>
	<20180222044013.GC18962@xz-mi>
	<2f5781cc-ced4-6df0-906e-cd456d722a6e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f5781cc-ced4-6df0-906e-cd456d722a6e@web.de>
Subject: Re: [Qemu-devel] [PATCH v2] intel-iommu: Accept 64-bit writes to
 FEADDR
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

On Sat, Feb 24, 2018 at 09:30:12AM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Xen is doing this [1] and currently triggers an abort.
> 
> [1] http://xenbits.xenproject.org/gitweb/?p=xen.git;a=blob;f=xen/drivers/passthrough/vtd/iommu.c;h=daaed0abbdd06b6ba3d948ea103aadf02651e83c;hb=refs/heads/master#l1108
> 
> Reported-by: Luis Lloret <luis_lloret@mentor.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks, Jan.

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  hw/i386/intel_iommu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2e841cde27..fb31de9416 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2129,8 +2129,15 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>  
>      /* Fault Event Address Register, 32-bit */
>      case DMAR_FEADDR_REG:
> -        assert(size == 4);
> -        vtd_set_long(s, addr, val);
> +        if (size == 4) {
> +            vtd_set_long(s, addr, val);
> +        } else {
> +            /*
> +             * While the register is 32-bit only, some guests (Xen...) write to
> +             * it with 64-bit.
> +             */
> +            vtd_set_quad(s, addr, val);
> +        }
>          break;
>  
>      /* Fault Event Upper Address Register, 32-bit */

-- 
Peter Xu
