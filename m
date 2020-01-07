Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C90AC282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1EA206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhSYuse9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1EA206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotcj-0001Mh-9P
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iotai-0007jV-9M
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iotah-0003VY-83
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:32 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iotah-0003Uh-2o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:31 -0500
Received: by mail-pj1-x1044.google.com with SMTP id s7so156834pjc.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=QSlAdgkdBtCqgeZMjTjn8Ck356ySWYi2bzB6dzsyjg4=;
 b=XhSYuse9Q2zBTLf/c61wE29rneUO+J1PsaE6XUPVhISKGmdPY0kV6qO+08VhkS16cf
 VXO7WWAe2rF7VWPsJxTFCxdpiONtR0xW9LM2ueeFb1qYBMw1Df3TE8tGqoVvPc8Ky61F
 2RaRr8Iq8Af7TwrHd/gB5RxMjgc952CLMWQfJlWIXas18Am3bJHpSFalhNiN3GmrgytX
 9biU5cNVKjaHVIcL7u6lwcX8DjptrlkeFscarKmxrZTf7yOkeQMvYLGcVbY77yGxJYMC
 vUQGGWWGT4yR8/g4YaA6n79tnXUMw9EoYoqvmgH4r2jNHY3QIqHc11V69kiZFjfXKlbo
 YVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=QSlAdgkdBtCqgeZMjTjn8Ck356ySWYi2bzB6dzsyjg4=;
 b=cKiE79kiF5zZC1civQqBVWJSgp73EWDaGvcsl0LY2a9v7O/BkszsUarSsiMp/+fNlk
 0SPAsJvjqKD+Kb/arO6W/nSVH6Wl0szCCXTnzBe0/EoUleyDdYJrqPEYYq7j/m7psfeU
 pGzu5Jfzy2wAmVFt0YoM6OtR8lI9IAg7KSrvNdOBi6DYH2b1IuH+U6J/sD+dcQnr8iMd
 GDEMMlb7jnVfvE8wZiFn5xoxrC9Ab3ywswxqlevBLDeghw0kRCC2yCAaBirs1WECWDk2
 jB9GBYfwaQBlBy/xYyhCwrb2U5dBCJXRn+9UpT/go9wRlEyCwDwe18/POIzQ5kcZmNmF
 YIbg==
X-Gm-Message-State: APjAAAUTOkj48NebGpg1v08P1sVjtFFcWh5fNl5fDiVjLYsNDiu7CU8E
 1MiQ6YkqY1bxV7kC/KhOfHbwxdUME4E=
X-Google-Smtp-Source: APXvYqyhSa3S1PUu/3jtsxNwybcI0++sqZZNxEEhlrDLUtE1JxOlesQzDy05Ct2cmPRZ3HY98ndMYA==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id
 u12mr1224412pjr.100.1578421709729; 
 Tue, 07 Jan 2020 10:28:29 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id l186sm449150pge.31.2020.01.07.10.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 10:28:29 -0800 (PST)
Date: Tue, 07 Jan 2020 10:28:29 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 10:27:44 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 06/36] target/riscv: Rename the H irqs to VS irqs
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <d43f1c34d02514d3df0527c20718725a36684887.1575914822.git.alistair.francis@wdc.com>
References: <d43f1c34d02514d3df0527c20718725a36684887.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-0d2e3aed-8a36-49b7-a42e-4d7b0155a60a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 10:10:56 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c      |  6 +++---
>  target/riscv/cpu_bits.h | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d23d2cba64..e8ae07107e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -80,14 +80,14 @@ const char * const riscv_excp_names[] = {
>  const char * const riscv_intr_names[] = {
>      "u_software",
>      "s_software",
> -    "h_software",
> +    "vs_software",
>      "m_software",
>      "u_timer",
>      "s_timer",
> -    "h_timer",
> +    "vs_timer",
>      "m_timer",
>      "u_external",
> -    "s_external",
> +    "vs_external",
>      "h_external",
>      "m_external",
>      "reserved",
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 9ce73c36de..eeaa03c0f8 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -514,29 +514,29 @@
>  /* Interrupt causes */
>  #define IRQ_U_SOFT                         0
>  #define IRQ_S_SOFT                         1
> -#define IRQ_H_SOFT                         2  /* reserved */
> +#define IRQ_VS_SOFT                        2
>  #define IRQ_M_SOFT                         3
>  #define IRQ_U_TIMER                        4
>  #define IRQ_S_TIMER                        5
> -#define IRQ_H_TIMER                        6  /* reserved */
> +#define IRQ_VS_TIMER                       6
>  #define IRQ_M_TIMER                        7
>  #define IRQ_U_EXT                          8
>  #define IRQ_S_EXT                          9
> -#define IRQ_H_EXT                          10 /* reserved */
> +#define IRQ_VS_EXT                         10
>  #define IRQ_M_EXT                          11
>
>  /* mip masks */
>  #define MIP_USIP                           (1 << IRQ_U_SOFT)
>  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> -#define MIP_HSIP                           (1 << IRQ_H_SOFT)
> +#define MIP_VSSIP                          (1 << IRQ_VS_SOFT)
>  #define MIP_MSIP                           (1 << IRQ_M_SOFT)
>  #define MIP_UTIP                           (1 << IRQ_U_TIMER)
>  #define MIP_STIP                           (1 << IRQ_S_TIMER)
> -#define MIP_HTIP                           (1 << IRQ_H_TIMER)
> +#define MIP_VSTIP                          (1 << IRQ_VS_TIMER)
>  #define MIP_MTIP                           (1 << IRQ_M_TIMER)
>  #define MIP_UEIP                           (1 << IRQ_U_EXT)
>  #define MIP_SEIP                           (1 << IRQ_S_EXT)
> -#define MIP_HEIP                           (1 << IRQ_H_EXT)
> +#define MIP_VSEIP                          (1 << IRQ_VS_EXT)
>  #define MIP_MEIP                           (1 << IRQ_M_EXT)
>
>  /* sip masks */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

