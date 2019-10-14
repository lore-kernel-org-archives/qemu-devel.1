Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6995CC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F2A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd7c7uT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F2A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5N2-0006Zu-Bu
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5MH-000636-BM
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5MF-0006An-Ua
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:46:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5MF-0006AL-Md
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:46:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so17741345wml.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=odsP/mevxCYmCQ+LVx2B/ZsHYtvK2GFG9QaLomsz51Q=;
 b=Rd7c7uT90utxC1zNjqn0WsViNmbVzr9r6mT54hdfK83zbBcGtoS/KHu5bN7JCc1JXq
 v2m+Yw6Ku3sTXi16xnxqplfu99uMQ1bnuHcahvFUbMnieTVNHpEveA69ShrHUCrmsBN2
 4JgsxxF4a0pECl2+K4VGnrafG5RNEFWHSgVzpMKOgIOoqT3eF46xyjOx3+5apT4KvTGo
 +GY0rE31q93YttPmt/JF9WNB+Rr00lvjfYx9Her4xMK3nUCKkBJfwkVETYdetK4DVis4
 MuFWWrxzHgMLO84RESIPCiQaNJ3WRg2QWShsCONWNIg95fQP8+aGoS4KGFOQLuECyIKp
 Qmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=odsP/mevxCYmCQ+LVx2B/ZsHYtvK2GFG9QaLomsz51Q=;
 b=APujvOT3U+QQKhXFb4w5p+JFdtHVAV2Ni/ijq3Of2PYL0m0Y3YS6/2tMUvXzMVrCE5
 /aLZA3PkvC6FfYclLkXl6NBHsmas9LzSlr4QdYsPt8WeLLbTpmoPhTZieZ7IsdWnoWEg
 v3VMNQg3SQXBXi+ggUyV7si9fa+tTrJBf9Kg/wK9CjurSe0TTaNJmj88b3TdXCzEgle3
 O0fqEWxXrVO623MPr8jNxUUxzGpDSvNlaGCVjLjpd+J6QK7oEFs9k4yR3QyH65Z2RWfW
 rPiUKOmPAz8zifp0KBcE4gLtMnMLTBg2fagv1raYCr9ZQbIU+Quvct5EPML8zyNDMcvP
 KAng==
X-Gm-Message-State: APjAAAW3S5Ii3ObW/UzU6i21A8YBpkTl17/O4sZS8Mk6EuaxlCRRgz+F
 /EBr7gGR3/edGEN6S+ROcYNFoQ==
X-Google-Smtp-Source: APXvYqwPoKGEiu1Fke5gwD6dTEibJLBjM9/a4ZmbCUoap1gW2reaqmq3sTxXEF9b+gi5+sgv7ImNEQ==
X-Received: by 2002:a1c:2604:: with SMTP id m4mr17278131wmm.112.1571078774123; 
 Mon, 14 Oct 2019 11:46:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a2sm21291230wrp.11.2019.10.14.11.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 11:46:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D09351FF87;
 Mon, 14 Oct 2019 19:46:12 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-12-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 11/20] target/arm: Hoist computation of TBFLAG_A32.VFPEN
In-reply-to: <20191011155546.14342-12-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 19:46:12 +0100
Message-ID: <87ftjvmah7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There are 3 conditions that each enable this flag.  M-profile always
> enables; A-profile with EL1 as AA64 always enables.  Both of these
> conditions can easily be cached.  The final condition relies on the
> FPEXC register which we are not prepared to cache.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  2 +-
>  target/arm/helper.c | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4d961474ce..9909ff89d4 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3192,7 +3192,7 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
>   * the same thing as the current security state of the processor!
>   */
>  FIELD(TBFLAG_A32, NS, 6, 1)
> -FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
> +FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC=
. */
>  FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
>  FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
>  /* For M profile only, set if FPCCR.LSPACT is set */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 398e5f5d6d..89aa6fd933 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11088,6 +11088,9 @@ static uint32_t rebuild_hflags_m32(CPUARMState *e=
nv, int fp_el,
>  {
>      uint32_t flags =3D 0;
>
> +    /* v8M always enables the fpu.  */
> +    flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
> +
>      if (arm_v7m_is_handler_mode(env)) {
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
>      }
> @@ -11119,6 +11122,10 @@ static uint32_t rebuild_hflags_a32(CPUARMState *=
env, int fp_el,
>                                     ARMMMUIdx mmu_idx)
>  {
>      uint32_t flags =3D rebuild_hflags_aprofile(env);
> +
> +    if (arm_el_is_aa64(env, 1)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
> +    }
>      return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
>  }
>
> @@ -11250,14 +11257,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>                  flags =3D FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
>                                     env->vfp.vec_stride);
>              }
> +            if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
> +            }

We seem to be short of symbolic definitions for this bit but whatever:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>          }
>
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
> -        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
> -            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)=
) {
> -            flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
> -        }
>          pstate_for_ss =3D env->uncached_cpsr;
>      }


--
Alex Benn=C3=A9e

