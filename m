Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A023FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B97520880
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rerYXtkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B97520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huhDJ-0008U5-QL
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1huhCi-00080w-BU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1huhCh-000227-Ay
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 13:55:28 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1huhCg-0001yb-W4; Mon, 05 Aug 2019 13:55:27 -0400
Received: by mail-lj1-x242.google.com with SMTP id z28so25804949ljn.4;
 Mon, 05 Aug 2019 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h6DShDWj2jKxyBG0bcoZTwCF6QDqjVvIRRw8CrwIB8k=;
 b=rerYXtkQNkd5+Ta/7hBZ3hdM2SIBtbsquKi4YRMqpJQkRzOHFfao4jHlcPA8RutPFj
 lK0JEWuvwB2CtgIsmxO4TPtytWks75gt9XAHSXMHEn3C+v5tAOIwFu8bMDo5JcgQm3A9
 RBfqmrtDNifXIAypyJ9Jlxz1ZBH0iO1jmc0jP+F4q1dxBjdcHyLYzwAWt0Pih5NaBo5P
 WNw7qkYNcfa4+xaeIBxeSLk+oOZFRIFvkM2m3EWc4ko4+nQH3HhvH7JQnMQTpMA48BRT
 anzFyPQwNM8V4OWnuhQDPVlOMhUXuw9g49IO3zDF94xhWZTejRvD/rfniMiViU8aoSW+
 dI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h6DShDWj2jKxyBG0bcoZTwCF6QDqjVvIRRw8CrwIB8k=;
 b=g5gZ0iofQ5Nw1ggeuTwGUM4SPJgloP/1k71Yal0M+btgdBFGsyVgXjzgyaRI1upzaQ
 2SXBw/ZepxzHYbgzuV1QwA0+8usngUQfNA9r5xzzVP/NEHQNYJJwV6SAgBSnmkxf2M6M
 c9tIGA2PHt0V7XlVq4jWJ5B8jaRHy4DedAQv113VzoG3kKwlDkPxFgCMPWoId2CUhXUv
 7dbow6HCUqBq96f1vU1T5AH9jaK192gcIqjsiU1QxKKzw4uYJthckEZQly4UTSG8t+3v
 D9iv+LwOJjIsKHQNSegXCrhNW1BD4wen/t5VJTPGFiCkehK0yjNQqBf3jiITd+36Mxzn
 8Dpw==
X-Gm-Message-State: APjAAAVm8AR4orwBSePchbltLm+J/yc7rHOyQMC/6iZQeR3q55n0kDF1
 k+YoRWyQS2ydXBSD2/LPcaYk4D5i7AoJl/LXtY8=
X-Google-Smtp-Source: APXvYqzxKz5wv3l5ZiALRRtwva8uIKl3+ODLv4YzPpBpXgj8Us7UM5nPBxl7dXE7Mxq94hvgBa7tbg6LBMvrUlgy+e0=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr33819250ljg.33.1565027725655; 
 Mon, 05 Aug 2019 10:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 10:51:46 -0700
Message-ID: <CAKmqyKPZ=hrwbrDQ6kZCiGfbRL4AO4V9i2Pr7kti0h=2=YMu9Q@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH] riscv: sifive_e: Correct various SoC IP
 block sizes
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

On Fri, Aug 2, 2019 at 5:27 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Some of the SoC IP block sizes are wrong. Correct them according
> to the FE310 manual.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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

