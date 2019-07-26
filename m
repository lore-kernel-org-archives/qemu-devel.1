Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370AC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D688621851
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hpP+t8Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D688621851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4DZ-0007AO-0J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hr4DO-0006jM-SE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hr4DN-0008It-J6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:41:10 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hr4DM-0008EG-PF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:41:09 -0400
Received: by mail-io1-xd43.google.com with SMTP id k20so106400280ios.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ju/a+1ebffMbw9h6KBThpPtb9pMJ4DA4Jdq1yJbuP4=;
 b=hpP+t8QmysjSYiI9a7e4xKQjOnT6n0ylUA6FJobdF+XWMyaWnOrs0nd5ZvXzrT4Z6H
 BRJEAUGv34Qc278BN/r3aSs2V3LFqGf5TAf6W4y2Al+MKwhHtUdCIVZbC5w6VqXktBew
 uZnF7qq+++fBDyQYbgT4mcMFUNn+egNq7Qp+nm5JnEHMekF5QbzoOusNiEW/NmV5iuPx
 GeOP5097BoeM7HcGidqY12Xo4vqyGY7rtGY4RJYEbLF2+SOrkExAjalp08t4BYZ0Fw0H
 q4iN+0U5WXPX/QGwJ2l76bcQEQZSozUaduSlwFO4G143yDuGm0gS907VXMUjqDXqYWGo
 ulTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ju/a+1ebffMbw9h6KBThpPtb9pMJ4DA4Jdq1yJbuP4=;
 b=VUBu2tycZNo0ys0RVDsgBddrVhBzjRZoEIyIfFL7xvWsv9W6LnI8L1l6bGmLuW/zj5
 HsxLXhkW+5NTcQjkvIWSoGs5d4s/x6jUf++xJxj9ZymdJF9BGlLpbexCqcameKLKpDrg
 p77fvsiDOn+rAGAIJA6ZWe8RI/dushe9aVwiq7BCbJ/tHqPQZXQjw1uyiK3xJbFSyUbe
 6bCV8yKiCGueirvu4Zdm0EXPwioDe4tbG1mEMDC36Tm6uNzE+Ep70e9mx0cvbIBDAD9U
 WIHtUuFHbEw86MUIWy1TbuhyM3A9OXNnK1usSjo8XBFd06ubAxmuryLxV/nJL2/IGwib
 EAFA==
X-Gm-Message-State: APjAAAW0Yx/YVYQSh7GST0DtYWMtEFqF5o/Y59oGuuX6x9ESogkO4ykq
 czdA927JPMWqDsB189mtZoye43jIO/fJOfk/pwo0AQ==
X-Google-Smtp-Source: APXvYqzkOSDU7gL2bu6uGizTvuxl8UnN2dq20ncNMuoCGmnvDzT8je+rXpUDRs+BJIbjdjqovYOVBtGeR4+2jsTHraA=
X-Received: by 2002:a6b:4e1a:: with SMTP id c26mr41036969iob.178.1564162867014; 
 Fri, 26 Jul 2019 10:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <10db21dad60854653b7b6272a44a63e2473af2b0.1564080680.git.alistair.francis@wdc.com>
In-Reply-To: <10db21dad60854653b7b6272a44a63e2473af2b0.1564080680.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Sat, 27 Jul 2019 01:40:56 +0800
Message-ID: <CAEiOBXV1CfOfpTFFNas0cALjAkhjgDb78GkLusPO2bzoHROrxA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 5/6] target/riscv: Update the
 Hypervisor CSRs to v0.4
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

On Fri, Jul 26, 2019 at 2:55 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Update the Hypervisor CSR addresses to match the v0.4 spec.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 11f971ad5d..97b96c4e19 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -173,6 +173,24 @@
>  #define CSR_SPTBR           0x180
>  #define CSR_SATP            0x180
>
> +/* Hpervisor CSRs */
> +#define CSR_HSTATUS         0x600
> +#define CSR_HEDELEG         0x602
> +#define CSR_HIDELEG         0x603
> +#define CSR_HCOUNTERNEN     0x606
> +#define CSR_HGATP           0x680
> +
> +#if defined(TARGET_RISCV32)
> +#define HGATP_MODE           SATP32_MODE
> +#define HGATP_ASID           SATP32_ASID
> +#define HGATP_PPN            SATP32_PPN
> +#endif
> +#if defined(TARGET_RISCV64)
> +#define HGATP_MODE           SATP64_MODE
> +#define HGATP_ASID           SATP64_ASID
> +#define HGATP_PPN            SATP64_PPN
> +#endif
> +
>

Basd on spec, is HGATP_VMID  preferable ?

chihmin

>  /* Physical Memory Protection */
>  #define CSR_PMPCFG0         0x3a0
>  #define CSR_PMPCFG1         0x3a1
> @@ -206,23 +224,6 @@
>  #define CSR_DPC             0x7b1
>  #define CSR_DSCRATCH        0x7b2
>
> -/* Hpervisor CSRs */
> -#define CSR_HSTATUS         0xa00
> -#define CSR_HEDELEG         0xa02
> -#define CSR_HIDELEG         0xa03
> -#define CSR_HGATP           0xa80
> -
> -#if defined(TARGET_RISCV32)
> -#define HGATP_MODE           SATP32_MODE
> -#define HGATP_ASID           SATP32_ASID
> -#define HGATP_PPN            SATP32_PPN
> -#endif
> -#if defined(TARGET_RISCV64)
> -#define HGATP_MODE           SATP64_MODE
> -#define HGATP_ASID           SATP64_ASID
> -#define HGATP_PPN            SATP64_PPN
> -#endif
> -
>  /* Performance Counters */
>  #define CSR_MHPMCOUNTER3    0xb03
>  #define CSR_MHPMCOUNTER4    0xb04
> --
> 2.22.0
>
>
>
