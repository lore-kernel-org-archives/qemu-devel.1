Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B05C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9392465E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axWRYFef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9392465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFMG-0005X4-4q
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihFKF-0004Lg-FI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihFKE-0002F6-GR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:03:55 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihFKE-0002ER-AY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:03:54 -0500
Received: by mail-ot1-x342.google.com with SMTP id a15so1298243otf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q/JxMM3NAomx6ykwazS1RjvqreMPIS0r/3fmUpKXorI=;
 b=axWRYFefeye5FfP+zMd5OTAmZRPvQUMATaOUIjVCy01y/g02z276Dwd+UP+AvBEYUh
 j4W2isW0KUNnTOZVYJo3QUorypyQwhQnzY1sEd7OtkJXHxeWlDhu1hlNsUylknMhyQWD
 vij+TnOdp29T+M5Q+zZnE/JqXRWcgv2Lhwt3HpquviOOcIAE5yz7fECqTNplInIoJKJ0
 u0YLGk8y+LU4GtJyyWutVF8/u00Jsb6mKbuBo9avs7IDzarVL68TQXXAw7A5QazbArDA
 IDPDIYaSAC3oi1wwPAMQjttLyHJF4kD3gq1dyRlGoUY6hlCTfyq/S+0DjOzt51gehsju
 wqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q/JxMM3NAomx6ykwazS1RjvqreMPIS0r/3fmUpKXorI=;
 b=PdVzix8+TXCHbR0N0UjUgNZRm1+xdIE9yWLW4hWHCiI53ip7boSXDoavTI5GBgVN6j
 TiXrKCiG0hTJWejWj/b2Np1eYC7UK5Df0H1gq3uA+mv07G+20bSh/zyy6J575sS9CFXK
 J+D8JRJzQnIXQJY7tf01xqVgS1Dy1aYfsMrQ8Nls6jHkFdGlEVXG6PjQ5MGKeYahotB2
 YtoYv/h35Pd0aqwgGqFNoQ4IftzYI/rodw9HuK9MtHw5cqmIzTYhmYU1gVZVp56cojBl
 6NffcZ4qyd8hPPO4gg0or8jUzC6J4qUyXHhMgA5uqjmICQyVzuntAyrc4hzWUdWBtvE4
 Sm8Q==
X-Gm-Message-State: APjAAAUXQ5Gt1LLtf5lpMdto4XKa+0Mj5b7IT+fNzKG6IAfaEPxIvmXG
 q1JoQGwZszSz4jTBEKEnLjXgDu1uKzN8OvW9GUw38A==
X-Google-Smtp-Source: APXvYqygUW70HQie5uMEgMKon0Mbjh7W5Mlwexza/X748hWAM7/UxdvvZalg9kqRZKB3P/vbtZskLcKGZApSJFfXBHA=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr38999964otd.91.1576598633324; 
 Tue, 17 Dec 2019 08:03:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576227325.git.alistair@alistair23.me>
 <40f97ae32a6f21d8184c1cc46fad2defb302238d.1576227325.git.alistair@alistair23.me>
In-Reply-To: <40f97ae32a6f21d8184c1cc46fad2defb302238d.1576227325.git.alistair@alistair23.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 16:03:42 +0000
Message-ID: <CAFEAcA8rZtJQsUXJ1E1gOAXzrHihzYvMoodgHhpro1Jd7jkVUg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] hw/arm: Add the Netduino Plus 2
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Alistair Francis <alistair23@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 14 Dec 2019 at 02:44, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  MAINTAINERS            |  6 +++++
>  hw/arm/Kconfig         |  3 +++
>  hw/arm/Makefile.objs   |  1 +
>  hw/arm/netduinoplus2.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
>  create mode 100644 hw/arm/netduinoplus2.c
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7bfdc3a7ac..881e7f56e7 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -105,6 +105,9 @@ config NETDUINOPLUS2
>      bool
>      select STM32F405_SOC
>
> +config NETDUINOPLUS2
> +    bool
> +
>  config NSERIES
>      bool
>      select OMAP

Something odd has happened here -- your patch 1/4 already
had a stanza:

+config NETDUINOPLUS2
+    bool
+    select STM32F405_SOC

so either that should be in this patch or this fragment here
should just be deleted.

Assuming you sort that out,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

