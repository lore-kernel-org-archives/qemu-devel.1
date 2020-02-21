Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD167C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81052073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnlJBnih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81052073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AKF-0005CF-T4
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AGm-0001ca-3D
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AGl-0003EO-2g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:31:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5AGk-0003Dw-UN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:31:11 -0500
Received: by mail-oi1-x242.google.com with SMTP id a142so1932224oii.7
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U1Bc8loQDFjm29dMTknkB+5dvxG15GcFWOZsq8q3zjw=;
 b=bnlJBnihavmyKnvky7XWfdBkN6rVSeow2KHqhBS60tykGRbCR8UDJ0Q54XOKzXfQ8V
 93VXHvy9xrPtLpKpcgto+zRmosbQ/R7gQamRQQvBU0J50uyZaJN9o9XTjfjnlMIPzAyH
 8Htn5SpL/3Dx0NexOg66zj6adwzdXi3WK4uV1TxVzSzQIYPvrNCX0w1LyAcTy/VNh1Nx
 IOajBnX7qdTD+cUObx920RE4Oe8BKTm2KmKF2aw6cqmohX79gmrT6xsY2U4E+xIiRRAT
 ZaKYywVn4/r913Ex4JJZOlRDYf9w7mSKwSNg6IURS4tVm8sxzEMUCfXRPVMK5KIamC7C
 0ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U1Bc8loQDFjm29dMTknkB+5dvxG15GcFWOZsq8q3zjw=;
 b=l50zhbJVQkVZgXtXomlEgAQOMMQD7khnDAQGa9odgZfqRuNv8DJmT6zYQbWU+YBxRD
 SAtgo2bpV/YR9CGnoRAecRBpVTxUbiNjtKW3kx3Fhc12ZPD0efL5sL9XbnQUGPjnhgra
 VisfholjDWwmb5lgQojcWffYR9fvsIZXRD7tUfOcSipWqkf9SipN/saV3ywtTnzS5gRy
 /+5UKPc2oG9lby9GcLTHAkO1NQky58TiMJGPPvLYvupKL3iMTBQTlRkIeKzxCHo9ycQA
 zlYG96ej00MDeBvT9qQWhc0FcOwr5Cc0ZPtpkmvwXemnx9hPKIhJ0HvFf19ASwktsQhF
 lcdg==
X-Gm-Message-State: APjAAAVissS3e0fq304dObAlj6kxVRwuaUAdX4WBHEQt2/7VRcbLgirG
 qPSi7soiQm7arA27WcNjOIuFy6VlnK9g2+z7CMglJA==
X-Google-Smtp-Source: APXvYqxyn2cmrtKE65AEEbfCldEVFhIJv9Bk0ca5cQmpGYqjTJAIYmkOGsMuaTpimJJZEZ/M86wN3IM2BomYewhbNLg=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2391309oic.48.1582299070080; 
 Fri, 21 Feb 2020 07:31:10 -0800 (PST)
MIME-Version: 1.0
References: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1582270927-2568-4-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1582270927-2568-4-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 15:30:59 +0000
Message-ID: <CAFEAcA9BgmTT6-1pifQhRPNyO5KVdXpdNbr0tGYF5Waw3tN3hQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpu/arm11mpcore: Set number of GIC priority bits
 to 4
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Fri, 21 Feb 2020 at 07:46, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> ARM11MPCore GIC is implemented with 4 priority bits.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/cpu/arm11mpcore.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
> index 2e3e87c..ab9fadb 100644
> --- a/hw/cpu/arm11mpcore.c
> +++ b/hw/cpu/arm11mpcore.c
> @@ -15,6 +15,7 @@
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
>
> +#define ARM11MPCORE_NUM_GIC_PRIORITY_BITS    4
>
>  static void mpcore_priv_set_irq(void *opaque, int irq, int level)
>  {
> @@ -86,6 +87,10 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
>
>      qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
>      qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
> +    qdev_prop_set_uint32(gicdev, "num-priority-bits",
> +                         ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
> +
> +
>      object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
>      if (err != NULL) {
>          error_propagate(errp, err);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

