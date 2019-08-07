Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87604C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CE622305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YSdPLmLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CE622305
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHog-0002M6-Ky
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49557)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHoE-0001uO-50
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHoD-0001tV-48
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:00:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvHoC-0001tK-VR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:00:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so101392824otn.9
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/CCm4A5Olufvollna31VV9arJaJ3pA9JKUKma77ctzM=;
 b=YSdPLmLfT4fThFHNds2eNrcZ1LOfcAfLqvpBAodR3yylq9/JcDUr+oOVzgKXilJobH
 4ACC2ZM3ikM9qNsqvPU0J446etVN6kjrG6xlwuxZe5fRppJPmgBUm1VFcct7dVuYZJYb
 GCbZfFn7K6oASCPc5or3GSSYrdaw5br7m0CMyjy9svCF9cLjBLVs6ITenhOzcunw94kW
 sWFEn4FU4Se1COZjb4zDjwouLFp+EP5M857N3QI94aFxVnaoFlI6VAO2cgaPtGXI3/di
 +Mn/ce/Hv+Gqv1WJfELRK1+OrQ+JZZTr0lwLeU6uGN6NqfXPyfEYCzjvzvS0enMkoH6T
 KaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/CCm4A5Olufvollna31VV9arJaJ3pA9JKUKma77ctzM=;
 b=Ow3hrVbHORHZ/B9mgtF0DXItq+9B9Xg7UoAbNG54U3aSDRiKg9E8/K49l2Gf4ZEH7f
 wTOFI+dAMqdcy1Hz1aB/qP1Hb9/54qclJInq7Qftour26iPRoUBbnhtBbHA25tHTYAyz
 rAYqI712FZ+2icX0fqWRohmkAlIzTfq9aCVkXYOGsIJIPg71azGC/ac9pcMWZ9MR+ek1
 mpPaxxjxJdaXuNzacRsaGxnbX17GwcXmdzgfQ0pdxJO0iFxnSW23dqPaQJl7q1Al1XAT
 qhm1cbzhoDtSH1qwbutb6lZpL5XvjrsZptF1UVIz4hxy7Z6eGIwKWgRgZtGKQqWNxNtn
 wYFw==
X-Gm-Message-State: APjAAAUcfHOt50Ye2a3gFjqltf3ddRgSAj6XbIDddAiDimOr3GJfQMpL
 wOqenzpgdsx0Hn3l107eKGGTm77ZoVJaVGV16dJmdg==
X-Google-Smtp-Source: APXvYqzkE3gQZZK7bSSpv7qx9tFtv3olJqCAgyhFjIlkUz7l3m6Rt6XIWRVxLG0FSM0l7q8RPsEhd2Hy+a/AOZCxqBE=
X-Received: by 2002:a5e:881a:: with SMTP id l26mr8086636ioj.185.1565168436343; 
 Wed, 07 Aug 2019 02:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-14-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565163924-18621-14-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 7 Aug 2019 17:00:25 +0800
Message-ID: <CAEiOBXWAvHyrxTFQryH2ChSCTk_iZU9mQstcmh+DT2bmS3pp+Q@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 13/28] riscv: sifive_e: prci: Update the
 PRCI register block size
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

On Wed, Aug 7, 2019 at 3:49 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> Currently the PRCI register block size is set to 0x8000, but in fact
> 0x1000 is enough, which is also what the manual says.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> Changes in v2: None
>
>  hw/riscv/sifive_e_prci.c         | 2 +-
>  include/hw/riscv/sifive_e_prci.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
> index c906f11..4cbce48 100644
> --- a/hw/riscv/sifive_e_prci.c
> +++ b/hw/riscv/sifive_e_prci.c
> @@ -85,7 +85,7 @@ static void sifive_prci_init(Object *obj)
>      SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
>
>      memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
> -                          TYPE_SIFIVE_E_PRCI, 0x8000);
> +                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
>      s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> diff --git a/include/hw/riscv/sifive_e_prci.h
> b/include/hw/riscv/sifive_e_prci.h
> index 7932fe7..81e506b 100644
> --- a/include/hw/riscv/sifive_e_prci.h
> +++ b/include/hw/riscv/sifive_e_prci.h
> @@ -47,6 +47,8 @@ enum {
>      SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
>  };
>
> +#define SIFIVE_E_PRCI_REG_SIZE  0x1000
> +
>  #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
>
>  #define SIFIVE_E_PRCI(obj) \
> --
> 2.7.4
>
>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
