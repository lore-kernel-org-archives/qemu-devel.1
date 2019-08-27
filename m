Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51359C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9AF214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BXf0wgFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9AF214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dlI-0003Tv-BZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2dkP-0002cf-Ln
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2dkO-0005Zj-Gu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:51:05 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i2dkO-0005ZW-BI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:51:04 -0400
Received: by mail-io1-xd41.google.com with SMTP id t3so47326521ioj.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v+lH8Rmoew2rqkppJIq9VYIhR98MkxmJCflZaHejMXM=;
 b=BXf0wgFU/Xjb7QZtSL7d6bIX2pa0hfSCY0bDGhQferoEj2kstXXnfA1/WRscJwh60C
 Q9eg/vn0wCdphHU/ASo8u3EaKSLG4kkqX+x3SALCQbPcie+grYOLRQwZ9KU2b/mTKUeq
 Xeg+8W7MiLRtablz5xqidnncSl6ENqQfriT4nlNIXYiQBHAz/ivXESBMludHbPToFpTz
 WUIdthv11SbFmdPBNARktLAGYsMh1vp4YYiTONzevsqAppHNs0X5Y8CgH3fbFBJkEvWG
 YBC8QsO68uiDNLHL9mo5VHihxZT4+AImynkdlUZAIuSzpLUz+/Ns3XO1j+VYm+BZfkEA
 a6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v+lH8Rmoew2rqkppJIq9VYIhR98MkxmJCflZaHejMXM=;
 b=nMBmMJ4fi2Mw1s4CXUNGA2x9vDGXis5N9Flu4AeWuGYePbkFCWH7pRBUB495vT07Os
 G5ZdqmvyUoXnGkgoz4Zj34bR8DQmgVlpYxZpAXAhGsHaF2mMGjLv9uFCMi4stEsxNJes
 6chQE2dnqX1ClFtIjpTSPsJAunMpYwRPVMZ5G4zMwY8ok+WaCr3ovKe4c7wPrg+IjAiL
 51HOj0J4WqI2HxFKwRLlEchCqQlDJLRD7g0DUwkNnXea9JQWv+2C1kpfvCh1+ruwJUYw
 xKinMVg5Xtc3qpWaJKuIDyxrC7ZW5E7ELaYkR+bqbdBBw4BzICYNu8veUB6Eh+X73r3z
 3Fwg==
X-Gm-Message-State: APjAAAUAyPNa8HmUEDY7QghuAKSxNdzKXg7oS6Mzi9INv7Oga8Dtp39+
 bSKNFZztLHBv0aehyGwpFkE2jUykLHsTuMTj9jx77Q==
X-Google-Smtp-Source: APXvYqzacKm4FYtxclYdKDgjQZnFnIPVeyN83/m+yGPla+26oZKxVenGpkrGAJmgRV7TewqnAdOnmPNJW3rbCIw0JOQ=
X-Received: by 2002:a02:a07:: with SMTP id 7mr23529361jaw.141.1566921063513;
 Tue, 27 Aug 2019 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566603412.git.alistair.francis@wdc.com>
 <e959ee81e5121c74678d2383a28665e44db9e31d.1566603412.git.alistair.francis@wdc.com>
In-Reply-To: <e959ee81e5121c74678d2383a28665e44db9e31d.1566603412.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 27 Aug 2019 23:50:52 +0800
Message-ID: <CAEiOBXX5RvuVjR805xnFDtGY-THYgUtiHvA-Yp-=NSP6SryUaA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 05/28] target/riscv: Add
 the Hypervisor CSRs to CPUState
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup.Patel@wdc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish.Patra@wdc.com, Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 24, 2019 at 7:45 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> As the MIP CSR is 32-bits to allow atomic_read on 32-bit hosts the vsip
> is 32-bit as well.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3a95c41428..4c342e7a79 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -154,6 +154,23 @@ struct CPURISCVState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> +    /* Hypervisor CSRs */
> +    target_ulong hstatus;
> +    target_ulong hedeleg;
> +    target_ulong hideleg;
> +    target_ulong hgatp;
> +
> +    /* Virtual CSRs */
> +    target_ulong vsstatus;
> +    uint32_t vsip;
> +    target_ulong vsie;
> +    target_ulong vstvec;
> +    target_ulong vsscratch;
> +    target_ulong vsepc;
> +    target_ulong vscause;
> +    target_ulong vstval;
> +    target_ulong vsatp;
> +
>      target_ulong scounteren;
>      target_ulong mcounteren;
>
> --
> 2.22.0
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
