Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29EEC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE4F2071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gX4AoLyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE4F2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqLy-0002Sv-FB
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibqKy-0001JK-Rh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibqKx-0006aK-PG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:22:20 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibqKx-0006ZF-BY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:22:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id j22so541430oij.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mt0ebUCDlDgmkudTT+9hpvbvHuHkrX1tE7sw2iHLAt8=;
 b=gX4AoLyXiyO1zwgoVhMLAVZUSrYejSWLpTUCSkiBTM8KIGfGghefVqaLWftqvuy6Pj
 4cuuh7ZuMbET9+Psx6/a854XuTdb/FIimeOv+hyIlMgKru2Z+gmys48h3M6bpd7qoo9S
 ofXdaDOv6K9Q7aqJGX5dIVqwOB1BkpeOLnfajgNaAq1lWHNwWHsbeX+qxUNwQrkaw7IV
 l0OBLF0KkTk+meKSgsBIoP0zg7mpiUegHM17p6gMhQsXdFTLCF/wxtN3J6eKS2ec8jk2
 4TBtpVV9N/go9/UjgELqSmmQAQ9rNqyRMUgByISLZIzK99yXgFdKnM4GqV1aZa/UWhH4
 j7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mt0ebUCDlDgmkudTT+9hpvbvHuHkrX1tE7sw2iHLAt8=;
 b=MgvcOMmFL2KTRhUF4tPFbqLiHMQHXaj7LoZsBaL+jkpkpHvqij8pxtcPdXs1dh6WIv
 St68H0R4w2JBhRRsUCB/P4AYUWcZePquxJn43BEo2cCs7fm8yzBb9P9B6/GrLz8iJh/4
 wgXXGBri+R2S76Zuv3myEhpkDMN9LwAq9pmA/nNG5x0TU2MQ1yySyHn+Dw64RdO9M438
 ahJmiv/hQ34dhMse+WsT4ucgY0P/A6I8seUA2iFjIU8sLhIqqW1+v2qtPtLeGh2q59Zz
 9nUiGbUIElsgoR08m3eTp4DxGkWyfatYcHtnV2EpldlvrRvpLkUmAWr3z+kAk5AeZqqJ
 eaug==
X-Gm-Message-State: APjAAAWHEL3/JHQWSLGoU65NyktEo8aB1oXVEUdelNDKSNQAenFMzcVE
 2YDnY9KqZvzRfm1Jh1uxtHIOpDZPqgCiaImyfhiABQ==
X-Google-Smtp-Source: APXvYqyf9UhXEkFzj9oRHoU3UbqvOfk+HCMVWPzXh2Pv1uoa+7cfVmqFdqUILIrrmurrCqbtkC4dtlXxj6WLaa0+9Hc=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr315133oia.146.1575310938470; 
 Mon, 02 Dec 2019 10:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-2-zhengxiang9@huawei.com>
In-Reply-To: <20191111014048.21296-2-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 18:22:07 +0000
Message-ID: <CAFEAcA8fkc+0RhOH7780sREPUOaCvE-rpUkwFN0-hwsVD7RiMg@mail.gmail.com>
Subject: Re: [RESEND PATCH v21 1/6] hw/arm/virt: Introduce a RAS machine option
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 at 01:44, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> RAS Virtualization feature is not supported now, so add a RAS machine
> option and disable it by default.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  hw/arm/virt.c         | 23 +++++++++++++++++++++++
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d4bedc2607..ea0fbf82be 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1819,6 +1819,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>      vms->its = value;
>  }
>
> +static bool virt_get_ras(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    return vms->ras;
> +}
> +
> +static void virt_set_ras(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    vms->ras = value;
> +}
> +
>  static char *virt_get_gic_version(Object *obj, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
> @@ -2122,6 +2136,15 @@ static void virt_instance_init(Object *obj)
>                                      "Valid values are none and smmuv3",
>                                      NULL);
>
> +    /* Default disallows RAS instantiation */
> +    vms->ras = false;
> +    object_property_add_bool(obj, "ras", virt_get_ras,
> +                             virt_set_ras, NULL);
> +    object_property_set_description(obj, "ras",
> +                                    "Set on/off to enable/disable "
> +                                    "RAS instantiation",
> +                                    NULL);

I think we could make the user-facing description of
the option a little clearer: something like
"Set on/off to enable/disable reporting host memory errors
to a KVM guest using ACPI and guest external abort exceptions"

?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

