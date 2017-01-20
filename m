Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUZP8-0001IN-Tk
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUZP5-0002Yp-Lt
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:38:58 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cUZP5-0002Y9-EN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:38:55 -0500
Received: by mail-lf0-x243.google.com with SMTP id h65so8617858lfi.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 05:38:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484894128-7871-1-git-send-email-jasowang@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a934380d-43ec-5898-f8e3-5f1ae87e3f2b@redhat.com>
Date: Fri, 20 Jan 2017 14:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <1484894128-7871-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: fix and simplify size
 calculation in process_device_iotlb_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com



On 20/01/2017 07:35, Jason Wang wrote:
> We don't use 1ULL which is wrong during size calculation. Fix it, and
> while at it, switch to use cto64() and adds a comments to make it
> simpler and easier to be understood.
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ec62239..3270fb9 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1485,8 +1485,16 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>          goto done;
>      }
>  
> +    /* According to ATS spec table 2.4:
> +     * S = 0, bits 15:12 = xxxx     range size: 4K
> +     * S = 1, bits 15:12 = xxx0     range size: 8K
> +     * S = 1, bits 15:12 = xx01     range size: 16K
> +     * S = 1, bits 15:12 = x011     range size: 32K
> +     * S = 1, bits 15:12 = 0111     range size: 64K
> +     * ...
> +     */
>      if (size) {
> -        sz = 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);
> +        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
>          addr &= ~(sz - 1);
>      } else {
>          sz = VTD_PAGE_SIZE;
> 


Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
