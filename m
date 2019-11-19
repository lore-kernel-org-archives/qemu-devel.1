Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D93C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1D4208CC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1S7vm8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1D4208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1Mg-00011W-Ps
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iX1Ko-0007Vp-Lc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iX1Kn-0005uq-CT
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:06:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iX1Kn-0005ug-8H
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574161572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofQZqSqicrmFJtRYA9/SezryMiu7YHehYa6UuAtP9k0=;
 b=Y1S7vm8fnz7RYfwT130yiUfUwxDHHLMH9S2LbGQv759aCH9Tz4y8OjNznTYcBNuEla8HDh
 4CDoOqIjC+GX58uvhXmOlIvdDS845zk17qHmFmdOrsWLHK48ovpYmPbwENTgtv7bgywWFX
 800BV0OskNYi+l/eIRgxQmFV4GI09nE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-pQDWjUj9MQqR1OWYOZ54NQ-1; Tue, 19 Nov 2019 06:06:11 -0500
Received: by mail-qk1-f200.google.com with SMTP id v9so3764413qkj.14
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 03:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OeD9l2jRzgPchUHAfbtxrD2x0Nj8lU4nN4WHt6T27uQ=;
 b=WQiGl7esaPyJBLcPF+E7Twk3vpHQFT842LISD2IQNApvoSzWDGxivELxyys36JZi8c
 lohj0gGys9eILw9rTMHhOPoa6ivVfvT7CFVOGgXPlZUzH3t8rJw+M2XgprglLl83dLn4
 yfB/DvHixiLwFs5bWgpdbEL0bLYcl666jn3Cby8eqEcOXzxJc1E5DvvCrVMX+q24b+WU
 M3lYZ5PUtW8DPTZmYuJqbCv9G/NF+bPK4RBeZN8SwKMzTMzowNJVki8Ou+RXDjDf1MI8
 3VW8kz7DmQuuwnLRUC8b2oppntWnqr/MfI14QU3jNWm1QEklHyY4ymC0FGwsuAWJbY1s
 Cp0Q==
X-Gm-Message-State: APjAAAVqoOC+lGTcY4p45hexN/I5/BXy8f9qjzgqHOH0T/KXKs+fGqN6
 7LNC7pnKHxGfEB+Zz+S403SJjgq89mhJAEHzkDEzyjU7sD3lGAHzwKI2uZ7ul35H/cC1HtUOhwv
 p3E/KaPdMnqFaVUk=
X-Received: by 2002:ac8:3968:: with SMTP id t37mr31806035qtb.37.1574161570949; 
 Tue, 19 Nov 2019 03:06:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqySobgqZtW1xUFeAp2t4r//olY5/d3scz4wOhZFYOm1PMk4aWqxuKNFwYBrqYBESGDzG7aUbw==
X-Received: by 2002:ac8:3968:: with SMTP id t37mr31806013qtb.37.1574161570751; 
 Tue, 19 Nov 2019 03:06:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id h3sm12752278qte.62.2019.11.19.03.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 03:06:10 -0800 (PST)
Date: Tue, 19 Nov 2019 06:06:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH v2 2/2] intel_iommu: TM field should not be in reserved
 bits
Message-ID: <20191119060551-mutt-send-email-mst@kernel.org>
References: <cover.1570503331.git.qi1.zhang@intel.com>
 <758ae02ef3a36b2790a7e61018bb55379ceeb450.1570503331.git.qi1.zhang@intel.com>
MIME-Version: 1.0
In-Reply-To: <758ae02ef3a36b2790a7e61018bb55379ceeb450.1570503331.git.qi1.zhang@intel.com>
X-MC-Unique: pQDWjUj9MQqR1OWYOZ54NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 08:28:14PM +0800, qi1.zhang@intel.com wrote:
> From: "Zhang, Qi" <qi1.zhang@intel.com>
>=20
> When dt is supported, TM field should not be Reserved(0).
>=20
> Refer to VT-d Spec 9.8
>=20
> Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> Signed-off-by: Qi, Yadong <yadong.qi@intel.com>

OK and we want to CC stable on this I guess?

> ---
>  hw/i386/intel_iommu.c          | 12 ++++++++----
>  hw/i386/intel_iommu_internal.h | 17 +++++++++++++----
>  2 files changed, 21 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a118efaeaf..d62604ece3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3549,15 +3549,19 @@ static void vtd_init(IntelIOMMUState *s)
>       * Rsvd field masks for spte
>       */
>      vtd_spte_rsvd[0] =3D ~0ULL;
> -    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> +                                                  x86_iommu->dt_supporte=
d);
>      vtd_spte_rsvd[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
>      vtd_spte_rsvd[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> =20
>      vtd_spte_rsvd_large[0] =3D ~0ULL;
> -    vtd_spte_rsvd_large[1] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
> -    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd_large[1] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits,
> +                                                         x86_iommu->dt_s=
upported);
> +    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
> +                                                         x86_iommu->dt_s=
upported);
> +    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
> +                                                         x86_iommu->dt_s=
upported);
>      vtd_spte_rsvd_large[4] =3D VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
> =20
>      if (x86_iommu_ir_supported(x86_iommu)) {
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index c1235a7063..3a839a8925 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -387,7 +387,9 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> =20
>  /* Rsvd field masks for spte */
> -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
> +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : =
\
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> @@ -395,11 +397,17 @@ typedef union VTDInvDesc VTDInvDesc;
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : =
\
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM))=
 : \
>          (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
> +#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
> +        dt_supported ? \
> +        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM=
)) : \
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> @@ -506,5 +514,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SL_W                    (1ULL << 1)
>  #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MAS=
K(aw))
>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
> +#define VTD_SL_TM                   (1ULL << 62)
> =20
>  #endif
> --=20
> 2.20.1


