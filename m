Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC28CA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2D020B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzlABeNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2D020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwhl-00041n-2L
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMwaF-00073L-KJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMwaD-0003RG-Mq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:00:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMwaD-0003Qx-HF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:00:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id s71so1766905oih.11
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WihhLkLz5JI2Iv66MelG0/9+caqWJ1bQ4J5EtoJb49E=;
 b=LzlABeNbY35PHfpVdt5yYzLJDfkH8Gv97vGOM0aK7Gx0/yZ7LJC4BxzaXAZDVzRrem
 A0ZPWLNTWY/EcrhtfCxToVrIFPQIaR0Nz/KW0xFSpD3/CjlUtKGCJAyXb1ZquadP1CiM
 OEUaDMo87FrGkzdfY3E0EsGvxII9AQWC22KCaNEDBj93x2IQKDY+o6fRU7xvX26D//DW
 xfCuvvdW701vSPROXUnAMON4LLvtdFnsrMOnoIc85L9FA4VjGa57TK0RAdWpmCZvUC7N
 fpjIUNR704HqG6BOXM+x63N4II6JD81KtLS5l0pVkjuadRu6X5+mFV2Qpty6mqaelx0K
 3q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WihhLkLz5JI2Iv66MelG0/9+caqWJ1bQ4J5EtoJb49E=;
 b=O+eXBFG/k7YZpEwJG8eTUvP8aa4RxDYYzEPqB4AdgMUHeCm4vysOYi+t8/26yxefV9
 tqtkrnsmIdN/h0cfK4s8wk57zW90yqc5/N9L1f5m3pDFfom6XtUg0lNMKA+SztfHXGs5
 UlJwReb9ilXwTARhUuVBC5x16hPovdAnnBZ6xdZxhTX3J+YLM9YOGlqdEN8i5YLsQ7Y+
 1+jqwCMK2Hbsyz0B73AePh6sf7x3Y3MVY11XNzp4CYHtuMpSwirXI0zWXE3p+d1ZFAC4
 qh11fRM8gTr3QFJAf85qzTZaLdUE8i8Ppdrn7ixBquff8a55lkweHyKKjjIH70mWTtvc
 rZvg==
X-Gm-Message-State: APjAAAVqXNBxf6i7BuZpfcPhKo4sv6+7ful8wnp5SxuFveV+mF6PGkO/
 TpkTbJyUngMB6GNStJLFTUKKaDs11ldhVfTMl3C6DQ==
X-Google-Smtp-Source: APXvYqyAIm4Smt3AnyTVpMDkUYuplblO4kboN4+1y3nJpXwThcJX40QO5UeWo5DOObRv8Gu/eNLho7kAPQxELFOMNSk=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr3690253oiy.170.1571760028458; 
 Tue, 22 Oct 2019 09:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191022155413.4619-1-svens@stackframe.org>
In-Reply-To: <20191022155413.4619-1-svens@stackframe.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 17:00:16 +0100
Message-ID: <CAFEAcA8DWwWLnMZqqsn4RpJbtPbxoPnrB2Z7UXvK3FhHRgk78A@mail.gmail.com>
Subject: Re: [PATCH v2] net: add tulip (dec21143) driver
To: Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 16:54, Sven Schnelle <svens@stackframe.org> wrote:
>
> This adds the basic functionality to emulate a Tulip NIC.
>
> Implemented are:
>
> - RX and TX functionality
> - Perfect Frame Filtering
> - Big/Little Endian descriptor support
> - 93C46 EEPROM support
> - LXT970 PHY
>
> Not implemented, mostly because i had no OS using these functions:
>
> - Imperfect frame filtering
> - General Purpose Timer
> - Transmit automatic polling
> - Boot ROM support
> - SIA interface
> - Big/Little Endian data buffer conversion
>
> Successfully tested with the following Operating Systems:
>
> - MSDOS with Microsoft Network Client 3.0 and DEC ODI drivers
> - HPPA Linux
> - Windows XP
> - HP-UX
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

There are a couple of minor wrong-indent nits:

> +static void tulip_update_ts(TULIPState *s, int state)
> +{
> +        s->csr[5] &= ~(CSR5_TS_MASK << CSR5_TS_SHIFT);
> +        s->csr[5] |= (state & CSR5_TS_MASK) << CSR5_TS_SHIFT;
> +        trace_tulip_tx_state(tulip_tx_state_name(state));
> +}

> +struct tulip_descriptor {
> +        uint32_t status;
> +        uint32_t control;
> +        uint32_t buf_addr1;
> +        uint32_t buf_addr2;
> +};

but maybe Jason can fix those up when he takes the patch ?

thanks
-- PMM

