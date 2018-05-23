Received: from eggs.gnu.org ([2001:4830:134:3::10]:49822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLPoP-0003Sf-DL
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLPoK-00042m-Im
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:12:01 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fLPoK-00041s-4R
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:11:56 -0400
Received: by mail-wr0-x242.google.com with SMTP id p3-v6so6281523wrn.7
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 02:11:56 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-17-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-17-peter.maydell@linaro.org>
Date: Wed, 23 May 2018 10:11:53 +0100
Message-ID: <874liyviqu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/27] iommu: Add IOMMU index argument to
 translate method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add an IOMMU index argument to the translate method of
> IOMMUs. Since all of our current IOMMU implementations
> support only a single IOMMU index, this has no effect
> on the behaviour.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Modulo comment about signed indexes in previous commit:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory.h    |  3 ++-
>  exec.c                   | 11 +++++++++--
>  hw/alpha/typhoon.c       |  3 ++-
>  hw/arm/smmuv3.c          |  2 +-
>  hw/dma/rc4030.c          |  2 +-
>  hw/i386/amd_iommu.c      |  2 +-
>  hw/i386/intel_iommu.c    |  2 +-
>  hw/ppc/spapr_iommu.c     |  3 ++-
>  hw/s390x/s390-pci-bus.c  |  2 +-
>  hw/sparc/sun4m_iommu.c   |  3 ++-
>  hw/sparc64/sun4u_iommu.c |  2 +-
>  memory.c                 |  2 +-
>  12 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 4e6b125add..b25cf527bb 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -252,9 +252,10 @@ typedef struct IOMMUMemoryRegionClass {
>       * @iommu: the IOMMUMemoryRegion
>       * @hwaddr: address to be translated within the memory region
>       * @flag: requested access permissions
> +     * @iommu_idx: IOMMU index for the translation
>       */
>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
> -                               IOMMUAccessFlags flag);
> +                               IOMMUAccessFlags flag, int iommu_idx);
>      /* Returns minimum supported page size in bytes.
>       * If this method is not provided then the minimum is assumed to
>       * be TARGET_PAGE_SIZE.
> diff --git a/exec.c b/exec.c
> index c3baadc349..c9285c9c39 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -498,8 +498,15 @@ static MemoryRegionSection address_space_translate_i=
ommu(IOMMUMemoryRegion *iomm
>      do {
>          hwaddr addr =3D *xlat;
>          IOMMUMemoryRegionClass *imrc =3D memory_region_get_iommu_class_n=
ocheck(iommu_mr);
> -        IOMMUTLBEntry iotlb =3D imrc->translate(iommu_mr, addr, is_write=
 ?
> -                                              IOMMU_WO : IOMMU_RO);
> +        int iommu_idx =3D 0;
> +        IOMMUTLBEntry iotlb;
> +
> +        if (imrc->attrs_to_index) {
> +            iommu_idx =3D imrc->attrs_to_index(iommu_mr, attrs);
> +        }
> +
> +        iotlb =3D imrc->translate(iommu_mr, addr, is_write ?
> +                                IOMMU_WO : IOMMU_RO, iommu_idx);
>
>          if (!(iotlb.perm & (1 << is_write))) {
>              goto unassigned;
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 6a40869488..d3ed7cdbe8 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -666,7 +666,8 @@ static bool window_translate(TyphoonWindow *win, hwad=
dr addr,
>     Pchip and generate a machine check interrupt.  */
>  static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
>                                               hwaddr addr,
> -                                             IOMMUAccessFlags flag)
> +                                             IOMMUAccessFlags flag,
> +                                             int iommu_idx)
>  {
>      TyphoonPchip *pchip =3D container_of(iommu, TyphoonPchip, iommu);
>      IOMMUTLBEntry ret;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 42dc521c13..978330900d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -538,7 +538,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr=
, SMMUTransCfg *cfg,
>  }
>
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> -                                      IOMMUAccessFlags flag)
> +                                      IOMMUAccessFlags flag, int iommu_i=
dx)
>  {
>      SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
>      SMMUv3State *s =3D sdev->smmu;
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 5d4833eeca..ccd8612888 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -491,7 +491,7 @@ static const MemoryRegionOps jazzio_ops =3D {
>  };
>
>  static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwad=
dr addr,
> -                                          IOMMUAccessFlags flag)
> +                                          IOMMUAccessFlags flag, int iom=
mu_idx)
>  {
>      rc4030State *s =3D container_of(iommu, rc4030State, dma_mr);
>      IOMMUTLBEntry ret =3D {
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 63d46ff6ee..1fd669fef8 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -991,7 +991,7 @@ static inline bool amdvi_is_interrupt_addr(hwaddr add=
r)
>  }
>
>  static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr ad=
dr,
> -                                     IOMMUAccessFlags flag)
> +                                     IOMMUAccessFlags flag, int iommu_id=
x)
>  {
>      AMDVIAddressSpace *as =3D container_of(iommu, AMDVIAddressSpace, iom=
mu);
>      AMDVIState *s =3D as->iommu_state;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b8c9354b0b..a4b9a254bd 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2282,7 +2282,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>  }
>
>  static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwadd=
r addr,
> -                                         IOMMUAccessFlags flag)
> +                                         IOMMUAccessFlags flag, int iomm=
u_idx)
>  {
>      VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iom=
mu);
>      IntelIOMMUState *s =3D vtd_as->iommu_state;
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 301708e45e..1b0880ac9e 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -112,7 +112,8 @@ static void spapr_tce_free_table(uint64_t *table, int=
 fd, uint32_t nb_table)
>  /* Called from RCU critical section */
>  static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
>                                                 hwaddr addr,
> -                                               IOMMUAccessFlags flag)
> +                                               IOMMUAccessFlags flag,
> +                                               int iommu_idx)
>  {
>      sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
>      uint64_t tce;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 10da87458e..e3e0ebb7f6 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -484,7 +484,7 @@ uint16_t s390_guest_io_table_walk(uint64_t g_iota, hw=
addr addr,
>  }
>
>  static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr =
addr,
> -                                          IOMMUAccessFlags flag)
> +                                          IOMMUAccessFlags flag, int iom=
mu_idx)
>  {
>      S390PCIIOMMU *iommu =3D container_of(mr, S390PCIIOMMU, iommu_mr);
>      S390IOTLBEntry *entry;
> diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
> index b677601fc6..7ca1e3fce4 100644
> --- a/hw/sparc/sun4m_iommu.c
> +++ b/hw/sparc/sun4m_iommu.c
> @@ -282,7 +282,8 @@ static void iommu_bad_addr(IOMMUState *s, hwaddr addr,
>  /* Called from RCU critical section */
>  static IOMMUTLBEntry sun4m_translate_iommu(IOMMUMemoryRegion *iommu,
>                                             hwaddr addr,
> -                                           IOMMUAccessFlags flags)
> +                                           IOMMUAccessFlags flags,
> +                                           int iommu_idx)
>  {
>      IOMMUState *is =3D container_of(iommu, IOMMUState, iommu);
>      hwaddr page, pa;
> diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
> index eb3aaa87e6..1ef7645ba5 100644
> --- a/hw/sparc64/sun4u_iommu.c
> +++ b/hw/sparc64/sun4u_iommu.c
> @@ -73,7 +73,7 @@
>  /* Called from RCU critical section */
>  static IOMMUTLBEntry sun4u_translate_iommu(IOMMUMemoryRegion *iommu,
>                                             hwaddr addr,
> -                                           IOMMUAccessFlags flag)
> +                                           IOMMUAccessFlags flag, int io=
mmu_idx)
>  {
>      IOMMUState *is =3D container_of(iommu, IOMMUState, iommu);
>      hwaddr baseaddr, offset;
> diff --git a/memory.c b/memory.c
> index accb28d694..ff6cbf5831 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1835,7 +1835,7 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *=
iommu_mr, IOMMUNotifier *n)
>      granularity =3D memory_region_iommu_get_min_page_size(iommu_mr);
>
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> -        iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE);
> +        iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iommu_i=
dx);
>          if (iotlb.perm !=3D IOMMU_NONE) {
>              n->notify(n, &iotlb);
>          }


--
Alex Benn=C3=A9e
