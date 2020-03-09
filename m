Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B526420727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2OJkH2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B526420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBITR-00077y-U7
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBISe-0006b1-4q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBISc-0002Y6-U5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:28:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBISc-0002Xn-Ob
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:28:46 -0400
Received: by mail-oi1-x242.google.com with SMTP id p125so10082797oif.10
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cfPlssygrlRP1RqqE9U9UFYMY69kVxQSNIUP9JvVdvg=;
 b=L2OJkH2USO3acp42xe0i5l+YSXk+/71fFTdqCZx1MpAwIBKkMtEzE1IFPoyEZE2Zha
 oiESSd5adLnZ5MmHi5y6go4v1S6oQsC0FsEHt+DEdPhWx/AlSkBjWzMwYPEB5uGRcYwO
 bAQt8CFUc1DEh81T1JGWuidLF+7XnWQTAWOcNJM/La5E8K6RBLxxt9xgJJe7GZoj9WYy
 J9nEjv48jONGKoPyylokgW8ZJ9YPUxygBIetiTuBw+VYVp/KJZg6hZuVC8TpuAFJanvu
 hAhgMHihjTCcUabaEVY5Df50o4FO24SvzHW8Nz0nhUuEYeynX7/tLftE8ZnZwyM2cDLH
 4dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cfPlssygrlRP1RqqE9U9UFYMY69kVxQSNIUP9JvVdvg=;
 b=BSGtZi52Zd/H7RhFwynBu0eWjm0AAAnptTBPnrPrebWablIrz3lwuhUvtcudYcqfLv
 4W++OTE8u7gCcyWX+Zh3vRiAHzeRXSqwsAVAKH2qzFo4yQI9iCH6lwZK4tWfQku56W8O
 LCZFif4QEYd1XzmvfYgJfmDQzal5zH/XAWIBKo1ImqzslRIVSmhd7dMv+ohStIbxWw3A
 KPFHJny+ToKvkaIWFZhEQkbJCDB8366Z4cjjpkEfPjmVwey/hxDAHmcIXx15/douYI4d
 GXXHVPjXUf1BBphwNpJZe3MjuhkHd+e7vcPFUjy6XvIiziiNxO7Mei2121KmiB10T+Fj
 H3ug==
X-Gm-Message-State: ANhLgQ3GaecpMcU3QQrK8BR9plAanLM/Gq5vVIk8JyOydgxs0yJeK39Q
 5zfkAtpzxTArmUFgZY8l6+9x8vpbtltT9PrT7IiHjQ==
X-Google-Smtp-Source: ADFU+vtMC1WEGFXE2Fx35PnPofuM6IkAhulbHGQu26ApZIsSNi+eVQVrDzviqGKNfWg6pdZT6vHmm4F4V3wRbvj0xFA=
X-Received: by 2002:a54:478b:: with SMTP id o11mr10839846oic.146.1583760525661; 
 Mon, 09 Mar 2020 06:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200302105516.5972-1-eric.auger@redhat.com>
 <20200302105516.5972-6-eric.auger@redhat.com>
In-Reply-To: <20200302105516.5972-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 13:28:34 +0000
Message-ID: <CAFEAcA-XD9LiokquaHj+kCYWA3N=7k3V3R8r5gA1HZM9Adus1A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
To: Eric Auger <eric.auger@redhat.com>
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
Cc: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 10:55, Eric Auger <eric.auger@redhat.com> wrote:
>
> Restructure the finalize_gic_version with switch cases and, in
> KVM mode, explictly check whether the chosen version is supported
> by the host.
>
> if the end-user explicitly sets v2/v3 and this is not supported by
> the host, then the user gets an explicit error message.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
> ---
>
> v2 -> v3:
> - explictly list V2 and V3 in the switch/case
> - fix indent
> ---
>  hw/arm/virt.c | 77 +++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 24 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index eb8c57c85e..aeb6c45e51 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1542,33 +1542,62 @@ static void virt_set_memmap(VirtMachineState *vms)
>   */
>  static void finalize_gic_version(VirtMachineState *vms)
>  {
> -    if (vms->gic_version == VIRT_GIC_VERSION_HOST ||
> -        vms->gic_version == VIRT_GIC_VERSION_MAX) {
> -        if (!kvm_enabled()) {
> -            if (vms->gic_version == VIRT_GIC_VERSION_HOST) {
> -                error_report("gic-version=host requires KVM");
> -                exit(1);
> -            } else {
> -                /* "max": currently means 3 for TCG */
> -                vms->gic_version = VIRT_GIC_VERSION_3;
> -            }
> -        } else {
> -            int probe_bitmap = kvm_arm_vgic_probe();
> +    if (kvm_enabled()) {
> +        int probe_bitmap = kvm_arm_vgic_probe();

Previously we would only do kvm_arm_vgic_probe() if the
user asked for 'host' or 'max'. Now we do it always,
which means that if the user is on a really old kernel
where the CREATE_DEVICE ioctl doesn't exist then we
will now fail if the user specifically asked for gicv2,
where previously we (probably) would have succeeded.
I don't think we should put too much weight on continuing
to theoretically support ancient kernels which we're not
actually testing against, but it does seem a bit odd to
probe even if we don't need to know the answer.

More relevant to actual plausible use cases, if
kvm_irqchip_in_kernel() == false, we shouldn't be
probing the kernel to ask what kind of GIC to use.

thanks
-- PMM

