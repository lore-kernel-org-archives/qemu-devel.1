Received: from eggs.gnu.org ([2001:4830:134:3::10]:56815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86hb-0007qB-GJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86hY-0004UK-Df
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:37:43 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:46487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86hY-0004Tx-8z
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:37:40 -0400
Received: by mail-qt0-x234.google.com with SMTP id 1so8909652qtn.3
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:37:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1509106789-8626-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0507875b-9bf5-f2a9-c6a5-b19329d4f6f5@amsat.org>
Date: Fri, 27 Oct 2017 12:37:29 -0300
MIME-Version: 1.0
In-Reply-To: <1509106789-8626-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/4] sun4m: implement IOMMU translation
 using IOMMU memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/27/2017 09:19 AM, Mark Cave-Ayland wrote:
[...]
> +/* Called from RCU critical section */
> +static IOMMUTLBEntry sun4m_translate_iommu(IOMMUMemoryRegion *iommu,
> +                                           hwaddr addr,
> +                                           IOMMUAccessFlags flags)
> +{
> +    IOMMUState *is = container_of(iommu, IOMMUState, iommu);
> +    hwaddr page, pa;
> +    int is_write = (flags & IOMMU_WO) ? 1 : 0;
> +    uint32_t pte;
> +    IOMMUTLBEntry ret = {
> +        .target_as = &address_space_memory,
> +        .iova = 0,
> +        .translated_addr = 0,
> +        .addr_mask = ~(hwaddr)0,

I never thought of it! I would have write (hwaddr)~0 but your way is
much cleaner.

> +        .perm = IOMMU_NONE,
> +    };
[...]
