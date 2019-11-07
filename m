Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15122C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B3A206BA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="2Gv2vFQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B3A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlI8-0001nX-0Z
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iSl7V-0005fD-ON
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iSl7U-00057N-Me
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:58:53 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iSl7U-000572-C4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:58:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id a18so1870266plm.10
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=SSF77W5ljtz4X2exwpOWBcNAR43MQ7/J9pvWQCD7wlk=;
 b=2Gv2vFQWvQsANsfINRgtnmGpO1lkxftxi+r6wmMYuc6+T1wdjtbI0I+3AtSprDYvM1
 udGPzzaIlgpMZLrzhGsbUfvDXSB492G9hRqQWcvfLrMZagJ6Sq6NkomIxkgRWgvMA7t6
 W42/RE4c9G66cDQTrNDEVcjg7QJ1LRrNvvPHVR7d/PwWCp5mq7H9YtBMXiyaLlgPIrrW
 PQqWLNjqp4aDQXukEOtdb2L3CynPCdPY2VaL73rDYeeakHrsA8Vfa53Pmp4dE7vQ0ffl
 HkhyUTiFv5SmQWBl+bnf3nRPTIcsbK7iczZq2EjjiVCZAJLjzvCGjiuQtYyZ+0NOamFv
 zqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=SSF77W5ljtz4X2exwpOWBcNAR43MQ7/J9pvWQCD7wlk=;
 b=ntULSJSIKg6dIt8ip4wSD8wc9INhXBGw9cYkn0eRR+9YxYwgyTmo8QysOBgieeTT1t
 BK2Uck2N3bqwGh3dIFIu6dE3+lJXBBTNrvTXL2sqUT3n7Mre6A94BKFv81VZ+7qCT42V
 9J0q8A8ibGIG3k3+yOOTjtPsohT5ZhFS6K3xBjO1zOovQu5quBPMNAgqs4KtXVcLUHkK
 cwIsGBUnImnagPREH2NbbzhB6fcl2cNRsUnud4j2np5g54HHxqVzV74LQgEN1owMTA5L
 8q8CEwRWqAZw1N7jEWKYxfHEGP6cEtHDOUJu5HyENNLPUe///ShVlLd94WRXqb4eUOM5
 Zk+g==
X-Gm-Message-State: APjAAAVgQ26AM/Mux9JRaL4kAoHnMhjR29jOc4Eq54L5jQ5/WKnKxoNe
 bfhLqIpzD3fhG6pQFOr8bPYIzRzFxCY=
X-Google-Smtp-Source: APXvYqxNDctI8BHXtYSYLrp0u2wqFzxx4+bAKNHtuef9ncnjI+kYTELDshtcJuv3kMJtavZPM7WkXg==
X-Received: by 2002:a17:90a:98d:: with SMTP id 13mr6383221pjo.98.1573145930748; 
 Thu, 07 Nov 2019 08:58:50 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 26sm2497779pjg.21.2019.11.07.08.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:58:50 -0800 (PST)
Date: Thu, 07 Nov 2019 08:58:50 -0800 (PST)
X-Google-Original-Date: Thu, 07 Nov 2019 08:58:24 PST (-0800)
Subject: Re: [PATCH for 4.2 v1 1/1] riscv/virt: Increase flash size
In-Reply-To: <03c2f42b32fb4e304319c241122ae83584f085e0.1573087610.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-35530489-a164-4825-90da-e550083fef9d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: alistair23@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 palmer@sifive.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 06 Nov 2019 16:47:20 PST (-0800), Alistair Francis wrote:
> Coreboot developers have requested that they have at least 32MB of flash
> to load binaries. We currently have 32MB of flash, but it is split in
> two to allow loading two flash binaries. Let's increase the flash size
> from 32MB to 64MB to ensure we have a single region that is 32MB.
>
> No QEMU release has include flash in the RISC-V virt machine, so this
> isn't a breaking change.

Even if we had, I wouldn't consider it a breaking change because it adds to 
the memory map so existing programs will continue to run fine.

>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cc8f311e6b..23f340df19 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -62,7 +62,7 @@ static const struct MemmapEntry {
>      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
> -    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
> +    [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
>      [VIRT_DRAM] =        { 0x80000000,           0x0 },
>      [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
>      [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

I'll include this in my next PR, which should be soon -- I was about to send 
it, but figure I should look at my email first :)

