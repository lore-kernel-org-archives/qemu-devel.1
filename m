Received: from eggs.gnu.org ([2001:4830:134:3::10]:41140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotwg-0006ah-Es
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotwe-0007E6-Vk
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:42:10 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eotwe-0007Ds-NY
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:42:08 -0500
Received: by mail-ot0-x241.google.com with SMTP id 95so5165612ote.5
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 08:42:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216215608.13227-6-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 16:41:47 +0000
Message-ID: <CAFEAcA8bkt+dOehzyWm3=KUtiVRHak8Ge2gJTJuCg3VAyLQoSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] aarch64-linux-user: Add support for
 SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 21:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Depending on the currently selected size of the SVE vector registers,
> we can either store the data within the "standard" allocation, or we
> may beedn to allocate additional space with an EXTRA record.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/signal.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index ca0ba28c98..4c9fef4bb2 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1452,6 +1452,30 @@ struct target_extra_context {
>      uint32_t reserved[3];
>  };
>
> +#define TARGET_SVE_MAGIC    0x53564501
> +
> +struct target_sve_context {
> +    struct target_aarch64_ctx head;
> +    uint16_t vl;
> +    uint16_t reserved[3];

Worth commenting that actual SVE register data will directly follow the struct.


> +static void target_restore_sve_record(CPUARMState *env,
> +                                      struct target_sve_context *sve, int vq)
> +{
> +    int i, j;
> +
> +    /* Note that SVE regs are stored as a byte stream, with each byte element
> +     * at a subsequent address.  This corresponds to a little-endian store
> +     * of our 64-bit hunks.

We're doing loads in this function, not stores.

> +     */
> +    for (i = 0; i < 32; ++i) {
> +        uint64_t *z = (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
> +        for (j = 0; j < vq * 2; ++j) {
> +            __get_user_e(env->vfp.zregs[i].d[j], z + j, le);
> +        }
> +    }
> +    for (i = 0; i <= 16; ++i) {
> +        uint16_t *p = (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
> +        for (j = 0; j < vq; ++j) {
> +            uint16_t r;
> +            __get_user_e(r, p + j, le);
> +            if (j & 3) {
> +                env->vfp.pregs[i].p[j >> 2] |= (uint64_t)r << ((j & 3) * 16);
> +            } else {
> +                env->vfp.pregs[i].p[j >> 2] = r;
> +            }
> +        }
> +    }
> +}
> +

> @@ -1659,21 +1759,53 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
>                                 target_siginfo_t *info, target_sigset_t *set,
>                                 CPUARMState *env)
>  {
> +    int std_size = sizeof(struct target_rt_sigframe);
>      int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
>      int fpsimd_ofs, end1_ofs, fr_ofs, end2_ofs = 0;
>      int extra_ofs = 0, extra_base = 0, extra_size = 0;
> +    int sve_ofs = 0, vq = 0, sve_size = 0;
>      struct target_rt_sigframe *frame;
>      struct target_rt_frame_record *fr;
>      abi_ulong frame_addr, return_addr;
>
> +    /* Reserve space for standard exit marker.  */
> +    std_size -= sizeof(struct target_aarch64_ctx);
> +
> +    /* FPSIMD record is always in the standard space.  */
>      fpsimd_ofs = size;
>      size += sizeof(struct target_fpsimd_context);
>      end1_ofs = size;
> +
> +    /* SVE state needs saving only if it exists.  */
> +    if (arm_feature(env, ARM_FEATURE_SVE)) {
> +        vq = (env->vfp.zcr_el[1] & 0xf) + 1;
> +        sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
> +
> +        /* For VQ <= 6, there is room in the standard space.  */

The kernel header arch/arm64/include/uapi/asm/sigcontext.h
claims the record is in the standard space if "vl <= 64", which
doesn't seem to match up with "VQ <= 6" ?

> +        if (sve_size <= std_size) {
> +            sve_ofs = size;
> +            size += sve_size;
> +            end1_ofs = size;
> +        } else {
> +            /* Otherwise we need to allocate extra space.  */
> +            extra_ofs = size;
> +            size += sizeof(struct target_extra_context);
> +            end1_ofs = size;
> +            size += QEMU_ALIGN_UP(sizeof(struct target_aarch64_ctx), 16);

Why do we add the size of target_aarch64_ctx to size here?
We already account for the size of the end record later, so
what is this one?

> +            extra_base = size;
> +            extra_size = sve_size + sizeof(struct target_aarch64_ctx);

If we ever get two different kinds of optional record that need to
live in the extra space, this is going to need refactoring,
because at the moment it assumes that the SVE record is the first
and only thing that might live there. I guess that's OK for now, though.

> +
> +            sve_ofs = size;
> +            size += sve_size;
> +            end2_ofs = size;
> +        }
> +    }
>      size += sizeof(struct target_aarch64_ctx);
> +
>      fr_ofs = size;
>      size += sizeof(struct target_rt_frame_record);
>
> -    frame_addr = get_sigframe(ka, env);
> +    frame_addr = get_sigframe(ka, env, size);
>      trace_user_setup_frame(env, frame_addr);
>      if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
>          goto give_sigsegv;
> @@ -1686,6 +1818,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
>                                    frame_addr + extra_base, extra_size);
>      }
>      target_setup_end_record((void *)frame + end1_ofs);
> +    if (sve_ofs) {
> +        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_size);
> +    }
>      if (end2_ofs) {
>          target_setup_end_record((void *)frame + end2_ofs);
>      }
> --

thanks
-- PMM
