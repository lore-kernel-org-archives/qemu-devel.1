Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D09C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C150621582
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ze19MaB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C150621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8OZ-000209-S2
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is8Fh-0005Ac-Hs
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is8Fg-0000G6-DJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:44:13 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is8Fg-0000F0-7R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:44:12 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so19413029oif.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 08:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nbt9ZpWqqdD6vIQRKy1qyLMQca6b/HxDSA+FsokmcTw=;
 b=Ze19MaB/y1XsL4yRJAYS7+aOJ29PUXv+3+2hmEqRDnag03+g1ye3cgUk7xQcL0z7Pf
 TlNX68znKCEYKCfow5hxU6VaTzw1i6KdPA/nB9h2H2P8z8BO0CncLNsMvxjdPU8QI0Cu
 AWKu15pI+kuTXZKA9AJtmfk6xPJIOrxvOsMA+ATDNwHDvqT8BxqsAN1uo0ANE/q6gWzY
 ANkjYzCzeq7V/JsFD8tay9ko/THXZO6gxV8rxKD4BZ1Jp+dISbjr1Sn9LfpfCZK3E1Pu
 7gXzmonJl+xa8QW281fmbxr9EhWik8NrHPvDiIkmm8AxdxGUfP6Ffg2qpDOtLbCI5RO0
 Ii5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nbt9ZpWqqdD6vIQRKy1qyLMQca6b/HxDSA+FsokmcTw=;
 b=gc5J7XzAtZCSnSbrhmDoNuuSvw1afaNRB2mDbaQE6Rvli7OwPOcgVdxQKElfJssjwv
 XvVXPHCTwya/WYoX444oAVd/rULXSwxRWdWrnhTo+0u0bkWXUejcTWQS/vDWAH3RDYiJ
 elUnMtp97W1S5RV3gnRO8gv3NAhMaG7sXf+1BdVtiLyN9jKRJzx5wklstiABUfXRwj2x
 uIFpac6FnEaH2UzD5aPk+0kN2z/FEwRhTwMFljUOEfm4JDQWQbTQr/M84QMDqX4CO5XN
 bWstEgFeLP1FqgDBQEjo4eF6u/koMz1SOO0TPTfMnw78+ZnaUSLfBERoZVPMgoi1Cn6r
 PrfA==
X-Gm-Message-State: APjAAAWGmjy6OyFAubLg2SPe48Uur3B2qzLFGPBchHSQdoKczl16BWll
 SRlnuoigPDCiSoQU9sJZa05MnsheXLNoS6VHnBk7IA==
X-Google-Smtp-Source: APXvYqy2Ea0ZSpaXvRx0kSDWa4cAPhZR203J8lHCxJ4EET5zN+o2QBNrDh+pFMTnItNoG/JnqzuXjV62Cr3+/XULQqo=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr4860165oig.163.1579193051335; 
 Thu, 16 Jan 2020 08:44:11 -0800 (PST)
MIME-Version: 1.0
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 16:44:00 +0000
Message-ID: <CAFEAcA9z9KDHmvh6WsrCPj_FTvNmOfhatxNQDftNG+ZKZN0wAA@mail.gmail.com>
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 11:33, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> Record the GHEB address via fw_cfg file, when recording
> a error to CPER, it will use this address to find out
> Generic Error Data Entries and write the error.
>
> Make the HEST GHES to a GED device.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  hw/acpi/generic_event_device.c         | 15 ++++++++++++++-
>  hw/acpi/ghes.c                         | 16 ++++++++++++++++
>  hw/arm/virt-acpi-build.c               | 13 ++++++++++++-
>  include/hw/acpi/generic_event_device.h |  2 ++
>  include/hw/acpi/ghes.h                 |  6 ++++++
>  5 files changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 9cee90c..9bf37e4 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -234,12 +234,25 @@ static const VMStateDescription vmstate_ged_state = {
>      }
>  };
>
> +static const VMStateDescription vmstate_ghes_state = {
> +    .name = "acpi-ghes-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),
> +        VMSTATE_STRUCT(ged_state, AcpiGedState, 1,
> +                       vmstate_ged_state, GEDState),
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_ghes_state, AcpiGhesState),
>          VMSTATE_END_OF_LIST(),
>      },
>      .subsections = (const VMStateDescription * []) {

You can't just add fields to an existing VMStateDescription
like this -- it will break migration compatibility. Instead you
need to add a new subsection to this vmstate, with a '.needed'
function which indicates when the subsection should be present.

thanks
-- PMM

