Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363FC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AD420842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csnMNOnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AD420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bT1-0005mn-Sl
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1bRi-0004PC-AH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1bRe-0004ai-OX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:43:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1bRe-0004Yk-Da
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581450221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLLnLUhGFese7WXU57belUDihGti22d23Zz/SC8bjDA=;
 b=csnMNOnf30JCsfepd3/U9Ai2LReQGpHcUDpwWpzatvuh3+ZvuysV47afXqXkOpYbhkSIfV
 W6okFnerNE9EzFruGDnU3PTChGvkVPMaMJyjPIpTLy2pxm+A7+1BfCte34KOsTI9G+/t90
 EEhs0YuV2/zwgtgANuqqmKE8oD2q6Ps=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-PopxtpsXNmucZ-zLc4mzww-1; Tue, 11 Feb 2020 14:43:34 -0500
Received: by mail-qt1-f200.google.com with SMTP id c22so7330946qtn.23
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h7KUPmf86zB702J560kJNk/Uikfj86BS/GU0xdCnSuI=;
 b=dWhB0m36VpoBCSeymMJv+YMhRXXvhsPxRFagcW3gnAGkYHl6EEDigPGP0nCYZ7QbRU
 tKUMtlVLAdRhayDHpyc0O8WqpDFoqovfXabnp24p0xoxgL3/MVMMskEiWjd6wlIreRbx
 cw1I1RVwRNt54mB/VpwJRlbwPAFSnc2PMNbh2di6SvbcSsYrAOPr+BgkWTjJ8PUyP1+4
 6Fpu7R6qpJHY1ah1dPdSeBT98Sekttv3RXllH2nqTnazMB8sYB7mEgUCAb2FD6PDv0GG
 K8GE4FjlyTgk3Mwhlzv/VU+DL5HQ7ctA25IDSRIfnfoyJDcC0OHmU3ORKNVj09TkRnSA
 k1OA==
X-Gm-Message-State: APjAAAXwKuinrc3hnaMw0YAFQD10WXUAU0t3Hd9OsaHeJHlWEvP3FcpQ
 JMz1LcRjjtO/AmrM24sc/W157ynUIUqn58vA5XHEjD5oS86UaxcE3EYDwPIFy/UpGVDFEmNzce+
 iSXCzjcJSpmZA8QU=
X-Received: by 2002:a05:620a:412:: with SMTP id
 18mr7737126qkp.213.1581450214429; 
 Tue, 11 Feb 2020 11:43:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzaQKrkmzYTPMBwqDXhjjHJJr6Jkmjr2WXR0RK4oj5iaQ+jZhyfSdQZUhqw4MyroKiz2WqNWw==
X-Received: by 2002:a05:620a:412:: with SMTP id
 18mr7737098qkp.213.1581450214196; 
 Tue, 11 Feb 2020 11:43:34 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id x197sm2540447qkb.28.2020.02.11.11.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:43:33 -0800 (PST)
Date: Tue, 11 Feb 2020 14:43:31 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 13/25] intel_iommu: modify x-scalable-mode to be string
 option
Message-ID: <20200211194331.GK984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-14-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1580300216-86172-14-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: PopxtpsXNmucZ-zLc4mzww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 04:16:44AM -0800, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
> While this vIOMMU implementation wants simplify it for user by providing
> typical combinations. User could config it by "x-scalable-mode" option. T=
he
> usage is as below:
>=20
> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"]"

Maybe also "off" when someone wants to explicitly disable it?

>=20
>  - "legacy": gives support for SL page table
>  - "modern": gives support for FL page table, pasid, virtual command
>  -  if not configured, means no scalable mode support, if not proper
>     configured, will throw error
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
>  hw/i386/intel_iommu.c          | 27 +++++++++++++++++++++++++--
>  hw/i386/intel_iommu_internal.h |  3 +++
>  include/hw/i386/intel_iommu.h  |  2 ++
>  3 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1c1eb7f..33be40c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3078,7 +3078,7 @@ static Property vtd_properties[] =3D {
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
> @@ -3708,8 +3708,11 @@ static void vtd_init(IntelIOMMUState *s)
>      }
> =20
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. =
*/
> -    if (s->scalable_mode) {
> +    if (s->scalable_mode && !s->scalable_modern) {
>          s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +    } else if (s->scalable_mode && s->scalable_modern) {
> +        s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
> +                   | VTD_ECAP_FLTS | VTD_ECAP_PSS;

This patch might be good to be the last one after all the impls are
ready.

>      }
> =20
>      vtd_reset_caches(s);
> @@ -3845,6 +3848,26 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
Error **errp)
>          return false;
>      }
> =20
> +    if (s->scalable_mode_str &&
> +        (strcmp(s->scalable_mode_str, "modern") &&
> +         strcmp(s->scalable_mode_str, "legacy"))) {
> +        error_setg(errp, "Invalid x-scalable-mode config");

Maybe "..., Please use 'modern', 'legacy', or 'off'." to show options.

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
> index 862033e..c4dbb2c 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -190,8 +190,11 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
>  #define VTD_ECAP_SRS                (1ULL << 31)
> +#define VTD_ECAP_PSS                (19ULL << 35)
> +#define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
>  #define VTD_ECAP_SLTS               (1ULL << 46)
> +#define VTD_ECAP_FLTS               (1ULL << 47)
> =20
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 8571a85..1ef2917 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -244,6 +244,8 @@ struct IntelIOMMUState {
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


