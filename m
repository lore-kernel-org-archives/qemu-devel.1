Received: from eggs.gnu.org ([2001:4830:134:3::10]:58107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCAn-0002FJ-R2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCAn-0007mT-1u
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:38:53 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQCAm-0007lz-Rt
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:38:52 -0400
Received: by mail-ot0-x243.google.com with SMTP id q17-v6so2831255otg.2
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:38:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605131944.14649-2-peterx@redhat.com>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-2-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 14:38:31 +0100
Message-ID: <CAFEAcA9-O7B5h0ozAqLEUXR=YRS+s-X7A_m=xce-aLgR59EG1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 1/3] memory: add MemTxAttrs to translate
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On 5 June 2018 at 14:19, Peter Xu <peterx@redhat.com> wrote:
> Add a new MemTxAttrs parameter to the IOMMUMemoryRegionClass.translate()
> function, which takes some extra context of the translation request.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/exec/memory.h    | 5 ++++-
>  exec.c                   | 2 +-
>  hw/alpha/typhoon.c       | 3 ++-
>  hw/arm/smmuv3.c          | 2 +-
>  hw/dma/rc4030.c          | 6 ++++--
>  hw/i386/amd_iommu.c      | 2 +-
>  hw/i386/intel_iommu.c    | 6 ++++--
>  hw/ppc/spapr_iommu.c     | 3 ++-
>  hw/s390x/s390-pci-bus.c  | 6 ++++--
>  hw/sparc/sun4m_iommu.c   | 3 ++-
>  hw/sparc64/sun4u_iommu.c | 3 ++-
>  memory.c                 | 3 ++-
>  12 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index eb2ba06519..6b0ced554d 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -234,9 +234,12 @@ typedef struct IOMMUMemoryRegionClass {
>       * @iommu: the IOMMUMemoryRegion
>       * @hwaddr: address to be translated within the memory region
>       * @flag: requested access permissions
> +     * @attrs: MemTxAttrs that was bound to the translation
> +     *         operation. If flag==IOMMU_NONE, this field is
> +     *         meaningless
>       */

This won't work, because the "allow TCG transactions to pass
through an IOMMU" code needs to pass IOMMU_NONE. IOMMU_NONE
means "give me all the permissions info, and don't shortcut it".
For TCG we get the info, and then cache it and use it for
subsequent transactions, both read and write, regardless of
whether the first one was a read or a write.

thanks
-- PMM
