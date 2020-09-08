Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E221C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6C72078B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2bFdz0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6C72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFezw-0008G9-IA
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFezK-0007SC-Vq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:52:50 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFezJ-0002DQ-8z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:52:50 -0400
Received: by mail-ej1-x644.google.com with SMTP id j11so23048824ejk.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GezjhMinrKGuK08uJoVyOZMTK6mhnTZ5YhOgEQjyS+E=;
 b=q2bFdz0m07SmMBBIl98ZaJqtC0JFuf9J7jTLs+LyhZl7vU/VmzREG7vYE8hShsuykA
 32EaZiKW9I9tM6yA8r9o69f5elWuXwwsxo/9LUVQvz6T7HjLE4Gk4WJCHZt5OP6a0Q4n
 2P5LkxcgWxKkzsKPtcwggh2xhbjlMQVmiI9Ie6Br2FxWMSR5h/4x4JUlgp5OzHAEEUt/
 2muvNpCSWrgK/xvVr+SW8FkQ6jrfY/ows/0mZWhdAfvX02on2pE7dlFzKv4m7BhomGA7
 2RcMKKyPE69REuOHN/tzVb/fJX8wlWUbIgDIDu4PwZbQzQMJ3nD+dAq4LKMlPOY6Vgt6
 yRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GezjhMinrKGuK08uJoVyOZMTK6mhnTZ5YhOgEQjyS+E=;
 b=h+NcyMqmXGQ0Eoxq3q24dIdIitABeS7dquRFA0rtL2F4eS3r3sgmSC7Wb2oK/mJK2Q
 WHDo4uadha+/srqk1zHghHEoqoQId2XniNUvGpOOFabTzlkJSbdg1De91gKeM2MiF6Ws
 HYoC7HsAJze0kkgutQgqm7JmYTOm1NQFArZKcEDRkkZvTJ3SPhDYQBOJvKOYsmz9k7oW
 4MMzJl4D6YbMvRlancjF+T1sfteJWwvocjbXMyp4AGHZ5Dc0hwVfVT3MBFxaOFVM4XR2
 9EFWWV3TKIsIVkaG4s8hRSM4xhJA+S7xmzDRZ7gclvm4f+IJkBWI9i6jyWqp+SEAn3Sy
 fy0w==
X-Gm-Message-State: AOAM532vPcOCzuUemH2z6wBuw5WPRUVYJPfuWn6n81APyTiVGwOrAg1Y
 f/Nny3/tdwGimMvZ0mR8wGmpZwsXJjJjgHEBMAQScg==
X-Google-Smtp-Source: ABdhPJzLwI+21WMVHbKAEcinTkhjaDTOnsqNsMVsgHm2qkFNzwpY5ZANtRrJcsf2Yx/SBxTYgz6Cr6pxYWzfFZW7VKc=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr25815970ejr.482.1599576767432; 
 Tue, 08 Sep 2020 07:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
In-Reply-To: <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 15:52:36 +0100
Message-ID: <CAFEAcA83=4=EhtQLmGJn5Z_PVZaDyo7pMwdX-9fTVUkVKe7Acw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] riscv: Initial commit of OpenTitan machine
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 23:31, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> This adds a barebone OpenTitan machine to QEMU.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>  default-configs/riscv32-softmmu.mak |   1 +
>  default-configs/riscv64-softmmu.mak |  11 +-

Just noticed this, but:

> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> index 1ae077ed87..94a236c9c2 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -10,3 +10,4 @@ CONFIG_SPIKE=y
>  CONFIG_SIFIVE_E=y
>  CONFIG_SIFIVE_U=y
>  CONFIG_RISCV_VIRT=y
> +CONFIG_OPENTITAN=y
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> index 235c6f473f..aaf6d735bb 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -1,3 +1,12 @@
>  # Default configuration for riscv64-softmmu
>
> -include riscv32-softmmu.mak
> +# Uncomment the following lines to disable these optional devices:
> +#
> +#CONFIG_PCI_DEVICES=n
> +
> +# Boards:
> +#
> +CONFIG_SPIKE=y
> +CONFIG_SIFIVE_E=y
> +CONFIG_SIFIVE_U=y
> +CONFIG_RISCV_VIRT=y

...shouldn't the riscv64-softmmu config have CONFIG_OPENTITAN too?
The usual principle is that the 64-bit executable can run the
32-bit boards too.

thanks
-- PMM

