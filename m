Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF1822293
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6E6UjPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF1822293
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNoN-0005i3-KJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNnv-000527-RW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNnu-0001PJ-N4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:24:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNnu-0001Oj-I0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:24:42 -0400
Received: by mail-ot1-x343.google.com with SMTP id j11so5438696otp.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YdkekqoaTpJxIRdIwiyZhbH3wPAqKNGC2ktF0UKNBVs=;
 b=r6E6UjPeYTxu7lDh1PnHIGhkvyjHEuNLUpklCf2DrtvDLp31pth6VTRPs4hDn5uRbK
 BwQ23dlE93x0BEQV4xDgImr883j2gHnXPbrQQcTI2n+7TtzCegdcxkOt9MbetsaLX8A3
 kyCdAUSlKX+MB/U4bLd88Nc9wSbW9+uzq/P2uFT0qTvDT+rDDazF5tMVkDgNT0l3IIaC
 ipeFrqthO5vQ1dujfzsp79PdiQwvN5aSMHrkGRGWIFPwOQ3lZLPZiT85saisz9VOINdg
 eOELN7TWkN9j2KNbVIUcVu5bYXm8+gl1Ng9aK/0vDm4Tskkxy7XfcXLm2yV+SYqkCrZ7
 nn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YdkekqoaTpJxIRdIwiyZhbH3wPAqKNGC2ktF0UKNBVs=;
 b=NtfNTswTrabwA0o5OXqssmQaKOo8rJzxgnXKiuTWOVMT7zpsUBXksqyZ0ZdUwzu+Bs
 429pO49s0ANzwB/ZXWGPtmHBZOF2v6jDc2BqNfnNIrfolkqWUMMOF46ADko4yWth4YcQ
 z2mwi0DufH2LpCjKeAOuNYndJuN9sUzah5NOrgWMHwte7qKJ++uUh3bV+AmhPLRY3jqy
 /MihR3Z4KBcBlhCETRTcDGjQS3FURi32GfG6wIT2giM0tZCYSqUfuUQE7/BlsDYS5gZk
 10Js0FnwpOdEH4FCnykQv3Oj/PPmgfxSinlUB0WAyzES+wwLRvkDh8zQiJOdTmbO+udm
 5hFw==
X-Gm-Message-State: APjAAAXfbjjlt0uaEgTcACUxIz7sOO7CT2tirWtiu0LMvhfqgKfloDcH
 k1NtT8TBdafDD/Px7juPSz8gatAA56Mxeey0azqIpg==
X-Google-Smtp-Source: APXvYqyTM5u+KrbfvWejxV5Uz7oWwIdFuTddvMaTu4yD3BQ7ncV8JzV/2DiKwnoA//6mztXYD7Lk3D6DTuItVHYcJcE=
X-Received: by 2002:a6b:5103:: with SMTP id f3mr9695959iob.142.1565191481717; 
 Wed, 07 Aug 2019 08:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-12-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-12-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:24:30 +0100
Message-ID: <CAFEAcA-WPX153SSC-M6y8LLzO86GaPvxATo1hu4e-UzkH8MXRg@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 11/33] hw/s390x/ipl.c: remove
 qbus_reset_all registration
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Replace deprecated qbus_reset_all by resettable_reset_cold_fn for
> the ipl registration in the main reset handlers.
>
> This does not impact the behavior.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/s390x/ipl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 60bd081d3e..402770a2c9 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -234,7 +234,11 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>       */
>      ipl->compat_start_addr = ipl->start_addr;
>      ipl->compat_bios_start_addr = ipl->bios_start_addr;
> -    qemu_register_reset(qdev_reset_all_fn, dev);
> +    /*
> +     * TODO: when we add some kind of main reset container / domain
> +     * switch to it to really benefit from multi-phase.
> +     */

I think this comment misses the mark a bit. Here's my suggestion:

/*
 * Because this Device is not on any bus in the qbus tree (it is
 * not a sysbus device and it's not on some other bus like a PCI
 * bus) it will not be automatically reset by the 'reset the
 * sysbus' hook registered by vl.c like most devices. So we must
 * manually register a reset hook for it.
 * TODO: there should be a better way to do this.
 */

> +    qemu_register_reset(resettable_reset_cold_fn, dev);
>  error:
>      error_propagate(errp, err);
>  }
> --
> 2.22.0
>

thanks
-- PMM

