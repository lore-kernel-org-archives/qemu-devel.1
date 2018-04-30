Received: from eggs.gnu.org ([2001:4830:134:3::10]:36009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD8xR-0005mM-4Z
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD8xQ-0006gR-5R
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:35:09 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD8xP-0006gH-V5
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:35:08 -0400
Received: by mail-ot0-x241.google.com with SMTP id j27-v6so9452829ota.5
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 06:35:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430122404.10741-1-peter.maydell@linaro.org>
References: <20180430122404.10741-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 14:34:46 +0100
Message-ID: <CAFEAcA_XLm34+7z3L6jPFMcffxPoKNvmKwrKVrrR6rT_E6wwvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 30 April 2018 at 13:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> Add more detail to the documentation for memory_region_init_iommu()
> and other IOMMU-related functions and data structures.

> @@ -203,20 +211,58 @@ typedef struct IOMMUMemoryRegionClass {
>       * be the access permission of this translation operation. We can
>       * set flag to IOMMU_NONE to mean that we don't need any
>       * read/write permission checks, like, when for region replay.
> +     *
> +     * Once the IOMMU has returned a TLB entry, it must notify
> +     * the IOMMU's users if that TLB entry changes, using
> +     * memory_region_notify_iommu() (or, if necessary, by calling
> +     * memory_region_notify_one() for each registered notifier).
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     * @hwaddr: address to be translated within the memory region
> +     * @flag: requested access permissions
>       */
>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>                                 IOMMUAccessFlags flag);

A question I just thought of -- how long is the IOMMUTLBEntry I get
back guaranteed to be valid for? For instance if I'm in an RCU
critical section can I assume it won't become invalid before I
leave the critical section? Or must I always register an IOMMU
notifier before I call translate? I'm guessing not the latter
because flatview_do_translate() does not, but is the guarantee
only RCU-critical section or while-holding-big-QEMU-lock or
something else?

thanks
-- PMM
