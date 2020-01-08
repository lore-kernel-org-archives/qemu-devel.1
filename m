Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A96DC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D2A2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF80TWv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D2A2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioyu2-0003fp-Rm
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ioytC-0002mf-0o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ioytB-0003nC-39
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:07:57 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ioytA-0003mW-UB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:07:57 -0500
Received: by mail-pg1-x541.google.com with SMTP id x7so630205pgl.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=Y6cMuBVs0196LTwcKZNj4poTRpEbBv+9KmEW8zwj1aI=;
 b=ZF80TWv7XtmFg2VGfdZULY7o5W1nZ1V/JS0t/P3fo6fOJw/kj1KROTVHJzcbvH1eyD
 3Tct8wa2zVJSFAFCCIcJU+F3j+VacvZRFTtbSnL7xYg1XmSSwNzXrcimA5I6QnNxOElC
 0pTbKuuiG8a4xdsFS45DnQ6H6OkYKbSMKSyHJz9ZE+eunvnhSCWHZqbSh9F2CkR+9j6i
 EBi6DcL+q2UIlkPG1zPz4pWSV/iR6kXM99jz96tfzeqKp75jy8EOoeqTeP1w8sunEkT/
 EveGKHaBDJAkonaR23DXq4vJHWHiGmOcF+mdG5ZgS7Y8FvTQhfkJc9UquxQtrQU4bfMv
 gRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=Y6cMuBVs0196LTwcKZNj4poTRpEbBv+9KmEW8zwj1aI=;
 b=UZOffvwj6dENMTVMddxcP3UBXvDmT8NnCA0vUNGO5b92pY7DLQyASYDz0WoGTWJgaN
 N8hjpj6am0b+J+rfCiJIHil7ANWllEybXZUEeU4G7kvAm2Y/oPZD+if6cm1YSMwcy4R1
 RkZPRiG7B+cypRg0Vo3ImNdSGi3psAPjM3r48O9lHJx/FM+vpI+z1ot9vEe98YmRxpro
 RODc/NRysnnwnrSuAW0wnSlAsoiHEK2w5MyO3TT0M/GamQA4IynYrF+GYQ9z7mc5hHxL
 OTP+lJnEjeGFqjKjsm1unhGFC/sk+QzAfw4+FAD0Lqz/zQ4lzDZhJSPprxjBhhfCjBUT
 VHoQ==
X-Gm-Message-State: APjAAAVi9kFYXh3CBfDbeaq1yNcYwGnKDCi7h6/3qsgL8wOMGvuRE9Pq
 KZTvqAP+nU/ekXPV+vWNONN1N5dnyfc=
X-Google-Smtp-Source: APXvYqzHyOcNMg6yhPbDCb4fW5EGJhEssiyAmmi5ZSvEgDPEGTd2PsHYPuVqoYJiTzdVmYUpLWpeeg==
X-Received: by 2002:aa7:90cc:: with SMTP id k12mr2043713pfk.105.1578442075714; 
 Tue, 07 Jan 2020 16:07:55 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id u128sm737573pfu.60.2020.01.07.16.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 16:07:55 -0800 (PST)
Date: Tue, 07 Jan 2020 16:07:55 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 16:07:52 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 14/36] target/riscv: Add Hypervisor virtual CSRs
 accesses
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <6245a7d85ae108253970aecd57b47a3f6ddeec2c.1575914822.git.alistair.francis@wdc.com>
References: <6245a7d85ae108253970aecd57b47a3f6ddeec2c.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-f31e4557-45d8-4bfc-92b8-5670f83b7502@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

On Mon, 09 Dec 2019 10:11:17 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index aaca1a6a0f..74e911af08 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -985,6 +985,30 @@ static int write_vsatp(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +static int read_mtval2(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mtval2;
> +    return 0;
> +}
> +
> +static int write_mtval2(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mtval2 = val;
> +    return 0;
> +}
> +
> +static int read_mtinst(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mtinst;
> +    return 0;
> +}
> +
> +static int write_mtinst(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mtinst = val;
> +    return 0;
> +}
> +
>  /* Physical Memory Protection */
>  static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -1208,6 +1232,9 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_VSTVAL] =              { hmode,   read_vstval,      write_vstval     },
>      [CSR_VSATP] =               { hmode,   read_vsatp,       write_vsatp      },
>
> +    [CSR_MTVAL2] =              { hmode,   read_mtval2,      write_mtval2     },
> +    [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
> +
>      /* Physical Memory Protection */
>      [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
>      [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

