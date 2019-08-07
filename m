Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C32C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125F021922
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BbAVFfeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125F021922
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIDJ-00078m-Cs
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvICX-0006gh-NL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvICW-00044l-MS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:25:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvICW-00044H-Ft
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:25:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so44371846oth.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B3BxVxXRR8OppXaEHTSAKIRifJOgdZlpHc1CA19aAiw=;
 b=BbAVFfeKgbgEwm3lEGj8uVGdsXvpvmEwXZvfmOSWIw/ZZ08O29uS5V+GxC5Z1nRdJJ
 yIpAv2pQrMLj9PD/s8ulzeJQoKyUgSfCg4WgMvIyMNOqGS/plXwNxiOp+8tlkfmU5wc6
 2i8r0uzLncACsDsa4PuhAWjzcMUMCaHUh7t1p6nebMlnhOFaq9YJZnlU2JXsKN9yh9+d
 ZAnINKqTZLQZz2/eVyEaK1b/Ei51bS1I4zq7211TKZh1lLI5AmwwAHsdqEwehFndNeCX
 EE0uxwoNMKra/wxl6k4MpNxxYjp5MOQt5emCskTiLfUXOVh1s4CS5HwuGR0y/eTI1kRt
 vqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B3BxVxXRR8OppXaEHTSAKIRifJOgdZlpHc1CA19aAiw=;
 b=cd8R1Mis8yBQJO1w0VHGp3pP+4DP1YtU28jCxZEaHZZ0FfXQ+FA2XidPtJOKKseUWe
 OEIDoqu0BV40R2j+9eEE14bYf5Le3YMkhF5QupkUn7tnTDh9xxvgOmmXjZrsJZBwvG+q
 Ti7gMDvWGJmjzVViRFZb5MUsEbYzRVDWIheCtFZ9GFw1IAjy+ml/mzi1tTosY6RyG2Nh
 F/oAkGPOxp8yJD8mVfEPLmvMRQ+t3T4MlvEWmLISo2vfr041I5tyR+r0u6fu+nwJkLLe
 WC3iMSBnQ+GzJUdesUU0zlUHuDgrXAcINS6q0lYPchbhEwssbIa+la25B4SbR9+Vyo0j
 gyYg==
X-Gm-Message-State: APjAAAUvwnI4jg2r/ZfxK6qjpyOliP6vN0dW8qg2h2jVfTkThOY6jmfO
 Ynx/sludvhmJJi7UBLP1Xc+flbj8oJWazTAdDVmCuA==
X-Google-Smtp-Source: APXvYqwQ81a3lC0CYbp9ciReu4P8ZDnNUj6OYrD5ThUxPRAE1PeNTVs6XWE6WdmCd3E4ErL/8/CbhS+B66wPvXqjHqk=
X-Received: by 2002:a02:662f:: with SMTP id k47mr9131387jac.4.1565169943521;
 Wed, 07 Aug 2019 02:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-10-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565163924-18621-10-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 7 Aug 2019 17:25:32 +0800
Message-ID: <CAEiOBXV1S_hOesF65YTi6EqKeYHjW+rByPgfcEg1yeET696KRw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 09/28] riscv: sifive_u: Update UART base
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

On Wed, Aug 7, 2019 at 3:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> This updates the UART base address to match the hardware.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>
> Changes in v2: None
>
>  hw/riscv/sifive_u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index fe8dd3e..ea45e77 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -61,8 +61,8 @@ static const struct MemmapEntry {
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
>
By the way,  OpenSBI also needs a patch to fix the same problem.

Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
