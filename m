Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C56C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 18:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E46220663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ6UQ94a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E46220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iekQG-00014J-4W
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 13:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iekPV-0000QM-MG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 13:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iekPU-0002Ry-Ll
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 13:39:01 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iekPS-0002PJ-DA; Tue, 10 Dec 2019 13:38:58 -0500
Received: by mail-lf1-x143.google.com with SMTP id n12so14571030lfe.3;
 Tue, 10 Dec 2019 10:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Um02XhQDSOXqFThAJBB5utYQHbTlMcj0aoANmKJJuk=;
 b=CQ6UQ94apAhPFmtn0lQ1Nv8qeDAtP59Pt1hwQXFS1eP/JPkJc7hD4pHj6JJJ9au0Zw
 tXOPBL8JlUhapBF+h15uRO3Wri26ZqgrbZ03FtM680qOGU6xLu0MItW0N52ySFfbtBj3
 rhLjdg7JH6R3QF4Jjn8S//T9fvWd0o0PSShydf654vpWh8CThO07ydiIZnbk9ihq1RQO
 gW+0d7wfp2Xtr/rZxq4dz6ewtrNx7z4XFYjGOmWArn06xwojscoCreSAHNafyxRkrCsq
 uJlUmtPfvUI37JLuGIDjntWVG4JzQJvsJXJ8/1g07/LHzIOaeR0/nBX8fGs1A/OIeiJR
 Z9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Um02XhQDSOXqFThAJBB5utYQHbTlMcj0aoANmKJJuk=;
 b=t9Bf18Er/xgB5tEvfcJ1lqVkN/UNWStrz5fqQEewAErh40z0ZZ/4HjovfzonYa02Ee
 4XRZBG13l8ZSNiBYFy/o6z00blkagpOVv9U1x4cYJlohHM9i5QQpufwhmZ4FKBLeURSs
 zbzms+kAz7CrFUpNZh7H90IhRap8Fs6hxvsCnxIObiDZKWKIBczEfbwJdJIMtTGhVFgZ
 WterS1HBpU5j4BQwbx0MkhGnbOF7LQP9Rv5E9G5VOlHjAYx+lF84aDO2ZOuHAqN/UB7R
 +YI5uISj4NdnhOWdJ40vQtkDEDJMZiytVwnJ5h1Gzl7ps4TM73JsvHxK+tWwunhSgCN+
 7FKw==
X-Gm-Message-State: APjAAAWhijGmDr5n1OHuBvNufAahPAg4hK3BCUa1L8T8aW3As6tQy7BG
 2COeBRW9znaDysiYF0gdbiDDzWPbRbh9VqUmCEM=
X-Google-Smtp-Source: APXvYqzCPPMdqUl/gbARWa3GIyn/8VO3DBPZHjdMuD3Py/uVn9/N6/x//wcU1RN1/6r0eN2lirTj6AjTmDsi0qAdIfM=
X-Received: by 2002:a19:c0b:: with SMTP id 11mr17290123lfm.135.1576003136065; 
 Tue, 10 Dec 2019 10:38:56 -0800 (PST)
MIME-Version: 1.0
References: <1575962077-28800-1-git-send-email-pannengyuan@huawei.com>
In-Reply-To: <1575962077-28800-1-git-send-email-pannengyuan@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Dec 2019 10:38:29 -0800
Message-ID: <CAKmqyKNH0NdhksX35C7Cm1e51in-iRBrmH8TJWGYregCgLgO6w@mail.gmail.com>
Subject: Re: [PATCH] riscv/sifive_u: fix a memory leak in soc_realize()
To: pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, zhang.zhanghailiang@huawei.com,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 9, 2019 at 11:15 PM <pannengyuan@huawei.com> wrote:
>
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> Fix a minor memory leak in riscv_sifive_u_soc_realize()
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0140e95..0e12b3c 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -542,6 +542,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          SIFIVE_U_PLIC_CONTEXT_BASE,
>          SIFIVE_U_PLIC_CONTEXT_STRIDE,
>          memmap[SIFIVE_U_PLIC].size);
> +    g_free(plic_hart_config);
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
>          serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
> --
> 2.7.2.windows.1
>
>
>

