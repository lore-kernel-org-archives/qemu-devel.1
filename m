Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294BDC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E325E20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9MLz4Bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E325E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAJd-0000C6-5R
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hi9QI-0007Cn-DX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 23:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hi9QH-00018Y-BX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 23:25:38 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hi9QH-00017D-2l
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 23:25:37 -0400
Received: by mail-io1-xd43.google.com with SMTP id m24so33833553ioo.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+yGUjS9WtkXidBm2EgH77cPR9n2FoDymKRrrTfpAZFY=;
 b=L9MLz4BtWOik5geQ9F8UPlEf+MbMN5kfDULnjF/hQfoWFZKY5ymGwJXqTlP/1fyTxi
 H+lYJ0xBi7XMzxuTYMtU3TcBUjBqb8+xvDUxmmDw4U0HXjxQBKRqN7jUN9RURnIRFbjX
 GQvfAlBn3dJBNecbsagSmb4SPlk/yEovvFzwdPoUoPI8hd7ANRjHC1NH+Qo1dcjnuIlH
 7O0YxBlWFL4D6mcWFutoqRSldXxnJng8p2tw19hQbGHVMt1j+m71MBq2ca/JIptfWiaK
 GSEz90NMGyWXX1Bm64Eci7nIpO4vb+0aqGdztSn1+j+Df1wH5QamhPeG5a7MmhMWvla6
 RyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+yGUjS9WtkXidBm2EgH77cPR9n2FoDymKRrrTfpAZFY=;
 b=s02DB9ipkW270O0kQXxyPjg+5LmarEJcNqou3EfcsgHW9QsqatcuB/whRXng5DRlGK
 QX9Cr06nJSUNiP6eDrkx8RsmlOFMIyilYvNmWjKpISe+AdjrSimNqG5X+Mb/FWOIMAHS
 VrTyCUmRPaoZhKesKoT3Kjl9yjv9IuYUDlhxUCqRYArt71FtgV7PBS6mqn77tt9Np1A+
 cjBJ+qYGew14SRovCVKkm3gtAjU3+XjGmMjShSxHSZZ62dCTjlAX1+yqj5NTAXgKT54/
 og0aojZNwO9bdwmgC99RZvVjwsYDZ/C089WSntlVCYN7ciQ01AkVj894TeBdq9DDo6h+
 PKZA==
X-Gm-Message-State: APjAAAVSDWLerqH0lAtMemK3rLIIj247KMHLv37H5Gy6IIpfDfqIOIKk
 BGe4TbvMzWe+XzFas8PUNTI/05fAWumUBN2T0oWfgQ==
X-Google-Smtp-Source: APXvYqx+/ZczVSJONQrJKWd5Gvuzq9xYKsTZ7mvALJEYF5dxLgMK3vw0trdkLLCDd7Osq8QBjPpjb+60I6CnnM8QmJM=
X-Received: by 2002:a6b:e60b:: with SMTP id g11mr31428459ioh.9.1562037934407; 
 Mon, 01 Jul 2019 20:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Tue, 2 Jul 2019 11:25:24 +0800
Message-ID: <CAHmQWvAbqWjDFotms-aAbiKVOhNzzcbewfRdOcg9NDq3A9aX=A@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH v9 0/2] Add Arm SBSA Reference Machine
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 22:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 30 Jun 2019 at 11:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> >
> > For the Aarch64, there is one machine 'virt', it is primarily meant to
> > run on KVM and execute virtualization workloads, but we need an
> > environment as faithful as possible to physical hardware,  to support
> > firmware and OS development for pysical Aarch64 machines.
> >
> > This machine comes with:
> >  - Re-designed memory map.
> >  - CPU cortex-a57.
> >  - EL2 and EL3 enabled.
> >  - GIC version 3.
> >  - System bus AHCI controller.
> >  - System bus XHCI controller.
> >  - CDROM and hard disc on AHCI bus.
> >  - E1000E ethernet card on PCIE bus.
> >  - VGA display adaptor on PCIE bus.
> >  - Only minimal device tree nodes.
> > And without:
> >  - virtio deivces.
> >  - fw_cfg device.
> >  - ACPI tables.
>
> I've pointed out a number of issues with these patches, but they
> all turn out to be very minor (mostly fixable by moving code between
> patch 1 and 2). The other thing we need is a MAINTAINERS section for
> the new board:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cad58b94879..0bf3739f06a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -728,6 +728,13 @@ F: include/hw/arm/fsl-imx6.h
>  F: include/hw/misc/imx6_*.h
>  F: include/hw/ssi/imx_spi.h
>
> +SBSA-REF
> +M: Hongbo Zhang <hongbo.zhang@linaro.org>
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/sbsa-ref.c
> +
>  Sharp SL-5500 (Collie) PDA
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>
>
> So rather than making you do another respin, I'm planning to
> make the fixes in my target-arm.next tree as I apply the patches.
> That way we can get this in before softfreeze (which is tomorrow).
>
Thank you for the efforts.

> thanks
> -- PMM

