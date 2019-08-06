Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA18C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616F20880
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQkL7KWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hunGF-0000qr-Fn
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hunFk-0008SZ-8G
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hunFi-00054m-9Q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:23:00 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hunFg-00053z-FT; Mon, 05 Aug 2019 20:22:58 -0400
Received: by mail-lf1-x142.google.com with SMTP id 62so54603514lfa.8;
 Mon, 05 Aug 2019 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jzDtlcAe6sBbtwghEve02LVVg4NhJdmfIxaUEhZl47I=;
 b=XQkL7KWxlAbhpNcHy41v9dSXYRR+3/1934//22uhOqe8VmhT4X3Jq7GPDqlaCenmE9
 1uh+2qk4mF3DbN2LM32vTLz4JwpCWCTaeByZqfAF6k1Qj/RSuS5YpCEYMS8cFcOv71aN
 bhYnyJC9iGSqu0MBltyvALRDSpuiBDbR+8PGCMAvrra4VKu3/CQz05xKTXXtBiuI66oK
 6sh1hnB5si/78MiRoEHfQIhFDpw0pvt8rlKigwhKWVsQOlJCKsy8kZZ3VWMy6R7iNU0F
 FMVyI0hwN1/SidF5KHiZyGyIJ8NXtZaFRffdfT6T9TeB3o+JVKfEPJuTiDl+TFvpIYc9
 DTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jzDtlcAe6sBbtwghEve02LVVg4NhJdmfIxaUEhZl47I=;
 b=eAOmtKb7aIH8Y90+zZ54wduJ3sgZ8mZIZjCRZlME9wgAXZ6nLO61K+N+Shs6JM7889
 /IJCZ0e+jUPSm/lOfIFd2m2sO7nhlW/rLuIZjN9z2OafoOLMKoz7fJzLI5ZSVuqNvvSo
 oAH1VXEejjP8G5Xr1VToMBO6Fwhyl7IoAtEEfD37qD/+RaqJ9NVFfCJ3gz7rBtSFLaDb
 Wn7i7Nm1DCeKNv/qLfdGevsdJloZGOs+S+ZoKvPr77AMvIAuh0tTFcfTxs/sXqH/7WWJ
 aCqADJRuFR9ky4RkP7hJEQw9vJYrrUIofe3B8/fgNT8QgTPbxRogaW1Fb9Lz/MgbJeJG
 WtoQ==
X-Gm-Message-State: APjAAAXiWd352bmL6DtTu+PEpTwnXe2QZlBcHkvA3O1LbCZx/FkL5uUY
 gby8dI7cmrXCdD7KWA35RFfFRe9nI4EYeDGGafk=
X-Google-Smtp-Source: APXvYqwDItWmQF2mk1ocS743MDh7nOe3qBy4EEXAxhHTE2Nry/IFovwjpyn5d0rEbjjvdfGh/h6QqVbmKQZxVmmir34=
X-Received: by 2002:a19:7006:: with SMTP id h6mr247841lfc.5.1565050975429;
 Mon, 05 Aug 2019 17:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-10-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565020823-24223-10-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 17:19:16 -0700
Message-ID: <CAKmqyKMsDk7f6d3qVs05NVouv1Uf04x21ZULGLc9dgphhNm6Xw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH 09/28] riscv: sifive_u: Update UART base
 addresses
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 9:05 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This updates the UART base address to match the hardware.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b235f29..9f05e09 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -60,8 +60,8 @@ static const struct MemmapEntry {
>      [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
> -    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
> -    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
> +    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
> +    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>      [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
>  };
> --
> 2.7.4
>
>

