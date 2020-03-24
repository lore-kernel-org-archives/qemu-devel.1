Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CFB20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwMuoEdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CFB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGoH8-0000Ao-9C
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGoG9-000834-IS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGoG5-0001EV-Rq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:26:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGoG4-0001Ai-3O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585074394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdvmk0sxBEMNM0N4Zitdlrx1grAFCUx0f4Xn26HyHgk=;
 b=FwMuoEdSkPpVZnvnLxQKZsr5uk4n1CFIT3hBWDLyvn2h2uE8igilFmkkGc4eLUGAyDagNq
 G/MyWeiu8kaGDRIEnAIBwp2PC6dku3la2ApQqQJ0oxblh7efBw1mSNCOKgzF0QzId5BWvd
 22edTD1Z2uQyfqtsRey05MgCRfrCFXE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-TirM9ZL2MWOSNoqJgvMhkg-1; Tue, 24 Mar 2020 14:26:30 -0400
X-MC-Unique: TirM9ZL2MWOSNoqJgvMhkg-1
Received: by mail-wm1-f71.google.com with SMTP id g26so1561503wmk.6
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V6jHAxEN32/ukQnnlbxQIqoT3ejEMpdc3eZJXOAV41c=;
 b=BuIZ4wjjTcbbz+UXIhxWO/rCaanUCLkPdhX4YInC4chI6QQsGOjbkkwyWKv/85vWxt
 Qf3zQVz3XX5eeWNGbUZNpWxeqmBLgm97WWfWp7wgR+ptakem9nUExzWi2CltI1uD1Fgd
 FfMV1CfltWP7lfAOguaX0G/Jqapb35iJ5rr7hIVmXIC2jwlWjMqx2OlUEY+XmX6XWfkl
 V62ZtagHw+iO3eyOBh4yh5Fx84pKRb5zkV3JQpIDpZMwAiR0ziue2xwVNxgRkpec8RlE
 I9lZNW8eTiA4dcNKbqKtHDoczfXtg5socMue+7o0mklX/jPcw9pFjvfYuH/ll2urlPYC
 7iQA==
X-Gm-Message-State: ANhLgQ0yUswZVtYn1GhBOaLhfW2Jh07iK5Rpqz12jXDMtcd534nYXNP0
 UMJ/uUM0wlv8ZVE0riGKUhf9kbMr/mZyXjBqkHQHG0kx+qsieiqaQYw+OLqHJQOHQizazMH93My
 0VSy8yZbpArpnTVc=
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr7343406wmk.79.1585074388980; 
 Tue, 24 Mar 2020 11:26:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvIYCrCeR8MIkoCWO59wRujpo/tfT33/kWbC4hZFUxGDVim/pLeqwAA9a3AhHLtgMFxuoR30g==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr7343377wmk.79.1585074388757; 
 Tue, 24 Mar 2020 11:26:28 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t12sm14061877wrm.0.2020.03.24.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:26:28 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:26:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Message-ID: <20200324182623.GD127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-20-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-20-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Sun, Mar 22, 2020 at 05:36:16AM -0700, Liu Yi L wrote:
> This patch adds the basic PASID-based iotlb (piotlb) invalidation
> support. piotlb is used during walking Intel VT-d 1st level page
> table. This patch only adds the basic processing. Detailed handling
> will be added in next patch.
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
>  hw/i386/intel_iommu.c          | 57 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/i386/intel_iommu_internal.h | 13 ++++++++++
>  2 files changed, 70 insertions(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b007715..b9ac07d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3134,6 +3134,59 @@ static bool vtd_process_pasid_desc(IntelIOMMUState=
 *s,
>      return (ret =3D=3D 0) ? true : false;
>  }
> =20
> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> +                                        uint16_t domain_id,
> +                                        uint32_t pasid)
> +{
> +}
> +
> +static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t doma=
in_id,
> +                             uint32_t pasid, hwaddr addr, uint8_t am, bo=
ol ih)
> +{
> +}
> +
> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> +                                    VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    uint8_t am;
> +    hwaddr addr;
> +
> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
> +        error_report_once("non-zero-field-in-piotlb_inv_desc hi: 0x%" PR=
Ix64
> +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0])=
;
> +        return false;
> +    }
> +
> +    domain_id =3D VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
> +    pasid =3D VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
> +    switch (inv_desc->val[0] & VTD_INV_DESC_IOTLB_G) {
> +    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
> +        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
> +        break;
> +
> +    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> +        am =3D VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
> +        addr =3D (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> +        if (am > VTD_MAMV) {

I saw this of spec 10.4.2, MAMV:

        Independent of value reported in this field, implementations
        supporting SMTS must support address-selective PASID-based
        IOTLB invalidations (p_iotlb_inv_dsc) with any defined address
        mask.

Does it mean we should even support larger AM?

Besides that, the patch looks good to me.

> +            error_report_once("Invalid am, > max am value, hi: 0x%" PRIx=
64
> +                    " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0=
]);
> +            return false;
> +        }
> +        vtd_piotlb_page_invalidate(s, domain_id, pasid,
> +             addr, am, VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
> +        break;
> +
> +    default:
> +        error_report_once("Invalid granularity in P-IOTLB desc hi: 0x%" =
PRIx64
> +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0])=
;
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>  {
> @@ -3248,6 +3301,10 @@ static bool vtd_process_inv_desc(IntelIOMMUState *=
s)
>          break;
> =20
>      case VTD_INV_DESC_PIOTLB:
> +        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
> +        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
>          break;
> =20
>      case VTD_INV_DESC_WAIT:
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 6f32d7b..314e2c4 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -457,6 +457,19 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
>  #define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
> =20
> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
> +
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000ffc0ULL
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
> +
> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & \
> +                                             VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
> +#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
> +#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> --=20
> 2.7.4
>=20

--=20
Peter Xu


