Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5859FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98463208B6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Jxs4UuuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98463208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZu1R-0005pB-TR
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kZu0C-00055G-Ql
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:57:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kZu0A-0004CV-IK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:57:24 -0500
Received: by mail-wm1-x343.google.com with SMTP id 13so12283760wmf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VTPZGqRAI9Uhe/2ZQKlj2SlQo8KD39n58MrSR+FxS28=;
 b=Jxs4UuuURzVR9gl5XQROjY8GG0Q+FXMhenObXxK5u+627IHvLG/KJZi20FsfBsPm22
 fK0pl2sgGSflKt+T03FhzWIAa+cjaGq+OOXbujBlnhMPZytsLJ30iGlg9gzBi7dKfQDI
 ZEFo0+XBYwNlXbIB0UPtCfVAxy4EVWdNLFgkxDKXjnZrSj/IMoJL7Iubut2M6sYik9Y5
 G/8JQelMnP5i3JXr/JmpcC/1qw8OL7BohcYMO29jezIxgf+iq3IcwQXA5luY3c53z4s4
 fOxBz76oMECGDsWGIYdt/67kAwOEvBoWGjmgkenmqzYSalAif2eGjsUrooiO9JFnBMwa
 rPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VTPZGqRAI9Uhe/2ZQKlj2SlQo8KD39n58MrSR+FxS28=;
 b=Q7oO0AsvSHVsvpe2SVyow2ADWYMX4HVehrMnqJ/FhVEaWgaU8SWd7F2hhfRq5wqv8C
 dUw6OBh+80JEV8x5x5D6blosJKRNFLiL2xxiPiCg66TRmN5HVcPJnQ3uZTIbFCoNGhBY
 01xwqV4TKjNGhPjeKGH+M5XXlL+FmWHf4kpXPcuCtOadMULARfd74o+2scG3wOtlGYGp
 G72t3IVJBKv8a3qyQFH2j6JFfTdq1qF/QkZxidcBv7UTg7DJNbbgWizYDEKynMiQdGVN
 Yr/WjPaG8X1Q0eAnmHJiPvWSgjSqA5z0Ppq0wruCQNAAqmselBp/ohrG8crlQqE5xOoX
 GFbw==
X-Gm-Message-State: AOAM530i+tKGkukRch1t5oTOMT321ok+gmKiQ57Ml261cOagrb2qpAgm
 qm9JuAgziZJUMfmEq2LCydXViQ==
X-Google-Smtp-Source: ABdhPJw5pMWxYYUkUCZjif0HEEEJs8i6Z+0hFHGNtwXTCJxmuKxBrSYr1oYlwl/pJhisO+o83k4s4w==
X-Received: by 2002:a1c:68c1:: with SMTP id d184mr2892296wmc.74.1604401040938; 
 Tue, 03 Nov 2020 02:57:20 -0800 (PST)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id f20sm2575903wmc.26.2020.11.03.02.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 02:57:20 -0800 (PST)
Date: Tue, 3 Nov 2020 10:57:18 +0000
From: Graeme Gregory <graeme@nuviainc.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] docs: add some notes on the sbsa-ref machine
Message-ID: <20201103105718.tlrx44tuhbu5u66e@xora-monster>
References: <20201103104710.27150-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103104710.27150-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Leif Lindholm <leif@nuviainc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 10:47:10AM +0000, Alex Bennée wrote:
> We should at least document what this machine is about.
> 
Looks good to me.

Reviewed-by: Graeme Gregory <graeme@nuviainc.com>

> Cc: Graeme Gregory <graeme@nuviainc.com>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Cc: Hongbo Zhang <hongbo.zhang@linaro.org>
> Cc: Shashi Mallela <shashi.mallela@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  docs/system/arm/sbsa.rst   | 30 ++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 docs/system/arm/sbsa.rst
> 
> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
> new file mode 100644
> index 0000000000..a47c9360de
> --- /dev/null
> +++ b/docs/system/arm/sbsa.rst
> @@ -0,0 +1,30 @@
> +Arm Server Base System Architecture Reference board (``sbsa-ref``)
> +==================================================================
> +
> +While the `virt` board is a generic board platform that doesn't match
> +any real hardware the `sbsa-ref` board intends to look like real
> +hardware. The `Server Base System Architecture
> +<https://developer.arm.com/documentation/den0029/latest>` defines a
> +minimum base line of hardware support and importantly how the firmware
> +reports that to any operating system. It is a static system that
> +reports a very minimal DT to the firmware for command line input to
> +the firmware. As a result it must have a firmware specifically built
> +to expect a certain hardware layout (as you would in a real machine).
> +
> +It is intended to be a machine for developing firmware and testing
> +standards compliance with operating systems.
> +
> +Supported devices
> +"""""""""""""""""
> +
> +The sbsa-ref board supports:
> +
> +  - A configurable number of Cortex-A57 cpus
> +  - GIC version 3
> +  - System bus AHCI controller.
> +  - System bus EHCI controller.
> +  - CDROM and hard disc on AHCI bus.
> +  - E1000E ethernet card on PCIE bus.
> +  - VGA display adaptor on PCIE bus.
> +  - A generic SBSA watchdog device
> +
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index fdcf25c237..9636f3fd00 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -79,6 +79,7 @@ undocumented; you can get a complete list by running
>     arm/mps2
>     arm/musca
>     arm/realview
> +   arm/sbsa-ref
>     arm/versatile
>     arm/vexpress
>     arm/aspeed
> -- 
> 2.20.1
> 

