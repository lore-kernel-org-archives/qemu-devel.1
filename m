Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B17C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869B4214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869B4214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig3Sa-0006Zf-Qu
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1ig3Rv-0006Ai-Rh
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1ig3Ru-00029H-57
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:10:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1ig3Rt-00024c-Qu
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:10:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so1329453wru.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 01:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v33cw69P2zoxuwSSZ6jlqZkbriymrwWqhO3QUIg5p9c=;
 b=bib2aD1z8RjmGChPvJ/Y5dWb8PJq4T/l5+J5Q2oAngzuoeZIaS6SCTz46dDj86M+O2
 Gk11bb2lxXmPSlTdPciom4+9aVZivLo9f4rtcTQBjaq26LJ4tRvFaTnd+yQs9p3AD94G
 47WwhqDl7uAKjWYdn4R/I/MrB3FHmfAfKLC5ZO7+htdhahgnXI00Ug4mtYPjQQw5OJ1C
 RfJRdsqgv1MrHq+QyoDKmoKTKCCF3022NX3+POCaGf4zCySaLgDveu0JvdhNdlh8u6kD
 qd4uzq1LEiUlMRB75fHGrtRVWgOA1CznqwVdVkbEni2dg03sRhhyka88p+ODXetKx7R8
 2YNg==
X-Gm-Message-State: APjAAAVNmM59SXU/iefX11lYyUZ7JOupU6ww1fTZyifsjNyFco3pEueJ
 zRUn/6hsB5vGfFqB7/R+yEk=
X-Google-Smtp-Source: APXvYqxGGnV7KycCASOnSV6qEbmPWACoXOKGC60c1kG/hWEqAbcNQ0XTUV31o2gF09wWfBce0S+tNw==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr18167052wrq.64.1576314652324; 
 Sat, 14 Dec 2019 01:10:52 -0800 (PST)
Received: from thl530.multi.box (pD9575849.dip0.t-ipconnect.de. [217.87.88.73])
 by smtp.gmail.com with ESMTPSA id o185sm13154009wmb.40.2019.12.14.01.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2019 01:10:51 -0800 (PST)
Date: Sat, 14 Dec 2019 10:10:47 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] target/m68k: only change valid bits in CACR
Message-ID: <20191214101047.217a887a@thl530.multi.box>
In-Reply-To: <20191212194045.12882-1-laurent@vivier.eu>
References: <20191212194045.12882-1-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Thu, 12 Dec 2019 20:40:45 +0100
schrieb Laurent Vivier <laurent@vivier.eu>:

> This is used by netBSD (and MacOS ROM) to detect the MMU type
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.c    | 28 ++++++++++++++++++++++------
>  target/m68k/cpu.h    |  4 ++++
>  target/m68k/helper.c | 16 ++++++++++++++--
>  3 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index e6596de29c..1d202cec49 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -114,11 +114,8 @@ static void m68000_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
> -static void m68020_cpu_initfn(Object *obj)
> +static void m680x0_cpu_common(CPUM68KState *env)
>  {
> -    M68kCPU *cpu = M68K_CPU(obj);
> -    CPUM68KState *env = &cpu->env;
> -
>      m68k_set_feature(env, M68K_FEATURE_M68000);
>      m68k_set_feature(env, M68K_FEATURE_USP);
>      m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> @@ -136,14 +133,32 @@ static void m68020_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
> -#define m68030_cpu_initfn m68020_cpu_initfn
> +
> +static void m68020_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m680x0_cpu_common(env);
> +    m68k_set_feature(env, M68K_FEATURE_MMU68851);
> +}
> +
> +static void m68030_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m680x0_cpu_common(env);
> +    m68k_set_feature(env, M68K_FEATURE_MMU68030);
> +}
>  
>  static void m68040_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68020_cpu_initfn(obj);
> +    m680x0_cpu_common(env);
> +    m68k_set_feature(env, M68K_FEATURE_MMU68040);
>      m68k_set_feature(env, M68K_FEATURE_M68040);
>  }
>  
> @@ -166,6 +181,7 @@ static void m68060_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_BKPT);
>      m68k_set_feature(env, M68K_FEATURE_RTD);
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
> +    m68k_set_feature(env, M68K_FEATURE_MMU68060);
>  }
>  
>  static void m5208_cpu_initfn(Object *obj)
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 20de3c379a..36e4353b44 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -483,6 +483,10 @@ enum m68k_features {
>      M68K_FEATURE_CHK2,
>      M68K_FEATURE_M68040, /* instructions specific to MC68040 */
>      M68K_FEATURE_MOVEP,
> +    M68K_FEATURE_MMU68851,
> +    M68K_FEATURE_MMU68030,
> +    M68K_FEATURE_MMU68040,
> +    M68K_FEATURE_MMU68060,
>  };
>  
>  static inline int m68k_feature(CPUM68KState *env, int feature)
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index ae766a6cb0..b5758bbd7d 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -205,7 +205,13 @@ void HELPER(m68k_movec_to)(CPUM68KState *env,
> uint32_t reg, uint32_t val) return;
>      /* MC680[234]0 */
>      case M68K_CR_CACR:
> -        env->cacr = val;
> +        if (m68k_feature(env, M68K_FEATURE_MMU68040)) {

Why is the *Cache* control register tied to an MMU feature?
Maybe use M68K_FEATURE_M68040 instead? Or call the new flag
M68K_FEATURE_CACHE040 instead?

> +            env->cacr = val & 0x80008000;
> +        } else if (m68k_feature(env, M68K_FEATURE_MMU68030)) {
> +            env->cacr = val & 0x00003fff;

That seems to be too much, according to my MC68030 UM, there are some
bits tied to zero inbetween. The correct mask should be 0x3f1f, I think.

> +        } else if (m68k_feature(env, M68K_FEATURE_MMU68851)) {
> +            env->cacr = val & 0x0000000f;
> +        }

What about the 68060? It has yet another set of bits in the CACR...

>          m68k_switch_sp(env);
>          return;
>      /* MC680[34]0 */
> @@ -261,7 +267,13 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState
> *env, uint32_t reg) return env->vbr;
>      /* MC680[234]0 */
>      case M68K_CR_CACR:
> -        return env->cacr;
> +        if (m68k_feature(env, M68K_FEATURE_MMU68040)) {
> +            return env->cacr & 0x80008000;
> +        } else if (m68k_feature(env, M68K_FEATURE_MMU68030)) {
> +            return env->cacr & 0x00003fff;
> +        } else if (m68k_feature(env, M68K_FEATURE_MMU68851)) {
> +            return env->cacr & 0x0000000f;
> +        }

Wouldn't it be enough to do the masking either only during the "from"
or during the "to" move? If you want to do it for both, I'd suggest to
declare a little helper function for the masking instead, so that you
don't have to repeat the code.

 Thomas

