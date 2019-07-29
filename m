Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D68C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD05206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MNUgdHA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD05206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7c3-0007cx-4C
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hs7RF-00023l-UV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hs7RE-00034v-Qo
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:49 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35]:35440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hs7RE-00034Q-Ib
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:48 -0400
Received: by mail-io1-xd35.google.com with SMTP id m24so120879686ioo.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WAiALMNkzL5uN9MeA97W3K0oNByFyZcmznPBDqq7Mfg=;
 b=MNUgdHA+VXLTXnxNT+CZ3mZ35wgasz0fMgnC0vyczUFKyLa5LhpUlxtB/Uhfi6zjJt
 qOjWaaQuEjGcV12AAsiSu7zzVqZpFkI21eFhUo2F3kUnshknd6Rt5qNbPmpabXoDd3TA
 JOUHO/vVZTLhVN1ainlSyS+PQ5KbxWvSM4/7OgOlkMbKIQH1Wr55N5F86kofYESycsJr
 OSI3MizvrE5DOo+1+DOHvYXfotFfQQEQwdIMyVXYFtYHOo0KxE8uPQuhwWzkpy2pxrS2
 71nQDttFpNOydnfczve0ip9zfzgOuTP4MPkUDwklNwobL393FHo3OKZgOlNkDubYZCcM
 op6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WAiALMNkzL5uN9MeA97W3K0oNByFyZcmznPBDqq7Mfg=;
 b=RNIQ6i5z7zyAVh+HuRIfWidSFecOPVKmbyQRfn5pNsHeNGhlQrRFdM1k6CSg6cvgOl
 N4G377scIFG1mlGalhJ+jNj3OfJa8Y7he/xwWeqfdiVTmuk6uV8M7MM+h54EmVZUeU7i
 265n59m+brciWLSkU9cnP62uZ0/pZ1ERLPZrQTtCBo3mZL7xG7wr/XaNq8f6KwAGjztY
 Nz4ecFz4PvFW9uw7NDjx8SUuztiaiCB+yRrmfm8guBnPlIPWKZ18XZHNkPGDUqxWlGhv
 /x41qYK0ymH+rTGlwlrEtnJFguvoMBPk5VWaiu/lbu8yIS1wdvJ1hnMfvVzzlcbhffvG
 n9Kw==
X-Gm-Message-State: APjAAAVv2aTA1urMQ1dfR3azU7dUB4ev84J3PYz8Kzp5gy+LN80ujgE5
 UtwS2aVbdygyWZM8sMffHOIaEruNL1Ty8Js69lMGLg==
X-Google-Smtp-Source: APXvYqwDxlwzlziWG2rmZ3MYHWHVSrbJZoc2VKOT+ol4vPkJ036OR/oV9QpSRV2XOPC4wAOhLpEj0H2Urmw2MPMj+58=
X-Received: by 2002:a6b:4e1a:: with SMTP id c26mr54148491iob.178.1564413587616; 
 Mon, 29 Jul 2019 08:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <4116c27c037b5e7f4822cfd7199724450dc6b5da.1564080680.git.alistair.francis@wdc.com>
In-Reply-To: <4116c27c037b5e7f4822cfd7199724450dc6b5da.1564080680.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Mon, 29 Jul 2019 23:19:36 +0800
Message-ID: <CAEiOBXUcwp5rZbdH7VuQjnM3Xq5-ONTWmcDp1Da+C1n_-w95Uw@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d35
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 6/6] target/riscv: Fix Floating
 Point register names
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

On Fri, Jul 26, 2019 at 2:56 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> From: Atish Patra <atish.patra@wdc.com>
>
> As per the RISC-V spec, Floating Point registers are named as f0..f31
> so lets fix the register names accordingly.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20a..af1e9b7690 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] = {
>  };
>
>  const char * const riscv_fpr_regnames[] = {
> -  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
> -  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
> -  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
> -  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
> +  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
> +  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
> +  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
> +  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
>  };
>

Could you indicate the section of the spec ?
By chapter 20 of user spec, the patch changes the floating register name to
architecture name but leave the integer register use the ABI name.

chihmin

>  const char * const riscv_excp_names[] = {
> --
> 2.22.0
>
>
>
