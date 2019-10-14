Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA562C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18D42133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBwOVgVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18D42133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3rJ-0003fw-Fn
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK32F-0003x5-6k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK32E-0006Cy-35
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:17:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK32D-0006Cf-RQ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:17:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so17874941wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pnR7DiTp4Gj4yELac5puy1nXSUz2BGRaIP9mr5NNbDQ=;
 b=YBwOVgVNUXn8Ur03HwR3qQXw/1Um3k/q9suRnVginDHFg4x0Jem5wZKwjEZmbcGaxP
 Nkb8ayeeO3FOd+fEbKDrIcqtRP1bwCFtjqhyZwi66dvl16kb6FUobijf4zmOj8rI+fMF
 6r8PSc0m8q67zpU/bpvtfXgRCfXokI6gu3DspS4IMaUmzk90vVvD7/RaXE01ZPU4mqor
 YTcLJ7xIl8b4W8pXQ8K7jiACLtKmJX87O7DKljp5Tas4nHrEz1LjeqRrDrZedchs93Lg
 BV7to4ODGR+m9JSVVd/95Ax1B9Jp/bdtwMSRrLoltxkADAnzU+6EckP7KavMO96uyXYC
 3/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pnR7DiTp4Gj4yELac5puy1nXSUz2BGRaIP9mr5NNbDQ=;
 b=Wgt6IRGzw7T1n5BrQavjdFdA4Kzvlhn/y3MoKPFKeL4xcaxA148O20yzzJhk82W8iE
 t3Bt93slrB+nH55kgx4DnaSgkkGkdTWMLP7KoA65x9D3eIPB0B4ZvzVyBRlVm7tfTOj7
 0QEA5WSy/YgahxuGKA2CQRj+dAdV+k8EzXg5NdMyvOaXIRTnUTTdmDLa08yNR38ZcrBx
 cto6r1KB1zXnNj9QjRxWxiJLUQkV9ty04YobrEXsTin267TX/khjXMEOx+8vkBfULJVe
 4S9Z5gvTuPsC8fLHbTSosx7sgh3b6F9ozj6CVp/uB7zK8bJ4rwnviDtxB+fj8TT21jxn
 zF8g==
X-Gm-Message-State: APjAAAWtNQ3JhWRaGxtyPIotx5iQZXmmT+utAMag603Woq+it+2++Qn6
 3/Xi3tNaZw281f1A8kRrY8tK6g==
X-Google-Smtp-Source: APXvYqz/Lv9SWzdVHOfa2/gErUaBRXB2O3tiOBCs45MrDO8hgtxtsV4OzBIyCwEYQgSx2Idq4ueGWA==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr16386444wml.43.1571069844514; 
 Mon, 14 Oct 2019 09:17:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o18sm47754615wrw.90.2019.10.14.09.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:17:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D62F1FF87;
 Mon, 14 Oct 2019 17:17:23 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-7-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 06/20] target/arm: Reduce tests vs M-profile in
 cpu_get_tb_cpu_state
In-reply-to: <20191011155546.14342-7-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 17:17:23 +0100
Message-ID: <87pnizmhd8.fsf@linaro.org>
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Hoist the computation of some TBFLAG_A32 bits that only apply to
> M-profile under a single test for ARM_FEATURE_M.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 49 +++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d4303420da..296a4b2232 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11194,6 +11194,29 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>
>          if (arm_feature(env, ARM_FEATURE_M)) {
>              flags =3D rebuild_hflags_m32(env, fp_el, mmu_idx);
> +
> +            if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
> +                FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
> +                !=3D env->v7m.secure) {
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1=
);
> +            }
> +
> +            if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MAS=
K) &&
> +                (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) =
||
> +                 (env->v7m.secure &&
> +                  !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)=
))) {
> +                /*
> +                 * ASPEN is set, but FPCA/SFPA indicate that there is no
> +                 * active FP context; we must create a new FP context be=
fore
> +                 * executing any FP insn.
> +                 */
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEED=
ED, 1);
> +            }
> +
> +            bool is_secure =3D env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_M=
ASK;
> +            if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
> +            }
>          } else {
>              flags =3D rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
>          }
> @@ -11233,32 +11256,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>          }
>      }
>
> -    if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
> -        FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) !=3D env->v7m.=
secure) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
> -    }
> -
> -    if (arm_feature(env, ARM_FEATURE_M) &&
> -        (env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
> -        (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
> -         (env->v7m.secure &&
> -          !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
> -        /*
> -         * ASPEN is set, but FPCA/SFPA indicate that there is no active
> -         * FP context; we must create a new FP context before executing
> -         * any FP insn.
> -         */
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
> -    }
> -
> -    if (arm_feature(env, ARM_FEATURE_M)) {
> -        bool is_secure =3D env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
> -
> -        if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
> -            flags =3D FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
> -        }
> -    }
> -
>      if (!arm_feature(env, ARM_FEATURE_M)) {
>          int target_el =3D arm_debug_target_el(env);


--
Alex Benn=C3=A9e

