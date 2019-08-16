Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D679C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064F62086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQWACyH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064F62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycxs-0007dY-6S
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hyclT-0003fB-2I
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hyclS-0003oE-3s
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:59:34 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hyclR-0003nR-Sr; Fri, 16 Aug 2019 09:59:34 -0400
Received: by mail-ed1-x543.google.com with SMTP id w20so5216222edd.2;
 Fri, 16 Aug 2019 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oGCfzZeHGWIUbTwKpxV1Bv6Y1t8I17TWnHFwqZIwhtA=;
 b=AQWACyH3QHfMlIuQM9XXcTAwqP5Z6a0cSfxWv6cFtjI/I4WudGQCvnz57LsQVHZKJU
 sGrhWwrDYLdN5HEUinbgJc/o7Ll81stmSSXzb8XwawcrZcGB5iMUcua+123T+Qri6L6x
 7fS17Q8easraYkB4Os/LE96p6JbrwXUV2/rUlRCIGiU/xKbzEnYuXtq/Er5FFmbG+mGH
 o+/XucHCfodeF9hcCxb1xCjA91EC6gGSo0/CKqpe/H9spAt3Fzt8/2pfzTNleWp550cc
 ocFBAi2fbQ2aqilvYBp9dQ/wnHewH9rKDi3Dg9D/038oxCCtT2/nuGu1eJVXXiqfAA/I
 C06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oGCfzZeHGWIUbTwKpxV1Bv6Y1t8I17TWnHFwqZIwhtA=;
 b=bs7D+EanLHxmQRENej3njdcrRWdL7Qy8uq2idySdn2xNnTqS6DiByCtZqo0OPQHm8h
 cWYy4+LZFL+afovlY9cuSHZAdQh3QcQLJykjb+JYBdRHnv5GMCDXHFDloGjngA3G4wqJ
 yFtMxvQxwnpPJFQGYdLeG1Kgp0a2yHMlrv+2MWR7kRpFf0tPw7BhJx6/fTBa2eADcIhH
 lgWFeknASNU7we6QSyVTBtvBurlK0eIebKnZ47atXFRnOWxrrCLT1ZWUNL8GwE0nBTEQ
 yR/EkzWZg0Yel1p5sAf9XxvHDbXpysY4r/REdGUm9RxQ6GjqWT7NwSriU3KjIg05lu91
 wahw==
X-Gm-Message-State: APjAAAUz7cY5TGSwpVvpV3FquYzOz5FbZB072kCeH4/XDWe0siBL/MGq
 rdGF5PrYikUpzq0GNV3SWHaD/NF+Q2T1K7LkkJs=
X-Google-Smtp-Source: APXvYqyp1tOIzSzFMRvN/wJR3ocnKlIwSqIn90sjN+IvT8x5KJVovMjxTrdISD3yLIRkAm76U3E64fs2f8ZGWdbgvys=
X-Received: by 2002:a50:8687:: with SMTP id r7mr11015604eda.137.1565963973118; 
 Fri, 16 Aug 2019 06:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565904855.git.alistair.francis@wdc.com>
 <083ae70e31e202880ed8babf4de1a3c1ea27100b.1565904855.git.alistair.francis@wdc.com>
In-Reply-To: <083ae70e31e202880ed8babf4de1a3c1ea27100b.1565904855.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 16 Aug 2019 21:59:21 +0800
Message-ID: <CAEUhbmUcqe-1PjctdPA9R5jSRaJxZuPb3swKbn34fGU1DhhGQA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v3 6/7] target/riscv: Fix mstatus dirty mask
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 5:38 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

