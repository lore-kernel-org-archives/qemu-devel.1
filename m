Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D29C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E748206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3z6qDSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E748206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZrB-0005g7-AZ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZpE-0004a4-QL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZpD-00029D-Vq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:59:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZpC-00024Y-QW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:59:55 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so11058658otd.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CZSGbPEDVE8gssL6qNKIjRs0aIa+88scQYQEG+Ybhuk=;
 b=v3z6qDSlDyPIuaiKU2aiMYJuRHhyfLUHyKcWFm0vj2xH1PrLSphdkFGEy60nQLs2tH
 oXslC9x/w60CufQKPLmQBJOFKo1PyZ0wU/1XK76ylHyafuIPGU6UC05LjpOlxnSPO3/b
 T9S4rVaoVc465fDbx1hpIlRSOGX3wy8hDv0x4OCoCYjuqbgvLLyMn/I2gKFs+a3dL19u
 sGsPPTV5R5CURFbzAznrTNaGEmh052by4UjPXj9I6TFR5QJvyGkKXeAYJ7OlHwxO6Oqn
 H9xQGUjjG4AbA3lXuOnnuOfLM0SzMiN5OZVQ3yp+jC9E8wJW2Cz9k+C7J3Y+5I0bcDBE
 yGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CZSGbPEDVE8gssL6qNKIjRs0aIa+88scQYQEG+Ybhuk=;
 b=ZvdzhmTg4XBg9LM6m37NobVE0zmCk2y2VimfSbihLL3l5IgJS4snQgveSY/eboxSt3
 G9eqslvN6A12ojf66zPZtafiMMA1HYAui5MGxdM1+8DjTnrybDdyQZWKLHOMTCE/b4wG
 MbDRwj0P/FYXcWLI7XzWsRLkW3/8vmJT8sV32C8InEZsitWEKxgDKNIbUgXX2gFoQSLv
 AzRUoeEfWq0j1s1/2cPn03+3DcUvnsPNwdCR13cJg6FZI5uvhUaZ+WON9fyn1kNVIdYj
 X2Sl0JrRzVE1fTnxfdQ5uvGssFwY31ikdVEQp3LqN09p2KsukJ1PdS87E+9rv/gQN8JO
 klIw==
X-Gm-Message-State: APjAAAXn09wT83fnPn/TXsb0glkZgZiwyiRoMF+iQBM3pMw8XcU1M+5D
 aiuMN50Eja6HBs8UIXwFPPuMFqaObjlKTd/SaYCk41tX
X-Google-Smtp-Source: APXvYqzXPT7ty6FBtOwSC8QDmgZ0x0fZn9PNBEePTI09bS5NO6d5ub9ZVut582dD70Q9lc9bX2ftf5XXw/hKHBs+cKQ=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr5842415otq.221.1581443993597; 
 Tue, 11 Feb 2020 09:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20200207095529.11309-1-rka@sysgo.com>
In-Reply-To: <20200207095529.11309-1-rka@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 17:59:42 +0000
Message-ID: <CAFEAcA9VsZ6b=hX7Y6gFwEd8U8dWmMKxi+QVoWAj9Saj-SRBgQ@mail.gmail.com>
Subject: Re: [PATCH] i.MX: Add support for WDT on i.MX6
To: Roman Kapl <rka@sysgo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 09:56, Roman Kapl <rka@sysgo.com> wrote:
>
> Uses the i.MX2 rudimentary watchdog driver.
>
> Signed-off-by: Roman Kapl <rka@sysgo.com>

>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/misc/imx6_ccm.h"
>  #include "hw/misc/imx6_src.h"
> +#include "hw/misc/imx6_src.h"
> +#include "hw/misc/imx2_wdt.h"

You accidentally duplicated the imx6_src.h line here.

I've just fixed that when I applied the patch to target-arm.next.

thanks
-- PMM

