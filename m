Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7709C206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqVGG31q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7709C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGneo-0002ot-M4
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGnde-0001ug-Ek
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGndc-0000FH-6p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:46:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGndc-0000F4-1l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585072011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QC3O7z8SNA4cPssnuHSLWkewsFZTYZiHTvhNnqe825c=;
 b=SqVGG31qKr9iiMlqI1xkUmAbNtNeQYWumOku+i1kPEqjT5fqS/SGHWq1+035qZsXDu51zR
 jUko/NvI0rOOiZtt0fyt0gp7QRHcSpsRaQBYv0wHan3HwA/8SBldwK07bNGsw33d9emC8R
 4qkUiKAL4dd97zO1e0gHihD+nvad2JY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-p20dhkkZPz2822MEnDa7Kg-1; Tue, 24 Mar 2020 13:46:50 -0400
X-MC-Unique: p20dhkkZPz2822MEnDa7Kg-1
Received: by mail-wm1-f70.google.com with SMTP id t22so1533157wmt.4
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 10:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qMQnlXZ4+W9pSmuD0MbvBFQqkeBh+78tD6YjGzWSr54=;
 b=TEQJiXR0zkK2JtxkeZRH3WyYpq6mmlGD9OpSgNjO4mUO7nXNfMtfxf7cNf6bh8HBeV
 Sap1DNpuiWZfJVAdM7ll8sNbxnhE7wIEq5arz1jWOVrcHqFKSIA+6zGoFNgpJaSAnbKT
 GJl9GK6casSOzpIbqtLY8XjEXzjnAnWhbj0JBycVBbr0jFg67M+H13rIOYTTR6/DZfIr
 NlBQRN1K5vjMQ83eJqUfSggyi2nEV6Y1WYjtZmQN+Q/19ggefxIfao0XNeBdCzsrOUMc
 MDS76oAa8Wfi4oe8lTVxP8xupFm6hrLyxz5f9mHpfiwjw/eKp4ig90eVXq/cvyxdt7BV
 a21Q==
X-Gm-Message-State: ANhLgQ14dlG0MqLSjEUsZarZw+vmEx56WoekUwmjpLPFqn3ashAkWNGY
 R7d3YHYQv+0zxC4Lc/5tzEoY3+JdPdf7+9M31ZaMiV08y33qzq1H/SNZr7+GLmqi68JFGifLq1/
 fUqwADIgJccJTusk=
X-Received: by 2002:adf:aacc:: with SMTP id i12mr40213269wrc.116.1585072008978; 
 Tue, 24 Mar 2020 10:46:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7Xq3xDq/ft0QrdRN3VE6gjTejZgxJ8O8JjoFJuohskC0CJwAJfPNCx07C/LnQgOVsCWmX5g==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr40213155wrc.116.1585072007766; 
 Tue, 24 Mar 2020 10:46:47 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k15sm7063230wrm.55.2020.03.24.10.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 10:46:47 -0700 (PDT)
Date: Tue, 24 Mar 2020 13:46:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 14/22] intel_iommu: bind/unbind guest page table to host
Message-ID: <20200324174642.GY127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-15-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-15-git-send-email-yi.l.liu@intel.com>
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:11AM -0700, Liu Yi L wrote:
> This patch captures the guest PASID table entry modifications and
> propagates the changes to host to setup dual stage DMA translation.
> The guest page table is configured as 1st level page table (GVA->GPA)
> whose translation result would further go through host VT-d 2nd
> level page table(GPA->HPA) under nested translation mode. This is the
> key part of vSVA support, and also a key to support IOVA over 1st-
> level page table for Intel VT-d in virtualization environment.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 98 ++++++++++++++++++++++++++++++++++++=
+++---
>  hw/i386/intel_iommu_internal.h | 25 +++++++++++
>  2 files changed, 118 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c985cae..0423c83 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -41,6 +41,7 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "qemu/jhash.h"
> +#include <linux/iommu.h>
> =20
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -695,6 +696,16 @@ static inline uint16_t vtd_pe_get_domain_id(VTDPASID=
Entry *pe)
>      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
>  }
> =20
> +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
> +}
> +
> +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -1856,6 +1867,81 @@ static void vtd_context_global_invalidate(IntelIOM=
MUState *s)
>      vtd_iommu_replay_all(s);
>  }
> =20
> +/**
> + * Caller should hold iommu_lock.
> + */
> +static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
> +                                int devfn, int pasid, VTDPASIDEntry *pe,
> +                                VTDPASIDOp op)
> +{
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +    HostIOMMUContext *host_icx;
> +    DualIOMMUStage1BindData *bind_data;
> +    struct iommu_gpasid_bind_data *g_bind_data;
> +    int ret =3D -1;
> +
> +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> +    if (!vtd_dev_icx) {
> +        return -EINVAL;
> +    }
> +
> +    host_icx =3D vtd_dev_icx->host_icx;
> +    if (!host_icx) {
> +        return -EINVAL;
> +    }
> +
> +    if (!(host_icx->stage1_formats
> +             & IOMMU_PASID_FORMAT_INTEL_VTD)) {
> +        error_report_once("IOMMU Stage 1 format is not compatible!\n");

Shouldn't we fail with this?

> +    }
> +
> +    bind_data =3D g_malloc0(sizeof(*bind_data));
> +    bind_data->pasid =3D pasid;
> +    g_bind_data =3D &bind_data->bind_data.gpasid_bind;
> +
> +    g_bind_data->flags =3D 0;
> +    g_bind_data->vtd.flags =3D 0;
> +    switch (op) {
> +    case VTD_PASID_BIND:
> +    case VTD_PASID_UPDATE:

Is VTD_PASID_UPDATE used anywhere?

But since it's called "UPDATE"... I really want to confirm with you
that the bind() to the kernel will handle the UPDATE case, right?  I
mean, we need to unbind first if there is an existing pgtable pointer.

If the answer is yes, then I think we're good, but we really need to
comment it somewhere about the fact.

> +        g_bind_data->version =3D IOMMU_UAPI_VERSION;
> +        g_bind_data->format =3D IOMMU_PASID_FORMAT_INTEL_VTD;
> +        g_bind_data->gpgd =3D vtd_pe_get_flpt_base(pe);
> +        g_bind_data->addr_width =3D vtd_pe_get_fl_aw(pe);
> +        g_bind_data->hpasid =3D pasid;
> +        g_bind_data->gpasid =3D pasid;
> +        g_bind_data->flags |=3D IOMMU_SVA_GPASID_VAL;
> +        g_bind_data->vtd.flags =3D
> +                             (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ? 1=
 : 0)
> +                           | (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ? =
1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_PCD_BIT(pe->val[1]) ? 1=
 : 0)
> +                           | (VTD_SM_PASID_ENTRY_PWT_BIT(pe->val[1]) ? 1=
 : 0)
> +                           | (VTD_SM_PASID_ENTRY_EMTE_BIT(pe->val[1]) ? =
1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_CD_BIT(pe->val[1]) ? 1 =
: 0);
> +        g_bind_data->vtd.pat =3D VTD_SM_PASID_ENTRY_PAT(pe->val[1]);
> +        g_bind_data->vtd.emt =3D VTD_SM_PASID_ENTRY_EMT(pe->val[1]);
> +        ret =3D host_iommu_ctx_bind_stage1_pgtbl(host_icx, bind_data);
> +        break;
> +    case VTD_PASID_UNBIND:
> +        g_bind_data->version =3D IOMMU_UAPI_VERSION;
> +        g_bind_data->format =3D IOMMU_PASID_FORMAT_INTEL_VTD;
> +        g_bind_data->gpgd =3D 0;
> +        g_bind_data->addr_width =3D 0;
> +        g_bind_data->hpasid =3D pasid;
> +        g_bind_data->gpasid =3D pasid;
> +        g_bind_data->flags |=3D IOMMU_SVA_GPASID_VAL;
> +        ret =3D host_iommu_ctx_unbind_stage1_pgtbl(host_icx, bind_data);
> +        break;
> +    default:
> +        error_report_once("Unknown VTDPASIDOp!!!\n");
> +        break;
> +    }
> +
> +    g_free(bind_data);
> +
> +    return ret;
> +}
> +
>  /* Do a context-cache device-selective invalidation.
>   * @func_mask: FM field after shifting
>   */
> @@ -2481,10 +2567,10 @@ static inline void vtd_fill_in_pe_in_cache(IntelI=
OMMUState *s,
> =20
>      pc_entry->pasid_entry =3D *pe;
>      pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;
> -    /*
> -     * TODO:
> -     * - send pasid bind to host for passthru devices
> -     */
> +    vtd_bind_guest_pasid(s, vtd_pasid_as->vtd_bus,
> +                         vtd_pasid_as->devfn,
> +                         vtd_pasid_as->pasid,
> +                         pe, VTD_PASID_BIND);
>  }
> =20
>  /**
> @@ -2574,11 +2660,13 @@ static gboolean vtd_flush_pasid(gpointer key, gpo=
inter value,
>       * - when pasid-base-iotlb(piotlb) infrastructure is ready,
>       *   should invalidate QEMU piotlb togehter with this change.
>       */
> +
>      return false;
>  remove:
> +    vtd_bind_guest_pasid(s, vtd_bus, devfn,
> +                         pasid, NULL, VTD_PASID_UNBIND);
>      /*
>       * TODO:
> -     * - send pasid bind to host for passthru devices
>       * - when pasid-base-iotlb(piotlb) infrastructure is ready,
>       *   should invalidate QEMU piotlb togehter with this change.
>       */
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 01fd95c..4451acf 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -516,6 +516,20 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw=
))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
> =20
> +enum VTD_DUAL_STAGE_UAPI {
> +    UAPI_BIND_GPASID,
> +    UAPI_NUM
> +};
> +typedef enum VTD_DUAL_STAGE_UAPI VTD_DUAL_STAGE_UAPI;
> +
> +enum VTDPASIDOp {
> +    VTD_PASID_BIND,
> +    VTD_PASID_UNBIND,
> +    VTD_PASID_UPDATE,

Same here (whether to drop?).

> +    VTD_OP_NUM
> +};
> +typedef enum VTDPASIDOp VTDPASIDOp;
> +
>  struct VTDPASIDCacheInfo {
>  #define VTD_PASID_CACHE_GLOBAL   (1ULL << 0)
>  #define VTD_PASID_CACHE_DOMSI    (1ULL << 1)
> @@ -552,6 +566,17 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-wi=
dth */
>  #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> =20
> +#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> +#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_PCD_BIT(val)  (!!(((val) >> 31) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_PWT_BIT(val)  (!!(((val) >> 30) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_EMTE_BIT(val) (!!(((val) >> 26) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_CD_BIT(val)   (!!(((val) >> 25) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_PAT(val)      (((val) >> 32) & 0xFFFFFFFFULL)
> +#define VTD_SM_PASID_ENTRY_EMT(val)      (((val) >> 27) & 0x7ULL)
> +
>  /* Second Level Page Translation Pointer*/
>  #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
> =20
> --=20
> 2.7.4
>=20

--=20
Peter Xu


