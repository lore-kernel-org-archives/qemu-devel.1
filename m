Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FEBC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E1E208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMOEfXBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47RY-0001gt-4d
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j47Qk-00018y-ME
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j47Qj-0002Rf-CW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:17:10 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j47Qj-0002Pg-7K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:17:09 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so20487338otd.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1IU1z/lDGDjqG+SqTPFK48+J0dlcBWNFWyaGTdTIn+Y=;
 b=IMOEfXBW1/AymufZSCU0E1TJjvP0pdJN27cX/ER8cmeSJ+CYBHawcV4vzfJoSfZcq+
 aFurAGQETH0gKjeRXc8/B0d/DDRFTLu/kgEbTamL9RqmdasgGmRyf6rLyc48wx/TtBV9
 8Ungr/8xETk8h+YAiJYKP24ie4x7hiPsQsGHDQVs1HhU1kL1KM5aSB7L77bShp8alAsh
 4Quxkq3gZfYElzk2H6eklOCcLWOoKt9uNY9ifqUWr0tyAOLApEqkFRUHU98+WqHoCjsy
 /Bs/mOzeKK9dUxnKsZ32yj2zxQUyr8QHi3UDqbq8WzNnQCmjMi5DbCP6yWeJSpH+ISmP
 Tb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1IU1z/lDGDjqG+SqTPFK48+J0dlcBWNFWyaGTdTIn+Y=;
 b=otLI1nFtqtLP2UULFknc95xehQB4qrIYlhzLuE54K8NHu1PVkSqsH5OFntoy7HXRWq
 vDLuDxF7ALl7uJWu6v8j7Cf4x1soIdhWhV94UWnMwq61/wBKnPBS+WLCblEVGD2UUG46
 UY4keVd2bV+HqMBf9+vbZ1lBFpjA575VZLW3AZIehm96tjR8obh3gJQVP0uR959KJT8O
 1dMIfBTZXOcLCxgqiZSJYMQqfodvNnNvVMzHQ+FjDjCZWWDzJTV2zjaSO+MZgD0azHsv
 YyU6A70DiXtOLAH/1F6HIeSHog8U+zPRGqQ1ZCnN03GG6OiDhDUqQpegEBCEj4yFBEdc
 RPCw==
X-Gm-Message-State: APjAAAWkzt3bc3EcKuAoGlOQVBuwr3TR7ZDlnjGuE79ujd92gu9p/71c
 GJG16n0bZ3P1pw0Ev08DArq6q40shMfoy7WFohmbyQ==
X-Google-Smtp-Source: APXvYqwN+7gcb4hF6o+vj70HXaJHSBDOAd4/1oz5m3JpbgLNnTRP7OIxP6jy8Z6QVP+fJehLWKrPofZ4kk+X3ElmBOs=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr15946114otq.221.1582049827603; 
 Tue, 18 Feb 2020 10:17:07 -0800 (PST)
MIME-Version: 1.0
References: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1581686212-9625-3-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1581686212-9625-3-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 18:16:56 +0000
Message-ID: <CAFEAcA9Bs9VuZNstbpF6Q2=MhVDN_HHMnUdwfOJSf7Qm9to2nw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpu/a9mpcore: Add num priority bits property
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Anthony Liguori <anthony@codemonkey.ws>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 13:21, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> Set number of priority bits property of gic as guided by machine
> configuration.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/cpu/a9mpcore.c         | 2 ++
>  include/hw/cpu/a9mpcore.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
> index 1f8bc8a..eb1e752 100644
> --- a/hw/cpu/a9mpcore.c
> +++ b/hw/cpu/a9mpcore.c
> @@ -68,6 +68,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
>      gicdev = DEVICE(&s->gic);
>      qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
>      qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
> +    qdev_prop_set_uint32(gicdev, "num-prio-bits", s->n_prio_bits);
>
>      /* Make the GIC's TZ support match the CPUs. We assume that
>       * either all the CPUs have TZ, or none do.
> @@ -167,6 +168,7 @@ static Property a9mp_priv_properties[] = {
>       * Other boards may differ and should set this property appropriately.
>       */
>      DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
> +    DEFINE_PROP_UINT32("num-priority-bits", A9MPPrivState, n_prio_bits, 8),
>      DEFINE_PROP_END_OF_LIST(),

You should be able to just directly pass through the property
from the GIC object by calling
    object_property_add_alias(obj, "num-priority-bits", OBJECT(&s->gic),
                              "num-priority-bits", &error_abort);
at the end of a9mp_priv_initfn().

Then you don't need to have a DEFINE_PROP* for it, or a field in
the state struct, or manually pass the value on in realize.

(We don't do this for the existing num-irq and num-cpu properties
because in those cases this device itself needs to know the
values, as well as passing them on to other devices under it.)

thanks
-- PMM

