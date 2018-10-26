Received: from eggs.gnu.org ([2001:4830:134:3::10]:42429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG6ba-0004oM-Vl
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG6ba-0003tC-1x
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:13:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gG6bZ-0003sk-LY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:13:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id c25-v6so1818113oiy.0
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 11:13:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540563667-23300-6-git-send-email-stefan.markovic@rt-rk.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
	<1540563667-23300-6-git-send-email-stefan.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 19:12:44 +0100
Message-ID: <CAFEAcA8-nJ1pKtNautOJ-+Zh0Onw3HoK26ABZozSj3_VR7C=Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/6] Determine the desired FPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

On 26 October 2018 at 15:21, Stefan Markovic <stefan.markovic@rt-rk.com> wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Floating-point mode is calculated from MIPS.abiflags FP ABI value
> (based on kernel implementation). Illegal combinations are rejected.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)

> +     if ((info->fp_abi > MAX_FP_ABI && info->fp_abi != MIPS_ABI_FP_UNKNOWN)
> +        || (info->interp_fp_abi > MAX_FP_ABI &&
> +            info->interp_fp_abi != MIPS_ABI_FP_UNKNOWN)) {
> +        fprintf(stderr, "qemu: Program and interpreter have "
> +                        "unexpected FPU modes\n");
> +        exit(137);

Why are we exit()ing with a funny exit status code here?

If this is a "can't happen" case, then we should assert(). If
it is a "can happen if fed an odd binary" case, then we should just
exit(1) as we do already in this function for an unsupported NaN mode.

> +    }
> +
> +    prog_req = (info->fp_abi == MIPS_ABI_FP_UNKNOWN) ? none_req
> +                                            : fpu_reqs[info->fp_abi];
> +    interp_req = (info->interp_fp_abi == MIPS_ABI_FP_UNKNOWN) ? none_req
> +                                            : fpu_reqs[info->interp_fp_abi];
> +
> +    prog_req.single &= interp_req.single;
> +    prog_req.soft &= interp_req.soft;
> +    prog_req.fr1 &= interp_req.fr1;
> +    prog_req.frdefault &= interp_req.frdefault;
> +    prog_req.fre &= interp_req.fre;
> +
> +    bool cpu_has_mips_r2_r6 = env->insn_flags & ISA_MIPS32R2 ||
> +                              env->insn_flags & ISA_MIPS64R2 ||
> +                              env->insn_flags & ISA_MIPS32R6 ||
> +                              env->insn_flags & ISA_MIPS64R6;
> +
> +    if (prog_req.fre && !prog_req.frdefault && !prog_req.fr1) {
> +        env->CP0_Config5 |= (1 << CP0C5_FRE);
> +        if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
> +            env->hflags |= MIPS_HFLAG_FRE;
> +        }
> +    } else if ((prog_req.fr1 && prog_req.frdefault) ||
> +         (prog_req.single && !prog_req.frdefault)) {
> +        if ((env->active_fpu.fcr0 & (1 << FCR0_F64)
> +            && cpu_has_mips_r2_r6) || prog_req.fr1) {
> +            env->CP0_Status |= (1 << CP0St_FR);
> +            env->hflags |= MIPS_HFLAG_F64;
> +        }
> +    } else  if (!prog_req.fre && !prog_req.frdefault &&
> +          !prog_req.fr1 && !prog_req.single && !prog_req.soft) {
> +        exit(137);
> +    }

Ditto here (and we haven't printed any error message here...)

thanks
-- PMM
