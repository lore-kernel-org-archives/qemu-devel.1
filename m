Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86AEC33C9B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9485B2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWtWNRjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9485B2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioyu3-0003hV-JQ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ioytB-0002md-BD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ioytA-0003mA-14
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:07:57 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ioyt9-0003lb-PP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:07:55 -0500
Received: by mail-pf1-x442.google.com with SMTP id i23so678536pfo.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=etp+MLzFnORAUHUXqQbHRVsi3/emy9/tFwTY2CHqll0=;
 b=DWtWNRjhC4FpbzIbwrCVTySHzY3Js9CCwBPtfYtqNnm6vzEUUDIq55wPG5Jb3Fsn51
 U9QtZfC/5ZcKLnR9Qu4Ime65YzKISsOurXOj2qhsdCTerDXOIMJuwYW+zac9Z9wjrIYc
 H8x9rvsrD1i6UHTk6LGMyTX4RXHGLwJ8SSmd0BNMUiM1qw+Z5KDlTrquezOnur4ypTmz
 vn6LLfKEAe2Y+X4jTCfhK2gueSiVghUoMGs1NLXaAqrclFSRW+pNYnRL7fLR1o/2TTzX
 sx9S/uoJBAHWV8qLAjTwcgPNvInQ+rz4u+9kozDSDRHHKxE6UFA1Oeq6MBzIsMURTNoa
 MU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=etp+MLzFnORAUHUXqQbHRVsi3/emy9/tFwTY2CHqll0=;
 b=ODznfh9ZHdkDpLhDr8uhNVauLJIbrWyi1j86LAhBx4C8WzXdX4i1+46Lhq3cVYktLf
 dukfkhC0KNxpabEdvJTXzQdC9pU+AyfQ1xSrSAXX999UeqaxKQWuflOIG4/Kawxwu2hq
 c4Coqp1TRYo+p2hxViX1UzVSFDKUyCroqhsuCFUGkZ8S3lvj9hxv6gzcNFGMilXMW6Gd
 61SpzWrs69CV2Aj6q3uVfOE1x4qu/9rq8J7y23Jfv4dZVp7Bc1B9hXxE+9KmSZ8QHNEf
 MeS0gIMTZJaF5EB+5QnYQaIXelHddCZ0WPrEbP/MGT9l70cQPGQ2fjWu4/0wIslaAWAo
 A6dA==
X-Gm-Message-State: APjAAAU27B/00MFU3VhU6ceLuzyMVwZ1I04ndFgDJiJXa/tsyP9S1Ivy
 qlPg3nGRu3Ql7P6gyOEvHiOiAl0tESo=
X-Google-Smtp-Source: APXvYqxPUpR9PjxZ9+Ull31FqscjWIUzaSRkh7MHWx9VS3oN16AxbQp791N062P12bGbNND3VDsXEQ==
X-Received: by 2002:a62:158c:: with SMTP id 134mr1988338pfv.81.1578442074436; 
 Tue, 07 Jan 2020 16:07:54 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id z30sm721516pff.131.2020.01.07.16.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 16:07:53 -0800 (PST)
Date: Tue, 07 Jan 2020 16:07:53 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 16:07:29 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 12/36] target/riscv: Add Hypervisor CSR access functions
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <d69ae8746c74f5ba16bff06d489a889255f4c0cf.1575914822.git.alistair.francis@wdc.com>
References: <d69ae8746c74f5ba16bff06d489a889255f4c0cf.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-0857a92e-ccc1-4516-a888-d63c76f0d771@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On Mon, 09 Dec 2019 10:11:11 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 136 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index eebfc1823d..b582d78529 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -98,6 +98,20 @@ static int smode(CPURISCVState *env, int csrno)
>      return -!riscv_has_ext(env, RVS);
>  }
>
> +static int hmode(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_has_ext(env, RVS) &&
> +        riscv_has_ext(env, RVH)) {
> +        /* Hypervisor extension is supported */
> +        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
> +            env->priv == PRV_M) {
> +            return 0;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
>  static int pmp(CPURISCVState *env, int csrno)
>  {
>      return -!riscv_feature(env, RISCV_FEATURE_PMP);
> @@ -226,8 +240,9 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
>
>  /* Machine constants */
>
> -#define M_MODE_INTERRUPTS (MIP_MSIP | MIP_MTIP | MIP_MEIP)
> -#define S_MODE_INTERRUPTS (MIP_SSIP | MIP_STIP | MIP_SEIP)
> +#define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
> +#define S_MODE_INTERRUPTS  (MIP_SSIP | MIP_STIP | MIP_SEIP)
> +#define VS_MODE_INTERRUPTS (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)
>
>  static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
>  static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
> @@ -257,6 +272,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
>      SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
>  static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
> +static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
>
>  #if defined(TARGET_RISCV32)
>  static const char valid_vm_1_09[16] = {
> @@ -757,6 +773,112 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +/* Hypervisor Extensions */
> +static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hstatus;
> +    return 0;
> +}
> +
> +static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hstatus = val;
> +    return 0;
> +}
> +
> +static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hedeleg;
> +    return 0;
> +}
> +
> +static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hedeleg = val;
> +    return 0;
> +}
> +
> +static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hideleg;
> +    return 0;
> +}
> +
> +static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hideleg = val;
> +    return 0;
> +}
> +
> +static int rmw_hip(CPURISCVState *env, int csrno, target_ulong *ret_value,
> +                   target_ulong new_value, target_ulong write_mask)
> +{
> +    int ret = rmw_mip(env, 0, ret_value, new_value,
> +                      write_mask & hip_writable_mask);
> +
> +    return ret;
> +}
> +
> +static int read_hie(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mie & VS_MODE_INTERRUPTS;
> +    return 0;
> +}
> +
> +static int write_hie(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    target_ulong newval = (env->mie & ~VS_MODE_INTERRUPTS) | (val & VS_MODE_INTERRUPTS);
> +    return write_mie(env, CSR_MIE, newval);
> +}
> +
> +static int read_hcounteren(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hcounteren;
> +    return 0;
> +}
> +
> +static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hcounteren = val;
> +    return 0;
> +}
> +
> +static int read_htval(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->htval;
> +    return 0;
> +}
> +
> +static int write_htval(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->htval = val;
> +    return 0;
> +}
> +
> +static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->htinst;
> +    return 0;
> +}
> +
> +static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->htinst = val;
> +    return 0;
> +}
> +
> +static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hgatp;
> +    return 0;
> +}
> +
> +static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hgatp = val;
> +    return 0;
> +}
> +
>  /* Physical Memory Protection */
>  static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -960,6 +1082,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      /* Supervisor Protection and Translation */
>      [CSR_SATP] =                { smode, read_satp,        write_satp        },
>
> +    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
> +    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
> +    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
> +    [CSR_HIP] =                 { hmode,   NULL,     NULL,     rmw_hip        },
> +    [CSR_HIE] =                 { hmode,   read_hie,         write_hie        },
> +    [CSR_HCOUNTEREN] =          { hmode,   read_hcounteren,  write_hcounteren },
> +    [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
> +    [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
> +    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
> +
>      /* Physical Memory Protection */
>      [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
>      [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

