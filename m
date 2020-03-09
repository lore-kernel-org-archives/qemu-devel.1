Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1AE2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1AE2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIAN-0005t5-II
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBI9h-0005Ss-KA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBI9g-0001Ip-89
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:09:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBI9f-0001Fk-Vf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:09:12 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1IRY-1jCvm42NFS-002kki; Mon, 09 Mar 2020 14:08:34 +0100
Subject: Re: [PATCH 1/2] cpu: Do not reset a vCPU before it is created
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200309121103.20234-1-philmd@redhat.com>
 <20200309121103.20234-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <50859eef-ba76-40f1-0f21-7738219d7a9a@vivier.eu>
Date: Mon, 9 Mar 2020 14:08:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309121103.20234-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FCfRZqqNFgrspElZJJ/JqH7asw0mQCh+m8agYT61lUu6IS3TW6E
 9Dl3RQZ2Rcm62oauoS7o/hDAHlvuEPYMS8a6ckhp7yEQwMu7QlTS5jxYIqz7gX3kMt2zFGG
 cS2tS+mxEqDH52iuTx+QIYvs1l+246Hi6cFuV3vzu7koXc5kT3nw3wPyszPiFNpwpQzUT/J
 IaqVJiJEkLnie2wTNh1xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qzhWhxRzmGo=:lG6qmr6v2y4YBe20mjsh9R
 0jjh73yR/b9xYyJxlt+3dxrIDMt3JJgDBTzadwDOGlLjB3KTfXHoJgMBRQg/FhWAplmZnbOVL
 DkxSOdgc73D5RLLxvtYao6GHZA1zrqd/R9OF7I58lIaj7T8nJkPbCCN0VI39TZuxM7vkI8nss
 bAYpPp075vB3RAwXk5WhIv9eLvf0f0ePj+l1lqILjp00jdoMBtVIvOXDZW6fTlHtesyf9kTLu
 rgkv+3YUdNuFw/8V/FojPT7NNCCIqlFGMdKXnVuYslNDKcVQQN3HBLpQb/hKR+jlMmUsheijj
 W2pZ2Oea2puziy2nviDD69wPm0amZ9kR6E47Aims6XwPqcrbvrSkGij0HuDdraMqDfI3Fx5hW
 Xf08mzwMbDMN11nz5z7/oGxlwHCvFnJF1ecfEBBF/3UCzyfbIT+pmzrUxhoXwanUxoVDEK9PA
 N4PnmLYuCNiQatkwCP6z8FHMJIkB7Wh+olR9Ixq4SpOm66FfhrOx1RtM05CJu/t5Cdrvzo5ei
 zC5Ae/XN+t2bi81cKiXUJJSJbtTufh3IsAJIOIPFYfOu/xRAN+Q//7grfi07czJ8ZdE3Ip4Co
 cCYJ6X7cDtSmicqbYGgXaxS8QWwI7lb8r+zlRlWHJaywAujeZUTDLoVQ+l6fptU/F6+SVVHG+
 6U1dxcrpZoVu2zxJQ/RtpY7R50nV+dpNPBfRdKOag7avdZiwsYvsk/5uVApIYAHEt4KcBFRnZ
 zOblcx+/j1U/exuCWkitrpn0YTj+/l+vrEt3ULEj/r6FtNCrlNJOmfmZ+A3Mz/By+cKv1uI7X
 tWHagXPa7zD+ZzjrMY1xpeY6ugyrL647Xh1sVMASkhSwR12m4Xq//eQLOURLTSEvkCo5iyJ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 13:11, Philippe Mathieu-Daudé a écrit :
> cpu_reset() might modify architecture-specific fields allocated
> by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
> commit 00d0f7cb66 when introducing new architectures, move the
> cpu_reset() calls after qemu_init_vcpu().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/cris/cpu.c    | 2 +-
>  target/lm32/cpu.c    | 3 +--
>  target/m68k/cpu.c    | 2 +-
>  target/mips/cpu.c    | 2 +-
>  target/sh4/cpu.c     | 2 +-
>  target/tilegx/cpu.c  | 2 +-
>  target/tricore/cpu.c | 2 +-
>  7 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 17c6712e29..9b8b99840d 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -134,8 +134,8 @@ static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      ccc->parent_realize(dev, errp);
>  }
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index 687bf35e65..56f7b97c8f 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -132,9 +132,8 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    cpu_reset(cs);
> -
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      lcc->parent_realize(dev, errp);
>  }
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f0653cda2f..51ca62694e 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -247,8 +247,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>      m68k_cpu_init_gdb(cpu);
>  
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      mcc->parent_realize(dev, errp);
>  }
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 6cd6b9650b..553945005f 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -149,8 +149,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>      cpu_mips_realize_env(&cpu->env);
>  
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      mcc->parent_realize(dev, errp);
>  }
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 70c8d8170f..2564436719 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -184,8 +184,8 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      scc->parent_realize(dev, errp);
>  }
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index cd422a0467..7e9982197f 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -91,8 +91,8 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      tcc->parent_realize(dev, errp);
>  }
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 85bc9f03a1..c5a5d54569 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -94,8 +94,8 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
>      if (tricore_feature(env, TRICORE_FEATURE_131)) {
>          set_feature(env, TRICORE_FEATURE_13);
>      }
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>  
>      tcc->parent_realize(dev, errp);
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

