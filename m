Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F6C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F2420717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F2420717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8meb-0007NN-A0
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i8mdg-0006tF-Kl
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i8mdf-0000TS-By
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:33:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i8mdf-0000T0-69
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:33:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id k1so13319739pls.11
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 07:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=ZcgtA7DUzweE6P+F0iSw5YWH7DE6YUf2lnvzah0tYC0=;
 b=gsWD+GcUsQ6yG4kgynJwZ1BSlDRd79Tf7jE+7S+Y0Otl6sq04g85dWl7BGLd7CV9nx
 n90k3W3GQOO1NARpGrgk1pn8mmKD3VjAo1gjIujkaKomZJTRc1KeYgoGklc7NRn1XYoQ
 v+TxamREU7SvLqSxAZdXjunUKDNl57GfY+d9pQHhZ1MFMtl3B90anrED8h3uGT4xgHjb
 RpdxvZjT89iEzw2pJKu/+tQ8gGRLrF0RUOmZaRjUejPDOlsR+BplmRc07NobNqd6Hdrm
 LWNsHuD6yFKZ5THarDbyjc1WS8YPj9TRXrm3J0Kb5bPHSrJCaj9zG10CaM8MmbtOVHAo
 AmCA==
X-Gm-Message-State: APjAAAUOlEtmZ/vukdCqnYogTlrFht1Iu0usyPiRnJX7pYx3JQYcXa03
 vfrmX3/V1B6dcjaacj64t3fqGg==
X-Google-Smtp-Source: APXvYqxtRY6ZXLmxssxB9Qa/E8e+bwcaMuq4LjXP+IYn0wnPdtxHjNg4Crku65r3921zyOqd/4rgHg==
X-Received: by 2002:a17:902:7685:: with SMTP id
 m5mr50039821pll.218.1568385209712; 
 Fri, 13 Sep 2019 07:33:29 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id g202sm38389325pfb.155.2019.09.13.07.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 07:33:29 -0700 (PDT)
Date: Fri, 13 Sep 2019 07:33:29 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 07:33:20 PDT (-0700)
In-Reply-To: <1567786819-22142-19-git-send-email-bmeng.cn@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-81295c42-a2f8-4f95-a54f-f9a319e10a36@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
Subject: Re: [Qemu-devel] [PATCH v8 18/32] riscv: sifive_u: Set the minimum
 number of cpus to 2
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 06 Sep 2019 09:20:05 PDT (-0700), bmeng.cn@gmail.com wrote:
> It is not useful if we only have one management CPU.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> ---
>
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - use management cpu count + 1 for the min_cpus
>
> Changes in v2:
> - update the file header to indicate at least 2 harts are created
>
>  hw/riscv/sifive_u.c         | 4 +++-
>  include/hw/riscv/sifive_u.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 2947e06..2023b71 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -10,7 +10,8 @@
>   * 1) CLINT (Core Level Interruptor)
>   * 2) PLIC (Platform Level Interrupt Controller)
>   *
> - * This board currently uses a hardcoded devicetree that indicates one hart.
> + * This board currently generates devicetree dynamically that indicates at least
> + * two harts.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -433,6 +434,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>       * management CPU.
>       */
>      mc->max_cpus = 4;
> +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>  }
>
>  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index f25bad8..6d22741 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -69,6 +69,8 @@ enum {
>      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
>  };
>
> +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
> +
>  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
>  #define SIFIVE_U_PLIC_NUM_SOURCES 54
>  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7

This fails "make check", so I'm going to squash in this

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ca9f7fea41..adecbf1dd9 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -528,6 +528,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
     mc->init = riscv_sifive_u_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+    mc->default_cpus = mc->max_cpus;
 }

 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)

