Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B484AC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAFD20851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qof7EXzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAFD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmKq-0003Yz-KH
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbmEh-0007a7-G3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbmEf-0004fx-J7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:27:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbmEd-0004df-Mc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:27:17 -0400
Received: by mail-ot1-x341.google.com with SMTP id r6so2627935oti.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eD4fQOxTidxCf/Trml/aI+W1F9Z/xmN+T13M5Tu+r+Q=;
 b=qof7EXzq8EJoEYPIHfdfG2CkD1rq8Z+bsoFK1tO56okmj7rTT/mGUeRl42N//194WZ
 i7LCLKvxtDKPxvbN2bf64BIcRdGUbd48QuHNbbKT+jPgOWXq4Q/ES57JbGdiw5gsW+Cm
 EzTHFpXHr/sZclI2pTlb9i5b2lZKRYsJpvKCraebiBqvnIh+HL9XsQu5VYtSqP2Ppl6v
 B/ulF4GjrUVmeYQRfbxrfqq6piD4uAyy8JYo113I50hzvJ7BnBSHxVkJVUhhoSAxgZUE
 qRNfWopQwmIF+odR6dSBY//IfMf1T1GxybyTfK6EzTdizIPJ4eOokhyjDuztRMeZHr+S
 sOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eD4fQOxTidxCf/Trml/aI+W1F9Z/xmN+T13M5Tu+r+Q=;
 b=VpZaKXETYajENpkKFzcOl1DiklnoE+zoPLqGWbw9tp9BaOcV8gkbiE+loUqSU1eHIo
 VArWWUcpapwbSoJQKV8BJGs4l1KLevthoN0nMgeqOvyqUkBv9InTZh9GFnPJ84HCVVhC
 YStW/imSBaPOO5Ass6eeOIDkzr+AWhHPdzRv0oZ75lLOHTqI8OM8fr+0zni3Xqor2KIS
 8W8O2LhjyFCjUvvoBWmlK4EpgEp06RPEaac7ZZ4qJ9Fa2BqlXRCZl0sIaDfpPaId/R26
 l4LfXKwYP1ExvMRrC46u8z7jSqVBjYIwmSJLqWmQJWlNIa8cJHrU1+8bJIBEWQIhoN+P
 s5cQ==
X-Gm-Message-State: APjAAAUok9STQaorVoniOn//0f3EALz8PykhlePALIWebhgqcc9HWPYd
 nAhL0opKQtcv48zSFDHUOGAD5zzlMlSZRCAwLClkzw==
X-Google-Smtp-Source: APXvYqyTqfbnswqjv5QSOOQE8dkJq6ZNu70K9lmENaXCSlmSHPr1HIUEwr+hC4aKZk4hrvsuthuryuCLyU4Yy19SqMc=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr6111331otn.135.1560518832803; 
 Fri, 14 Jun 2019 06:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190611142821.3874-1-eric.auger@redhat.com>
 <20190611142821.3874-3-eric.auger@redhat.com>
In-Reply-To: <20190611142821.3874-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 14:26:19 +0100
Message-ID: <CAFEAcA_OYdL1TPN+OTdkZ0J2fx_4vFiXCs0fUVdGjkkMURCfZA@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/smmuv3: Implement dummy replay
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Jun 2019 at 15:29, Eric Auger <eric.auger@redhat.com> wrote:
>
> On ARM we currently do not support VFIO-PCI devices protected
> by the IOMMU. Any attempt to run such use case results in this
> kind of warning:
>
> "-device vfio-pci,host=0004:01:00.0,id=hostdev0,bus=pci.1,addr=0x0:
> warning: SMMUv3 does not support notification on MAP: device vfio-pci
> will not function properly".
>
> However this is just a warning and this should not prevent the
> guest from booting in a reasonable amount of time. This does not
> happen currently.
>
> This is due to the fact the VFIO vfio_listener_region_add() calls
> memory_region_iommu_replay(). As the SMMUv3 IOMMUMemoryRegionClass
> currently does not implement the replay() callback, the default
> memory_region_iommu_replay() implementation is used. This latter
> loops on the whole notifier's range (48b address space), translates
> each page and call the notifier on the resulting entry. This totally
> freezes the guest.
>
> The Intel IOMMU implements the replay() function which only
> notifies valid page table entries.
>
> In the looming SMMUv3 nested stage VFIO integration, there will be
> no need to replay() anything as there will not be any shadow page
> tables: the stage 1 page tables are owned by the guest.
>
> So let's implement a void replay() which satisfies both cases.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e2f07d2864..1f578365ef 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1489,6 +1489,11 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      }
>  }
>
> +static inline void
> +smmuv3_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> +{
> +}

This doesn't seem like a valid implementation of the replay
method to me. The API doc comment says
     * The default implementation of memory_region_iommu_replay() is to
     * call the IOMMU translate method for every page in the address space
     * with flag == IOMMU_NONE and then call the notifier if translate
     * returns a valid mapping. If this method is implemented then it
     * overrides the default behaviour, and must provide the full semantics
     * of memory_region_iommu_replay(), by calling @notifier for every
     * translation present in the IOMMU.

This empty function is definitely not going to call the notifier
for every IOMMU translation...

thanks
-- PMM

