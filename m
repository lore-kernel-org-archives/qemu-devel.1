Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F6BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8202147A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWMspbzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8202147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hue9I-0004Qe-5Z
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hue8o-0003tR-6e
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hue8n-0001Cu-34
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:39:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hue8m-0001CD-T5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:39:13 -0400
Received: by mail-oi1-x243.google.com with SMTP id t76so62226370oih.4
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YzbjEHeA4M4mezodUhb4QRSd2I0FmgU9srKk2gg6Vo0=;
 b=RWMspbzTzY8NK68dHzwoXneTOmV0Ug6jOi00qd1xko2NktNyuWsbx6rzMT0DnAcF2i
 Ap7PghLWtW45ASHLvCZq3bAF+NtvFD70R8YPJ4XEGsovmhJ3APZpQvWUjWvBLttL2aov
 VhGTjcPanWUw2vTXXcV6NtHMEogaUjqEGP6q18pt/neFZ6IwkCjrQx1ZJ1+4GlSeLqNq
 tHL3I+6tE/9TgI6XkYpckKeuwNwjaz40to3gWRgcVwB+0anC4EN9av9e2AVtq0aT5h21
 ExOnsFKFbJ9Dvz2491vu8lDDQvpIRRzqQpZJcVQtH4e0fjQ1nGUFRsstc75XER+eWyr3
 Viag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YzbjEHeA4M4mezodUhb4QRSd2I0FmgU9srKk2gg6Vo0=;
 b=lMNBb38M3S7iFXYEIDTbEHU1SJ4nKNimCU93FwF6LmYjLtlZe3ukMLpV5K78mNkz2C
 L7ONzyYINpQDemSMY35+QxtNcFwzLBMSxBNwC5HSJef/No6J0ewe1XrE5t/C87xIQWmA
 juZOBcTKErJegqnN4fN1GViubvGy0ndSLl46OZQPFgX9w4Ep/8A9pVSL3b7D9/8hqWFz
 HdLrvMu1SleXErS4NB7b4qAqe7YMuF875a079N8pzTTRWO30FK2IuAzl3fCoChFMuILh
 2rDJ+gHZW+MhdPhkN17935hR6LWtMCFZN90QfZrk8LZQmQ50uBdQlocqTXvX9ACTORmC
 187w==
X-Gm-Message-State: APjAAAUEB40ocZ9QNjpCtqL4gYplmPSB6E5pkUnzE35m0gAmZhXDGFvW
 h++XBn+JWDjxv4q+uGTUiHloGSy2F59WvAcsCFPYhQ==
X-Google-Smtp-Source: APXvYqysuGAsbCo6h27jo+D700yRPdB3jwzlv9kluWTNApyAXnbregC/+kDNoCkSjHHf/gW+aPRPV/wBIpEaUx2CX/8=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr11031304oie.48.1565015951817; 
 Mon, 05 Aug 2019 07:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190711061857.13086-1-eric.auger@redhat.com>
 <20190711061857.13086-6-eric.auger@redhat.com>
In-Reply-To: <20190711061857.13086-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 15:39:01 +0100
Message-ID: <CAFEAcA_N=7w6XHU4H3uJhLFZuiFgpQhN--=ixUV7z6bvzkwqfQ@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v3 5/5] hw/arm/smmuv3: Remove
 spurious error messages on IOVA invalidations
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
> An IOVA/ASID invalidation is notified to all IOMMU Memory Regions
> through smmuv3_inv_notifiers_iova/smmuv3_notify_iova.
>
> When the notification occurs it is possible that some of the
> PCIe devices associated to the notified regions do not have a
> valid stream table entry. In that case we output a LOG_GUEST_ERROR
> message, for example:
>
> invalid sid=<SID> (L1STD span=0)
> "smmuv3_notify_iova error decoding the configuration for iommu mr=<MR>
>
> This is unfortunate as the user gets the impression that there
> are some translation decoding errors whereas there are not.
>
> This patch adds a new field in SMMUEventInfo that tells whether
> the detection of an invalid STE must lead to an error report.
> invalid_ste_allowed is set before doing the invalidations and
> kept unset on actual translation.
>
> The other configuration decoding error messages are kept since if the
> STE is valid then the rest of the config must be correct.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3-internal.h |  1 +
>  hw/arm/smmuv3.c          | 15 ++++++++-------
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b160289cd1..d190181ef1 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -381,6 +381,7 @@ typedef struct SMMUEventInfo {
>      uint32_t sid;
>      bool recorded;
>      bool record_trans_faults;
> +    bool inval_ste_allowed;
>      union {
>          struct {
>              uint32_t ssid;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2e270a0f07..517755aed5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -320,7 +320,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>      uint32_t config;
>
>      if (!STE_VALID(ste)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
> +        if (!event->inval_ste_allowed) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
> +        }

Here the new flag check just suppresses the error log...

>          goto bad_ste;
>      }
>
> @@ -405,7 +407,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>
>          span = L1STD_SPAN(&l1std);
>
> -        if (!span) {
> +        if (!span && !event->inval_ste_allowed) {
>              /* l2ptr is not valid */
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "invalid sid=%d (L1STD span=0)\n", sid);

...but here it suppresses both the error logging and also
the setting of event->type and returning -EINVAL. Instead
we'll fall through to the following code. Is that really OK?

thanks
-- PMM

