Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ACE22464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjAOZDaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ACE22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugrM-0006oV-A4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iudtp-00025A-Pk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iudto-00063K-Qm
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:56:01 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iudto-00061o-KG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:56:00 -0500
Received: by mail-oi1-x244.google.com with SMTP id c77so3132789oib.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BGSUZ0K3tTXM+Hr2iD1GyUIPRP5aM7N3qL9xhCmhXVU=;
 b=cjAOZDaGsgpUTC9UWZvIxEmgdPZnJrqWTSvsi65TaSL430wSwYGyx6kGFthxh1FoXS
 zvkH5l7StTl4lAjZ9IvOGi/dFZ19Wn9hdZKuMkJZ7tF7YE/olOmHajXYpr4aIuZZJgpe
 Sei8HwOvcFv8p3OsmXuxPL2P/ncziAiKUpqgpL/RkN3nve1IQk4KPYl2ag0wPtDEPQTj
 +OdzBK9TmyZe0qnxdx0Fs2YYpz+lUJbYT7T3yc9uRyPM/s7ZgvXhG3u8v9eJQDBkRoL3
 Wj4qsEh5mC4jmxeYIEKJ80sW0vNRI/PgCstpw2s2s+1S31h0jsnpBhPMFs6AXNxqjrPT
 x0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BGSUZ0K3tTXM+Hr2iD1GyUIPRP5aM7N3qL9xhCmhXVU=;
 b=RGXy8eEGj8CkwqSbEUdg4PX21ro8M2RWmhcDMu3s8AOp57D3Di7/PRUZGsGY2YssrA
 0Cv9QREqw9swdTe3Sw2ougClDjXF0F8RYcRxK2Iqn7RVmVg9j5y2Hd4mlrEAq/geUxqd
 i9oTCv2Tem0Z8A9HXWnXf5LPrnusGk79G95cXbyk13whJcc0kbDLu8Uj1chz0IGf3PZe
 Bh2bpWPhxqrMlf3Dk5NqVwEzqjBWaNvRYONjlJgDZuQpPIg40+KKKOTNg0S80pYs7qUV
 nLPBQwsJL29IlsEoHGqa71Wfm7xwmT3ksaM9g7xh/MDu1G46WcOqn5xj5FJHeUlRMtq1
 JHTw==
X-Gm-Message-State: APjAAAXHYySOgzvqV5LiaXWWZS9FgiFUIyrfu3a9nWqNDzH1rHrPh5Vt
 2rSE8iqsbQiHdeuJ9K9+OiU32l2LJmKO2a7b1LnueQ==
X-Google-Smtp-Source: APXvYqxGAQkjM1Wc/YPytSwutQimb7S1je4V8E7wXspYpQ9pb/FjtnOGRP9K9otkp/TwHRCzX0jD3uLa0YXcYxtVk64=
X-Received: by 2002:aca:f484:: with SMTP id s126mr10361435oih.48.1579791359784; 
 Thu, 23 Jan 2020 06:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20200120185928.25115-1-philmd@redhat.com>
 <20200120185928.25115-3-philmd@redhat.com>
In-Reply-To: <20200120185928.25115-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 14:55:49 +0000
Message-ID: <CAFEAcA8-aM=B6G-Zin-yEJycf6v1Brhxkn8it30jPDqrKkyWgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Add an entry for the Siemens SX1
 (OMAP310) machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 at 19:00, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Add the Siemens SX1 (OMAP310) cellphones with the other ARM machines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52fbc18566..27fbe1abb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -560,6 +560,12 @@ F: include/hw/arm/digic.h
>  F: hw/*/digic*
>  F: include/hw/*/digic*
>
> +Siemens SX1 (OMAP310)
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/omap_sx1.c

At least as far as I'm concerned this is 'Odd Fixes'
status at best. I don't even have any test images
for it.

thanks
-- PMM

