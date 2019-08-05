Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE47C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98659206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Unr+lODJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98659206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huWLa-0001aP-NN
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 02:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1huWLD-000199-Ny
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1huWLC-0007D5-HX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:19:31 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:33457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1huWLC-0007Cl-C9
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:19:30 -0400
Received: by mail-io1-xd29.google.com with SMTP id z3so23798939iog.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1DuDiNQtglBjRp20PSFaAsKw2FXyDFQdSpQgrUHAhrQ=;
 b=Unr+lODJwsfeBZ4k2YWDLoIjYAPk2uEP/U7hIe1Ps1FWyPgeWe+iYHHv178qw6dqWf
 FgLVVz++4geNrupnH8CV2qW3ZU0IZpOzB0W6L8o+Kq8vWoQ8eeSEcxxcsO3OTiDc9iSl
 /P3QoHV5hz12nj8nh9kYlK63jh8lQj0aed54Usm4+dHf8KgQu9iV4rOUlAqwhYCjbuq4
 Q7PERTpzDAqqXZ2RAV22QG5vXPPWy8GKmILcho1EAC0yqFRLF1EtTBTk56+CrlnKtFCg
 WcOjtHDtD/8slw9MnDfMfqwS/bMwZR0vivcsRmcsncJV6hylIfiBC26si2NyKWm+xaqL
 IUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1DuDiNQtglBjRp20PSFaAsKw2FXyDFQdSpQgrUHAhrQ=;
 b=osPnGV/FqCLJuiwVEZz6FGi3u3HI8JAcm+MvU8UawfGyzYB4/qF4jfG1yMyzqrL/xa
 1ULevCWq1jP0xLoT4Z53VuiBcpZjlqgaqz+Gc54y+2j4RV8AHVlWpi5+KOH5SVPGcVj8
 MGvTDTQnf/6ZSidGNO4rsWT5II4zJBQPABCqfpKS2MLzCzTJ/18Q34QXTs8YaLUkhJ4u
 rf3czILuaW3v8Kn5kfMxgmztrpcVRMF+SuM6dJbAqjBAO1O8yUuSEjW4r4U4220ee0Em
 NTzsT9zVlytx90lRGXB+hh5Q5tN0+RF0T/lHU55Sl/Ii+o2YvROJA+IE+iCBYiZqYQPo
 7fYQ==
X-Gm-Message-State: APjAAAVPecCEg6FWdMk9hQtS6BEj1QTTfJEtmGgDucx2nhGtgUz2iGbn
 +txQivHPjh+Xcc8cFL8acNtBWyaqm0OkX6Vfsa4bPQ==
X-Google-Smtp-Source: APXvYqxqn2qEJJSnuvLXt71c50oqODpWb07xyU0/rlt1d+LlV7YtHOU2bycs7IOYdsu9VUad1MpNztX6W7l61iGnwWQ=
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr38682669jao.58.1564985969333; 
 Sun, 04 Aug 2019 23:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564529681.git.alistair.francis@wdc.com>
 <dc666f1d37590b76d66415941bc24fe5a7cb46b4.1564529681.git.alistair.francis@wdc.com>
In-Reply-To: <dc666f1d37590b76d66415941bc24fe5a7cb46b4.1564529681.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Mon, 5 Aug 2019 14:19:16 +0800
Message-ID: <CAEiOBXVxn+AXX0M4U_mYzfHVjTECoCUxmPLpUZBFDXCB4i-gXQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d29
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-4.2 v2 4/5] target/riscv: Update the
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

On Wed, Jul 31, 2019 at 7:40 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Update the Hypervisor CSR addresses to match the v0.4 spec.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 11f971ad5d..e99834856c 100644
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
> +#define HGATP_VMID           SATP32_ASID
> +#define HGATP_PPN            SATP32_PPN
> +#endif
> +#if defined(TARGET_RISCV64)
> +#define HGATP_MODE           SATP64_MODE
> +#define HGATP_VMID           SATP64_ASID
> +#define HGATP_PPN            SATP64_PPN
> +#endif
> +
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
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
