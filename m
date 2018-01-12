Received: from eggs.gnu.org ([2001:4830:134:3::10]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea4K2-0005lR-OI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea4K2-0006Wr-0T
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:44:58 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:40919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea4K1-0006W4-Rm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:44:57 -0500
Received: by mail-ot0-x244.google.com with SMTP id d10so5835670oti.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:44:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-6-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 18:44:36 +0000
Message-ID: <CAFEAcA-e0unT9rx9L0mqCbOwCREDg+-FifKL-mwusNZSRv_Vpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Add
 aa32_vfp_dreg/aa64_vfp_qreg helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Helpers that return a pointer into env->vfp.regs so that we isolate
> the logic of how to index the regs array for different cpu modes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -64,15 +64,16 @@ static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
>      /* VFP data registers are always little-endian.  */
>      nregs = arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        stfq_le_p(buf, env->vfp.regs[reg]);
> +        stfq_le_p(buf, *aa32_vfp_dreg(env, reg));
>          return 8;
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          /* Aliases for Q regs.  */
>          nregs += 16;
>          if (reg < nregs) {
> -            stfq_le_p(buf, env->vfp.regs[(reg - 32) * 2]);
> -            stfq_le_p(buf + 8, env->vfp.regs[(reg - 32) * 2 + 1]);
> +            uint64_t *q = aa32_vfp_dreg(env, (reg - 32) * 2);
> +            stfq_le_p(buf, q[0]);
> +            stfq_le_p(buf + 8, q[1]);
>              return 16;
>          }
>      }
> @@ -90,14 +91,15 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
>
>      nregs = arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        env->vfp.regs[reg] = ldfq_le_p(buf);
> +        *aa32_vfp_dreg(env, reg) = ldfq_le_p(buf);
>          return 8;
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          nregs += 16;
>          if (reg < nregs) {
> -            env->vfp.regs[(reg - 32) * 2] = ldfq_le_p(buf);
> -            env->vfp.regs[(reg - 32) * 2 + 1] = ldfq_le_p(buf + 8);
> +            uint64_t *q = aa32_vfp_dreg(env, (reg - 32) * 2);
> +            q[0] = ldfq_le_p(buf);
> +            q[1] = ldfq_le_p(buf + 8);
>              return 16;
>          }
>      }

After reading patch 7 I came back to this one. I wonder if these two
(which I think are the only ones) justify an aa32_vfp_qreg() ?

thanks
-- PMM
