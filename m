Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFB820757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyjw5OUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFB820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3Xq-0004k6-Tm
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK3X3-0003lp-JX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK3X2-000715-Kb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:21:33 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:45940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK3X2-00070q-Gi; Thu, 02 Apr 2020 13:21:32 -0400
Received: by mail-vs1-xe43.google.com with SMTP id x82so2866573vsc.12;
 Thu, 02 Apr 2020 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oekO7Iey/J+A25klZ5udo88BsGYzcw759MzkmKCIw7I=;
 b=Yyjw5OUUGqmZDd+hbAZZJr3vBaJH10dqL/IeHbbmJ15NIXnzKSSEw4V/Y6J3Wadzht
 AJp52TwXMZiG7+7IcHqpMIoB086/sPq+iZfwk1NnLNT1Zpsm1hxpHfHy9oZjo0dRYAOT
 qT6zvjqfPSEfSMZ3AREJfTBGib75ZmWfxm+wvwYOQ0Jx8hEGcEptj6d1343fIdEd7/LC
 YGMFYOcO9ylPETm3aqwXlFCFse9wjOwF3FIGv6L91GW8NNakm9bxpYv3vqKioerHh8fl
 qhyfMxF7A0ZfQIZIJ8zHFjc0qJq7Z40GK41fgFptWvUcdTxpE/moV4Xq3blfKnG/wWTb
 nA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oekO7Iey/J+A25klZ5udo88BsGYzcw759MzkmKCIw7I=;
 b=onxIgQUJC03WEgzMVMEwA8z2z5NvuIWV4Am351zkjbbH1Y+Jc9NOOA6pWhIczleIyp
 YboTCXjnLlR7tfCmBb/S0ZWnmGqvcqt8QE7bZLPjz0Pe6pRl8kN4VKzKFhVuUcGJWpp0
 mHcuz+EWsHXF9QS6EsvP4CUszyysFouYygKs0/EDuEw0FQL4Ja3iVEi9WF22JzQ6GylU
 Lf8oO2rSmIYnxYuI2qiqVyXLuHhtqKY0cbu9c3cg4wHp+qalu2tnieIrJkvJUDsYS1fd
 8Gvyq0LI0M+BAnT1fc3HPdR1YV2XrGh9lkHPNcSe/5ePbDH/ynYBXliXHAqBvjzOU89f
 xdRg==
X-Gm-Message-State: AGi0PuZvx7wFjGroN3JdImPCu5r+FhjRVRzEl6xP0EJ0Gzlmcw97fY6p
 9/SNJglVXmvupCMMbvn+J5YvgSg5fqkNQJ7XSDI=
X-Google-Smtp-Source: APiQypLjpBvwjPcUGDckkK+JIFI7+N1j/u9APL6KxTZ2vsPmPjH8NErMxZs49o49DsLvfz3AQT/31/i0bqcm7kN+AU0=
X-Received: by 2002:a67:26c2:: with SMTP id m185mr3304616vsm.180.1585848091833; 
 Thu, 02 Apr 2020 10:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <20200402134721.27863-3-edgar.iglesias@gmail.com>
In-Reply-To: <20200402134721.27863-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 10:13:19 -0700
Message-ID: <CAKmqyKNY0qv8iwJCheC0x7EQgdUgLsMtJzwkyS6CpcRzOiJLZw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] dma/xlnx-zdma: Populate DBG0.CMN_BUF_FREE
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 2, 2020 at 6:46 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Populate DBG0.CMN_BUF_FREE so that SW can see some free space.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xlnx-zdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index a6c5b2304a..6a4699757a 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -680,6 +680,12 @@ static RegisterAccessInfo zdma_regs_info[] = {
>      },{ .name = "ZDMA_CH_DBG0",  .addr = A_ZDMA_CH_DBG0,
>          .rsvd = 0xfffffe00,
>          .ro = 0x1ff,
> +
> +        /*
> +         * There's SW out there that will check the debug regs for free space.
> +         * Claim that we always have 0x100 free.
> +         */
> +        .reset = 0x100
>      },{ .name = "ZDMA_CH_DBG1",  .addr = A_ZDMA_CH_DBG1,
>          .rsvd = 0xfffffe00,
>          .ro = 0x1ff,
> --
> 2.20.1
>
>

