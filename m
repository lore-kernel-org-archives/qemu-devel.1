Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B64C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0317E2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6fBKiEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0317E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7TY-00083C-7A
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jH7Sl-0007dK-4V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jH7Sj-00020R-3f
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:56:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jH7Si-0001zP-VS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585148216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6D3Gg2ZnlwPQ1wWUId9JYNBTi/MG/a0bO81zQU8fus8=;
 b=W6fBKiEhQPkb2t4ONMRF0NT+e7tE9Ug8A6wpWt16HBSn9gf4knPoYo/wOfGLL6Fr+Fv/je
 hVQhw4OW8Cet93oQHdR0QBtC0WHHDMsE53M6+wa1O/nGu92bGfDB264UfnslFpFYZJE5es
 i/fGlIyupTyypBnLZOk4mevjhkcG4tY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-7XTKUv8APP2GjuYZ3u8jdg-1; Wed, 25 Mar 2020 10:56:52 -0400
X-MC-Unique: 7XTKUv8APP2GjuYZ3u8jdg-1
Received: by mail-wr1-f71.google.com with SMTP id y1so150963wrp.5
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FgpVoXWbEKslcRBhKxnhvTc9Ht1yp2ZJ8I8pykrMRVU=;
 b=bs9cIoAZzdsEIJu5UMJd/AAsCaHqp1jxGP/uGM4XUGpw67ZZDJhT0cOzTYbo9iF+bL
 KOv091/6tE3bVnXKeYKsoKSCU1RgY7y4pglLcfYsxokVHMcYjsq7WzEsLm6IxvZzp4jQ
 JCllbhgJs1nKt3oywXRRUpgyvzJBnFax+LVzg24umRlSiMuFc9ryDpluHY612Y08/S8C
 1mcovlTK9cCctbBK8cB3gHj0M3O/Cobu5ZO4kirN7G2h+dL5WCME7Pj/iLpQbcya74lh
 Ow6UUZu/w4nTZLLbRJetVfdgT9XcXfkxO6nty9LU5o7yL433xvokGzmaHO39dTUrRTWp
 yEbw==
X-Gm-Message-State: ANhLgQ15NtNmqmPZx2xrgJ6MasV1I/uXOllkSaWEqbZFEiqw9PwNa8Md
 CMrgUui9kHk4y+CY5MsUzk0ePvY0nGBwRHCbrrRKOxNpRMHogxBU8Okv3mPBVMXOzob6iRxBcfP
 WBGbIKIj1SxpGYbk=
X-Received: by 2002:a1c:a908:: with SMTP id s8mr4026797wme.133.1585148211228; 
 Wed, 25 Mar 2020 07:56:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vswJ0Oq78RJOfqKLvu5siSZGVUHFaIEy7pUVbXr0KFQJTqtwb/24Gqj9LPvLXCRW7qXAXc5xg==
X-Received: by 2002:a1c:a908:: with SMTP id s8mr4026772wme.133.1585148210989; 
 Wed, 25 Mar 2020 07:56:50 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a8sm8809545wmb.39.2020.03.25.07.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:56:50 -0700 (PDT)
Date: Wed, 25 Mar 2020 10:56:46 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 14/22] intel_iommu: bind/unbind guest page table to host
Message-ID: <20200325145646.GB354390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-15-git-send-email-yi.l.liu@intel.com>
 <20200324174642.GY127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A2021CD@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A2021CD@SHSMSX104.ccr.corp.intel.com>
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
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 12:42:58PM +0000, Liu, Yi L wrote:
> > From: Peter Xu
> > Sent: Wednesday, March 25, 2020 1:47 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v1 14/22] intel_iommu: bind/unbind guest page table=
 to host
> >=20
> > On Sun, Mar 22, 2020 at 05:36:11AM -0700, Liu Yi L wrote:
> > > This patch captures the guest PASID table entry modifications and
> > > propagates the changes to host to setup dual stage DMA translation.
> > > The guest page table is configured as 1st level page table (GVA->GPA)
> > > whose translation result would further go through host VT-d 2nd level
> > > page table(GPA->HPA) under nested translation mode. This is the key
> > > part of vSVA support, and also a key to support IOVA over 1st- level
> > > page table for Intel VT-d in virtualization environment.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 98
> > +++++++++++++++++++++++++++++++++++++++---
> > >  hw/i386/intel_iommu_internal.h | 25 +++++++++++
> > >  2 files changed, 118 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > c985cae..0423c83 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -41,6 +41,7 @@
> > >  #include "migration/vmstate.h"
> > >  #include "trace.h"
> > >  #include "qemu/jhash.h"
> > > +#include <linux/iommu.h>
> > >
> > >  /* context entry operations */
> > >  #define VTD_CE_GET_RID2PASID(ce) \
> > > @@ -695,6 +696,16 @@ static inline uint16_t
> > vtd_pe_get_domain_id(VTDPASIDEntry *pe)
> > >      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> > >  }
> > >
> > > +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe) {
> > > +    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9; }
> > > +
> > > +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe) {
> > > +    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR; }
> > > +
> > >  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)  {
> > >      return pdire->val & 1;
> > > @@ -1856,6 +1867,81 @@ static void
> > vtd_context_global_invalidate(IntelIOMMUState *s)
> > >      vtd_iommu_replay_all(s);
> > >  }
> > >
> > > +/**
> > > + * Caller should hold iommu_lock.
> > > + */
> > > +static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
> > > +                                int devfn, int pasid, VTDPASIDEntry =
*pe,
> > > +                                VTDPASIDOp op) {
> > > +    VTDHostIOMMUContext *vtd_dev_icx;
> > > +    HostIOMMUContext *host_icx;
> > > +    DualIOMMUStage1BindData *bind_data;
> > > +    struct iommu_gpasid_bind_data *g_bind_data;
> > > +    int ret =3D -1;
> > > +
> > > +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> > > +    if (!vtd_dev_icx) {
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    host_icx =3D vtd_dev_icx->host_icx;
> > > +    if (!host_icx) {
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    if (!(host_icx->stage1_formats
> > > +             & IOMMU_PASID_FORMAT_INTEL_VTD)) {
> > > +        error_report_once("IOMMU Stage 1 format is not
> > > + compatible!\n");
> >=20
> > Shouldn't we fail with this?
>=20
> oh, yes. no need to go further though host should also fail it.
>=20
> > > +    }
> > > +
> > > +    bind_data =3D g_malloc0(sizeof(*bind_data));
> > > +    bind_data->pasid =3D pasid;
> > > +    g_bind_data =3D &bind_data->bind_data.gpasid_bind;
> > > +
> > > +    g_bind_data->flags =3D 0;
> > > +    g_bind_data->vtd.flags =3D 0;
> > > +    switch (op) {
> > > +    case VTD_PASID_BIND:
> > > +    case VTD_PASID_UPDATE:
> >=20
> > Is VTD_PASID_UPDATE used anywhere?
> >=20
> > But since it's called "UPDATE"... I really want to confirm with you tha=
t the bind() to
> > the kernel will handle the UPDATE case, right?  I mean, we need to unbi=
nd first if
> > there is an existing pgtable pointer.
>=20
> I guess you mean host kernel. right? Actually, it's fine. host kernel
> only needs to fill in the latest pgtable pointer and permission configs
> to the pasid entry and then issue a cache invalidation. No need to do
> unbind firstly since kernel always needs to flush cache after modifying
> a pasid entry (includes valid->valid).

Great.

>=20
> >=20
> > If the answer is yes, then I think we're good, but we really need to co=
mment it
> > somewhere about the fact.
> >=20
> > > +        g_bind_data->version =3D IOMMU_UAPI_VERSION;
> > > +        g_bind_data->format =3D IOMMU_PASID_FORMAT_INTEL_VTD;
> > > +        g_bind_data->gpgd =3D vtd_pe_get_flpt_base(pe);
> > > +        g_bind_data->addr_width =3D vtd_pe_get_fl_aw(pe);
> > > +        g_bind_data->hpasid =3D pasid;
> > > +        g_bind_data->gpasid =3D pasid;
> > > +        g_bind_data->flags |=3D IOMMU_SVA_GPASID_VAL;
> > > +        g_bind_data->vtd.flags =3D
> > > +                             (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2])=
 ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]=
) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_PCD_BIT(pe->val[1])=
 ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_PWT_BIT(pe->val[1])=
 ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_EMTE_BIT(pe->val[1]=
) ? 1 : 0)
> > > +                           | (VTD_SM_PASID_ENTRY_CD_BIT(pe->val[1]) =
? 1 : 0);
> > > +        g_bind_data->vtd.pat =3D VTD_SM_PASID_ENTRY_PAT(pe->val[1]);
> > > +        g_bind_data->vtd.emt =3D VTD_SM_PASID_ENTRY_EMT(pe->val[1]);
> > > +        ret =3D host_iommu_ctx_bind_stage1_pgtbl(host_icx, bind_data=
);
> > > +        break;
> > > +    case VTD_PASID_UNBIND:
> > > +        g_bind_data->version =3D IOMMU_UAPI_VERSION;
> > > +        g_bind_data->format =3D IOMMU_PASID_FORMAT_INTEL_VTD;
> > > +        g_bind_data->gpgd =3D 0;
> > > +        g_bind_data->addr_width =3D 0;
> > > +        g_bind_data->hpasid =3D pasid;
> > > +        g_bind_data->gpasid =3D pasid;
> > > +        g_bind_data->flags |=3D IOMMU_SVA_GPASID_VAL;
> > > +        ret =3D host_iommu_ctx_unbind_stage1_pgtbl(host_icx, bind_da=
ta);
> > > +        break;
> > > +    default:
> > > +        error_report_once("Unknown VTDPASIDOp!!!\n");
> > > +        break;
> > > +    }
> > > +
> > > +    g_free(bind_data);
> > > +
> > > +    return ret;
> > > +}
> > > +
> > >  /* Do a context-cache device-selective invalidation.
> > >   * @func_mask: FM field after shifting
> > >   */
> > > @@ -2481,10 +2567,10 @@ static inline void
> > > vtd_fill_in_pe_in_cache(IntelIOMMUState *s,
> > >
> > >      pc_entry->pasid_entry =3D *pe;
> > >      pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;
> > > -    /*
> > > -     * TODO:
> > > -     * - send pasid bind to host for passthru devices
> > > -     */
> > > +    vtd_bind_guest_pasid(s, vtd_pasid_as->vtd_bus,
> > > +                         vtd_pasid_as->devfn,
> > > +                         vtd_pasid_as->pasid,
> > > +                         pe, VTD_PASID_BIND);
> > >  }
> > >
> > >  /**
> > > @@ -2574,11 +2660,13 @@ static gboolean vtd_flush_pasid(gpointer key,
> > gpointer value,
> > >       * - when pasid-base-iotlb(piotlb) infrastructure is ready,
> > >       *   should invalidate QEMU piotlb togehter with this change.
> > >       */
> > > +
> > >      return false;
> > >  remove:
> > > +    vtd_bind_guest_pasid(s, vtd_bus, devfn,
> > > +                         pasid, NULL, VTD_PASID_UNBIND);
> > >      /*
> > >       * TODO:
> > > -     * - send pasid bind to host for passthru devices
> > >       * - when pasid-base-iotlb(piotlb) infrastructure is ready,
> > >       *   should invalidate QEMU piotlb togehter with this change.
> > >       */
> > > diff --git a/hw/i386/intel_iommu_internal.h
> > > b/hw/i386/intel_iommu_internal.h index 01fd95c..4451acf 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -516,6 +516,20 @@ typedef struct VTDRootEntry VTDRootEntry;
> > > #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
> > ~VTD_HAW_MASK(aw))
> > >  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
> > >
> > > +enum VTD_DUAL_STAGE_UAPI {
> > > +    UAPI_BIND_GPASID,
> > > +    UAPI_NUM
> > > +};
> > > +typedef enum VTD_DUAL_STAGE_UAPI VTD_DUAL_STAGE_UAPI;
> > > +
> > > +enum VTDPASIDOp {
> > > +    VTD_PASID_BIND,
> > > +    VTD_PASID_UNBIND,
> > > +    VTD_PASID_UPDATE,
> >=20
> > Same here (whether to drop?).
> >
> If above reply doesn't make sense, may drop it.

Your reply makes perfect sense, but still, could we drop it because
it's not used? :)

I suggest drop UPDATE, then either:

  - comment at VTD_PASID_BIND that when binding exists, we'll update
    the entry so the caller does not need to call unbind, or,

  - rename BIND to BIND_UPDATE to show that

What do you think?

--=20
Peter Xu


