Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96672076E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLb72elA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96672076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGoTH-0004IN-U6
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGoSZ-0003lE-NO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGoSY-00023J-Ct
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:39:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGoSY-000232-96
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585075169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LdSnvN/Ug425RLl0yRu+fkLaFKjx6Jknu90K7pLEHM=;
 b=ZLb72elAVbJDtLKa7W3QWGh2BWUTlObk31Eq3HC7kXqqVHKEBeUgun+lepwWyGRX0RyPRK
 P6UZEPrxhYPVTISuCm7iKVMwGDwYQKmShEfXaQxJp2Xbh77DVleuqbraGYrSllgWsGBD02
 OK5iH3BTjuVhpSvOHCIBcHxZllogYbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-uRS9vW4jO6mGv65QeR2Acg-1; Tue, 24 Mar 2020 14:39:24 -0400
X-MC-Unique: uRS9vW4jO6mGv65QeR2Acg-1
Received: by mail-wr1-f70.google.com with SMTP id j12so5772538wrr.18
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sL0eAVRaIWASbETqSE83z4WnVFPyEX+txd4A0EQ2lwc=;
 b=j2nDNLIEad2LZ/esZzi5laY1/UXop+Hk3Sh4Nnj+23IFYl2hrwaz3cCujjEbp/HMsv
 iLO4KVPZxEr9k1jRXUVjhqcpySZJuUFtMClDyaMFpzxyWcH0r6PivElkP/Dkw6MQwYqr
 z1aM7n6fpTkp6lnnWU6+ny5mNA3aio3g+jWeL+x2CdMRfmPDxd+tMAR1+2Xsn50d8m1T
 kYX5K6lgVArDFo5YE1gbzafwXSk/G7xARask4m1b9dhvlqcNQmJsAALwnuzm6oCR4EWY
 4Utcsy+pNRyN/QEFRxI0MwhPG3r2vjP9lEdC3bIIkUbFHm82JyQ/edZKIJImq7T6Y4Mb
 fVLg==
X-Gm-Message-State: ANhLgQ1OhddBW8Z9wMnhllyz0GJOjbUolviIqYzP9W3PIubh3nuO/1xg
 jSYfLPbgFiKamPgbQJElFKHWgccOUSr53H2TdG/Us5QLFKRRlgBTppQvKGIpXvpUM5C+IyJLvsF
 1dNYmLRMUcfIS4cY=
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr37906499wrh.7.1585075163718; 
 Tue, 24 Mar 2020 11:39:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs86kYZ/+t0REuC2ggpfxrOYEhm3LfxtXq73FBGwpUfdi0cWoVqJ/8tqEMfzSw3nK3hElg0AQ==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr37906470wrh.7.1585075163494; 
 Tue, 24 Mar 2020 11:39:23 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v2sm31518906wrt.58.2020.03.24.11.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:39:22 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:39:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 22/22] intel_iommu: modify x-scalable-mode to be
 string option
Message-ID: <20200324183918.GG127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-23-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-23-git-send-email-yi.l.liu@intel.com>
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

On Sun, Mar 22, 2020 at 05:36:19AM -0700, Liu Yi L wrote:
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
> While this vIOMMU implementation wants simplify it for user by providing
> typical combinations. User could config it by "x-scalable-mode" option. T=
he
> usage is as below:
>=20
> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"|"off"]"
>=20
>  - "legacy": gives support for SL page table
>  - "modern": gives support for FL page table, pasid, virtual command
>  - "off": no scalable mode support
>  -  if not configured, means no scalable mode support, if not proper
>     configured, will throw error
>=20
> Note: this patch is supposed to be merged when  the whole vSVA patch seri=
es
> were merged.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/i386/intel_iommu.c          | 29 +++++++++++++++++++++++++++--
>  hw/i386/intel_iommu_internal.h |  4 ++++
>  include/hw/i386/intel_iommu.h  |  2 ++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 72cd739..ea1f5c4 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4171,7 +4171,7 @@ static Property vtd_properties[] =3D {
>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>                        VTD_HOST_ADDRESS_WIDTH),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALS=
E),
> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, =
FALSE),
> +    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode=
_str),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -4802,8 +4802,12 @@ static void vtd_init(IntelIOMMUState *s)
>      }
> =20
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. =
*/
> -    if (s->scalable_mode) {
> +    if (s->scalable_mode && !s->scalable_modern) {
>          s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +    } else if (s->scalable_mode && s->scalable_modern) {
> +        s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
> +                   | VTD_ECAP_FLTS | VTD_ECAP_PSS | VTD_ECAP_VCS;
> +        s->vccap |=3D VTD_VCCAP_PAS;
>      }
> =20
>      vtd_reset_caches(s);
> @@ -4935,6 +4939,27 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
Error **errp)
>          return false;
>      }
> =20
> +    if (s->scalable_mode_str &&
> +        (strcmp(s->scalable_mode_str, "modern") &&
> +         strcmp(s->scalable_mode_str, "legacy"))) {

The 'off' check is missing?

> +        error_setg(errp, "Invalid x-scalable-mode config,"
> +                         "Please use \"modern\", \"legacy\" or \"off\"")=
;
> +        return false;
> +    }
> +
> +    if (s->scalable_mode_str &&
> +        !strcmp(s->scalable_mode_str, "legacy")) {
> +        s->scalable_mode =3D true;
> +        s->scalable_modern =3D false;
> +    } else if (s->scalable_mode_str &&
> +        !strcmp(s->scalable_mode_str, "modern")) {
> +        s->scalable_mode =3D true;
> +        s->scalable_modern =3D true;
> +    } else {
> +        s->scalable_mode =3D false;
> +        s->scalable_modern =3D false;
> +    }
> +
>      return true;
>  }
> =20
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index b5507ce..52b25ff 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -196,8 +196,12 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
>  #define VTD_ECAP_SRS                (1ULL << 31)
> +#define VTD_ECAP_PSS                (19ULL << 35)
> +#define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
> +#define VTD_ECAP_VCS                (1ULL << 44)
>  #define VTD_ECAP_SLTS               (1ULL << 46)
> +#define VTD_ECAP_FLTS               (1ULL << 47)
> =20
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 9782ac4..07494d4 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -268,6 +268,8 @@ struct IntelIOMMUState {
> =20
>      bool caching_mode;              /* RO - is cap CM enabled? */
>      bool scalable_mode;             /* RO - is Scalable Mode supported? =
*/
> +    char *scalable_mode_str;        /* RO - admin's Scalable Mode config=
 */
> +    bool scalable_modern;           /* RO - is modern SM supported? */
> =20
>      dma_addr_t root;                /* Current root table pointer */
>      bool root_scalable;             /* Type of root table (scalable or n=
ot) */
> --=20
> 2.7.4
>=20

--=20
Peter Xu


