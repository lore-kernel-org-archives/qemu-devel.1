Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EAEC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857252075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqHE+bAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857252075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrth-0003hv-7H
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqp5-0007ng-UK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqp4-0000WZ-IU
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:02:15 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDqp4-0000WM-BC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:02:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id m16so5286608oic.5
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JNdVUv0zNXaOfCb4Gice9wMOQgdLgAnNhUj5m0MnIEY=;
 b=nqHE+bAYeccazvFVv4LtPzdLNeAZIaYIXaJeBGsztk/vijCrzp/x4/pOciFBNgWWty
 srCZWTEAJBBNAJbLoeqzhSTC8Ysao60knw8aGhi7JKL0NonKmbNeDDYt9xlLfeYheH3W
 Ik+SxOBPsV+IASTgEq6dYZOg51EBiqjUIsWOy9zr37Rhb56dB/gMHLHDe0vTmT13vJJk
 pMYt5c2m+c6jlRfO03Ea7rZp6vWsX20ovbG4Ujd4tQGvtWaI5RqtuZTUCG0ta2rzAzUI
 XAeLYq+FYk7FbxUNu8ekRv5b8LBENW7U5YgNzNMaxtw6K9w8PA9wdWykZM3JjBoOvYz5
 rASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JNdVUv0zNXaOfCb4Gice9wMOQgdLgAnNhUj5m0MnIEY=;
 b=UTuunKqlAAg33BP2DQGuGWJG7XrbB42CYanZXnGsOSmZLvQ5HgV3g0ftz+QbS7ZdHH
 zvWVrjTGJptlE4XI9g01cEEiUQU2ldsZPzclLAdxomnbpLKvyjeMn113hPYy02Fgd/VH
 IKwX/OIy9s2vpzhpN+rG8dvTMtr0mUpaITX8NhFYPvScfvoxZsCaLYRhIxuKmCGpQ1/E
 waaL80q9VPgDXGC1qJhQm9X8QH1jW6wxT1PcSRGHUyxa7qatlYEHOI7yMeAj583YubQN
 7lMgrQ1dzHS/nJdoCIuNyZ3M3ymIQSRquTpK9xYE4WootIKQyc6GTQrI/PPRD2PI/s0u
 gBqg==
X-Gm-Message-State: APjAAAUU/nsB7cVwpXLYkdUGJjRiQtf2gukB0qbJEkia194v7GWlnqXZ
 6xea3X+AT6viuVGKQCkdaT4tJvjDJYiwhL+HbXE/aA==
X-Google-Smtp-Source: APXvYqwr6tN8GXFQ7CSFaOjf/oLfGBMHKVf8cyd/Pii9KiQZKSXzWNxCXSDpmv1EfcdURgP92oDDz5CwwTPlogBzkDA=
X-Received: by 2002:aca:b646:: with SMTP id g67mr7302016oif.163.1569592933016; 
 Fri, 27 Sep 2019 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-2-zhengxiang9@huawei.com>
In-Reply-To: <20190906083152.25716-2-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 15:02:02 +0100
Message-ID: <CAFEAcA9cQwAJfPBC9fRcxLZVzZqag0Si62nTBNwDPyQiPVwPcg@mail.gmail.com>
Subject: Re: [PATCH v18 1/6] hw/arm/virt: Introduce RAS platform version and
 RAS machine option
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Support RAS Virtualization feature since version 4.2, disable it by
> default in the old versions. Also add a machine option which allows user
> to enable it explicitly.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  hw/arm/virt.c         | 33 +++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  2 ++
>  2 files changed, 35 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d74538b021..e0451433c8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1783,6 +1783,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
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
> @@ -2026,6 +2040,19 @@ static void virt_instance_init(Object *obj)
>                                      "Valid values are none and smmuv3",
>                                      NULL);
>
> +    if (vmc->no_ras) {
> +        vms->ras = false;
> +    } else {
> +        /* Default disallows RAS instantiation */
> +        vms->ras = false;
> +        object_property_add_bool(obj, "ras", virt_get_ras,
> +                                 virt_set_ras, NULL);
> +        object_property_set_description(obj, "ras",
> +                                        "Set on/off to enable/disable "
> +                                        "RAS instantiation",
> +                                        NULL);
> +    }

For a property which is disabled by default, you don't need
to have a separate flag in the VirtMachineClass struct.
Those are only needed for properties where we need the old machine
types to have the property be 'off' but new machine types
need to default to it be 'on'. Since vms->ras is false
by default anyway, you can just have this part:

> +        /* Default disallows RAS instantiation */
> +        vms->ras = false;
> +        object_property_add_bool(obj, "ras", virt_get_ras,
> +                                 virt_set_ras, NULL);
> +        object_property_set_description(obj, "ras",
> +                                        "Set on/off to enable/disable "
> +                                        "RAS instantiation",
> +                                        NULL);

Compare the 'vms->secure' flag and associated property
for an example of this.

>      vms->irqmap = a15irqmap;
>
>      virt_flash_create(vms);
> @@ -2058,8 +2085,14 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
>
>  static void virt_machine_4_1_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_4_2_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
> +    /* Disable memory recovery feature for 4.1 as RAS support was
> +     * introduced with 4.2.
> +     */
> +    vmc->no_ras = true;
>  }
>  DEFINE_VIRT_MACHINE(4, 1)

thanks
-- PMM

