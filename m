Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BCC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501D82067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQPampuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501D82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNaz-0000L5-96
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNZQ-0007bM-U7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNZL-0007FL-Ro
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:12 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipNZL-0007C1-9o
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:07 -0500
Received: by mail-pg1-x544.google.com with SMTP id b9so2440218pgk.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=GQ/CTU9UZPoDIfSC5uAvm0HxUXJkB1DNdwrAHTNgMqY=;
 b=JQPampuX01Y1eseokDwHhGB6LZcNwAXAwBu11WDAcfOl4WEpD0iGd7QX35f/qzQRQk
 OB/uy47qrzpdsB6di1Mz0kBMtNHin6aoOBDxk5sbBY5Hs8/RNjO4JalNgJMVjXTkRu1z
 Y6c21Ew108YPhnMdSB7t2KzLhAdgeC60J6SHNM6uMVFPR6Mb7++pA9mdPQEUdpRAJ/ve
 cYyhOfy7GRQUMic5F+yUfGyQBhpMgCNdx9XcjAs97iqR53jnth1iXbyyGukOjNdX29pz
 8heySCPPSYAy5ftRv82gbw4e3phYAF1NW/8eQI4Y7eIsK9Hc22qi38wznwXTxz7f4l8D
 kiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=GQ/CTU9UZPoDIfSC5uAvm0HxUXJkB1DNdwrAHTNgMqY=;
 b=hL3Fii+Fd3p+MeVuZFmW8HL0q17ZFUnBOVaCbyjHu04nCSnjbiF3REuTJo6Gy5z3w/
 rkR+yWqwR1vuMv5jP7gLJ3gqW1Anwl5/dLD6RBrTr8hLZhyTC8/IEVXG/gmqJL4kB0rd
 ukSo2jAtZcCmAp3JUW1dluOQvcGQ12l5pAHNEYstFGBsTlTtTz4kiGUnv8Jc8EBWgRK4
 9xEdkS6Tsyb+DXXqCiwov1edAVFDhI30E9/ewY1+k1UvRrvkK9uqKu6sXtPh9V9f+FZO
 bsz5eeLOO5onAwKK/WyJ0CbVwQD/NgI7+MQnJYj7bS99nn6Pwfv05vn4mRcusS9eM+Xp
 sznQ==
X-Gm-Message-State: APjAAAXHtd9W2B1/99ZZAtlPZmRdBJzWuB6Fc/ZvjbnPS9Zn8P37e6gY
 uLGufGPCRDGk/TOf2dtXYoH2DkdXG7w=
X-Google-Smtp-Source: APXvYqz1bcHW86KgjzVfvgc3kcIBDdHaq47vxtU2N4lTrjb64GZd5OpnOYuzt+ya6lGlPl56HRB7dw==
X-Received: by 2002:a63:ff5c:: with SMTP id s28mr8577205pgk.196.1578536945288; 
 Wed, 08 Jan 2020 18:29:05 -0800 (PST)
Received: from localhost (189.8.197.35.bc.googleusercontent.com.
 [35.197.8.189])
 by smtp.gmail.com with ESMTPSA id h128sm5527563pfe.172.2020.01.08.18.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:29:04 -0800 (PST)
Date: Wed, 08 Jan 2020 18:29:04 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 18:26:45 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 32/36] target/riscv: Raise the new execptions when 2nd
 stage translation fails
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <f8bbda95f454a47bbfac3df8473f523a57aee3bb.1575914822.git.alistair.francis@wdc.com>
References: <f8bbda95f454a47bbfac3df8473f523a57aee3bb.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-2a2e73ac-badd-4db1-95ff-10d8558bedf1@palmerdabbelt-glaptop>
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

On Mon, 09 Dec 2019 10:12:04 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 8667e5ffce..43c6629014 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -589,16 +589,28 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>      }
>      switch (access_type) {
>      case MMU_INST_FETCH:
> -        cs->exception_index = page_fault_exceptions ?
> -            RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
> +        if (riscv_cpu_virt_enabled(env) && !first_stage) {
> +            cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
> +        } else {
> +            cs->exception_index = page_fault_exceptions ?
> +                RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
> +        }
>          break;
>      case MMU_DATA_LOAD:
> -        cs->exception_index = page_fault_exceptions ?
> -            RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        if (riscv_cpu_virt_enabled(env) && !first_stage) {
> +            cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
> +        } else {
> +            cs->exception_index = page_fault_exceptions ?
> +                RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        }
>          break;
>      case MMU_DATA_STORE:
> -        cs->exception_index = page_fault_exceptions ?
> -            RISCV_EXCP_STORE_PAGE_FAULT : RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        if (riscv_cpu_virt_enabled(env) && !first_stage) {
> +            cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
> +        } else {
> +            cs->exception_index = page_fault_exceptions ?
> +                RISCV_EXCP_STORE_PAGE_FAULT : RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        }
>          break;
>      default:
>          g_assert_not_reached();

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

