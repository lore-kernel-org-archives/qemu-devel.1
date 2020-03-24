Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3724C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7902076E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7nzo+yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7902076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGoOf-0001nf-Sj
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGoNm-0001Ni-11
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGoNk-0006M5-25
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:34:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21493)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGoNj-0006Lq-TP
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585074871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+izK7uojpuAG3C1I2IXijKbU7roR/RgKfvz5jcY2yA=;
 b=T7nzo+yg2Ni2F2KyKmtP8u9acCElMJPE7/zInMWKuyq9IeI6rEluSsGOn+16OJnyzq3pqK
 KamQKoJbj69qfQRMDMYEi1E5z6bd+3DfkjniXiVy/CuJ+qka0priflEvnj5+rQ9nmtGI9q
 0ED/HgYgEMAkgVpwxiFT12TDj6qIgfc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-9gtW6M_DPpagOyp4ZfMqUQ-1; Tue, 24 Mar 2020 14:34:29 -0400
X-MC-Unique: 9gtW6M_DPpagOyp4ZfMqUQ-1
Received: by mail-wm1-f70.google.com with SMTP id w12so1570927wmc.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6ZJqfs+Ow1XzRDF0cAMw7udrxVvYxzXME1Cp7ORdgzI=;
 b=h3Ox55cWbBCiAeRnR3dQoLkCduUk0dcqVm9p6gEaqstGBnctaHqjN6ELUqQd9o3WSA
 BCo5hsfVWBtlPaAUlf6vd3nlzMzUlNhzzlQpNXNWgSgloKn+HoNjC+f4Q2e8ViqcUFy2
 sPmYMsiDCiBRjryyWGwDSXGxv0FH9Ar28LmEaPKeH71lkCTyOvYF//4V4cIeiGYDDAUA
 C+kHpa5sWfAtu29Rh7qJiZ98OOnz7i/aYAOoq2dM/7yuv2ySQATb6qLy3sKc81wsof5b
 tObwKh0YwMbuA07dFubeqoubpJceaQSMhY1U0lcrcxtP2Ap4d9i4I5krxPpDPVdacyaO
 9q2A==
X-Gm-Message-State: ANhLgQ1XD+w/fFcTZOoCqmBzdoIGypxWx3p+YN8wYZWvuR2UrO4uGXZw
 7x9t+8yu5gixyDeqwecx7ZBkljSdIPLT90RSNrz0ownXOj+25Z97K6XvzusKSb2pRTlXS6Li9Rx
 6UqwBp2FODmZA6H4=
X-Received: by 2002:adf:dd86:: with SMTP id x6mr31819810wrl.169.1585074868535; 
 Tue, 24 Mar 2020 11:34:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuCAe/rn2Aicw35jdGbZd7Clfm6waLJyNnVeOjwPm9ho+IbIPYkPjybUosROUum4zOmxMNJsQ==
X-Received: by 2002:adf:dd86:: with SMTP id x6mr31819768wrl.169.1585074868268; 
 Tue, 24 Mar 2020 11:34:28 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id d6sm3754866wrw.10.2020.03.24.11.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:34:27 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:34:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotlb
 invalidation to host
Message-ID: <20200324183423.GE127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-21-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-21-git-send-email-yi.l.liu@intel.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:17AM -0700, Liu Yi L wrote:
> This patch propagates PASID-based iotlb invalidation to host.
>=20
> Intel VT-d 3.0 supports nested translation in PASID granular.
> Guest SVA support could be implemented by configuring nested
> translation on specific PASID. This is also known as dual stage
> DMA translation.
>=20
> Under such configuration, guest owns the GVA->GPA translation
> which is configured as first level page table in host side for
> a specific pasid, and host owns GPA->HPA translation. As guest
> owns first level translation table, piotlb invalidation should
> be propagated to host since host IOMMU will cache first level
> page table related mappings during DMA address translation.
>=20
> This patch traps the guest PASID-based iotlb flush and propagate
> it to host.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 139 +++++++++++++++++++++++++++++++++++=
++++++
>  hw/i386/intel_iommu_internal.h |   7 +++
>  2 files changed, 146 insertions(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b9ac07d..10d314d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3134,15 +3134,154 @@ static bool vtd_process_pasid_desc(IntelIOMMUSta=
te *s,
>      return (ret =3D=3D 0) ? true : false;
>  }
> =20
> +/**
> + * Caller of this function should hold iommu_lock.
> + */
> +static void vtd_invalidate_piotlb(IntelIOMMUState *s,
> +                                  VTDBus *vtd_bus,
> +                                  int devfn,
> +                                  DualIOMMUStage1Cache *stage1_cache)
> +{
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +    HostIOMMUContext *host_icx;
> +
> +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> +    if (!vtd_dev_icx) {
> +        goto out;
> +    }
> +    host_icx =3D vtd_dev_icx->host_icx;
> +    if (!host_icx) {
> +        goto out;
> +    }
> +    if (host_iommu_ctx_flush_stage1_cache(host_icx, stage1_cache)) {
> +        error_report("Cache flush failed");

I think this should not easily be triggered by the guest, but just in
case... Let's use error_report_once() to be safe.

> +    }
> +out:
> +    return;
> +}
> +
> +static inline bool vtd_pasid_cache_valid(
> +                          VTDPASIDAddressSpace *vtd_pasid_as)
> +{
> +    return vtd_pasid_as->iommu_state &&

This check can be dropped because always true?

If you agree with both the changes, please add:

Reviewed-by: Peter Xu <peterx@redhat.com>

> +           (vtd_pasid_as->iommu_state->pasid_cache_gen
> +             =3D=3D vtd_pasid_as->pasid_cache_entry.pasid_cache_gen);
> +}
> +
> +/**
> + * This function is a loop function for the s->vtd_pasid_as
> + * list with VTDPIOTLBInvInfo as execution filter. It propagates
> + * the piotlb invalidation to host. Caller of this function
> + * should hold iommu_lock.
> + */
> +static void vtd_flush_pasid_iotlb(gpointer key, gpointer value,
> +                                  gpointer user_data)
> +{
> +    VTDPIOTLBInvInfo *piotlb_info =3D user_data;
> +    VTDPASIDAddressSpace *vtd_pasid_as =3D value;
> +    uint16_t did;
> +
> +    /*
> +     * Needs to check whether the pasid entry cache stored in
> +     * vtd_pasid_as is valid or not. "invalid" means the pasid
> +     * cache has been flushed, thus host should have done piotlb
> +     * invalidation together with a pasid cache invalidation, so
> +     * no need to pass down piotlb invalidation to host for better
> +     * performance. Only when pasid entry cache is "valid", should
> +     * a piotlb invalidation be propagated to host since it means
> +     * guest just modified a mapping in its page table.
> +     */
> +    if (!vtd_pasid_cache_valid(vtd_pasid_as)) {
> +        return;
> +    }
> +
> +    did =3D vtd_pe_get_domain_id(
> +                &(vtd_pasid_as->pasid_cache_entry.pasid_entry));
> +
> +    if ((piotlb_info->domain_id =3D=3D did) &&
> +        (piotlb_info->pasid =3D=3D vtd_pasid_as->pasid)) {
> +        vtd_invalidate_piotlb(vtd_pasid_as->iommu_state,
> +                              vtd_pasid_as->vtd_bus,
> +                              vtd_pasid_as->devfn,
> +                              piotlb_info->stage1_cache);
> +    }
> +
> +    /*
> +     * TODO: needs to add QEMU piotlb flush when QEMU piotlb
> +     * infrastructure is ready. For now, it is enough for passthru
> +     * devices.
> +     */
> +}
> +
>  static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>                                          uint16_t domain_id,
>                                          uint32_t pasid)
>  {
> +    VTDPIOTLBInvInfo piotlb_info;
> +    DualIOMMUStage1Cache *stage1_cache;
> +    struct iommu_cache_invalidate_info *cache_info;
> +
> +    stage1_cache =3D g_malloc0(sizeof(*stage1_cache));
> +    stage1_cache->pasid =3D pasid;
> +
> +    cache_info =3D &stage1_cache->cache_info;
> +    cache_info->version =3D IOMMU_UAPI_VERSION;
> +    cache_info->cache =3D IOMMU_CACHE_INV_TYPE_IOTLB;
> +    cache_info->granularity =3D IOMMU_INV_GRANU_PASID;
> +    cache_info->pasid_info.pasid =3D pasid;
> +    cache_info->pasid_info.flags =3D IOMMU_INV_PASID_FLAGS_PASID;
> +
> +    piotlb_info.domain_id =3D domain_id;
> +    piotlb_info.pasid =3D pasid;
> +    piotlb_info.stage1_cache =3D stage1_cache;
> +
> +    vtd_iommu_lock(s);
> +    /*
> +     * Here loops all the vtd_pasid_as instances in s->vtd_pasid_as
> +     * to find out the affected devices since piotlb invalidation
> +     * should check pasid cache per architecture point of view.
> +     */
> +    g_hash_table_foreach(s->vtd_pasid_as,
> +                         vtd_flush_pasid_iotlb, &piotlb_info);
> +    vtd_iommu_unlock(s);
> +    g_free(stage1_cache);
>  }
> =20
>  static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t doma=
in_id,
>                               uint32_t pasid, hwaddr addr, uint8_t am, bo=
ol ih)
>  {
> +    VTDPIOTLBInvInfo piotlb_info;
> +    DualIOMMUStage1Cache *stage1_cache;
> +    struct iommu_cache_invalidate_info *cache_info;
> +
> +    stage1_cache =3D g_malloc0(sizeof(*stage1_cache));
> +    stage1_cache->pasid =3D pasid;
> +
> +    cache_info =3D &stage1_cache->cache_info;
> +    cache_info->version =3D IOMMU_UAPI_VERSION;
> +    cache_info->cache =3D IOMMU_CACHE_INV_TYPE_IOTLB;
> +    cache_info->granularity =3D IOMMU_INV_GRANU_ADDR;
> +    cache_info->addr_info.flags =3D IOMMU_INV_ADDR_FLAGS_PASID;
> +    cache_info->addr_info.flags |=3D ih ? IOMMU_INV_ADDR_FLAGS_LEAF : 0;
> +    cache_info->addr_info.pasid =3D pasid;
> +    cache_info->addr_info.addr =3D addr;
> +    cache_info->addr_info.granule_size =3D 1 << (12 + am);
> +    cache_info->addr_info.nb_granules =3D 1;
> +
> +    piotlb_info.domain_id =3D domain_id;
> +    piotlb_info.pasid =3D pasid;
> +    piotlb_info.stage1_cache =3D stage1_cache;
> +
> +    vtd_iommu_lock(s);
> +    /*
> +     * Here loops all the vtd_pasid_as instances in s->vtd_pasid_as
> +     * to find out the affected devices since piotlb invalidation
> +     * should check pasid cache per architecture point of view.
> +     */
> +    g_hash_table_foreach(s->vtd_pasid_as,
> +                         vtd_flush_pasid_iotlb, &piotlb_info);
> +    vtd_iommu_unlock(s);
> +    g_free(stage1_cache);
>  }
> =20
>  static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 314e2c4..967cc4f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -560,6 +560,13 @@ struct VTDPASIDCacheInfo {
>                                        VTD_PASID_CACHE_DEVSI)
>  typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
> =20
> +struct VTDPIOTLBInvInfo {
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    DualIOMMUStage1Cache *stage1_cache;
> +};
> +typedef struct VTDPIOTLBInvInfo VTDPIOTLBInvInfo;
> +
>  /* PASID Table Related Definitions */
>  #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>  #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> --=20
> 2.7.4
>=20

--=20
Peter Xu


