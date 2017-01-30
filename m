Received: from eggs.gnu.org ([2001:4830:134:3::10]:41692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYCLE-0005dp-8E
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYCLD-0001O6-DR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:49:56 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:36043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYCLD-0001Nx-8p
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:49:55 -0500
Received: by mail-vk0-x231.google.com with SMTP id t8so215680942vke.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 05:49:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123021748.13170-19-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
	<20170123021748.13170-19-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 13:49:34 +0000
Message-ID: <CAFEAcA_YbHYSL4hS7_K3rA9VTU+eYmE7CG+dSgnTB+GKOnPRLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 18/26] target-hppa: Add framework and enable
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 02:17, Richard Henderson <rth@twiddle.net> wrote:
> This is just about the minimum required to enable compilation
> without actually executing any instructions.  This contains the
> HPPACPU structure and the required callbacks, the gdbstub, the
> basic translation loop, and a translate_one function that always
> results in an illegal instruction.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

> --- /dev/null
> +++ b/target/hppa/gdbstub.c
> @@ -0,0 +1,111 @@
> +/*
> + * HPPA gdb server stub

> +int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    HPPACPU *cpu = HPPA_CPU(cs);
> +    CPUHPPAState *env = &cpu->env;
> +    target_ulong val = ldtul_p(mem_buf);
> +
> +    switch (n) {
> +    case 0:
> +        cpu_hppa_put_psw(env, val);
> +        break;
> +    case 1 ... 31:
> +        env->gr[n] = val;
> +        break;
> +    case 32:
> +        env->sar = val;
> +        break;
> +    case 33:
> +        env->iaoq_f = val;
> +        break;
> +    case 35:
> +        env->iaoq_b = val;

Is this a missing "break;" or a missing "/* fall through */" ?

(spotted by Coverity, CID 1369420.)

> +    case 59:
> +        env->cr26 = val;
> +        break;
> +    case 60:
> +        env->cr27 = val;
> +        break;
> +    case 64:
> +        env->fr[0] = deposit64(env->fr[0], 32, 32, val);
> +        cpu_hppa_loaded_fr0(env);
> +        break;
> +    case 65 ... 127:
> +        {
> +            uint64_t *fr = &env->fr[(n - 64) / 2];
> +            *fr = deposit64(*fr, val, (n & 1 ? 0 : 32), 32);
> +        }
> +        break;
> +    default:
> +        if (n >= 128) {
> +            return 0;
> +        }
> +        break;
> +    }
> +    return sizeof(target_ulong);
> +})

thanks
-- PMM
