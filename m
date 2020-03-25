Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A043CC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3302074D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg742e/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3302074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7P1-0005Um-GL
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jH7OI-0004hb-Jy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jH7OF-0006mp-5C
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:52:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jH7OE-0006mh-VU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585147938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gvLrjZYSLAX/QkL3Q82BkUPMxQQQCwHCjOqpqDV8gA=;
 b=Zg742e/hNq3gOrLWlhzx4U1c9pUitvaC4PgtRHiSifXInQa5NyKaiyLgNZadsates6sR13
 aEzV56+7g71VPh2of9RC5Er9gIxibY/LLib9PemayD2cmu9aqHSL9jhfMNj3LEzBJauO9/
 WTXaMjL1alvFO2kTPSznvSDPVv0h+LI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-tq9cbEa0Ml2wn0-trmSnZg-1; Wed, 25 Mar 2020 10:52:16 -0400
X-MC-Unique: tq9cbEa0Ml2wn0-trmSnZg-1
Received: by mail-wr1-f69.google.com with SMTP id e10so1263095wru.6
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V/6JN+E+IbOfuVX2jhaM+fyZp5LECqC5sognwg+QtgA=;
 b=PoyfxD2Ly2ryRH+nX3rO1GkgLT82mVY+dE6r1Qop3s/B1ZO3gOUmCBPlfjxSzJ/m0G
 nwsFsnE9SM6uzwPgLzxlqoEQOoaho1girkQ+rIxAzdW7FNizMSAnBvPtdhzcxH1WCr8c
 RY1RlUCFewrViAdS8n3hlorI1RBKdY329LIZNtgC4Yrdk197Ts7KRgZ0l4gysjcaf8ZI
 yvE+lRmM681JFQIYNERZsaLlqRVHex9tgijw3J6nZCUTlvTOTq56YMy3K5ehyff6kR6W
 Rt9XxvEDzcU3TTWDG8qDSBMXKodC3/bIyTZaD9rXYf0Ilx/qP+6IrINDl+oiA/ZWu9Sp
 qUMA==
X-Gm-Message-State: ANhLgQ1BhEo97YkbbMgAoJ14V1TznxnLlkOdMYTVYiT665VAq4gdueCN
 24TL6+RXck2RmrVxQ8SVif/7LS7zu2voFRGyea4PdXbjUv3v6v55iebRizVqNGQeT8VolgjH2pB
 wE+CrJ63qApXoOB0=
X-Received: by 2002:adf:e98b:: with SMTP id h11mr3864011wrm.409.1585147934860; 
 Wed, 25 Mar 2020 07:52:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuooWz1hKn6LDBt+k+L9tA2FDTmUQUF00GCFYAxGtYskP4p8A3HZrXby5c7vdl+YFVOX9W+BA==
X-Received: by 2002:adf:e98b:: with SMTP id h11mr3863969wrm.409.1585147934457; 
 Wed, 25 Mar 2020 07:52:14 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v8sm1831174wrp.84.2020.03.25.07.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:52:13 -0700 (PDT)
Date: Wed, 25 Mar 2020 10:52:09 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 12/22] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20200325145209.GA354390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-13-git-send-email-yi.l.liu@intel.com>
 <20200324173209.GW127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A20213D@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A20213D@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 12:20:21PM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, March 25, 2020 1:32 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v1 12/22] intel_iommu: add PASID cache management
> > infrastructure
> >=20
> > On Sun, Mar 22, 2020 at 05:36:09AM -0700, Liu Yi L wrote:
> > > This patch adds a PASID cache management infrastructure based on new
> > > added structure VTDPASIDAddressSpace, which is used to track the PASI=
D
> > > usage and future PASID tagged DMA address translation support in
> > > vIOMMU.
> > >
> > >     struct VTDPASIDAddressSpace {
> > >         VTDBus *vtd_bus;
> > >         uint8_t devfn;
> > >         AddressSpace as;
> > >         uint32_t pasid;
> > >         IntelIOMMUState *iommu_state;
> > >         VTDContextCacheEntry context_cache_entry;
> > >         QLIST_ENTRY(VTDPASIDAddressSpace) next;
> > >         VTDPASIDCacheEntry pasid_cache_entry;
> > >     };
> > >
> > > Ideally, a VTDPASIDAddressSpace instance is created when a PASID is
> > > bound with a DMA AddressSpace. Intel VT-d spec requires guest softwar=
e
> > > to issue pasid cache invalidation when bind or unbind a pasid with an
> > > address space under caching-mode. However, as VTDPASIDAddressSpace
> > > instances also act as pasid cache in this implementation, its creatio=
n
> > > also happens during vIOMMU PASID tagged DMA translation. The creation
> > > in this path will not be added in this patch since no PASID-capable
> > > emulated devices for now.
> > >
> > > The implementation in this patch manages VTDPASIDAddressSpace
> > > instances per PASID+BDF (lookup and insert will use PASID and
> > > BDF) since Intel VT-d spec allows per-BDF PASID Table. When a guest
> > > bind a PASID with an AddressSpace, QEMU will capture the guest pasid
> > > selective pasid cache invalidation, and allocate remove a
> > > VTDPASIDAddressSpace instance per the invalidation
> > > reasons:
> > >
> > >     *) a present pasid entry moved to non-present
> > >     *) a present pasid entry to be a present entry
> > >     *) a non-present pasid entry moved to present
> > >
> > > vIOMMU emulator could figure out the reason by fetching latest guest
> > > pasid entry.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 394
> > +++++++++++++++++++++++++++++++++++++++++
> > >  hw/i386/intel_iommu_internal.h |  14 ++
> > >  hw/i386/trace-events           |   1 +
> > >  include/hw/i386/intel_iommu.h  |  33 +++-
> > >  4 files changed, 441 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > 1daeab2..c985cae 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -40,6 +40,7 @@
> > >  #include "kvm_i386.h"
> > >  #include "migration/vmstate.h"
> > >  #include "trace.h"
> > > +#include "qemu/jhash.h"
> > >
> > >  /* context entry operations */
> > >  #define VTD_CE_GET_RID2PASID(ce) \
> > > @@ -65,6 +66,8 @@
> > >  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
> > > static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifie=
r
> > > *n);
> > >
> > > +static void vtd_pasid_cache_reset(IntelIOMMUState *s);
> > > +
> > >  static void vtd_panic_require_caching_mode(void)
> > >  {
> > >      error_report("We need to set caching-mode=3Don for intel-iommu t=
o enable "
> > > @@ -276,6 +279,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
> > >      vtd_iommu_lock(s);
> > >      vtd_reset_iotlb_locked(s);
> > >      vtd_reset_context_cache_locked(s);
> > > +    vtd_pasid_cache_reset(s);
> > >      vtd_iommu_unlock(s);
> > >  }
> > >
> > > @@ -686,6 +690,11 @@ static inline bool vtd_pe_type_check(X86IOMMUSta=
te
> > *x86_iommu,
> > >      return true;
> > >  }
> > >
> > > +static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe) {
> > > +    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> > > +}
> > > +
> > >  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)  {
> > >      return pdire->val & 1;
> > > @@ -2395,19 +2404,402 @@ static bool
> > vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
> > >      return true;
> > >  }
> > >
> > > +static inline void vtd_init_pasid_key(uint32_t pasid,
> > > +                                     uint16_t sid,
> > > +                                     struct pasid_key *key) {
> > > +    key->pasid =3D pasid;
> > > +    key->sid =3D sid;
> > > +}
> > > +
> > > +static guint vtd_pasid_as_key_hash(gconstpointer v) {
> > > +    struct pasid_key *key =3D (struct pasid_key *)v;
> > > +    uint32_t a, b, c;
> > > +
> > > +    /* Jenkins hash */
> > > +    a =3D b =3D c =3D JHASH_INITVAL + sizeof(*key);
> > > +    a +=3D key->sid;
> > > +    b +=3D extract32(key->pasid, 0, 16);
> > > +    c +=3D extract32(key->pasid, 16, 16);
> > > +
> > > +    __jhash_mix(a, b, c);
> > > +    __jhash_final(a, b, c);
> > > +
> > > +    return c;
> > > +}
> > > +
> > > +static gboolean vtd_pasid_as_key_equal(gconstpointer v1,
> > > +gconstpointer v2) {
> > > +    const struct pasid_key *k1 =3D v1;
> > > +    const struct pasid_key *k2 =3D v2;
> > > +
> > > +    return (k1->pasid =3D=3D k2->pasid) && (k1->sid =3D=3D k2->sid);=
 }
> > > +
> > > +static inline int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s,
> > > +                                            uint8_t bus_num,
> > > +                                            uint8_t devfn,
> > > +                                            uint32_t pasid,
> > > +                                            VTDPASIDEntry *pe) {
> > > +    VTDContextEntry ce;
> > > +    int ret;
> > > +    dma_addr_t pasid_dir_base;
> > > +
> > > +    if (!s->root_scalable) {
> > > +        return -VTD_FR_PASID_TABLE_INV;
> > > +    }
> > > +
> > > +    ret =3D vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(&ce);
> > > +    ret =3D vtd_get_pe_from_pasid_table(s,
> > > +                                  pasid_dir_base, pasid, pe);
> >=20
> > The indents across the series are still strange...  Take this one as ex=
ample, nornally
> > I'll indent at the left bracket if I want to use another newline:
> >=20
> >        ret =3D vtd_get_pe_from_pasid_table(s, pasid_dir_base,
> >                                          pasid, pe);
> >=20
> > And here actually you don't need a new line at all because it's only
> > 70 chars...
> >=20
> > I don't think it's a must (I am always not sure whether we should be th=
at strict on all
> > these), but it should be preferred if you change all the similar places=
 with the same
> > indentation as the existing code.
>=20
> Sure, I'll have a double check on it.
>=20
> > > +
> > > +    return ret;
> > > +}
> > > +
> > > +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry
> > > +*p2) {
> > > +    return !memcmp(p1, p2, sizeof(*p1)); }
> > > +
> > > +/**
> > > + * This function cached the pasid entry in &vtd_pasid_as. Also
> > > + * notifies host about the new pasid binding. Caller of this
> > > + * function should hold iommu_lock.
> > > + */
> > > +static inline void vtd_fill_in_pe_in_cache(IntelIOMMUState *s,
> > > +                                           VTDPASIDAddressSpace *vtd=
_pasid_as,
> > > +                                           VTDPASIDEntry *pe) {
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_entr=
y;
> > > +
> > > +    pc_entry->pasid_entry =3D *pe;
> > > +    pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;
> > > +    /*
> > > +     * TODO:
> > > +     * - send pasid bind to host for passthru devices
> > > +     */
> > > +}
> > > +
> > > +/**
> > > + * This function updates the pasid entry cached in &vtd_pasid_as.
> > > + * Caller of this function should hold iommu_lock.
> > > + */
> > > +static void vtd_update_pe_in_cache(IntelIOMMUState *s,
> > > +                                   VTDPASIDAddressSpace *vtd_pasid_a=
s,
> > > +                                   VTDPASIDEntry *pe) {
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_entr=
y;
> > > +
> > > +    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
> > > +        /* No need to go further as cached pasid entry is latest */
> > > +        return;
> > > +    }
> > > +
> > > +    vtd_fill_in_pe_in_cache(s, vtd_pasid_as, pe); }
> > > +
> > > +/**
> > > + * This function is used to clear pasid_cache_gen of cached pasid
> > > + * entry in vtd_pasid_as instances. Caller of this function should
> > > + * hold iommu_lock.
> > > + */
> > > +static gboolean vtd_flush_pasid(gpointer key, gpointer value,
> > > +                                gpointer user_data) {
> > > +    VTDPASIDCacheInfo *pc_info =3D user_data;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as =3D value;
> > > +    IntelIOMMUState *s =3D vtd_pasid_as->iommu_state;
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_entr=
y;
> > > +    VTDBus *vtd_bus =3D vtd_pasid_as->vtd_bus;
> > > +    VTDPASIDEntry pe;
> > > +    uint16_t did;
> > > +    uint32_t pasid;
> > > +    uint16_t devfn;
> > > +    int ret;
> > > +
> > > +    did =3D vtd_pe_get_domain_id(&pc_entry->pasid_entry);
> > > +    pasid =3D vtd_pasid_as->pasid;
> > > +    devfn =3D vtd_pasid_as->devfn;
> > > +
> > > +    if (!(pc_entry->pasid_cache_gen =3D=3D s->pasid_cache_gen)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    switch (pc_info->flags & VTD_PASID_CACHE_INFO_MASK) {
> > > +    case VTD_PASID_CACHE_PASIDSI:
> > > +        if (pc_info->pasid !=3D pasid) {
> > > +            return false;
> > > +        }
> > > +        /* Fall through */
> > > +    case VTD_PASID_CACHE_DOMSI:
> > > +        if (pc_info->domain_id !=3D did) {
> > > +            return false;
> > > +        }
> > > +        /* Fall through */
> > > +    case VTD_PASID_CACHE_GLOBAL:
> > > +        break;
> > > +    default:
> > > +        error_report("invalid pc_info->flags");
> > > +        abort();
> > > +    }
> > > +
> > > +    /*
> > > +     * pasid cache invalidation may indicate a present pasid
> > > +     * entry to present pasid entry modification. To cover such
> > > +     * case, vIOMMU emulator needs to fetch latest guest pasid
> > > +     * entry and check cached pasid entry, then update pasid
> > > +     * cache and send pasid bind/unbind to host properly.
> > > +     */
> > > +    ret =3D vtd_dev_get_pe_from_pasid(s,
> > > +                  pci_bus_num(vtd_bus->bus), devfn, pasid, &pe);
> > > +    if (ret) {
> > > +        /*
> > > +         * No valid pasid entry in guest memory. e.g. pasid entry
> > > +         * was modified to be either all-zero or non-present. Either
> > > +         * case means existing pasid cache should be removed.
> > > +         */
> > > +        goto remove;
> > > +    }
> > > +
> > > +    vtd_update_pe_in_cache(s, vtd_pasid_as, &pe);
> > > +    /*
> > > +     * TODO:
> > > +     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
> > > +     *   should invalidate QEMU piotlb togehter with this change.
> > > +     */
> > > +    return false;
> > > +remove:
> > > +    /*
> > > +     * TODO:
> > > +     * - send pasid bind to host for passthru devices
> > > +     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
> > > +     *   should invalidate QEMU piotlb togehter with this change.
> > > +     */
> > > +    return true;
> > > +}
> > > +
> > > +/**
> > > + * This function finds or adds a VTDPASIDAddressSpace for a device
> > > + * when it is bound to a pasid. Caller of this function should hold
> > > + * iommu_lock.
> > > + */
> > > +static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *=
s,
> > > +                                                   VTDBus *vtd_bus,
> > > +                                                   int devfn,
> > > +                                                   uint32_t pasid) {
> > > +    struct pasid_key key;
> > > +    struct pasid_key *new_key;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as;
> > > +    uint16_t sid;
> > > +
> > > +    sid =3D vtd_make_source_id(pci_bus_num(vtd_bus->bus), devfn);
> > > +    vtd_init_pasid_key(pasid, sid, &key);
> > > +    vtd_pasid_as =3D g_hash_table_lookup(s->vtd_pasid_as, &key);
> > > +
> > > +    if (!vtd_pasid_as) {
> > > +        new_key =3D g_malloc0(sizeof(*new_key));
> > > +        vtd_init_pasid_key(pasid, sid, new_key);
> > > +        /*
> > > +         * Initiate the vtd_pasid_as structure.
> > > +         *
> > > +         * This structure here is used to track the guest pasid
> > > +         * binding and also serves as pasid-cache mangement entry.
> > > +         *
> > > +         * TODO: in future, if wants to support the SVA-aware DMA
> > > +         *       emulation, the vtd_pasid_as should have include
> > > +         *       AddressSpace to support DMA emulation.
> > > +         */
> > > +        vtd_pasid_as =3D g_malloc0(sizeof(VTDPASIDAddressSpace));
> > > +        vtd_pasid_as->iommu_state =3D s;
> > > +        vtd_pasid_as->vtd_bus =3D vtd_bus;
> > > +        vtd_pasid_as->devfn =3D devfn;
> > > +        vtd_pasid_as->context_cache_entry.context_cache_gen =3D 0;
> > > +        vtd_pasid_as->pasid =3D pasid;
> > > +        vtd_pasid_as->pasid_cache_entry.pasid_cache_gen =3D 0;
> > > +        g_hash_table_insert(s->vtd_pasid_as, new_key, vtd_pasid_as);
> > > +    }
> > > +    return vtd_pasid_as;
> > > +}
> > > +
> > >  static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t
> > > domain_id)  {
> > > +    VTDPASIDCacheInfo pc_info;
> > > +
> > > +    trace_vtd_pasid_cache_dsi(domain_id);
> > > +
> > > +    pc_info.flags =3D VTD_PASID_CACHE_DOMSI;
> > > +    pc_info.domain_id =3D domain_id;
> > > +
> > > +    /*
> > > +     * Loop all existing pasid caches and update them.
> > > +     */
> > > +    vtd_iommu_lock(s);
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                                 vtd_flush_pasid, &pc_info);
> > > +    vtd_iommu_unlock(s);
> > > +
> > > +    /*
> > > +     * TODO:
> > > +     * Domain selective PASID cache invalidation flushes
> > > +     * all the pasid caches within a domain. To be safe,
> > > +     * after invalidating the pasid caches, emulator needs
> > > +     * to replay the pasid bindings by walking guest pasid
> > > +     * dir and pasid table. e.g. When the guest setup a new
> > > +     * PASID entry then send a PASID DSI.
> > > +     */
> > >      return 0;
> > >  }
> > >
> > >  static int vtd_pasid_cache_psi(IntelIOMMUState *s,
> > >                                 uint16_t domain_id, uint32_t pasid)  =
{
> > > +    VTDPASIDCacheInfo pc_info;
> > > +    VTDHostIOMMUContext *vtd_dev_icx;
> > > +
> > > +    /* PASID selective implies a DID selective */
> > > +    pc_info.flags =3D VTD_PASID_CACHE_PASIDSI;
> > > +    pc_info.domain_id =3D domain_id;
> > > +    pc_info.pasid =3D pasid;
> > > +
> > > +    /*
> > > +     * Regards to a pasid selective pasid cache invalidation (PSI),
> > > +     * it could be either cases of below:
> > > +     * a) a present pasid entry moved to non-present
> > > +     * b) a present pasid entry to be a present entry
> > > +     * c) a non-present pasid entry moved to present
> > > +     *
> > > +     * Here the handling of a PSI follows below steps:
> > > +     * 1) loop all the exisitng vtd_pasid_as instances to update the=
m
> > > +     *    according to the latest guest pasid entry in pasid table.
> > > +     *    this will make sure affected existing vtd_pasid_as instanc=
es
> > > +     *    cached the latest pasid entries. Also, during the loop, th=
e
> > > +     *    host should be notified if needed. e.g. pasid unbind or pa=
sid
> > > +     *    update. Should be able to cover case a) and case b).
> > > +     *
> > > +     * 2) loop all devices to cover case c)
> > > +     *    - For devices which have HostIOMMUContext instances,
> > > +     *      we loop them and check if guest pasid entry exists. If y=
es,
> > > +     *      it is case c), we update the pasid cache and also notify
> > > +     *      host.
> > > +     *    - For devices which have no HostIOMMUContext, it is not
> > > +     *      necessary to create pasid cache at this phase since it
> > > +     *      could be created when vIOMMU does DMA address translatio=
n.
> > > +     *      This is not yet implemented since there is no emulated
> > > +     *      pasid-capable devices today. If we have such devices in
> > > +     *      future, the pasid cache shall be created there.
> > > +     */
> > > +
> > > +    vtd_iommu_lock(s);
> > > +    /* Step 1: loop all the exisitng vtd_pasid_as instances */
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                                vtd_flush_pasid, &pc_info);
> > > +
> >=20
> > <START>
> >=20
> > > +    /*
> > > +     * Step 2: loop all the exisitng vtd_dev_icx instances.
> > > +     * Ideally, needs to loop all devices to find if there is any ne=
w
> > > +     * PASID binding regards to the PASID cache invalidation request=
.
> > > +     * But it is enough to loop the devices which are backed by host
> > > +     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
> > > +     * if new PASID happened on them, their vtd_pasid_as instance co=
uld
> > > +     * be created during future vIOMMU DMA translation.
> > > +     */
> > > +    QLIST_FOREACH(vtd_dev_icx, &s->vtd_dev_icx_list, next) {
> > > +        VTDPASIDAddressSpace *vtd_pasid_as;
> > > +        VTDPASIDCacheEntry *pc_entry;
> > > +        VTDPASIDEntry pe;
> > > +        VTDBus *vtd_bus =3D vtd_dev_icx->vtd_bus;
> > > +        uint16_t devfn =3D vtd_dev_icx->devfn;
> > > +        int bus_n =3D pci_bus_num(vtd_bus->bus);
> > > +
> > > +        /* i) fetch vtd_pasid_as and check if it is valid */
> > > +        vtd_pasid_as =3D vtd_add_find_pasid_as(s, vtd_bus,
> > > +                                             devfn, pasid);
> >=20
> > I don't feel like it's correct here...
> >=20
> > Assuming we have two devices assigned D1, D2.  D1 uses PASID=3D1, D2 us=
es PASID=3D2.
> > When invalidating against PASID=3D1, are you also going to create a
> > VTDPASIDAddressSpace also for D2 with PASID=3D1?
>=20
> Answer is no. Before going forward, let's see if the below flow looks goo=
d to you.
>=20
> Let me add one more device besides D1 and D2. Say device D3 which also
> uses PASID=3D1. And assume it begins with no PASID usage in guest.
>=20
> Then the flow from scratch is:
>=20
> a) guest IOMMU driver setup PASID entry for D1 with PASID=3D1,
>    then invalidates against PASID #1
> b) trap to QEMU, and comes to this function. Since there is
>    no previous pasid cache invalidation, so the Step 1 of this
>    function has nothing to do, then goes to Step 2 which is to
>    loop all assigned devices and check if the guest pasid entry
>    is present. In this loop, should find D1's pasid entry for
>    PASID#1 is present. So create the VTDPASIDAddressSpace and
>    initialize its pasid_cache_entry and pasid_cache_gen fields.
> c) guest IOMMU driver setup PASID entry for D2 with PASID=3D2,
>    then invalidates against PASID #2
> d) same with b), only difference is the Step 1 of this function
>    will loop the VTDPASIDAddressSpace created in b), but its
>    pasid is 1 which is not the target of current pasid cache
>    invalidation. Same with b), in Step 2, it will create a
>    VTDPASIDAddressSpace for D2+PASID#2
> e) guest IOMMU driver setup PASID entry for D3 with PASID=3D1,
>    then invalidates against PASID #1
> f) trap to QEMU and comes to this function. Step 1 loops two
>    VTDPASIDAddressSpace created in b) and d), and it finds there
>    is a VTDPASIDAddressSpace whose pasid is 1. vtd_flush_pasid()
>    will check if the cached pasid entry is the same with the one
>    in guest memory. In this flow, it should be the same, so
>    vtd_flush_pasid() will do nothing for it. Then comes to Step 2,
>    it loops D1, D2, D3.
>    - For D1, no need to do more since there is already a
>      VTDPASIDAddressSpace created for D1+PASID#1.
>    - For D2, its guest pasid entry for PASID#1 is not present, so
>      no need to do anything for it.
>    - For D3, its guest pasid entry for PASID#1 is present and it
>      is exactly the reason for this invalidation. So create a
>      VTDPASIDAddressSpace for and init the pasid_cache_entry and
>      pasid_cache_gen fields.
>=20
> > I feel like we shouldn't create VTDPASIDAddressSpace only if it existed=
, say, until
> > when we reach vtd_dev_get_pe_from_pasid() below with retcode=3D=3D0.
>=20
> You are right. I think I failed to destroy the VTDAddressSpace when
> vtd_dev_get_pe_from_pasid() returns error. Thus the code won't create
> a VTDPASIDAddressSpace for D2+PASID#1.

OK, but that free() is really not necessary...  Please see below.

>=20
> > Besides this...
> >=20
> > > +        pc_entry =3D &vtd_pasid_as->pasid_cache_entry;
> > > +        if (s->pasid_cache_gen =3D=3D pc_entry->pasid_cache_gen) {
> > > +            /*
> > > +             * pasid_cache_gen equals to s->pasid_cache_gen means
> > > +             * vtd_pasid_as is valid after the above s->vtd_pasid_as
> > > +             * updates in Step 1. Thus no need for the below steps.
> > > +             */
> > > +            continue;
> > > +        }
> > > +
> > > +        /*
> > > +         * ii) vtd_pasid_as is not valid, it's potentailly a new
> > > +         *    pasid bind. Fetch guest pasid entry.
> > > +         */
> > > +        if (vtd_dev_get_pe_from_pasid(s, bus_n, devfn, pasid, &pe)) =
{
>=20
> Yi: should destroy pasid_as as there is no valid pasid entry. Thus to
> ensure all the pasid_as in hash table are valid.
>=20
> > > +            continue;
> > > +        }
> > > +
> > > +        /*
> > > +         * iii) pasid entry exists, update pasid cache
> > > +         *
> > > +         * Here need to check domain ID since guest pasid entry
> > > +         * exists. What needs to do are:
> > > +         *   - update the pc_entry in the vtd_pasid_as
> > > +         *   - set proper pc_entry.pasid_cache_gen
> > > +         *   - pass down the latest guest pasid entry config to host
> > > +         *     (will be added in later patch)
> > > +         */
> > > +        if (domain_id =3D=3D vtd_pe_get_domain_id(&pe)) {
> > > +            vtd_fill_in_pe_in_cache(s, vtd_pasid_as, &pe);
> > > +        }
> > > +    }
> >=20
> > <END>
> >=20
> > ... I'm a bit confused on the whole range between <START> and <END> on =
how it
> > differs from the vtd_replay_guest_pasid_bindings() you're going to intr=
oduce.
> > Shouldn't the replay code do similar thing?  Can we merge them?
>=20
> Yes, there is similar thing which is to create VTDPASIDAddressSpace
> per the guest pasid entry presence.
>=20
> But there are differences. For one, the code here is to loop all
> assigned devices for a specific PASID. While the logic in
> vtd_replay_guest_pasid_bindings() is to loop all assigned devices
> and the PASID tables behind them. For two, the code here only cares
> about the case which guest pasid entry from INVALID->VALID.
> The reason is in Step 1 of this function, VALID->INVALID and
> VALID->VALID cases are already covered. While the logic in
> vtd_replay_guest_pasid_bindings() needs to cover all the three cases.
> The last reason I didn't merge them is in vtd_replay_guest_pasid_bindings=
()
> it needs to divide the pasid entry fetch into two steps and check
> the result (if fetch pasid directory entry failed, it could skip a
> range of PASIDs). While the code in this function, it doesn't care
> about it, it only cares if there is a valid pasid entry for this
> specific pasid.
>=20
> >=20
> > My understanding is that we can just make sure to do it right once in t=
he replay
> > code (the three cases: INVALID->VALID, VALID->INVALID,
> > VALID->VALID), then no matter whether it's DSI/PSI/GSI, we call the
> > replay code probably with VTDPASIDCacheInfo* passed in, then the replay=
 code will
> > know what to look after.
>=20
> Hmmm, let me think more to abstract the code between the
> <START> and <END> to be a helper function to be called by
> vtd_replay_guest_pasid_bindings(). Also, in that case, I
> need to apply the two step concept in the replay function.

... I think your vtd_sm_pasid_table_walk() is already suitable for
this because it allows to specify "start" and "end" pasid.  Now you're
always passing in the (0, VTD_MAX_HPASID) tuple, here you can simply
pass in (pasid, pasid+1).  But I think you need to touch up
vtd_sm_pasid_table_walk() a bit to make sure it allows the pasid to be
not aliged to VTD_PASID_TBL_ENTRY_NUM.

Another thing is I think vtd_sm_pasid_table_walk_one() didn't really
check vtd_pasid_table_walk_info.did domain information...  When that's
fixed, this case is the same as the DSI walk with a specific pasid
range.

And again, please also consider to use VTDPASIDCacheInfo to be used
directly during the page walk, so vtd_pasid_table_walk_info can be
replaced I think, because IIUC VTDPASIDCacheInfo contains all
information the table walk will need.

>=20
> > > +
> > > +    vtd_iommu_unlock(s);
> > >      return 0;
> > >  }
> > >
> > > +/**
> > > + * Caller of this function should hold iommu_lock  */ static void
> > > +vtd_pasid_cache_reset(IntelIOMMUState *s) {
> > > +    VTDPASIDCacheInfo pc_info;
> > > +
> > > +    trace_vtd_pasid_cache_reset();
> > > +
> > > +    pc_info.flags =3D VTD_PASID_CACHE_GLOBAL;
> > > +
> > > +    /*
> > > +     * Reset pasid cache is a big hammer, so use
> > > +     * g_hash_table_foreach_remove which will free
> > > +     * the vtd_pasid_as instances, indicates the
> > > +     * cached pasid_cache_gen would be set to 0.
> > > +     */
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                           vtd_flush_pasid, &pc_info);
> >=20
> > Would this make sure the per pasid_as pasid_cache_gen will be reset to =
zero?  I'm
> > not very sure, say, what if the memory is stall during a reset and stil=
l have the old
> > data?
> >=20
> > I'm not sure, but I feel like we should simply drop all pasid_as here, =
rather than
> > using the same code for a global pasid invalidation.
>=20
> I see. Maybe I can get another helper function which always returns
> true, and replace vtd_flush_pasid with the new function. This should
> ensure all pasid_as are dropped. How do you think?

g_hash_table_remove_all() might be easier. :)

--=20
Peter Xu


