Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A093C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7181F21D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW2ew+XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7181F21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZv1K-0005jD-D4
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZuzI-0004x4-5T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:00:32 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZuz9-0001Rt-3B
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:00:31 -0500
Received: by mail-ej1-x644.google.com with SMTP id k3so23660243ejj.10
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 04:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wc/j5SHyW9NWmwkprdgV8UdSO/qQi/VqUxuMbcZe3Q4=;
 b=HW2ew+XFFITRvKhmPqVCvJnFlmcnIpNKLI5ug//Ud4wcX8gxfKp7AwoQ3QEKk+rSu/
 ItWU5bX9soq5gU/4KDncFFCCw9W1UVMjNe6mC39Me4BrZeuwQb+Znpi3wkmbQ8m8gafQ
 lP7ytP3n6ZdgLvQDkhu7jgDrtRq3l/XhTMGDEnnvfJTvB+lZyh9g3eBkrJ6GjGxbSI3I
 s5SFktQ6P71dRkHBX06oxmt0zes1p8L/QR0O2L1NSA33UWeBRnG/PVcrPHUQbs0eYLJT
 Dg02GtGUWZT76TubNMHzJSNNOYLcMlwEEiOLm7QNPlCOBRrqIExkJpPf7iLNgRf8zSnI
 JTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wc/j5SHyW9NWmwkprdgV8UdSO/qQi/VqUxuMbcZe3Q4=;
 b=YOkYlk2NymVi2StPb6TRYMHMiQuBlhhkrSCme7A0zU+sykPvnxQ5wLJimVVhwnVkSu
 ANcYIx4Ytu0/7oRtifkQiJl9kqnAzZPgANeRAft+O6+yJe2CMnvgojhNDwUo7QWBiwzy
 ER6KsLwqYQZlLsVYe2dkebiRUhDKdCjeEyy0V5UupHXRRMSrtlgy25GOykbcnFz2aAmq
 dNzIc9RhAGLPuoTjo5zL4rEueSNx+IhuUgzRvTGfxA99q+BPdofxWyHOV5UKbp6eyM4y
 n9OtpUIqb8TSCkizTrkjSwx1sz0XEdwr0AlfZaGpN/2JYvrWZ7+o76f6K6QjB6WXB0sg
 /GGw==
X-Gm-Message-State: AOAM532V2buPQKynnHn8rclYo/ikQZup9zqdS51WJYy4xdqbQRY1bzuA
 Qp7Nvv+feOHbx4FFKrTKJy13za/pTYxkPgXHgmMgAg==
X-Google-Smtp-Source: ABdhPJwVYyh5Y18A/EGT68etj1ZlSCzYvaIQfjbVhlK9d4+EikTazDvlqnaTcoKDr6whdCDrVx+xnzbQ7X3ZYPuHrNk=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr19335227ejk.407.1604404821025; 
 Tue, 03 Nov 2020 04:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20201103104710.27150-1-alex.bennee@linaro.org>
In-Reply-To: <20201103104710.27150-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 12:00:09 +0000
Message-ID: <CAFEAcA9+wCmp5Kek4UCZnqTnnA3xN6LiV_F4P5G8Z1-xQm=i2g@mail.gmail.com>
Subject: Re: [RFC PATCH] docs: add some notes on the sbsa-ref machine
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Hongbo Zhang <hongbo.zhang@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Leif Lindholm <leif@nuviainc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 10:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> We should at least document what this machine is about.

typo and grammar nits only:

> +Supported devices
> +"""""""""""""""""
> +
> +The sbsa-ref board supports:
> +
> +  - A configurable number of Cortex-A57 cpus

"CPUs"

(Also if you take Leif's suggestion, "AArch64" not "aarch64".)

> +  - GIC version 3
> +  - System bus AHCI controller.
> +  - System bus EHCI controller.

Can we be consistent about either ending with a full stop or not
in this list? I think the usual style is not to.

> +  - CDROM and hard disc on AHCI bus.
> +  - E1000E ethernet card on PCIE bus.
> +  - VGA display adaptor on PCIE bus.

"PCIe"

> +  - A generic SBSA watchdog device

thanks
-- PMM

