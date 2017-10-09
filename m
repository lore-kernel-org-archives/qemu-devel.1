Received: from eggs.gnu.org ([2001:4830:134:3::10]:45624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1a6t-0006oB-Q7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1a6n-0005WZ-Qr
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:36:51 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1a6n-0005WD-EH
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:36:45 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u138so24712992wmu.4
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 08:36:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-5-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 16:36:23 +0100
Message-ID: <CAFEAcA-UJY+H_5jsgL7WEKRv8imhooXK95ppNPvmCAb5VPWb_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 04/20] hw/arm/smmu-common: VMSAv8-64
 page table walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> This patch implements the page table walk for VMSAv8-64.
>
> The page table walk function is devised to walk the tables
> for a range of IOVAs and to call a callback for each valid
> leaf entry (frame or block).
>
> smmu_page_walk_level_64() handles the walk from a specific level.
> The advantage of using recursivity is one easily skips invalid
> entries at any stage. Only if the entry of level n is valid then
> we walk the level n+1, otherwise we jump to the next index of
> level n.
>
> Walk for an IOVA range will be used for SMMU memory region custom
> replay. Translation function uses the same function for a granule.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v6 -> v7:
> - fix wrong error handling in walk_page_table
> - check perm in smmu_translate
>
> v5 -> v6:
> - use IOMMUMemoryRegion
> - remove initial_lookup_level()
> - fix block replay
>
> v4 -> v5:
> - add initial level in translation config
> - implement block pte
> - rename must_translate into nofail
> - introduce call_entry_hook
> - small changes to dynamic traces
> - smmu_page_walk code moved from smmuv3.c to this file
> - remove smmu_translate*
>
> v3 -> v4:
> - reworked page table walk to prepare for VFIO integration
>   (capability to scan a range of IOVA). Same function is used
>   for translate for a single iova. This is largely inspired
>   from intel_iommu.c
> - as the translate function was not straightforward to me,
>   I tried to stick more closely to the VMSA spec.
> - remove support of nested stage (kernel driver does not
>   support it anyway)
> - use error_report and trace events
> - add aa64[] field in SMMUTransCfg
> ---
>  hw/arm/smmu-common.c         | 343 +++++++++++++++++++++++++++++++++++++=
++++++
>  hw/arm/smmu-internal.h       | 105 +++++++++++++
>  hw/arm/trace-events          |  12 ++
>  include/hw/arm/smmu-common.h |   4 +
>  4 files changed, 464 insertions(+)
>  create mode 100644 hw/arm/smmu-internal.h
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 2a94547..f476120 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -29,6 +29,349 @@
>
>  #include "qemu/error-report.h"
>  #include "hw/arm/smmu-common.h"
> +#include "smmu-internal.h"
> +
> +/*************************/
> +/* VMSAv8-64 Translation */
> +/*************************/
> +
> +/**
> + * get_pte - Get the content of a page table entry located in
> + * @base_addr[@index]
> + */
> +static uint64_t get_pte(dma_addr_t baseaddr, uint32_t index)
> +{
> +    uint64_t pte;
> +
> +    if (smmu_read_sysmem(baseaddr + index * sizeof(pte),
> +                         &pte, sizeof(pte), false)) {
> +        error_report("can't read pte at address=3D0x%"PRIx64,
> +                     baseaddr + index * sizeof(pte));

This is just a "guest has misprogrammed something" error presumably;
those are LOG_GUEST_ERROR. Or if it can happen in normal use then
don't log it at all.

> +        pte =3D (uint64_t)-1;

This doesn't look right. "Successfully read -1 from memory" and
"Failed to read memory" are different things, so you don't want to
mash them together into the same return code.

> +        return pte;
> +    }
> +    trace_smmu_get_pte(baseaddr, index, baseaddr + index * sizeof(pte), =
pte);
> +    /* TODO: handle endianness */
> +    return pte;
> +}
> +
> +/* VMSAv8-64 Translation Table Format Descriptor Decoding */
> +
> +#define PTE_ADDRESS(pte, shift) (extract64(pte, shift, 47 - shift) << sh=
ift)
> +
> +/**
> + * get_page_pte_address - returns the L3 descriptor output address,
> + * ie. the page frame
> + * ARM ARM spec: Figure D4-17 VMSAv8-64 level 3 descriptor format
> + */
> +static inline hwaddr get_page_pte_address(uint64_t pte, int granule_sz)
> +{
> +    return PTE_ADDRESS(pte, granule_sz);
> +}
> +
> +/**
> + * get_table_pte_address - return table descriptor output address,
> + * ie. address of next level table
> + * ARM ARM Figure D4-16 VMSAv8-64 level0, level1, and level 2 descriptor=
 formats
> + */
> +static inline hwaddr get_table_pte_address(uint64_t pte, int granule_sz)
> +{
> +    return PTE_ADDRESS(pte, granule_sz);
> +}
> +
> +/**
> + * get_block_pte_address - return block descriptor output address and bl=
ock size
> + * ARM ARM Figure D4-16 VMSAv8-64 level0, level1, and level 2 descriptor=
 formats
> + */
> +static hwaddr get_block_pte_address(uint64_t pte, int level, int granule=
_sz,
> +                                    uint64_t *bsz)
> +{
> +    int n;
> +
> +    switch (granule_sz) {
> +    case 12:
> +        if (level =3D=3D 1) {
> +            n =3D 30;
> +        } else if (level =3D=3D 2) {
> +            n =3D 21;
> +        } else {
> +            goto error_out;
> +        }
> +        break;
> +    case 14:
> +        if (level =3D=3D 2) {
> +            n =3D 25;
> +        } else {
> +            goto error_out;
> +        }
> +        break;
> +    case 16:
> +        if (level =3D=3D 2) {
> +            n =3D 29;
> +        } else {
> +            goto error_out;
> +        }
> +        break;
> +    default:
> +            goto error_out;
> +    }

This is essentially a check that the initial SMMUTransCfg didn't
specify an incompatible initial_level and granule, right? We should
check that earlier, rather than here, and if it's strictly a QEMU
code bug to get that wrong we should just assert. If a guest misconfig
can cause it then we shouldn't use error_report().

> +    *bsz =3D 1 << n;
> +    return PTE_ADDRESS(pte, n);
> +
> +error_out:
> +
> +    error_report("unexpected granule_sz=3D%d/level=3D%d for block pte",
> +                 granule_sz, level);
> +    *bsz =3D 0;
> +    return (hwaddr)-1;
> +}
> +
> +static int call_entry_hook(uint64_t iova, uint64_t mask, uint64_t gpa,
> +                           int perm, smmu_page_walk_hook hook_fn, void *=
private)
> +{
> +    IOMMUTLBEntry entry;
> +    int ret;
> +
> +    entry.target_as =3D &address_space_memory;
> +    entry.iova =3D iova & mask;
> +    entry.translated_addr =3D gpa;
> +    entry.addr_mask =3D ~mask;
> +    entry.perm =3D perm;
> +
> +    ret =3D hook_fn(&entry, private);
> +    if (ret) {
> +        error_report("%s hook returned %d", __func__, ret);
> +    }
> +    return ret;
> +}
> +
> +/**
> + * smmu_page_walk_level_64 - Walk an IOVA range from a specific level
> + * @baseaddr: table base address corresponding to @level
> + * @level: level
> + * @cfg: translation config
> + * @start: end of the IOVA range
> + * @end: end of the IOVA range
> + * @hook_fn: the hook that to be called for each detected area
> + * @private: private data for the hook function
> + * @flags: access flags of the parent
> + * @nofail: indicates whether each iova of the range
> + *  must be translated or whether failure is allowed
> + *
> + * Return 0 on success, < 0 on errors not related to translation
> + * process, > 1 on errors related to translation process (only
> + * if nofail is set)
> + */
> +static int
> +smmu_page_walk_level_64(dma_addr_t baseaddr, int level,
> +                        SMMUTransCfg *cfg, uint64_t start, uint64_t end,
> +                        smmu_page_walk_hook hook_fn, void *private,
> +                        IOMMUAccessFlags flags, bool nofail)
> +{
> +    uint64_t subpage_size, subpage_mask, pte, iova =3D start;
> +    int ret, granule_sz, stage, perm;
> +
> +    granule_sz =3D cfg->granule_sz;
> +    stage =3D cfg->stage;
> +    subpage_size =3D 1ULL << level_shift(level, granule_sz);
> +    subpage_mask =3D level_page_mask(level, granule_sz);
> +
> +    trace_smmu_page_walk_level_in(level, baseaddr, granule_sz,
> +                                  start, end, flags, subpage_size);
> +
> +    while (iova < end) {
> +        dma_addr_t next_table_baseaddr;
> +        uint64_t iova_next, pte_addr;
> +        uint32_t offset;
> +
> +        iova_next =3D (iova & subpage_mask) + subpage_size;
> +        offset =3D iova_level_offset(iova, level, granule_sz);
> +        pte_addr =3D baseaddr + offset * sizeof(pte);
> +        pte =3D get_pte(baseaddr, offset);
> +
> +        trace_smmu_page_walk_level(level, iova, subpage_size,
> +                                   baseaddr, offset, pte);
> +
> +        if (pte =3D=3D (uint64_t)-1) {
> +            if (nofail) {
> +                return SMMU_TRANS_ERR_WALK_EXT_ABRT;
> +            }
> +            goto next;
> +        }
> +        if (is_invalid_pte(pte) || is_reserved_pte(pte, level)) {
> +            trace_smmu_page_walk_level_res_invalid_pte(stage, level, bas=
eaddr,
> +                                                       pte_addr, offset,=
 pte);
> +            if (nofail) {
> +                return SMMU_TRANS_ERR_TRANS;
> +            }
> +            goto next;
> +        }
> +
> +        if (is_page_pte(pte, level)) {
> +            uint64_t gpa =3D get_page_pte_address(pte, granule_sz);
> +
> +            perm =3D flags & pte_ap_to_perm(pte, true);
> +
> +            trace_smmu_page_walk_level_page_pte(stage, level, iova,
> +                                                baseaddr, pte_addr, pte,=
 gpa);
> +            ret =3D call_entry_hook(iova, subpage_mask, gpa, perm,
> +                                  hook_fn, private);
> +            if (ret) {
> +                return ret;
> +            }
> +            goto next;
> +        }
> +        if (is_block_pte(pte, level)) {

A block descriptor and a page descriptor are basically the same format,
and you can see in the CPU TLB walk code that we thus treat them basically
the same way. It's a bit odd that the code here handles them totally
separately and in apparently significantly different ways.

> +            size_t target_page_size =3D qemu_target_page_size();;

Stray extra semicolon. Also, this isn't really the current CPU target
page size (which in any case the SMMU has no way of knowning) so I'm
suspicious that it's not what you really want. (What do you want?)

> +            uint64_t block_size, top_iova;
> +            hwaddr gpa, block_gpa;
> +
> +            block_gpa =3D get_block_pte_address(pte, level, granule_sz,
> +                                              &block_size);
> +            perm =3D flags & pte_ap_to_perm(pte, true);
> +
> +            if (block_gpa =3D=3D -1) {
> +                if (nofail) {
> +                    return SMMU_TRANS_ERR_WALK_EXT_ABRT;
> +                } else {
> +                    goto next;
> +                }
> +            }
> +            trace_smmu_page_walk_level_block_pte(stage, level, baseaddr,
> +                                                 pte_addr, pte, iova, bl=
ock_gpa,
> +                                                 (int)(block_size >> 20)=
);
> +
> +            gpa =3D block_gpa + (iova & (block_size - 1));
> +            if ((block_gpa =3D=3D gpa) && (end >=3D iova_next - 1)) {
> +                ret =3D call_entry_hook(iova, ~(block_size - 1), block_g=
pa,
> +                                      perm, hook_fn, private);
> +                if (ret) {
> +                    return ret;
> +                }
> +                goto next;
> +            } else {
> +                top_iova =3D MIN(end, iova_next);
> +                while (iova < top_iova) {
> +                    gpa =3D block_gpa + (iova & (block_size - 1));
> +                    ret =3D call_entry_hook(iova, ~(target_page_size - 1=
),
> +                                          gpa, perm, hook_fn, private);
> +                    if (ret) {
> +                        return ret;
> +                    }
> +                    iova +=3D target_page_size;
> +                }

No "goto next" ? All the other parts of this loop seem to do that
(though it also suggests that you want if ... else if ... else if ... else)=
.

> +            }
> +        }
> +        if (level  =3D=3D 3) {
> +            goto next;

Yuck!

> +        }
> +        /* table pte */
> +        next_table_baseaddr =3D get_table_pte_address(pte, granule_sz);
> +        trace_smmu_page_walk_level_table_pte(stage, level, baseaddr, pte=
_addr,
> +                                             pte, next_table_baseaddr);
> +        perm =3D flags & pte_ap_to_perm(pte, false);

This is converting the architectural TLB entry attribute flags into
the QEMU architecture independent IOMMUAccessFlags and then passing
the latter onto the next stage of the TLB walk. I think it would be
better to stick to using the architectural attribute flags, as the
CPU TLB walk code does.

> +        ret =3D smmu_page_walk_level_64(next_table_baseaddr, level + 1, =
cfg,
> +                                      iova, MIN(iova_next, end),
> +                                      hook_fn, private, perm, nofail);
> +        if (ret) {
> +            return ret;
> +        }
> +
> +next:
> +        iova =3D iova_next;
> +    }

The usual way to write "while (cond) { ... goto next; ...   next: something=
; }"
is "for (; cond; something) { ... ;continue; ...}".

> +
> +    return SMMU_TRANS_ERR_NONE;
> +}
> +
> +/**
> + * smmu_page_walk - walk a specific IOVA range from the initial
> + * lookup level, and call the hook for each valid entry
> + *
> + * @cfg: translation config
> + * @start: start of the IOVA range
> + * @end: end of the IOVA range
> + * @nofail: if true, each IOVA within the range must have a translation
> + * @hook_fn: the hook that to be called for each detected area
> + * @private: private data for the hook function
> + */
> +int smmu_page_walk(SMMUTransCfg *cfg, uint64_t start, uint64_t end,
> +                   bool nofail, smmu_page_walk_hook hook_fn, void *priva=
te)
> +{
> +    uint64_t roof =3D MIN(end, (1ULL << (64 - cfg->tsz)) - 1);
> +    IOMMUAccessFlags perm =3D IOMMU_ACCESS_FLAG(true, true);
> +    int stage =3D cfg->stage;
> +    dma_addr_t ttbr;
> +
> +    if (!hook_fn) {
> +        return 0;
> +    }
> +
> +    if (!cfg->aa64) {
> +        error_report("VMSAv8-32 page walk is not yet implemented");
> +        abort();
> +    }
> +
> +    ttbr =3D extract64(cfg->ttbr, 0, 48);
> +    trace_smmu_page_walk(stage, cfg->ttbr, cfg->initial_level, start, ro=
of);
> +
> +    return smmu_page_walk_level_64(ttbr, cfg->initial_level, cfg, start,=
 roof,
> +                                   hook_fn, private, perm, nofail);
> +}
> +
> +/**
> + * set_translated_address: page table walk callback for smmu_translate
> + *
> + * once a leaf entry is found, applies the offset to the translated addr=
ess
> + * and check the permission
> + *
> + * @entry: entry filled by the page table walk function, ie. contains th=
e
> + * leaf entry iova/translated addr and permission flags
> + * @private: pointer to the original entry that must be translated
> + */
> +static int set_translated_address(IOMMUTLBEntry *entry, void *private)
> +{
> +    IOMMUTLBEntry *tlbe_in =3D (IOMMUTLBEntry *)private;
> +    size_t offset =3D tlbe_in->iova - entry->iova;
> +
> +    if (((tlbe_in->perm & IOMMU_RO) && !(entry->perm & IOMMU_RO)) ||
> +        ((tlbe_in->perm & IOMMU_WO) && !(entry->perm & IOMMU_WO))) {
> +        return SMMU_TRANS_ERR_PERM;
> +    }
> +    tlbe_in->translated_addr =3D entry->translated_addr + offset;
> +    trace_smmu_set_translated_address(tlbe_in->iova, tlbe_in->translated=
_addr);
> +    return 0;

return SMMU_TRANS_ERR_NONE; ?

> +}
> +
> +/**
> + * smmu_translate - Attempt to translate a given entry according to @cfg
> + *
> + * @cfg: translation configuration
> + * @tlbe: entry pre-filled with the input iova, mask
> + *
> + * return: !=3D0 if no mapping is found for the tlbe->iova or access per=
mission
> + * does not match
> + */
> +int smmu_translate(SMMUTransCfg *cfg, IOMMUTLBEntry *tlbe)
> +{
> +    int ret =3D 0;
> +
> +    if (cfg->bypassed || cfg->disabled) {
> +        return 0;
> +    }
> +
> +    ret =3D smmu_page_walk(cfg, tlbe->iova, tlbe->iova + 1, true /* nofa=
il */,
> +                         set_translated_address, tlbe);
> +
> +    if (ret) {
> +        error_report("translation failed for iova=3D0x%"PRIx64" perm=3D%=
d (%d)",
> +                     tlbe->iova, tlbe->perm, ret);
> +        goto exit;
> +    }
> +
> +exit:

Not much point in goto to next statement.

> +    return ret;
> +}
>
>  inline MemTxResult smmu_read_sysmem(dma_addr_t addr, void *buf, dma_addr=
_t len,
>                                      bool secure)
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> new file mode 100644
> index 0000000..aeeadd4
> --- /dev/null
> +++ b/hw/arm/smmu-internal.h
> @@ -0,0 +1,105 @@
> +/*
> + * ARM SMMU support - Internal API
> + *
> + * Copyright (c) 2017 Red Hat, Inc.
> + * Written by Eric Auger
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_ARM_SMMU_INTERNAL_H
> +#define HW_ARM_SMMU_INTERNAL_H
> +
> +#define ARM_LPAE_MAX_ADDR_BITS          48

Another 48... which address size limit is this intended to represent?

> +#define ARM_LPAE_MAX_LEVELS             4
> +
> +/* PTE Manipulation */
> +
> +#define ARM_LPAE_PTE_TYPE_SHIFT         0
> +#define ARM_LPAE_PTE_TYPE_MASK          0x3
> +
> +#define ARM_LPAE_PTE_TYPE_BLOCK         1
> +#define ARM_LPAE_PTE_TYPE_RESERVED      1
> +#define ARM_LPAE_PTE_TYPE_TABLE         3
> +#define ARM_LPAE_PTE_TYPE_PAGE          3

This looks weird, because several of these are the same as each other.
That's because they're really distinct sets of values, some for
L0/1/2 descriptors, and some for L3 descriptors. If you want
to define constant names for this can you make the prefixes different
for the different cases, please?

> +
> +#define ARM_LPAE_PTE_VALID              (1 << 0)
> +
> +static inline bool is_invalid_pte(uint64_t pte)
> +{
> +    return !(pte & ARM_LPAE_PTE_VALID);
> +}
> +
> +static inline bool is_reserved_pte(uint64_t pte, int level)
> +{
> +    return ((level =3D=3D 3) &&
> +            ((pte & ARM_LPAE_PTE_TYPE_MASK) =3D=3D ARM_LPAE_PTE_TYPE_RES=
ERVED));

return isn't a function so you don't need the outer brackets here.

> +}
> +
> +static inline bool is_block_pte(uint64_t pte, int level)
> +{
> +    return ((level < 3) &&
> +            ((pte & ARM_LPAE_PTE_TYPE_MASK) =3D=3D ARM_LPAE_PTE_TYPE_BLO=
CK));
> +}
> +
> +static inline bool is_table_pte(uint64_t pte, int level)
> +{
> +    return ((level < 3) &&
> +            ((pte & ARM_LPAE_PTE_TYPE_MASK) =3D=3D ARM_LPAE_PTE_TYPE_TAB=
LE));
> +}
> +
> +static inline bool is_page_pte(uint64_t pte, int level)
> +{
> +    return ((level =3D=3D 3) &&
> +            ((pte & ARM_LPAE_PTE_TYPE_MASK) =3D=3D ARM_LPAE_PTE_TYPE_PAG=
E));
> +}
> +
> +static IOMMUAccessFlags pte_ap_to_perm(uint64_t pte, bool is_leaf)
> +{
> +    int ap;
> +    IOMMUAccessFlags flags;
> +
> +    if (is_leaf) {
> +        ap =3D extract64(pte, 6, 2);
> +    } else {
> +        ap =3D extract64(pte, 61, 2);
> +    }
> +    flags =3D IOMMU_ACCESS_FLAG(true, !(ap & 0x2));
> +    return flags;
> +}
> +
> +/* Level Indexing */
> +
> +static inline int level_shift(int level, int granule_sz)
> +{
> +    return granule_sz + (3 - level) * (granule_sz - 3);
> +}
> +
> +static inline uint64_t level_page_mask(int level, int granule_sz)
> +{
> +    return ~((1ULL << level_shift(level, granule_sz)) - 1);
> +}
> +
> +/**
> + * TODO: handle the case where the level resolves less than
> + * granule_sz -3 IA bits.
> + */
> +static inline
> +uint64_t iova_level_offset(uint64_t iova, int level, int granule_sz)
> +{
> +    return (iova >> level_shift(level, granule_sz)) &
> +            ((1ULL << (granule_sz - 3)) - 1);
> +}
> +
> +#endif
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 193063e..c67cd39 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -2,3 +2,15 @@
>
>  # hw/arm/virt-acpi-build.c
>  virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
> +
> +# hw/arm/smmu-common.c
> +
> +smmu_page_walk(int stage, uint64_t baseaddr, int first_level, uint64_t s=
tart, uint64_t end) "stage=3D%d, baseaddr=3D0x%"PRIx64", first level=3D%d, =
start=3D0x%"PRIx64", end=3D0x%"PRIx64
> +smmu_page_walk_level_in(int level, uint64_t baseaddr, int granule_sz, ui=
nt64_t start, uint64_t end, int flags, uint64_t subpage_size) "level=3D%d b=
aseaddr=3D0x%"PRIx64" granule=3D%d, start=3D0x%"PRIx64" end=3D0x%"PRIx64" f=
lags=3D%d subpage_size=3D0x%lx"
> +smmu_page_walk_level(int level, uint64_t iova, size_t subpage_size, uint=
64_t baseaddr, uint32_t offset, uint64_t pte) "level=3D%d iova=3D0x%lx subp=
age_sz=3D0x%lx baseaddr=3D0x%"PRIx64" offset=3D%d =3D> pte=3D0x%lx"
> +smmu_page_walk_level_res_invalid_pte(int stage, int level, uint64_t base=
addr, uint64_t pteaddr, uint32_t offset, uint64_t pte) "stage=3D%d level=3D=
%d base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" offset=3D%d pte=3D0x%lx"
> +smmu_page_walk_level_page_pte(int stage, int level,  uint64_t iova, uint=
64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=3D%=
d level=3D%d iova=3D0x%"PRIx64" base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=
=3D0x%"PRIx64" page address =3D 0x%"PRIx64
> +smmu_page_walk_level_block_pte(int stage, int level, uint64_t baseaddr, =
uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) =
"stage=3D%d level=3D%d base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=3D0x%"PRI=
x64" iova=3D0x%"PRIx64" block address =3D 0x%"PRIx64" block size =3D %d MiB=
"
> +smmu_page_walk_level_table_pte(int stage, int level, uint64_t baseaddr, =
uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=3D%d, level=3D%d b=
ase@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=3D0x%"PRIx64" next table address =
=3D 0x%"PRIx64
> +smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pt=
e) "baseaddr=3D0x%"PRIx64" index=3D0x%x, pteaddr=3D0x%"PRIx64", pte=3D0x%"P=
RIx64
> +smmu_set_translated_address(hwaddr iova, hwaddr pa) "iova =3D 0x%"PRIx64=
" -> pa =3D 0x%"PRIx64
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index a5999b0..112a11c 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -116,4 +116,8 @@ MemTxResult smmu_read_sysmem(dma_addr_t addr, void *b=
uf,
>                               dma_addr_t len, bool secure);
>  void smmu_write_sysmem(dma_addr_t addr, void *buf, dma_addr_t len, bool =
secure);
>
> +int smmu_translate(SMMUTransCfg *cfg, IOMMUTLBEntry *tlbe);
> +int smmu_page_walk(SMMUTransCfg *cfg, uint64_t start, uint64_t end,
> +                   bool nofail, smmu_page_walk_hook hook_fn, void *priva=
te);
> +
>  #endif  /* HW_ARM_SMMU_COMMON */
> --

thanks
-- PMM
