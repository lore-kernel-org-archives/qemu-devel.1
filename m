Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F2C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11594216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11594216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhBu-0004YQ-90
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 23:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hkffv-0008LX-N8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hkffu-0003cU-E2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:16:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hkfft-0003Zc-6A
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:16:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so8482428pfe.11
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 19:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AejX9I0nPw0C0alAPdpDESjIN8ZZo4n3Ywa8AB9AMrA=;
 b=I2RorO9TEPoyWGC6ocQaqSo7jiDUgr5xSSwG6Negr6te7xMMIJbPm/OKm7Qtq3s3cR
 I6NA5piE4FbiHyu0G7fcwih+wah3Rac1IWZ7vRK7gA28i2A8UDfK/nZI2/93BxKpHWq3
 1Yw89IehoqjjpwNwTZgNcl9/45B2ePpfpyhP6Pvrz/vm3ZOkin37JZ/eGGxAZSCM+MXJ
 joxdXBNGodSCRDaQ0YcWOmC8L52esFA8p29TZBsJrWP3LndtZ2MejeNUEn033oVYK8cl
 r7Qt05iYtvGr8E2FePb6cE1PySy4Lnk2KX2hsis9Z0TTNOtEnXByp9P1CXHyU5GsqTtE
 lftg==
X-Gm-Message-State: APjAAAUS25FscsryozxzzmUBw+BE8WFpIcuJVC6G++6ukWe3q+LSySGr
 /5ohmstLB7VV3j61IBefw88VXA==
X-Google-Smtp-Source: APXvYqwiHBXdfW1lQRsPP9qtg3vYT14hpbHkuAdm3AVWoWrwhMRY7huqrXfHQq6nGgsXieZZDbWI9w==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id
 o14mr30006833pjq.142.1562638566419; 
 Mon, 08 Jul 2019 19:16:06 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm19146288pfw.33.2019.07.08.19.16.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 19:16:05 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 9 Jul 2019 10:15:54 +0800
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190709021554.GB5178@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-5-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562324511-2910-5-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
X-Mailman-Approved-At: Mon, 08 Jul 2019 23:51:52 -0400
Subject: Re: [Qemu-devel] [RFC v1 04/18] intel_iommu: add "sm_model" option
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 07:01:37PM +0800, Liu Yi L wrote:
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of
> capabilities related to scalable mode translation, thus there
> are multiple combinations. While this vIOMMU implementation
> wants simplify it for user by providing typical combinations.
> User could config it by "sm_model" option. The usage is as
> below:
> 
> "-device intel-iommu,x-scalable-mode=on,sm_model=["legacy"|"scalable"]"

Is it a requirement to split into two parameters, instead of just
exposing everything about scalable mode when x-scalable-mode is set?

> 
>  - "legacy": gives support for SL page table
>  - "scalable": gives support for FL page table, pasid, virtual command
>  - default to be "legacy" if "x-scalable-mode=on while no sm_model is
>    configured
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/i386/intel_iommu.c          | 28 +++++++++++++++++++++++++++-
>  hw/i386/intel_iommu_internal.h |  2 ++
>  include/hw/i386/intel_iommu.h  |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 44b1231..3160a05 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3014,6 +3014,7 @@ static Property vtd_properties[] = {
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> +    DEFINE_PROP_STRING("sm_model", IntelIOMMUState, sm_model),

Can do 's/-/_/' to follow the rest if we need it.

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -3489,6 +3490,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      return;
>  }
>  
> +const char sm_model_manual[] =
> +        "\"-device intel-iommu,x-scalable-mode=on,"
> +        "sm_model=[\"legacy\"|\"scalable\"]\"\n"
> +        " - \"legacy\" gives support for SL page table based IOVA\n"
> +        " - \"scalable\" gives support for FL page table based IOVA and SVA\n"
> +        " - default to be \"legacy\" if \"x-scalable-mode=on\""
> +        " while no sm_model is configured\n";
> +
>  /* Do the initialization. It will also be called when reset, so pay
>   * attention when adding new initialization stuff.
>   */
> @@ -3557,9 +3566,26 @@ static void vtd_init(IntelIOMMUState *s)
>          s->cap |= VTD_CAP_CM;
>      }
>  
> +    if (s->sm_model && !s->scalable_mode) {
> +        printf("\n\"sm_model\" depends on \"x-scalable-mode\"\n"
> +               "please check if \"x-scalable-mode\" is expected\n"
> +               "\"sm_model\" manual:\n%s", sm_model_manual);
> +        exit(1);

Let's avoid calling exit() directly considering that we've had things
like vtd_decide_config() already which allows an Error**.  We can also
introduce that too into vtd_init() and pass the error to upper to
handle the failure.

> +    }
> +
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. */
>      if (s->scalable_mode) {
> -        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +        if (!s->sm_model || !strcmp(s->sm_model, "legacy")) {
> +            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +        } else if (!strcmp(s->sm_model, "scalable")) {
> +            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
> +                       | VTD_ECAP_FLTS;

Do you also need VTD_ECAP_SLTS here?

> +        } else {
> +            printf("\n!!!!! Invalid sm_model config !!!!!\n"
> +                "Please config sm_model=[\"legacy\"|\"scalable\"]\n"
> +                "\"sm_model\" manual:\n%s", sm_model_manual);
> +            exit(1);

Same here.

Thanks,

> +        }
>      }
>  
>      vtd_reset_caches(s);
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c1235a7..adae198 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -190,8 +190,10 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
>  #define VTD_ECAP_SRS                (1ULL << 31)
> +#define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
>  #define VTD_ECAP_SLTS               (1ULL << 46)
> +#define VTD_ECAP_FLTS               (1ULL << 47)
>  
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 12f3d26..b51cc9f 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -270,6 +270,7 @@ struct IntelIOMMUState {
>      bool buggy_eim;                 /* Force buggy EIM unless eim=off */
>      uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
>      bool dma_drain;                 /* Whether DMA r/w draining enabled */
> +    char *sm_model;          /* identify actual scalable mode iommu model*/
>  
>      /*
>       * Protects IOMMU states in general.  Currently it protects the
> -- 
> 2.7.4
> 

Regards,

-- 
Peter Xu

