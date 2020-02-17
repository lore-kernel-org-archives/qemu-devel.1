Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72EC761A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D20206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qop5AkN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D20206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3d9y-0006Jg-1Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3d9E-0005aC-Rq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3d9A-0003oY-Os
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:57:04 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3d9A-0003no-Jq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:57:00 -0500
Received: by mail-oi1-x242.google.com with SMTP id a22so16101943oid.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sg+UkZAgfr2THYTi41XlM+2CEPbUNU/g6/JClAJlFcM=;
 b=Qop5AkN+18R/lWpboztqm0Ydf8U2lga/d4wByIZtpMlSPSga0UUQxWnCSiABWWFRzA
 gPyioncINFTxdJZ42V0O0ZgUNA7LnnFYhZmGJ0by1OXxB6pFJXEC7qXbSGqXWtQzWF0j
 BAyHx6fz7+rT+5C1QOHGtgX03w83y5NdVm3atM/Ff653YJaHmqUE/JVLebgeSNr9dNVo
 ud8ADDzBFoZ4+e0HZvIYY54PrPPLbMEsvyXtalNU9XH1+keKB1N3AWdoP/JMcFUeJtZX
 6eJdIGD3uo6zExTPh2LCMB8uVxymBemtp9b4sjMgH7FxRqi+OF0HoN//JvjXASSCbhvw
 UaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sg+UkZAgfr2THYTi41XlM+2CEPbUNU/g6/JClAJlFcM=;
 b=YmoHx0mzygjnOMpaxMnSe0rfdWFbUiRuL48aP2zePBf71AMFU1F+zi/shcvGgYs2sF
 dYKQ+tu+OvIXkC9og2qmfLVuk56eEV1P+HPw1ID0WYYdPqrgINGDbEjUMfYOkqkmqBId
 NvEliRNUrFKhJsTCH+mDgxNDOXQXmffMV/cEbQmXmufNDrvoT+NRRHyIrdNTYw0l/CdM
 tQ4sHIsSiczHPDtzuTHxcUwift54qqsEzuMq+Fl/j29+PzKWLnvz7V8O3Vj+ZUm6wbHo
 uGbh/xFq241oS3KqEuUlIie/nnSdPZoKMz0v2etbgSXThx3BEjyCf9YYREGsOP++qd6f
 7iew==
X-Gm-Message-State: APjAAAXmT0rPMduVd4naoJTIM6WQKbwoVvy8GMYDx1qUWxEh/WmNJXpL
 uHQ0/4cvIAWDDuWEVppgAeKNxN5pQM503nX5evv2/Q==
X-Google-Smtp-Source: APXvYqybf8YZ9SUzxobgA2xrodUgdT3AHb1n4PyyRooaWMI3idjXX1mNmrSzQOT13JWJadZ8k1xyJiztS9f7qXlt3EM=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr9691959oiy.170.1581933419718; 
 Mon, 17 Feb 2020 01:56:59 -0800 (PST)
MIME-Version: 1.0
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 09:56:48 +0000
Message-ID: <CAFEAcA9ioqVhsBjZZXJDSnSRi-rbz80DZvSv1DsOfN0+NTGA6g@mail.gmail.com>
Subject: Re: [PATCH RFC 00/16] Implement Microvm for aarch64 architecture
To: Xu Yandong <xuyandong2@huawei.com>
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
Cc: wu.wubin@huawei.com, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 07:42, Xu Yandong <xuyandong2@huawei.com> wrote:
>
> Implement Microvm for aarch64 architecture
>
> This series attempts to implement microvm for aarch64
> architecture.
>
> Just like how Sergio Lopez does for implementing microvm
> for x86 architecture. We remove parts of emulate devices which
> are not needed in microvm, compared with normal VM,
> We only keep PL011 (UART), PL031 (RTC) and virtio-mmio
> devices for microvm of aarch64.

For x86, 'microvm' makes sense, because the standard
PC models are models of real hardware with a lot of
legacy baggage. The situation is different for aarch64.
The 'virt' board is already intended as a "minimal
machine for booting a VM that knows it's a VM".
Why do we need another model that's intended for the
same purpose?

It would be more interesting to look at whether there
are reasonable places where we could allow command
line options to have the 'virt' board not provide
some devices where that makes a significant speed
improvement. Analysis of where the extra time is
actually going would also be helpful.

NB: I'm pretty firmly against dropping PCI. This is
a pluggable discoverable bus, and it's a much better
way to provide virtio than virtio-mmio.

thanks
-- PMM

