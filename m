Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92887C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567902070E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSct3BTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567902070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipM22-0004JC-Aa
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipM0c-0002iy-93
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipM0Y-00087j-5S
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:09 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipM0X-00085C-SR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:05 -0500
Received: by mail-pg1-x544.google.com with SMTP id b137so2357989pga.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=KQfEp3p4VDk1zl6NMFLBM7nYydr2cpxfeNHo46j1imQ=;
 b=NSct3BTVlZw87sPjRg3gcYeUL/bKHx7xEpHMxeZbTfQyLrWLGKcOnUw7sKc98wRPmS
 9xKkpvGHZFLno+SkXVU2neudyWHCgEeAOGtUqn6k4fDERIpj9XfxZ/nglj5NbM7uR8Tc
 LlQVAi82Jts1YrOZHnQznpR8XQpn+kAJ/AumAqQxXL2SmXny1Ua4yIiqEPPbTKODiW3c
 hpitBNOxBIBCJHY8ebX8kie2k9oK9YVOGZ4OV1Srl3/94KH0OyhzYOJ9CuFMxTPHtVpd
 oZqabKOX5BcTUwG16DFjdCRHxPGV4ajplLS4LeEmayeuSOKvdWVV9seTQmVGiki/MrW9
 kijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=KQfEp3p4VDk1zl6NMFLBM7nYydr2cpxfeNHo46j1imQ=;
 b=V5csrykrOtPhhdL9GqY2mDP75nXq66LjVlbK5qlOLXw5htm3NxpPAsl8pwKpQnkUND
 x2ShksHw12j3luTsKX619I4xhyYd5ErIrq78OL9g7U04wDOyx2wdpzKoZ+3Qy5Df6QKU
 +0h5RStk0nv2rruW3TF3Bya2LgqrJjhXw1lVV+hPAUXHiU754GizRDJD0L2O+Hkv5KgI
 4b3za9iMKlccNrf8lcPFMUPCAOgWwaZnWk+vpCVWPwHKOCVvpRWMQ1QU3kizPeLgg3+e
 +bjRvxEc7323nvJWLYO0ndfRK9P3vqAs2N3WRnwrLpMplUEigy5dMhbJavD7R3HatLPv
 YEhQ==
X-Gm-Message-State: APjAAAXiooq+VkQFdwRveUBlLHnLj/YUSJl/vgSl//Prk5YGWjJ4boyT
 ygSksZV8u0Alk35lpPY/CNNUNw5yej0=
X-Google-Smtp-Source: APXvYqzhndEtEvRI3a7LIipHv22w+jhMBvDuQwRJ3OwlqGswzepvtxGh6kNurd42JjqAhztGkXgSmw==
X-Received: by 2002:a62:7883:: with SMTP id t125mr8447867pfc.141.1578530944521; 
 Wed, 08 Jan 2020 16:49:04 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id bo19sm455227pjb.25.2020.01.08.16.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:49:03 -0800 (PST)
Date: Wed, 08 Jan 2020 16:49:03 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 16:29:07 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 20/36] target/riscv: Add support for virtual interrupt
 setting
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <2389483485d4642a6e5670e2546c62e493e91fd6.1575914822.git.alistair.francis@wdc.com>
References: <2389483485d4642a6e5670e2546c62e493e91fd6.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-6814f8b9-d54a-4663-900c-83023307a658@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On Mon, 09 Dec 2019 10:11:32 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 63439c9370..85eed5d885 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -37,13 +37,36 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
>  #ifndef CONFIG_USER_ONLY
>  static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>  {
> +    target_ulong irqs;
> +
>      target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
>      target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
> -    target_ulong pending = env->mip & env->mie;
> -    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
> -    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
> -    target_ulong irqs = (pending & ~env->mideleg & -mie) |
> -                        (pending &  env->mideleg & -sie);
> +    target_ulong hs_mstatus_sie = get_field(env->mstatus_novirt, MSTATUS_SIE);
> +
> +    target_ulong pending = env->mip & env->mie &
> +                               ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> +    target_ulong vspending = (env->mip & env->mie &
> +                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
> +
> +    target_ulong mie    = env->priv < PRV_M ||
> +                          (env->priv == PRV_M && mstatus_mie);
> +    target_ulong sie    = env->priv < PRV_S ||
> +                          (env->priv == PRV_S && mstatus_sie);
> +    target_ulong hs_sie = env->priv < PRV_S ||
> +                          (env->priv == PRV_S && hs_mstatus_sie);
> +
> +    if (riscv_cpu_virt_enabled(env)) {
> +        target_ulong pending_hs_irq = pending & -hs_sie;
> +
> +        if (pending_hs_irq) {
> +            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
> +            return ctz64(pending_hs_irq);
> +        }
> +
> +        pending = vspending;
> +    }
> +
> +    irqs = (pending & ~env->mideleg & -mie) | (pending &  env->mideleg & -sie);

Isn't "-unsigned" implementation defined?  I can't get GCC to throw a warning
and it was already there, so maybe I'm just wrong?

>
>      if (irqs) {
>          return ctz64(irqs); /* since non-zero */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

