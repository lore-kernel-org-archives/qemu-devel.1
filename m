Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE4C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 22:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951C2218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 22:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+JD85aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951C2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ3LD-0005MB-Ot
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 18:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iJ3KT-0004ut-64
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 18:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iJ3KR-0001Wk-PN
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 18:24:08 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iJ3KO-0001Mn-JK; Fri, 11 Oct 2019 18:24:04 -0400
Received: by mail-lf1-x141.google.com with SMTP id u3so8065243lfl.10;
 Fri, 11 Oct 2019 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k98FUPIsfV/LM/5NVcO5lDSAEMNWmkx1yca0Rwd7Ozo=;
 b=k+JD85aKN0Gr3kB0ykAR0dZ7YvVqhK0X6crBA3FYyV35OwIFxT/SiP6WHVvoaA5kUY
 CHfUJQqsa0Zsxu6TQyctkR+BMkwTbl2smAFmVsn0r8zJ+fyVzmJGDSi6T1huTSIdgUl/
 J+BV3PWABp9rOFB1cmxgJKZgqRB4P7zn1/Op2iIUpyfLK7tqTFYbdsZyN5nqPHYfuX2n
 t3fuV44HFSf41LtgH0VFB4G+au4NpAA1X9u07Q+Rw8GIsMfAUSHYPGJkmO5qAJ/5JADR
 XnqH73oLU9TCxOUbH7gZhwaH+DQ5SmtarUVX8lVTngf/FSkrqbNe0myhglc8xtugRc8o
 H51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k98FUPIsfV/LM/5NVcO5lDSAEMNWmkx1yca0Rwd7Ozo=;
 b=s9QFVvoYiM60H3vNs3vsMYPn2mlFCeWIcEbtuTBCZXYvN3pckIniW/qXGy9VZUpywQ
 TTKPYQfnRxnDW5zD4jXDHv2S8EKxDm6LVoyf8b2ZF3z9PboGmptY0YH1aSUqBKe8edc9
 qWG8voDyC/08WJJ1NC894xYBfDAJ2l7xIImtN0Y/gw53NERwBJbJQWFUA/VrzFUI9MYg
 giAqRQ5XXfNf3ngUCu7ecU0iZcbJ3s+63HTkoawTf0xokZ6W5iLdSrLR8D4jMuy3cZPx
 KhrnnMOuAeckk3qgzBHHf9t79PLPNfFeip7h9gUD1AeFxkoBN0i2tcB54hhjXjC/prxi
 Ms2Q==
X-Gm-Message-State: APjAAAUVi6x4ZPHxVbjtARIt05+bTeAzfTmuOFc92eNId4xyd/wwbXty
 5mvmeuMQ5XNCEPcnAaNYT87HJgeDVhmepr6kIUg=
X-Google-Smtp-Source: APXvYqyvRX8vT89krooWVA7CZwnqTWVr6sLq6Defg7QJnoYUZ5KiohFYzFdq3DYSbti1s3nCYZZKpZdcDKP7T7K3G9k=
X-Received: by 2002:a19:c392:: with SMTP id
 t140mr10228222lff.156.1570832642085; 
 Fri, 11 Oct 2019 15:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <LqVBb_I--3-1@tuta.io>
In-Reply-To: <LqVBb_I--3-1@tuta.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2019 15:18:56 -0700
Message-ID: <CAKmqyKNh-jgg-LWHp4RMM9vaaMNr7qHtNSVYs9OFXhvJ-+7RXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv/pmp: Fix bug preventing
To: Chris Williams <diodesign@tuta.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Qemu Riscv <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dayeol@berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, Qemu Devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 6, 2019 at 1:32 AM Chris Williams <diodesign@tuta.io> wrote:
>
> Hello. I hope you don't mind me resubmitting this patch. Please let me know if

Not at all!

Thanks for the patch.

In future if people don't respond you can just keep pinging your patch.

> I've formatted it incorrectly or if it needs more explanation. My previous
> attempt probably wasn't formatted quite right. This is my first time
> contributing to Qemu, so I'm keen to get it right - thanks.

This whole paragraph should not be in the commit. It can go below the
line though.

Also please use `git format-patch` to format the patch and then `git
send-email` to send the patch. There is a whole heap of detail here:
https://wiki.qemu.org/Contribute/SubmitAPatch

>
> This fixes an issue that prevents a RISC-V CPU from executing instructions
> immediately from the base address of a PMP TOR region.
>
> When jumping to an instruction in a PMP TOR region, pmp_hart_has_privs() is
> called to validate the access. If this instruction is the very first word of a
> PMP TOR region, at address 0 relative to the start address of the region, then
> the access will fail. This is because pmp_hart_has_privs() is called with size
> 0 to perform this validation, causing this check...
>
> e = pmp_is_in_range(env, i, addr + size - 1);
>
> ... to fail, as (addr + size - 1) falls below the base address of the PMP
> region. Really, the access should succeed. For example, if I have a region
> spanning 0x80d96000 to 0x88d95fff and the CPU jumps to 0x80d96000, then:
>
> s = 0x80d96000
> e = 0x80d95fff
>
> And the validation fails. The size check proposed below catches these zero-size
> instruction fetch access probes. The word alignment in pmpaddr{0-15} and
> earlier instruction alignment checks should prevent the execution of
> instructions over the upper boundary of the PMP region, though I'm happy to give
> this more attention if this is a concern.

This seems like a similar issue to this patch as well:
https://lore.kernel.org/qemu-devel/20191007052813.25814-1-dayeol@berkeley.edu/

From that discussion:

"In general, size 0 means "unknown size".  In this case, the one tlb lookup is
going to be used by lots of instructions -- everything that fits on the page."

Richard's last comment seems like a better fix:

"You certainly could do

    if (size == 0) {
        size = -(addr | TARGET_PAGE_MASK);
    }

to assume that all bytes from addr to the end of the page are accessed.  That
would avoid changing too much of the rest of the logic.

That said, this code will continue to not work for mis-aligned boundaries."

So I don't think this is the correct solution. I'm not sure if Dayeol
is planning on sending a follow up version. If not feel free to send
it.

>
> Signed-off-by: Chris Williams <diodesign@tuta.io <mailto:diodesign@tuta.io>>

It looks like this is a HTML patch, also ensure all patches are just
plain text, `git send-email` will do this.

Thanks for the patch though! Please send any more fixes that you find :)

Alistair

>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index d4f1007109..9308672e20 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -235,8 +235,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong
> addr,
>      /* 1.10 draft priv spec states there is an implicit order
>           from low to high */
>      for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +        /* catch zero-size instruction checks */
>          s = pmp_is_in_range(env, i, addr);
> -        e = pmp_is_in_range(env, i, addr + size - 1);
> +        e = pmp_is_in_range(env, i, (size == 0) ? addr : addr + size - 1);
>
>          /* partially inside */
>          if ((s + e) == 1) {
>
>

