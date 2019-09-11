Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E23C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824C42085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zb0oQ47/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824C42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84jZ-0001E6-6x
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i84V8-0005X0-U3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i84V6-0000Pg-KT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:25:46 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i84V6-0000PI-CE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:25:44 -0400
Received: by mail-io1-xd44.google.com with SMTP id d25so46770026iob.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WDXxo7RChx1Yedny8qFMElJwnL7cMFzyo3wfJ0zwgjk=;
 b=Zb0oQ47/+P1wa+mjC6AdQ3unyt/Z99GBT2SLffyBL8pROPEDPrc5RA2FkHfvBl5h8r
 L0fuKYYMYcRnY/KzS8fk9avB1uKW+Jq7nRs6G8+jLXq26r09M9Ist+O29/lYQ1vk8zLx
 VlFxOs18FXVW+9ScNZ3cqe4kz8qR4LZo9nda+TR55edmKGlMfyYqWI9819o0r+8O9LS+
 i3MsGxTNudvbRum6dJE6S6o7QwUq3FWnQTgomqC+xJklGAuHPzQEg36sarTyncB8OzyS
 nd6v1Kfhyuot5xdHebYVs6njJ1AsrSxm5iDzcrNsGiv7ySIfDpvOnuZeoZHsITotejn8
 2Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WDXxo7RChx1Yedny8qFMElJwnL7cMFzyo3wfJ0zwgjk=;
 b=Sm4Seo0iFoI/39INaAMmsW27b6lY2R57GO7hAVRESpKHjzYDvPj2F+e/EKBCcN66iG
 0n40EEgSXxEiPzS53m/ljtXHLUrRnhO+WLcNIqCrfKxvHjCb9QtpiL6jX0gKOgFKfj1h
 k0b+sdjHl+mDpz6pVFrnJ6d1DyPb7xFpz4rRUV+pXIPDJWatZzRQev4CY5zcpYH6RSlG
 +d1gtFlrFAX1EqQAcjIx4Q/LHSYLBfNSQ1HvtI1fVoXR+29HUV28rD9q5KjTbYuklWI+
 W3V6OLtMSzr+ZofM2s+tSzqcfMhrrv4fINVCqTd/9nPlENg3ovYFQJ4iZSfbaINJdcF1
 ejhQ==
X-Gm-Message-State: APjAAAXgNyxd8aXYT/rZozgIs2d+sNw78dEQ+BW4ckNwr5NUx4FE7lpC
 YNU28im0tfHguRNl7ifkXA5yjcHnqpcHhNO3M+Nl9w==
X-Google-Smtp-Source: APXvYqwmrchLaUawFJaNqlPBFrAFk1kmYTK8WctTcZDjfjl0TKZpAGBqbCj0a6yxPGpBLzbTsgJ2MZse2nprmURRtLk=
X-Received: by 2002:a6b:ec16:: with SMTP id c22mr1362431ioh.185.1568215543429; 
 Wed, 11 Sep 2019 08:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-4-git-send-email-zhiwei_liu@c-sky.com>
In-Reply-To: <1568183141-67641-4-git-send-email-zhiwei_liu@c-sky.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 11 Sep 2019 23:25:32 +0800
Message-ID: <CAEiOBXUoYKPes+BoDCWdDw60nyaqzW2qtgTVAdQ4Sbf_QuNTJA@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v2 03/17] RISC-V: support
 vector extension csr
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 2:38 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:

> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu_bits.h | 15 ++++++++++++
>  target/riscv/csr.c      | 65
> ++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 11f971a..9eb43ec 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -29,6 +29,14 @@
>  #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>  #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA |
> FSR_NXA)
>
> +/* Vector Fixed-Point round model */
> +#define FSR_VXRM_SHIFT      9
> +#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> +
> +/* Vector Fixed-Point saturation flag */
> +#define FSR_VXSAT_SHIFT     8
> +#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
> +
>  /* Control and Status Registers */
>
>  /* User Trap Setup */
> @@ -48,6 +56,13 @@
>  #define CSR_FRM             0x002
>  #define CSR_FCSR            0x003
>
> +/* User Vector CSRs */
> +#define CSR_VSTART          0x008
> +#define CSR_VXSAT           0x009
> +#define CSR_VXRM            0x00a
> +#define CSR_VL              0xc20
> +#define CSR_VTYPE           0xc21
> +
>  /* User Timers and Counters */
>  #define CSR_CYCLE           0xc00
>  #define CSR_TIME            0xc01
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e0d4586..a6131ff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -87,12 +87,12 @@ static int ctr(CPURISCVState *env, int csrno)
>      return 0;
>  }
>
> -#if !defined(CONFIG_USER_ONLY)
>  static int any(CPURISCVState *env, int csrno)
>  {
>      return 0;
>  }
>
> +#if !defined(CONFIG_USER_ONLY)
>  static int smode(CPURISCVState *env, int csrno)
>  {
>      return -!riscv_has_ext(env, RVS);
> @@ -158,8 +158,10 @@ static int read_fcsr(CPURISCVState *env, int csrno,
> target_ulong *val)
>          return -1;
>      }
>  #endif
> -    *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
> -        | (env->frm << FSR_RD_SHIFT);
> +    *val = (env->vfp.vxrm << FSR_VXRM_SHIFT)
> +            | (env->vfp.vxsat << FSR_VXSAT_SHIFT)
> +            | (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
> +            | (env->frm << FSR_RD_SHIFT);
>      return 0;
>  }
>
> @@ -172,10 +174,60 @@ static int write_fcsr(CPURISCVState *env, int csrno,
> target_ulong val)
>      env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
> +    env->vfp.vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
> +    env->vfp.vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
>      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>      return 0;
>  }
>
> +static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vfp.vtype;
> +    return 0;
> +}
> +
> +static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vfp.vl;
> +    return 0;
> +}
> +
> +static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vfp.vxrm;
> +    return 0;
> +}
> +
> +static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vfp.vxsat;
> +    return 0;
> +}
> +
> +static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vfp.vstart;
> +    return 0;
> +}
> +
> +static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vfp.vxrm = val;
> +    return 0;
> +}
> +
> +static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vfp.vxsat = val;
> +    return 0;
> +}
> +
> +static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vfp.vstart = val;
> +    return 0;
> +}
> +
>  /* User Timers and Counters */
>  static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -873,7 +925,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
> {
>      [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags
>   },
>      [CSR_FRM] =                 { fs,   read_frm,         write_frm
>    },
>      [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr
>   },
> -
> +    /* Vector CSRs */
> +    [CSR_VSTART] =              { any,   read_vstart,     write_vstart
>   },
> +    [CSR_VXSAT] =               { any,   read_vxsat,      write_vxsat
>    },
> +    [CSR_VXRM] =                { any,   read_vxrm,       write_vxrm
>   },
> +    [CSR_VL] =                  { any,   read_vl
>   },
> +    [CSR_VTYPE] =               { any,   read_vtype
>    },
>      /* User Timers and Counters */
>      [CSR_CYCLE] =               { ctr,  read_instret
>   },
>      [CSR_INSTRET] =             { ctr,  read_instret
>   },
> --
> 2.7.4
>
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
