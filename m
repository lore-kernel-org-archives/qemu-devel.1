Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57791C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3C820731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Coa0etZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3C820731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuQJ-0000c6-LE
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kZuPh-0008Tn-No
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:23:45 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kZuPf-0005Pc-Kh
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:23:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id 205so4640417wma.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=QrCy0ptCmo+IcRbkhv465ExulosTAPj5gllxESOYYNw=;
 b=Coa0etZSFfyeWp5V7U2tfjIGUhz39srC5jb4qAy2iiduICqJOgOzKZgXkI4eczzsrU
 o3qbVw6RQ1L1oqLASqigDvw4O5ic21GNC7dJ8GP83N17bDyMGkzkdkXSZpnrz7S3dYUu
 dk9Rq3OxHkYWebGP2JxInsC6YYW38LDDUQXGOsGSxdKnJrn5X6nwccoEUhL+kc2H72qo
 smoj+otVrF2F4r4g0cyy+1SEiXyw51hzy9ZFrMzP74wHPrfvLjQ3bH/NGbN/By/9JCXi
 +ti3W+U+HhKDTZfLqv3hgbmwdu/Tl4PViiCdMCwzFKt4crtfs9ywzWgzJuqQ/hM2ZgpX
 PAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=QrCy0ptCmo+IcRbkhv465ExulosTAPj5gllxESOYYNw=;
 b=FuY5OKVTIdtF8JSSQBu5o/jWQVQW7Netwl5of1t63djbQI4F0c0v8udhTVyroJcEAi
 gIA9bucLx2NCCiJxVsUBmXoZn9LWwugUXi679ojYYb7X6V29zZRiIxqOupi3j6ls5r+7
 6ympQqBYhyulYS/xevHiCg1vgObrZzKSZrzwpX93XYPTRfZ8k+rkv03BGHKUjD0e/rXK
 RurWDMcJ+fBfvxq+waA+GE7V6RIUmn8+HzrYwhx/9PFr9bcKcxBAsBlkoGVAw02hFMfH
 CO3FOkRmo+4fbYgxAJBSRS0wcCR/Ge9jGT1XKx0FQLCY45ZHYCWiRJmknyltPuDM7dTC
 thZg==
X-Gm-Message-State: AOAM533cl5MmEU0SXwqLzWfkjxBAJ8eBPB1E+iFeAJ7We6+DDHWWyqly
 VZDdvTznBskM43PHbpdhqXfrqg==
X-Google-Smtp-Source: ABdhPJwnYiXY40LQDyTVPMGqiYvIv0qs/6L1ShwTqYr+mPIYs3+7ccqUYFyuvkjFizZwiVJfwgl4vg==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr3010886wmz.15.1604402621789;
 Tue, 03 Nov 2020 03:23:41 -0800 (PST)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net.
 [82.27.104.80])
 by smtp.gmail.com with ESMTPSA id b4sm17758251wro.57.2020.11.03.03.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:23:41 -0800 (PST)
Date: Tue, 3 Nov 2020 11:23:39 +0000
From: Leif Lindholm <leif@nuviainc.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] docs: add some notes on the sbsa-ref machine
Message-ID: <20201103112339.GP1664@vanye>
References: <20201103104710.27150-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103104710.27150-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=leif@nuviainc.com; helo=mail-wm1-x343.google.com
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Hongbo Zhang <hongbo.zhang@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 10:47:10 +0000, Alex Bennée wrote:
> We should at least document what this machine is about.

Thanks!
(comments below)

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
> +the firmware.

I think you mean the right thing, but ...
"a very minimal DT to the firmware for non-discoverable information
 about components affected by the qemu command line"
 (i.e. cpus and memory)

> As a result it must have a firmware specifically built
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

The intent was always for sbsa-ref to be tracking SBSA development, so
I wonder whether we should be documenting specific versions of cpu and
gic (and then keep remembering to update the docs).
My short-term plan was to swap the a57 for "max", but
documentation-wise, could we just say "number of aarch64 cpus"?
Could we refer to the gic as "latest supported emulated"?

/
    Leif

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

