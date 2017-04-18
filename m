Received: from eggs.gnu.org ([2001:4830:134:3::10]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KRT-0006jD-7T
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KRR-0000tp-Hh
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:08:39 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0KRQ-0000su-Qk
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:08:37 -0400
Date: Tue, 18 Apr 2017 14:07:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418040736.GP12235@umbus.fritz.box>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H14uD12u8nekTETJ"
Content-Disposition: inline
In-Reply-To: <1492428730-13438-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] memory: tune last param of
 iommu_ops.translate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--H14uD12u8nekTETJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 07:32:04PM +0800, Peter Xu wrote:
> This patch converts the old "is_write" bool into IOMMUAccessFlags. The
> difference is that "is_write" can only express either read/write, but
> sometimes what we really want is "none" here (neither read nor write).
> Replay is an good example - during replay, we should not check any RW
> permission bits since thats not an actual IO at all.
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

spapr specific part,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  exec.c                   |  6 ++++--
>  hw/alpha/typhoon.c       |  2 +-
>  hw/dma/rc4030.c          |  2 +-
>  hw/i386/amd_iommu.c      |  4 ++--
>  hw/i386/intel_iommu.c    |  4 ++--
>  hw/pci-host/apb.c        |  2 +-
>  hw/ppc/spapr_iommu.c     |  2 +-
>  hw/s390x/s390-pci-bus.c  |  2 +-
>  hw/s390x/s390-pci-inst.c |  2 +-
>  include/exec/memory.h    | 10 ++++++++--
>  memory.c                 |  3 ++-
>  11 files changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index c97ef4a..188892b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -475,7 +475,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSp=
ace *as, hwaddr addr,
>              break;
>          }
> =20
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write ?
> +                                         IOMMU_WO : IOMMU_RO);
>          if (!(iotlb.perm & (1 << is_write))) {
>              iotlb.target_as =3D NULL;
>              break;
> @@ -507,7 +508,8 @@ MemoryRegion *address_space_translate(AddressSpace *a=
s, hwaddr addr,
>              break;
>          }
> =20
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write ?
> +                                         IOMMU_WO : IOMMU_RO);
>          addr =3D ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
>          *plen =3D MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index f50f5cf..c1cf780 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -664,7 +664,7 @@ static bool window_translate(TyphoonWindow *win, hwad=
dr addr,
>  /* TODO: A translation failure here ought to set PCI error codes on the
>     Pchip and generate a machine check interrupt.  */
>  static IOMMUTLBEntry typhoon_translate_iommu(MemoryRegion *iommu, hwaddr=
 addr,
> -                                             bool is_write)
> +                                             IOMMUAccessFlags flag)
>  {
>      TyphoonPchip *pchip =3D container_of(iommu, TyphoonPchip, iommu);
>      IOMMUTLBEntry ret;
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 0080141..edf9432 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -489,7 +489,7 @@ static const MemoryRegionOps jazzio_ops =3D {
>  };
> =20
>  static IOMMUTLBEntry rc4030_dma_translate(MemoryRegion *iommu, hwaddr ad=
dr,
> -                                          bool is_write)
> +                                          IOMMUAccessFlags flag)
>  {
>      rc4030State *s =3D container_of(iommu, rc4030State, dma_mr);
>      IOMMUTLBEntry ret =3D {
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index f86a40a..42b34ef 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -987,7 +987,7 @@ static inline bool amdvi_is_interrupt_addr(hwaddr add=
r)
>  }
> =20
>  static IOMMUTLBEntry amdvi_translate(MemoryRegion *iommu, hwaddr addr,
> -                                     bool is_write)
> +                                     IOMMUAccessFlags flag)
>  {
>      AMDVIAddressSpace *as =3D container_of(iommu, AMDVIAddressSpace, iom=
mu);
>      AMDVIState *s =3D as->iommu_state;
> @@ -1016,7 +1016,7 @@ static IOMMUTLBEntry amdvi_translate(MemoryRegion *=
iommu, hwaddr addr,
>          return ret;
>      }
> =20
> -    amdvi_do_translate(as, addr, is_write, &ret);
> +    amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
>      trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
>              PCI_FUNC(as->devfn), addr, ret.translated_addr);
>      return ret;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 02f047c..ea54ec3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2221,7 +2221,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>  }
> =20
>  static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr add=
r,
> -                                         bool is_write)
> +                                         IOMMUAccessFlags flag)
>  {
>      VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iom=
mu);
>      IntelIOMMUState *s =3D vtd_as->iommu_state;
> @@ -2243,7 +2243,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegi=
on *iommu, hwaddr addr,
>      }
> =20
>      vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn, addr,
> -                           is_write, &ret);
> +                           flag & IOMMU_WO, &ret);
>      VTD_DPRINTF(MMU,
>                  "bus %"PRIu8 " slot %"PRIu8 " func %"PRIu8 " devfn %"PRI=
u8
>                  " iova 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->=
bus),
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 653e711..ad7abb2 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -209,7 +209,7 @@ static AddressSpace *pbm_pci_dma_iommu(PCIBus *bus, v=
oid *opaque, int devfn)
> =20
>  /* Called from RCU critical section */
>  static IOMMUTLBEntry pbm_translate_iommu(MemoryRegion *iommu, hwaddr add=
r,
> -                                         bool is_write)
> +                                         IOMMUAccessFlags flag)
>  {
>      IOMMUState *is =3D container_of(iommu, IOMMUState, iommu);
>      hwaddr baseaddr, offset;
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index ae30bbe..a3ae78d 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -110,7 +110,7 @@ static void spapr_tce_free_table(uint64_t *table, int=
 fd, uint32_t nb_table)
> =20
>  /* Called from RCU critical section */
>  static IOMMUTLBEntry spapr_tce_translate_iommu(MemoryRegion *iommu, hwad=
dr addr,
> -                                               bool is_write)
> +                                               IOMMUAccessFlags flag)
>  {
>      sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
>      uint64_t tce;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 69b0291..9b2c344 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -355,7 +355,7 @@ out:
>  }
> =20
>  static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *mr, hwaddr addr,
> -                                          bool is_write)
> +                                          IOMMUAccessFlags flag)
>  {
>      uint64_t pte;
>      uint32_t flags;
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index d2a8c0a..0087aa7 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -622,7 +622,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
> =20
>      mr =3D &iommu->iommu_mr;
>      while (start < end) {
> -        entry =3D mr->iommu_ops->translate(mr, start, 0);
> +        entry =3D mr->iommu_ops->translate(mr, start, IOMMU_NONE);
> =20
>          if (!entry.translated_addr) {
>              pbdev->state =3D ZPCI_FS_ERROR;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index c4fc94d..9047bf3 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -185,8 +185,14 @@ struct MemoryRegionOps {
>  typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
> =20
>  struct MemoryRegionIOMMUOps {
> -    /* Return a TLB entry that contains a given address. */
> -    IOMMUTLBEntry (*translate)(MemoryRegion *iommu, hwaddr addr, bool is=
_write);
> +    /*
> +     * Return a TLB entry that contains a given address. Flag should
> +     * be the access permission of this translation operation. We can
> +     * set flag to IOMMU_NONE to mean that we don't need any
> +     * read/write permission checks, like, when for region replay.
> +     */
> +    IOMMUTLBEntry (*translate)(MemoryRegion *iommu, hwaddr addr,
> +                               IOMMUAccessFlags flag);
>      /* Returns minimum supported page size */
>      uint64_t (*get_min_page_size)(MemoryRegion *iommu);
>      /* Called when IOMMU Notifier flag changed */
> diff --git a/memory.c b/memory.c
> index b782d5b..47dc107 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1625,6 +1625,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, I=
OMMUNotifier *n,
>  {
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
> +    IOMMUAccessFlags flag =3D is_write ? IOMMU_WO : IOMMU_RO;
> =20
>      /* If the IOMMU has its own replay callback, override */
>      if (mr->iommu_ops->replay) {
> @@ -1635,7 +1636,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, I=
OMMUNotifier *n,
>      granularity =3D memory_region_iommu_get_min_page_size(mr);
> =20
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D mr->iommu_ops->translate(mr, addr, flag);
>          if (iotlb.perm !=3D IOMMU_NONE) {
>              n->notify(n, &iotlb);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H14uD12u8nekTETJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9ZEGAAoJEGw4ysog2bOSI2EQAKACwwre9+TqIYpg/kbH2vDl
ZZ8rxY6DTwzS6padPfdMHcx4pdh4SWbCp11lGo0TsF1Ik0tNY2HoDNOtf24zW4bE
/jSFdjTZXhDBIHaM2ASqCHWfgUMFJyxXmR/GTI1NQHo6KwQDvW1/tDgqU9k1qR0+
wS1T2omR8ZemJhB5CMUQ8vsArHqLdLQt8qp24jVzSto5LN+yBxoDYpIe4JeYKsK5
EHNpo04R/NNyParg7dMdcxQVT7tr7Y/WOBEmKwiESMsLNH/w+tEwjuIjFMYbzJOm
sEJqpRnOtMoCEKO7r460Wly0FTjnbLj5P9S8gITTV9+s9UtqTC7QCAGQwNzhZtY5
+eOC4qF+kV9Ul0b6di2YiwpdSUdAyy4AfItlsG26+DbRtCfUye9x9BGZJbTFQLwL
JVFowEBTzk36obywVnF6QClC/+DfaWkhCh6hftmadJ3FwpJb3QUPn7Z8KV4Ydg2E
BGINtibrX2c9Pdny9Xgp8/3lQnV7s1iGAnohc47XisyBTnT6fDH/Pjb1zhHcb7g3
5sA3XraSKiB3rYOVcl5usAR4ksuphUsckR6f2p8NugNjpbGZda64FDAd81sgduay
4gCtTsONgn/dZTcp3DNKeFhqC+RGoP6dPDim52ZoclIEPJPdJ5lqkjYJYh9wxCOi
RYOtN519RmF7jailrWsw
=bK+e
-----END PGP SIGNATURE-----

--H14uD12u8nekTETJ--
