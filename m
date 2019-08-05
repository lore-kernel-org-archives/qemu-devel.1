Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17098C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77C1206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BKv1SsZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77C1206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huWGf-0000GF-W8
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 02:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1huWGF-0008GL-Bm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1huWGE-0004Hu-8V
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:14:23 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1huWGE-0004HW-2w
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:14:22 -0400
Received: by mail-io1-xd41.google.com with SMTP id m24so164957314ioo.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Y7WcXkyB2SsSCuxnbdm58cZx75IvMUDQfLeylZQwF8=;
 b=BKv1SsZ3DQft4EMwl0rdlX61+WUPZwPbxotZpozeU0puOcEwt04XMsOPzFWEgn4dxX
 Itc8CIu23Q/D1qNqtH5JJIlPHWS8ekVjvPjHq7/j6+xZo2pzcm/51QKWqjiG+YvaWtsq
 Jlqr9v5K1L/1X2ss7sUEPO919YdFSJ0WnadrRcFrbPcUIq70anC1wsmkR0oXFUJMr6ka
 2NimW2eJcdGdT2X4yZ8kJ5SW7J2ycLxLikdlEMzQzN9hTaYRYaupcCIuV5UGEm3PZesz
 7QOOOXjau8NOOjNWMZT3oViGDlx86NfVfk84yUNkc6z7ern2dK8kqv9BboI+G0LX1D4n
 8+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Y7WcXkyB2SsSCuxnbdm58cZx75IvMUDQfLeylZQwF8=;
 b=JkvajDEmtFZF7M8+aisui08Of/OoQRjM88i+3jf4m3X0TXXnGcL0FwB9S7HDlNHNyN
 QCJsidA8tJcueYEmLf6RYaMv9aDFEa1q56/RrvXCieQcQr2FV0xcSpJRbnMBNpB/y4u/
 yn9aZcOLrz3AvT7X5VG8OIjCQSl5S1NfWezZ21cFvjBl63l6WPVXfJCgma5BMqwKpRc+
 dHnwdCT22xToigU3Pj+UTzFqn0p/04lozaChwUPgmbevP/i+luKpLoI3usa8GGTtoEyK
 3n1fiFZiOIlfspQ5EDzLJeg2iGw5qm4EFv88Pji0gwZx6Dnh0m8PXJyp8PF4pcXIYQdb
 y0Yg==
X-Gm-Message-State: APjAAAXIzuPvO6MRJKkMeGIHomEUg7/7vMKOu+b5RTnve0LnROOiG8QM
 uh3kKl65JaFPJ6HPtZFDFQWLWN2shKWhz71lJ05GtQ==
X-Google-Smtp-Source: APXvYqwhH8Gy7RhdSjCAEYn9//rXzJtQA1xuW178I6YEy+5tRPmnUKwI/tp7qCVhQML8iCdDcutWlMcG1tEtWdtcZYg=
X-Received: by 2002:a02:b395:: with SMTP id p21mr37874965jan.31.1564985660493; 
 Sun, 04 Aug 2019 23:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Mon, 5 Aug 2019 14:14:07 +0800
Message-ID: <CAEiOBXWQ02uRQQOpP=Rauq8WZnYtoxNqjM--Rpi5tHX2W0bGsw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
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

On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:

> Some of the SoC IP block sizes are wrong. Correct them according
> to the FE310 manual.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_e.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 2a499d8..9655847 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
>  } sifive_e_memmap[] = {
> -    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
> +    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
>      [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
>      [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
>      [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
> -    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
> -    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
> +    [SIFIVE_E_AON] =      { 0x10000000,     0x1000 },
> +    [SIFIVE_E_PRCI] =     { 0x10008000,     0x1000 },
>      [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
>      [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
>      [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
> --
> 2.7.4
>
>
It seems the modification follows  E310-G002(Hifive1 Rev B) spec and the
origin is for E310-G000(Hifive1) spec.
There should be some way to specify different board version with different
memory map or we have policy, always support the latest spec.

chihmin
