Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5FCC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A04208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvH2Ifhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A04208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhy9f-0000WT-Ht
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxhY-00070H-HH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxhW-0003TC-HG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:54:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhxhU-0003P7-Rd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:54:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id t76so10195995oih.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bT/L3E9J3H7vjr92bp5OMJgMLvn8Ud0Rw7GtNyrTxtk=;
 b=DvH2IfhcSYN2o1qB1/f3zI10cVdiSkycOv0AevZdJyBuihIIHG+H+bOlXGAOM7gjFy
 ZWZiHo1dQS8Qyn9+3nLR0lDi8k2JcBfK67TeCu2q4vYR2F6uk1wm4w3OFKW9eIQuyQla
 qLePYpUlREKb0vcbeZLqQW89MH2iw0VHXDLeg6SGiHU+d6knsz/wGoWVTs+1ce/rUUET
 coc/p7/0B8ovbauNm4DvV2adRd5CRDg/NoW/Gua+cnCHEx2MgTEFoL7XXT98pnIWESH5
 Ad9/sw8div+NzKMJsu47+E6yuhX5lhTIIehXsp6mNfS45pRHryrYY0TBz0vcKuNXxBGm
 lTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bT/L3E9J3H7vjr92bp5OMJgMLvn8Ud0Rw7GtNyrTxtk=;
 b=VIELIcThUO1WMVDeK6rBwNo1PL6T6Dyqi/06hDxEa5QG1qPeBADIQTiYmbD1Gt+hnX
 cY689aArBLOrg3sH1Uq8fRS4D7yeQpu9QIcJvjTcqk/ct8Hof+RhETEcvzdaZKF4irnn
 uBeXdVkUhc7kGwsQFaSgzTAFAcn/fweBAI60xBfoSyGZo18vGQdlJHRzevvD/JPGa2LE
 b50E3Das9gPjUSGabETKCs+B7Efbxvd/1OXvJhOOeRRbYFfftf0XQdUalHiTxbp/Bgv6
 273MXq7s7FLMDfXsPTiUEIYERDmOG9JDSiPVcSfJ6ORsOi2gh7RMKtpVJLkL6vtVQteT
 B+cw==
X-Gm-Message-State: APjAAAUt1UwZcs7KHYnalkAmZoZ9ExC3jSPuXctFRZsDNmOG7Lt0t9QR
 qVgC3L1aynOcV7QXnUERp/llZS6AWQmbUftd4UopEQ==
X-Google-Smtp-Source: APXvYqz3mAARrjP9vYnZWQXMZiaWusZuzuOaFYIfvzm7tJjUMqPyHkcb9b/pSqHLFmnFsplc/nwp329aOOGcz9u7eXc=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr7205800oic.170.1561992874882; 
 Mon, 01 Jul 2019 07:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:54:24 +0100
Message-ID: <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Sun, 30 Jun 2019 at 11:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware,  to support
> firmware and OS development for pysical Aarch64 machines.
>
> This machine comes with:
>  - Re-designed memory map.
>  - CPU cortex-a57.
>  - EL2 and EL3 enabled.
>  - GIC version 3.
>  - System bus AHCI controller.
>  - System bus XHCI controller.
>  - CDROM and hard disc on AHCI bus.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Only minimal device tree nodes.
> And without:
>  - virtio deivces.
>  - fw_cfg device.
>  - ACPI tables.

I've pointed out a number of issues with these patches, but they
all turn out to be very minor (mostly fixable by moving code between
patch 1 and 2). The other thing we need is a MAINTAINERS section for
the new board:

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b94879..0bf3739f06a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -728,6 +728,13 @@ F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h

+SBSA-REF
+M: Hongbo Zhang <hongbo.zhang@linaro.org>
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/sbsa-ref.c
+
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org


So rather than making you do another respin, I'm planning to
make the fixes in my target-arm.next tree as I apply the patches.
That way we can get this in before softfreeze (which is tomorrow).

thanks
-- PMM

