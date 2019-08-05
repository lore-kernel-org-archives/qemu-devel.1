Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D1DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEEF20644
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjk6tF00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEEF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hueBd-0007bd-08
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hueBE-00075q-59
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hueBD-0002Yu-7i
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:41:44 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hueBC-0002YW-VQ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:41:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so79480932otq.6
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zUOYRM1EOhdMiSMBt/ZvivXhL3kt1XZhGVCOp5W+Bk0=;
 b=vjk6tF00pSzrwmPLNOxLjRHejSjVpHk4nnPqrziQ+UEmMaHDt5XRVRGv0qYPplpRGo
 P8k2+f8Z5LDIWgW9uIcrkcC0w6h+I655eqFbQc+iooYaEkHuND9o0/c/kZYn99L5rjRQ
 HXE/s1MRLKY4HQbdNpPr3ljeB5s5NqVZJaVTHrok11OKESah/96N/AycMEo/iqbZQ7Mj
 5O274lHSoMDO15moPWQscSnYhGEuiIs/s7/EYlW8lNn1iQLeOBt2nQx/M86lUeEhDkr0
 PGiHi152RWuH4CeOf8GvZeQ1ehmvY3Au4jeB34f4286xJuR8Rg5jtUFxftvZFyW9mDLb
 DcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zUOYRM1EOhdMiSMBt/ZvivXhL3kt1XZhGVCOp5W+Bk0=;
 b=iIaGiVgk7Juc3b3TPG5ma/mFXBXZzQRmG3pT9MklY4BJv83+Z/Bh+x1hnAZSXYk/0j
 +QU6BS6UaH+ti0xlRz3P0xy0TxTKMq1LHIHjWXVpanuBIvel3EmiOZNkG0T0SmsYuvby
 LMvE6y/zer7ummNx2HPmHR/La1HOiNEDVNRaUDqNtb9DKLZntWIPHCedI2DTfxsXhfjW
 EpGi+egSj5N8emVy0et5QwLl3N5J2jhaUG+HVrp/rpC8pheY/LmriBt5k0iXUPKqtDYf
 o3DVXzSRFgE+kKDHJfgQYV8exPZTYW7EB+A6H/IR19dADxQBgijFR6LVQ6MtT8nbuxxJ
 ZZEA==
X-Gm-Message-State: APjAAAVab6B5BBdbV1fFRj1oglm9uzTqxh2B7HQojuxjyUCUrvx+idlP
 9ZRyNPfLmHW8oCFrvvtswMXkNjYQfzJGPFSwXhJ0JA==
X-Google-Smtp-Source: APXvYqwrDMivYx3Kz8u5oMeKRBmjLUfCTmQ0cJcONooop+TT7QtGNq6VOWy8wCaQ5hpjIAk+615OnPj8euTYqRyx4cc=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr85032806otn.135.1565016102060; 
 Mon, 05 Aug 2019 07:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190711061857.13086-1-eric.auger@redhat.com>
 <20190711061857.13086-4-eric.auger@redhat.com>
In-Reply-To: <20190711061857.13086-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 15:41:31 +0100
Message-ID: <CAFEAcA_=Rz5f8RvZU7kjKXhM5sHKFDujoMRTuzanrauP3ChPVA@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v3 3/5] hw/vfio/common: Assert in
 case of nested mode
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 07:19, Eric Auger <eric.auger@redhat.com> wrote:
>
> As of today, VFIO only works along with vIOMMU supporting
> caching mode. The SMMUv3 does not support this mode and
> requires HW nested paging to work properly with VFIO.
>
> So any attempt to run a VFIO device protected by such IOMMU
> would prevent the assigned device from working and at the
> moment the guest does not even boot as the default
> memory_region_iommu_replay() implementation attempts to
> translate the whole address space and completely stalls
> the execution.
>
> So let's assert if we recognize nested mode case.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index a859298fda..d622191fe6 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -604,9 +604,17 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      if (memory_region_is_iommu(section->mr)) {
>          VFIOGuestIOMMU *giommu;
>          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> +        bool nested;
>          int iommu_idx;
>
>          trace_vfio_listener_region_add_iommu(iova, end);
> +
> +        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
> +                                          (void *)&nested) && nested) {
> +            error_report("VFIO/vIOMMU integration based on HW nested paging "
> +                         "is not yet supported");
> +            abort();
> +        }
>          /*
>           * FIXME: For VFIO iommu types which have KVM acceleration to
>           * avoid bouncing all map/unmaps through qemu this way, this

Other failure paths in this function mostly seem to do an
error_report() and return (apart from the one call to hw_error()
at the bottom of the function). Is an abort() OK here?

thanks
-- PMM

