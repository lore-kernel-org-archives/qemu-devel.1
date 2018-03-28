Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1C8W-0007IL-FY
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1C8P-0007rT-Gc
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:33:12 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1C8P-0007qN-2x
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:33:05 -0400
Received: by mail-wr0-x243.google.com with SMTP id y55so2469405wry.3
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 07:33:04 -0700 (PDT)
References: <20180323225739.17329-1-laurent@vivier.eu>
	<20180323225739.17329-3-laurent@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180323225739.17329-3-laurent@vivier.eu>
Date: Wed, 28 Mar 2018 15:33:02 +0100
Message-ID: <87efk48e3l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 02/20] linux-user: move aarch64
 signal.c parts to aarch64 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org


Laurent Vivier <laurent@vivier.eu> writes:

> No code change, only move code from signal.c to
> aarch64/signal.c, except adding includes and
> exporting setup_frame() and setup_rt_frame().
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/aarch64/signal.c        | 561 +++++++++++++++++++++++++++++++=
++++++
>  linux-user/aarch64/target_signal.h |   5 +
>  linux-user/signal.c                | 560 +------------------------------=
-----
>  3 files changed, 567 insertions(+), 559 deletions(-)
>
> diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
> index 02ca338b6c..c472f86bcb 100644
> --- a/linux-user/aarch64/signal.c
> +++ b/linux-user/aarch64/signal.c
> @@ -16,3 +16,564 @@
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
> +#include "qemu/osdep.h"
> +#include "qemu.h"
> +#include "target_signal.h"
> +#include "signal-common.h"
> +#include "linux-user/trace.h"
> +
> +struct target_sigcontext {
> +    uint64_t fault_address;
> +    /* AArch64 registers */
> +    uint64_t regs[31];
> +    uint64_t sp;
> +    uint64_t pc;
> +    uint64_t pstate;
> +    /* 4K reserved for FP/SIMD state and future expansion */
> +    char __reserved[4096] __attribute__((__aligned__(16)));
> +};
> +
> +struct target_ucontext {
> +    abi_ulong tuc_flags;
> +    abi_ulong tuc_link;
> +    target_stack_t tuc_stack;
> +    target_sigset_t tuc_sigmask;
> +    /* glibc uses a 1024-bit sigset_t */
> +    char __unused[1024 / 8 - sizeof(target_sigset_t)];
> +    /* last for future expansion */
> +    struct target_sigcontext tuc_mcontext;
> +};
> +
> +/*
> + * Header to be used at the beginning of structures extending the user
> + * context. Such structures must be placed after the rt_sigframe on the =
stack
> + * and be 16-byte aligned. The last structure must be a dummy one with t=
he
> + * magic and size set to 0.
> + */
> +struct target_aarch64_ctx {
> +    uint32_t magic;
> +    uint32_t size;
> +};
> +
> +#define TARGET_FPSIMD_MAGIC 0x46508001
> +
> +struct target_fpsimd_context {
> +    struct target_aarch64_ctx head;
> +    uint32_t fpsr;
> +    uint32_t fpcr;
> +    uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
> +};
> +
> +#define TARGET_EXTRA_MAGIC  0x45585401
> +
> +struct target_extra_context {
> +    struct target_aarch64_ctx head;
> +    uint64_t datap; /* 16-byte aligned pointer to extra space cast to __=
u64 */
> +    uint32_t size; /* size in bytes of the extra space */
> +    uint32_t reserved[3];
> +};
> +
> +#define TARGET_SVE_MAGIC    0x53564501
> +
> +struct target_sve_context {
> +    struct target_aarch64_ctx head;
> +    uint16_t vl;
> +    uint16_t reserved[3];
> +    /* The actual SVE data immediately follows.  It is layed out
> +     * according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of
> +     * the original struct pointer.
> +     */
> +};
> +
> +#define TARGET_SVE_VQ_BYTES  16
> +
> +#define TARGET_SVE_SIG_ZREG_SIZE(VQ)  ((VQ) * TARGET_SVE_VQ_BYTES)
> +#define TARGET_SVE_SIG_PREG_SIZE(VQ)  ((VQ) * (TARGET_SVE_VQ_BYTES / 8))
> +
> +#define TARGET_SVE_SIG_REGS_OFFSET \
> +    QEMU_ALIGN_UP(sizeof(struct target_sve_context), TARGET_SVE_VQ_BYTES)
> +#define TARGET_SVE_SIG_ZREG_OFFSET(VQ, N) \
> +    (TARGET_SVE_SIG_REGS_OFFSET + TARGET_SVE_SIG_ZREG_SIZE(VQ) * (N))
> +#define TARGET_SVE_SIG_PREG_OFFSET(VQ, N) \
> +    (TARGET_SVE_SIG_ZREG_OFFSET(VQ, 32) + TARGET_SVE_SIG_PREG_SIZE(VQ) *=
 (N))
> +#define TARGET_SVE_SIG_FFR_OFFSET(VQ) \
> +    (TARGET_SVE_SIG_PREG_OFFSET(VQ, 16))
> +#define TARGET_SVE_SIG_CONTEXT_SIZE(VQ) \
> +    (TARGET_SVE_SIG_PREG_OFFSET(VQ, 17))
> +
> +struct target_rt_sigframe {
> +    struct target_siginfo info;
> +    struct target_ucontext uc;
> +};
> +
> +struct target_rt_frame_record {
> +    uint64_t fp;
> +    uint64_t lr;
> +    uint32_t tramp[2];
> +};
> +
> +static void target_setup_general_frame(struct target_rt_sigframe *sf,
> +                                       CPUARMState *env, target_sigset_t=
 *set)
> +{
> +    int i;
> +
> +    __put_user(0, &sf->uc.tuc_flags);
> +    __put_user(0, &sf->uc.tuc_link);
> +
> +    __put_user(target_sigaltstack_used.ss_sp, &sf->uc.tuc_stack.ss_sp);
> +    __put_user(sas_ss_flags(env->xregs[31]), &sf->uc.tuc_stack.ss_flags);
> +    __put_user(target_sigaltstack_used.ss_size, &sf->uc.tuc_stack.ss_siz=
e);
> +
> +    for (i =3D 0; i < 31; i++) {
> +        __put_user(env->xregs[i], &sf->uc.tuc_mcontext.regs[i]);
> +    }
> +    __put_user(env->xregs[31], &sf->uc.tuc_mcontext.sp);
> +    __put_user(env->pc, &sf->uc.tuc_mcontext.pc);
> +    __put_user(pstate_read(env), &sf->uc.tuc_mcontext.pstate);
> +
> +    __put_user(env->exception.vaddress, &sf->uc.tuc_mcontext.fault_addre=
ss);
> +
> +    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
> +        __put_user(set->sig[i], &sf->uc.tuc_sigmask.sig[i]);
> +    }
> +}
> +
> +static void target_setup_fpsimd_record(struct target_fpsimd_context *fps=
imd,
> +                                       CPUARMState *env)
> +{
> +    int i;
> +
> +    __put_user(TARGET_FPSIMD_MAGIC, &fpsimd->head.magic);
> +    __put_user(sizeof(struct target_fpsimd_context), &fpsimd->head.size);
> +    __put_user(vfp_get_fpsr(env), &fpsimd->fpsr);
> +    __put_user(vfp_get_fpcr(env), &fpsimd->fpcr);
> +
> +    for (i =3D 0; i < 32; i++) {
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
> +#ifdef TARGET_WORDS_BIGENDIAN
> +        __put_user(q[0], &fpsimd->vregs[i * 2 + 1]);
> +        __put_user(q[1], &fpsimd->vregs[i * 2]);
> +#else
> +        __put_user(q[0], &fpsimd->vregs[i * 2]);
> +        __put_user(q[1], &fpsimd->vregs[i * 2 + 1]);
> +#endif
> +    }
> +}
> +
> +static void target_setup_extra_record(struct target_extra_context *extra,
> +                                      uint64_t datap, uint32_t extra_siz=
e)
> +{
> +    __put_user(TARGET_EXTRA_MAGIC, &extra->head.magic);
> +    __put_user(sizeof(struct target_extra_context), &extra->head.size);
> +    __put_user(datap, &extra->datap);
> +    __put_user(extra_size, &extra->size);
> +}
> +
> +static void target_setup_end_record(struct target_aarch64_ctx *end)
> +{
> +    __put_user(0, &end->magic);
> +    __put_user(0, &end->size);
> +}
> +
> +static void target_setup_sve_record(struct target_sve_context *sve,
> +                                    CPUARMState *env, int vq, int size)
> +{
> +    int i, j;
> +
> +    __put_user(TARGET_SVE_MAGIC, &sve->head.magic);
> +    __put_user(size, &sve->head.size);
> +    __put_user(vq * TARGET_SVE_VQ_BYTES, &sve->vl);
> +
> +    /* Note that SVE regs are stored as a byte stream, with each byte el=
ement
> +     * at a subsequent address.  This corresponds to a little-endian sto=
re
> +     * of our 64-bit hunks.
> +     */
> +    for (i =3D 0; i < 32; ++i) {
> +        uint64_t *z =3D (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
> +        for (j =3D 0; j < vq * 2; ++j) {
> +            __put_user_e(env->vfp.zregs[i].d[j], z + j, le);
> +        }
> +    }
> +    for (i =3D 0; i <=3D 16; ++i) {
> +        uint16_t *p =3D (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
> +        for (j =3D 0; j < vq; ++j) {
> +            uint64_t r =3D env->vfp.pregs[i].p[j >> 2];
> +            __put_user_e(r >> ((j & 3) * 16), p + j, le);
> +        }
> +    }
> +}
> +
> +static void target_restore_general_frame(CPUARMState *env,
> +                                         struct target_rt_sigframe *sf)
> +{
> +    sigset_t set;
> +    uint64_t pstate;
> +    int i;
> +
> +    target_to_host_sigset(&set, &sf->uc.tuc_sigmask);
> +    set_sigmask(&set);
> +
> +    for (i =3D 0; i < 31; i++) {
> +        __get_user(env->xregs[i], &sf->uc.tuc_mcontext.regs[i]);
> +    }
> +
> +    __get_user(env->xregs[31], &sf->uc.tuc_mcontext.sp);
> +    __get_user(env->pc, &sf->uc.tuc_mcontext.pc);
> +    __get_user(pstate, &sf->uc.tuc_mcontext.pstate);
> +    pstate_write(env, pstate);
> +}
> +
> +static void target_restore_fpsimd_record(CPUARMState *env,
> +                                         struct target_fpsimd_context *f=
psimd)
> +{
> +    uint32_t fpsr, fpcr;
> +    int i;
> +
> +    __get_user(fpsr, &fpsimd->fpsr);
> +    vfp_set_fpsr(env, fpsr);
> +    __get_user(fpcr, &fpsimd->fpcr);
> +    vfp_set_fpcr(env, fpcr);
> +
> +    for (i =3D 0; i < 32; i++) {
> +        uint64_t *q =3D aa64_vfp_qreg(env, i);
> +#ifdef TARGET_WORDS_BIGENDIAN
> +        __get_user(q[0], &fpsimd->vregs[i * 2 + 1]);
> +        __get_user(q[1], &fpsimd->vregs[i * 2]);
> +#else
> +        __get_user(q[0], &fpsimd->vregs[i * 2]);
> +        __get_user(q[1], &fpsimd->vregs[i * 2 + 1]);
> +#endif
> +    }
> +}
> +
> +static void target_restore_sve_record(CPUARMState *env,
> +                                      struct target_sve_context *sve, in=
t vq)
> +{
> +    int i, j;
> +
> +    /* Note that SVE regs are stored as a byte stream, with each byte el=
ement
> +     * at a subsequent address.  This corresponds to a little-endian load
> +     * of our 64-bit hunks.
> +     */
> +    for (i =3D 0; i < 32; ++i) {
> +        uint64_t *z =3D (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
> +        for (j =3D 0; j < vq * 2; ++j) {
> +            __get_user_e(env->vfp.zregs[i].d[j], z + j, le);
> +        }
> +    }
> +    for (i =3D 0; i <=3D 16; ++i) {
> +        uint16_t *p =3D (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
> +        for (j =3D 0; j < vq; ++j) {
> +            uint16_t r;
> +            __get_user_e(r, p + j, le);
> +            if (j & 3) {
> +                env->vfp.pregs[i].p[j >> 2] |=3D (uint64_t)r << ((j & 3)=
 * 16);
> +            } else {
> +                env->vfp.pregs[i].p[j >> 2] =3D r;
> +            }
> +        }
> +    }
> +}
> +
> +static int target_restore_sigframe(CPUARMState *env,
> +                                   struct target_rt_sigframe *sf)
> +{
> +    struct target_aarch64_ctx *ctx, *extra =3D NULL;
> +    struct target_fpsimd_context *fpsimd =3D NULL;
> +    struct target_sve_context *sve =3D NULL;
> +    uint64_t extra_datap =3D 0;
> +    bool used_extra =3D false;
> +    bool err =3D false;
> +    int vq =3D 0, sve_size =3D 0;
> +
> +    target_restore_general_frame(env, sf);
> +
> +    ctx =3D (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
> +    while (ctx) {
> +        uint32_t magic, size, extra_size;
> +
> +        __get_user(magic, &ctx->magic);
> +        __get_user(size, &ctx->size);
> +        switch (magic) {
> +        case 0:
> +            if (size !=3D 0) {
> +                err =3D true;
> +                goto exit;
> +            }
> +            if (used_extra) {
> +                ctx =3D NULL;
> +            } else {
> +                ctx =3D extra;
> +                used_extra =3D true;
> +            }
> +            continue;
> +
> +        case TARGET_FPSIMD_MAGIC:
> +            if (fpsimd || size !=3D sizeof(struct target_fpsimd_context)=
) {
> +                err =3D true;
> +                goto exit;
> +            }
> +            fpsimd =3D (struct target_fpsimd_context *)ctx;
> +            break;
> +
> +        case TARGET_SVE_MAGIC:
> +            if (arm_feature(env, ARM_FEATURE_SVE)) {
> +                vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> +                sve_size =3D QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(v=
q), 16);
> +                if (!sve && size =3D=3D sve_size) {
> +                    sve =3D (struct target_sve_context *)ctx;
> +                    break;
> +                }
> +            }
> +            err =3D true;
> +            goto exit;
> +
> +        case TARGET_EXTRA_MAGIC:
> +            if (extra || size !=3D sizeof(struct target_extra_context)) {
> +                err =3D true;
> +                goto exit;
> +            }
> +            __get_user(extra_datap,
> +                       &((struct target_extra_context *)ctx)->datap);
> +            __get_user(extra_size,
> +                       &((struct target_extra_context *)ctx)->size);
> +            extra =3D lock_user(VERIFY_READ, extra_datap, extra_size, 0);
> +            break;
> +
> +        default:
> +            /* Unknown record -- we certainly didn't generate it.
> +             * Did we in fact get out of sync?
> +             */
> +            err =3D true;
> +            goto exit;
> +        }
> +        ctx =3D (void *)ctx + size;
> +    }
> +
> +    /* Require FPSIMD always.  */
> +    if (fpsimd) {
> +        target_restore_fpsimd_record(env, fpsimd);
> +    } else {
> +        err =3D true;
> +    }
> +
> +    /* SVE data, if present, overwrites FPSIMD data.  */
> +    if (sve) {
> +        target_restore_sve_record(env, sve, vq);
> +    }
> +
> + exit:
> +    unlock_user(extra, extra_datap, 0);
> +    return err;
> +}
> +
> +static abi_ulong get_sigframe(struct target_sigaction *ka,
> +                              CPUARMState *env, int size)
> +{
> +    abi_ulong sp;
> +
> +    sp =3D env->xregs[31];
> +
> +    /*
> +     * This is the X/Open sanctioned signal stack switching.
> +     */
> +    if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
> +        sp =3D target_sigaltstack_used.ss_sp + target_sigaltstack_used.s=
s_size;
> +    }
> +
> +    sp =3D (sp - size) & ~15;
> +
> +    return sp;
> +}
> +
> +typedef struct {
> +    int total_size;
> +    int extra_base;
> +    int extra_size;
> +    int std_end_ofs;
> +    int extra_ofs;
> +    int extra_end_ofs;
> +} target_sigframe_layout;
> +
> +static int alloc_sigframe_space(int this_size, target_sigframe_layout *l)
> +{
> +    /* Make sure there will always be space for the end marker.  */
> +    const int std_size =3D sizeof(struct target_rt_sigframe)
> +                         - sizeof(struct target_aarch64_ctx);
> +    int this_loc =3D l->total_size;
> +
> +    if (l->extra_base) {
> +        /* Once we have begun an extra space, all allocations go there. =
 */
> +        l->extra_size +=3D this_size;
> +    } else if (this_size + this_loc > std_size) {
> +        /* This allocation does not fit in the standard space.  */
> +        /* Allocate the extra record.  */
> +        l->extra_ofs =3D this_loc;
> +        l->total_size +=3D sizeof(struct target_extra_context);
> +
> +        /* Allocate the standard end record.  */
> +        l->std_end_ofs =3D l->total_size;
> +        l->total_size +=3D sizeof(struct target_aarch64_ctx);
> +
> +        /* Allocate the requested record.  */
> +        l->extra_base =3D this_loc =3D l->total_size;
> +        l->extra_size =3D this_size;
> +    }
> +    l->total_size +=3D this_size;
> +
> +    return this_loc;
> +}
> +
> +static void target_setup_frame(int usig, struct target_sigaction *ka,
> +                               target_siginfo_t *info, target_sigset_t *=
set,
> +                               CPUARMState *env)
> +{
> +    target_sigframe_layout layout =3D {
> +        /* Begin with the size pointing to the reserved space.  */
> +        .total_size =3D offsetof(struct target_rt_sigframe,
> +                               uc.tuc_mcontext.__reserved),
> +    };
> +    int fpsimd_ofs, fr_ofs, sve_ofs =3D 0, vq =3D 0, sve_size =3D 0;
> +    struct target_rt_sigframe *frame;
> +    struct target_rt_frame_record *fr;
> +    abi_ulong frame_addr, return_addr;
> +
> +    /* FPSIMD record is always in the standard space.  */
> +    fpsimd_ofs =3D alloc_sigframe_space(sizeof(struct target_fpsimd_cont=
ext),
> +                                      &layout);
> +
> +    /* SVE state needs saving only if it exists.  */
> +    if (arm_feature(env, ARM_FEATURE_SVE)) {
> +        vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> +        sve_size =3D QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
> +        sve_ofs =3D alloc_sigframe_space(sve_size, &layout);
> +    }
> +
> +    if (layout.extra_ofs) {
> +        /* Reserve space for the extra end marker.  The standard end mar=
ker
> +         * will have been allocated when we allocated the extra record.
> +         */
> +        layout.extra_end_ofs
> +            =3D alloc_sigframe_space(sizeof(struct target_aarch64_ctx), =
&layout);
> +    } else {
> +        /* Reserve space for the standard end marker.
> +         * Do not use alloc_sigframe_space because we cheat
> +         * std_size therein to reserve space for this.
> +         */
> +        layout.std_end_ofs =3D layout.total_size;
> +        layout.total_size +=3D sizeof(struct target_aarch64_ctx);
> +    }
> +
> +    /* Reserve space for the return code.  On a real system this would
> +     * be within the VDSO.  So, despite the name this is not a "real"
> +     * record within the frame.
> +     */
> +    fr_ofs =3D layout.total_size;
> +    layout.total_size +=3D sizeof(struct target_rt_frame_record);
> +
> +    frame_addr =3D get_sigframe(ka, env, layout.total_size);
> +    trace_user_setup_frame(env, frame_addr);
> +    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> +        goto give_sigsegv;
> +    }
> +
> +    target_setup_general_frame(frame, env, set);
> +    target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
> +    target_setup_end_record((void *)frame + layout.std_end_ofs);
> +    if (layout.extra_ofs) {
> +        target_setup_extra_record((void *)frame + layout.extra_ofs,
> +                                  frame_addr + layout.extra_base,
> +                                  layout.extra_size);
> +        target_setup_end_record((void *)frame + layout.extra_end_ofs);
> +    }
> +    if (sve_ofs) {
> +        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_si=
ze);
> +    }
> +
> +    /* Set up the stack frame for unwinding.  */
> +    fr =3D (void *)frame + fr_ofs;
> +    __put_user(env->xregs[29], &fr->fp);
> +    __put_user(env->xregs[30], &fr->lr);
> +
> +    if (ka->sa_flags & TARGET_SA_RESTORER) {
> +        return_addr =3D ka->sa_restorer;
> +    } else {
> +        /*
> +         * mov x8,#__NR_rt_sigreturn; svc #0
> +         * Since these are instructions they need to be put as little-en=
dian
> +         * regardless of target default or current CPU endianness.
> +         */
> +        __put_user_e(0xd2801168, &fr->tramp[0], le);
> +        __put_user_e(0xd4000001, &fr->tramp[1], le);
> +        return_addr =3D frame_addr + fr_ofs
> +            + offsetof(struct target_rt_frame_record, tramp);
> +    }
> +    env->xregs[0] =3D usig;
> +    env->xregs[31] =3D frame_addr;
> +    env->xregs[29] =3D frame_addr + fr_ofs;
> +    env->pc =3D ka->_sa_handler;
> +    env->xregs[30] =3D return_addr;
> +    if (info) {
> +        tswap_siginfo(&frame->info, info);
> +        env->xregs[1] =3D frame_addr + offsetof(struct target_rt_sigfram=
e, info);
> +        env->xregs[2] =3D frame_addr + offsetof(struct target_rt_sigfram=
e, uc);
> +    }
> +
> +    unlock_user_struct(frame, frame_addr, 1);
> +    return;
> +
> + give_sigsegv:
> +    unlock_user_struct(frame, frame_addr, 1);
> +    force_sigsegv(usig);
> +}
> +
> +void setup_rt_frame(int sig, struct target_sigaction *ka,
> +                    target_siginfo_t *info, target_sigset_t *set,
> +                    CPUARMState *env)
> +{
> +    target_setup_frame(sig, ka, info, set, env);
> +}
> +
> +void setup_frame(int sig, struct target_sigaction *ka,
> +                 target_sigset_t *set, CPUARMState *env)
> +{
> +    target_setup_frame(sig, ka, 0, set, env);
> +}
> +
> +long do_rt_sigreturn(CPUARMState *env)
> +{
> +    struct target_rt_sigframe *frame =3D NULL;
> +    abi_ulong frame_addr =3D env->xregs[31];
> +
> +    trace_user_do_rt_sigreturn(env, frame_addr);
> +    if (frame_addr & 15) {
> +        goto badframe;
> +    }
> +
> +    if  (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
> +        goto badframe;
> +    }
> +
> +    if (target_restore_sigframe(env, frame)) {
> +        goto badframe;
> +    }
> +
> +    if (do_sigaltstack(frame_addr +
> +            offsetof(struct target_rt_sigframe, uc.tuc_stack),
> +            0, get_sp_from_cpustate(env)) =3D=3D -EFAULT) {
> +        goto badframe;
> +    }
> +
> +    unlock_user_struct(frame, frame_addr, 0);
> +    return -TARGET_QEMU_ESIGRETURN;
> +
> + badframe:
> +    unlock_user_struct(frame, frame_addr, 0);
> +    force_sig(TARGET_SIGSEGV);
> +    return -TARGET_QEMU_ESIGRETURN;
> +}
> +
> +long do_sigreturn(CPUARMState *env)
> +{
> +    return do_rt_sigreturn(env);
> +}
> diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/targ=
et_signal.h
> index e66367cac1..af1f1320e2 100644
> --- a/linux-user/aarch64/target_signal.h
> +++ b/linux-user/aarch64/target_signal.h
> @@ -26,4 +26,9 @@ static inline abi_ulong get_sp_from_cpustate(CPUARMStat=
e *state)
>     return state->xregs[31];
>  }
>
> +void setup_frame(int sig, struct target_sigaction *ka,
> +                 target_sigset_t *set, CPUARMState *env);
> +void setup_rt_frame(int sig, struct target_sigaction *ka,
> +                    target_siginfo_t *info, target_sigset_t *set,
> +                    CPUARMState *env);
>  #endif /* AARCH64_TARGET_SIGNAL_H */
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 435cadbe96..2b05d7951b 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1383,565 +1383,7 @@ badframe:
>      return -TARGET_QEMU_ESIGRETURN;
>  }
>
> -#elif defined(TARGET_AARCH64)
> -
> -struct target_sigcontext {
> -    uint64_t fault_address;
> -    /* AArch64 registers */
> -    uint64_t regs[31];
> -    uint64_t sp;
> -    uint64_t pc;
> -    uint64_t pstate;
> -    /* 4K reserved for FP/SIMD state and future expansion */
> -    char __reserved[4096] __attribute__((__aligned__(16)));
> -};
> -
> -struct target_ucontext {
> -    abi_ulong tuc_flags;
> -    abi_ulong tuc_link;
> -    target_stack_t tuc_stack;
> -    target_sigset_t tuc_sigmask;
> -    /* glibc uses a 1024-bit sigset_t */
> -    char __unused[1024 / 8 - sizeof(target_sigset_t)];
> -    /* last for future expansion */
> -    struct target_sigcontext tuc_mcontext;
> -};
> -
> -/*
> - * Header to be used at the beginning of structures extending the user
> - * context. Such structures must be placed after the rt_sigframe on the =
stack
> - * and be 16-byte aligned. The last structure must be a dummy one with t=
he
> - * magic and size set to 0.
> - */
> -struct target_aarch64_ctx {
> -    uint32_t magic;
> -    uint32_t size;
> -};
> -
> -#define TARGET_FPSIMD_MAGIC 0x46508001
> -
> -struct target_fpsimd_context {
> -    struct target_aarch64_ctx head;
> -    uint32_t fpsr;
> -    uint32_t fpcr;
> -    uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
> -};
> -
> -#define TARGET_EXTRA_MAGIC  0x45585401
> -
> -struct target_extra_context {
> -    struct target_aarch64_ctx head;
> -    uint64_t datap; /* 16-byte aligned pointer to extra space cast to __=
u64 */
> -    uint32_t size; /* size in bytes of the extra space */
> -    uint32_t reserved[3];
> -};
> -
> -#define TARGET_SVE_MAGIC    0x53564501
> -
> -struct target_sve_context {
> -    struct target_aarch64_ctx head;
> -    uint16_t vl;
> -    uint16_t reserved[3];
> -    /* The actual SVE data immediately follows.  It is layed out
> -     * according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of
> -     * the original struct pointer.
> -     */
> -};
> -
> -#define TARGET_SVE_VQ_BYTES  16
> -
> -#define TARGET_SVE_SIG_ZREG_SIZE(VQ)  ((VQ) * TARGET_SVE_VQ_BYTES)
> -#define TARGET_SVE_SIG_PREG_SIZE(VQ)  ((VQ) * (TARGET_SVE_VQ_BYTES / 8))
> -
> -#define TARGET_SVE_SIG_REGS_OFFSET \
> -    QEMU_ALIGN_UP(sizeof(struct target_sve_context), TARGET_SVE_VQ_BYTES)
> -#define TARGET_SVE_SIG_ZREG_OFFSET(VQ, N) \
> -    (TARGET_SVE_SIG_REGS_OFFSET + TARGET_SVE_SIG_ZREG_SIZE(VQ) * (N))
> -#define TARGET_SVE_SIG_PREG_OFFSET(VQ, N) \
> -    (TARGET_SVE_SIG_ZREG_OFFSET(VQ, 32) + TARGET_SVE_SIG_PREG_SIZE(VQ) *=
 (N))
> -#define TARGET_SVE_SIG_FFR_OFFSET(VQ) \
> -    (TARGET_SVE_SIG_PREG_OFFSET(VQ, 16))
> -#define TARGET_SVE_SIG_CONTEXT_SIZE(VQ) \
> -    (TARGET_SVE_SIG_PREG_OFFSET(VQ, 17))
> -
> -struct target_rt_sigframe {
> -    struct target_siginfo info;
> -    struct target_ucontext uc;
> -};
> -
> -struct target_rt_frame_record {
> -    uint64_t fp;
> -    uint64_t lr;
> -    uint32_t tramp[2];
> -};
> -
> -static void target_setup_general_frame(struct target_rt_sigframe *sf,
> -                                       CPUARMState *env, target_sigset_t=
 *set)
> -{
> -    int i;
> -
> -    __put_user(0, &sf->uc.tuc_flags);
> -    __put_user(0, &sf->uc.tuc_link);
> -
> -    __put_user(target_sigaltstack_used.ss_sp, &sf->uc.tuc_stack.ss_sp);
> -    __put_user(sas_ss_flags(env->xregs[31]), &sf->uc.tuc_stack.ss_flags);
> -    __put_user(target_sigaltstack_used.ss_size, &sf->uc.tuc_stack.ss_siz=
e);
> -
> -    for (i =3D 0; i < 31; i++) {
> -        __put_user(env->xregs[i], &sf->uc.tuc_mcontext.regs[i]);
> -    }
> -    __put_user(env->xregs[31], &sf->uc.tuc_mcontext.sp);
> -    __put_user(env->pc, &sf->uc.tuc_mcontext.pc);
> -    __put_user(pstate_read(env), &sf->uc.tuc_mcontext.pstate);
> -
> -    __put_user(env->exception.vaddress, &sf->uc.tuc_mcontext.fault_addre=
ss);
> -
> -    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
> -        __put_user(set->sig[i], &sf->uc.tuc_sigmask.sig[i]);
> -    }
> -}
> -
> -static void target_setup_fpsimd_record(struct target_fpsimd_context *fps=
imd,
> -                                       CPUARMState *env)
> -{
> -    int i;
> -
> -    __put_user(TARGET_FPSIMD_MAGIC, &fpsimd->head.magic);
> -    __put_user(sizeof(struct target_fpsimd_context), &fpsimd->head.size);
> -    __put_user(vfp_get_fpsr(env), &fpsimd->fpsr);
> -    __put_user(vfp_get_fpcr(env), &fpsimd->fpcr);
> -
> -    for (i =3D 0; i < 32; i++) {
> -        uint64_t *q =3D aa64_vfp_qreg(env, i);
> -#ifdef TARGET_WORDS_BIGENDIAN
> -        __put_user(q[0], &fpsimd->vregs[i * 2 + 1]);
> -        __put_user(q[1], &fpsimd->vregs[i * 2]);
> -#else
> -        __put_user(q[0], &fpsimd->vregs[i * 2]);
> -        __put_user(q[1], &fpsimd->vregs[i * 2 + 1]);
> -#endif
> -    }
> -}
> -
> -static void target_setup_extra_record(struct target_extra_context *extra,
> -                                      uint64_t datap, uint32_t extra_siz=
e)
> -{
> -    __put_user(TARGET_EXTRA_MAGIC, &extra->head.magic);
> -    __put_user(sizeof(struct target_extra_context), &extra->head.size);
> -    __put_user(datap, &extra->datap);
> -    __put_user(extra_size, &extra->size);
> -}
> -
> -static void target_setup_end_record(struct target_aarch64_ctx *end)
> -{
> -    __put_user(0, &end->magic);
> -    __put_user(0, &end->size);
> -}
> -
> -static void target_setup_sve_record(struct target_sve_context *sve,
> -                                    CPUARMState *env, int vq, int size)
> -{
> -    int i, j;
> -
> -    __put_user(TARGET_SVE_MAGIC, &sve->head.magic);
> -    __put_user(size, &sve->head.size);
> -    __put_user(vq * TARGET_SVE_VQ_BYTES, &sve->vl);
> -
> -    /* Note that SVE regs are stored as a byte stream, with each byte el=
ement
> -     * at a subsequent address.  This corresponds to a little-endian sto=
re
> -     * of our 64-bit hunks.
> -     */
> -    for (i =3D 0; i < 32; ++i) {
> -        uint64_t *z =3D (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
> -        for (j =3D 0; j < vq * 2; ++j) {
> -            __put_user_e(env->vfp.zregs[i].d[j], z + j, le);
> -        }
> -    }
> -    for (i =3D 0; i <=3D 16; ++i) {
> -        uint16_t *p =3D (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
> -        for (j =3D 0; j < vq; ++j) {
> -            uint64_t r =3D env->vfp.pregs[i].p[j >> 2];
> -            __put_user_e(r >> ((j & 3) * 16), p + j, le);
> -        }
> -    }
> -}
> -
> -static void target_restore_general_frame(CPUARMState *env,
> -                                         struct target_rt_sigframe *sf)
> -{
> -    sigset_t set;
> -    uint64_t pstate;
> -    int i;
> -
> -    target_to_host_sigset(&set, &sf->uc.tuc_sigmask);
> -    set_sigmask(&set);
> -
> -    for (i =3D 0; i < 31; i++) {
> -        __get_user(env->xregs[i], &sf->uc.tuc_mcontext.regs[i]);
> -    }
> -
> -    __get_user(env->xregs[31], &sf->uc.tuc_mcontext.sp);
> -    __get_user(env->pc, &sf->uc.tuc_mcontext.pc);
> -    __get_user(pstate, &sf->uc.tuc_mcontext.pstate);
> -    pstate_write(env, pstate);
> -}
> -
> -static void target_restore_fpsimd_record(CPUARMState *env,
> -                                         struct target_fpsimd_context *f=
psimd)
> -{
> -    uint32_t fpsr, fpcr;
> -    int i;
> -
> -    __get_user(fpsr, &fpsimd->fpsr);
> -    vfp_set_fpsr(env, fpsr);
> -    __get_user(fpcr, &fpsimd->fpcr);
> -    vfp_set_fpcr(env, fpcr);
> -
> -    for (i =3D 0; i < 32; i++) {
> -        uint64_t *q =3D aa64_vfp_qreg(env, i);
> -#ifdef TARGET_WORDS_BIGENDIAN
> -        __get_user(q[0], &fpsimd->vregs[i * 2 + 1]);
> -        __get_user(q[1], &fpsimd->vregs[i * 2]);
> -#else
> -        __get_user(q[0], &fpsimd->vregs[i * 2]);
> -        __get_user(q[1], &fpsimd->vregs[i * 2 + 1]);
> -#endif
> -    }
> -}
> -
> -static void target_restore_sve_record(CPUARMState *env,
> -                                      struct target_sve_context *sve, in=
t vq)
> -{
> -    int i, j;
> -
> -    /* Note that SVE regs are stored as a byte stream, with each byte el=
ement
> -     * at a subsequent address.  This corresponds to a little-endian load
> -     * of our 64-bit hunks.
> -     */
> -    for (i =3D 0; i < 32; ++i) {
> -        uint64_t *z =3D (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
> -        for (j =3D 0; j < vq * 2; ++j) {
> -            __get_user_e(env->vfp.zregs[i].d[j], z + j, le);
> -        }
> -    }
> -    for (i =3D 0; i <=3D 16; ++i) {
> -        uint16_t *p =3D (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
> -        for (j =3D 0; j < vq; ++j) {
> -            uint16_t r;
> -            __get_user_e(r, p + j, le);
> -            if (j & 3) {
> -                env->vfp.pregs[i].p[j >> 2] |=3D (uint64_t)r << ((j & 3)=
 * 16);
> -            } else {
> -                env->vfp.pregs[i].p[j >> 2] =3D r;
> -            }
> -        }
> -    }
> -}
> -
> -static int target_restore_sigframe(CPUARMState *env,
> -                                   struct target_rt_sigframe *sf)
> -{
> -    struct target_aarch64_ctx *ctx, *extra =3D NULL;
> -    struct target_fpsimd_context *fpsimd =3D NULL;
> -    struct target_sve_context *sve =3D NULL;
> -    uint64_t extra_datap =3D 0;
> -    bool used_extra =3D false;
> -    bool err =3D false;
> -    int vq =3D 0, sve_size =3D 0;
> -
> -    target_restore_general_frame(env, sf);
> -
> -    ctx =3D (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
> -    while (ctx) {
> -        uint32_t magic, size, extra_size;
> -
> -        __get_user(magic, &ctx->magic);
> -        __get_user(size, &ctx->size);
> -        switch (magic) {
> -        case 0:
> -            if (size !=3D 0) {
> -                err =3D true;
> -                goto exit;
> -            }
> -            if (used_extra) {
> -                ctx =3D NULL;
> -            } else {
> -                ctx =3D extra;
> -                used_extra =3D true;
> -            }
> -            continue;
> -
> -        case TARGET_FPSIMD_MAGIC:
> -            if (fpsimd || size !=3D sizeof(struct target_fpsimd_context)=
) {
> -                err =3D true;
> -                goto exit;
> -            }
> -            fpsimd =3D (struct target_fpsimd_context *)ctx;
> -            break;
> -
> -        case TARGET_SVE_MAGIC:
> -            if (arm_feature(env, ARM_FEATURE_SVE)) {
> -                vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> -                sve_size =3D QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(v=
q), 16);
> -                if (!sve && size =3D=3D sve_size) {
> -                    sve =3D (struct target_sve_context *)ctx;
> -                    break;
> -                }
> -            }
> -            err =3D true;
> -            goto exit;
> -
> -        case TARGET_EXTRA_MAGIC:
> -            if (extra || size !=3D sizeof(struct target_extra_context)) {
> -                err =3D true;
> -                goto exit;
> -            }
> -            __get_user(extra_datap,
> -                       &((struct target_extra_context *)ctx)->datap);
> -            __get_user(extra_size,
> -                       &((struct target_extra_context *)ctx)->size);
> -            extra =3D lock_user(VERIFY_READ, extra_datap, extra_size, 0);
> -            break;
> -
> -        default:
> -            /* Unknown record -- we certainly didn't generate it.
> -             * Did we in fact get out of sync?
> -             */
> -            err =3D true;
> -            goto exit;
> -        }
> -        ctx =3D (void *)ctx + size;
> -    }
> -
> -    /* Require FPSIMD always.  */
> -    if (fpsimd) {
> -        target_restore_fpsimd_record(env, fpsimd);
> -    } else {
> -        err =3D true;
> -    }
> -
> -    /* SVE data, if present, overwrites FPSIMD data.  */
> -    if (sve) {
> -        target_restore_sve_record(env, sve, vq);
> -    }
> -
> - exit:
> -    unlock_user(extra, extra_datap, 0);
> -    return err;
> -}
> -
> -static abi_ulong get_sigframe(struct target_sigaction *ka,
> -                              CPUARMState *env, int size)
> -{
> -    abi_ulong sp;
> -
> -    sp =3D env->xregs[31];
> -
> -    /*
> -     * This is the X/Open sanctioned signal stack switching.
> -     */
> -    if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
> -        sp =3D target_sigaltstack_used.ss_sp + target_sigaltstack_used.s=
s_size;
> -    }
> -
> -    sp =3D (sp - size) & ~15;
> -
> -    return sp;
> -}
> -
> -typedef struct {
> -    int total_size;
> -    int extra_base;
> -    int extra_size;
> -    int std_end_ofs;
> -    int extra_ofs;
> -    int extra_end_ofs;
> -} target_sigframe_layout;
> -
> -static int alloc_sigframe_space(int this_size, target_sigframe_layout *l)
> -{
> -    /* Make sure there will always be space for the end marker.  */
> -    const int std_size =3D sizeof(struct target_rt_sigframe)
> -                         - sizeof(struct target_aarch64_ctx);
> -    int this_loc =3D l->total_size;
> -
> -    if (l->extra_base) {
> -        /* Once we have begun an extra space, all allocations go there. =
 */
> -        l->extra_size +=3D this_size;
> -    } else if (this_size + this_loc > std_size) {
> -        /* This allocation does not fit in the standard space.  */
> -        /* Allocate the extra record.  */
> -        l->extra_ofs =3D this_loc;
> -        l->total_size +=3D sizeof(struct target_extra_context);
> -
> -        /* Allocate the standard end record.  */
> -        l->std_end_ofs =3D l->total_size;
> -        l->total_size +=3D sizeof(struct target_aarch64_ctx);
> -
> -        /* Allocate the requested record.  */
> -        l->extra_base =3D this_loc =3D l->total_size;
> -        l->extra_size =3D this_size;
> -    }
> -    l->total_size +=3D this_size;
> -
> -    return this_loc;
> -}
> -
> -static void target_setup_frame(int usig, struct target_sigaction *ka,
> -                               target_siginfo_t *info, target_sigset_t *=
set,
> -                               CPUARMState *env)
> -{
> -    target_sigframe_layout layout =3D {
> -        /* Begin with the size pointing to the reserved space.  */
> -        .total_size =3D offsetof(struct target_rt_sigframe,
> -                               uc.tuc_mcontext.__reserved),
> -    };
> -    int fpsimd_ofs, fr_ofs, sve_ofs =3D 0, vq =3D 0, sve_size =3D 0;
> -    struct target_rt_sigframe *frame;
> -    struct target_rt_frame_record *fr;
> -    abi_ulong frame_addr, return_addr;
> -
> -    /* FPSIMD record is always in the standard space.  */
> -    fpsimd_ofs =3D alloc_sigframe_space(sizeof(struct target_fpsimd_cont=
ext),
> -                                      &layout);
> -
> -    /* SVE state needs saving only if it exists.  */
> -    if (arm_feature(env, ARM_FEATURE_SVE)) {
> -        vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> -        sve_size =3D QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
> -        sve_ofs =3D alloc_sigframe_space(sve_size, &layout);
> -    }
> -
> -    if (layout.extra_ofs) {
> -        /* Reserve space for the extra end marker.  The standard end mar=
ker
> -         * will have been allocated when we allocated the extra record.
> -         */
> -        layout.extra_end_ofs
> -            =3D alloc_sigframe_space(sizeof(struct target_aarch64_ctx), =
&layout);
> -    } else {
> -        /* Reserve space for the standard end marker.
> -         * Do not use alloc_sigframe_space because we cheat
> -         * std_size therein to reserve space for this.
> -         */
> -        layout.std_end_ofs =3D layout.total_size;
> -        layout.total_size +=3D sizeof(struct target_aarch64_ctx);
> -    }
> -
> -    /* Reserve space for the return code.  On a real system this would
> -     * be within the VDSO.  So, despite the name this is not a "real"
> -     * record within the frame.
> -     */
> -    fr_ofs =3D layout.total_size;
> -    layout.total_size +=3D sizeof(struct target_rt_frame_record);
> -
> -    frame_addr =3D get_sigframe(ka, env, layout.total_size);
> -    trace_user_setup_frame(env, frame_addr);
> -    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> -        goto give_sigsegv;
> -    }
> -
> -    target_setup_general_frame(frame, env, set);
> -    target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
> -    target_setup_end_record((void *)frame + layout.std_end_ofs);
> -    if (layout.extra_ofs) {
> -        target_setup_extra_record((void *)frame + layout.extra_ofs,
> -                                  frame_addr + layout.extra_base,
> -                                  layout.extra_size);
> -        target_setup_end_record((void *)frame + layout.extra_end_ofs);
> -    }
> -    if (sve_ofs) {
> -        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_si=
ze);
> -    }
> -
> -    /* Set up the stack frame for unwinding.  */
> -    fr =3D (void *)frame + fr_ofs;
> -    __put_user(env->xregs[29], &fr->fp);
> -    __put_user(env->xregs[30], &fr->lr);
> -
> -    if (ka->sa_flags & TARGET_SA_RESTORER) {
> -        return_addr =3D ka->sa_restorer;
> -    } else {
> -        /*
> -         * mov x8,#__NR_rt_sigreturn; svc #0
> -         * Since these are instructions they need to be put as little-en=
dian
> -         * regardless of target default or current CPU endianness.
> -         */
> -        __put_user_e(0xd2801168, &fr->tramp[0], le);
> -        __put_user_e(0xd4000001, &fr->tramp[1], le);
> -        return_addr =3D frame_addr + fr_ofs
> -            + offsetof(struct target_rt_frame_record, tramp);
> -    }
> -    env->xregs[0] =3D usig;
> -    env->xregs[31] =3D frame_addr;
> -    env->xregs[29] =3D frame_addr + fr_ofs;
> -    env->pc =3D ka->_sa_handler;
> -    env->xregs[30] =3D return_addr;
> -    if (info) {
> -        tswap_siginfo(&frame->info, info);
> -        env->xregs[1] =3D frame_addr + offsetof(struct target_rt_sigfram=
e, info);
> -        env->xregs[2] =3D frame_addr + offsetof(struct target_rt_sigfram=
e, uc);
> -    }
> -
> -    unlock_user_struct(frame, frame_addr, 1);
> -    return;
> -
> - give_sigsegv:
> -    unlock_user_struct(frame, frame_addr, 1);
> -    force_sigsegv(usig);
> -}
> -
> -static void setup_rt_frame(int sig, struct target_sigaction *ka,
> -                           target_siginfo_t *info, target_sigset_t *set,
> -                           CPUARMState *env)
> -{
> -    target_setup_frame(sig, ka, info, set, env);
> -}
> -
> -static void setup_frame(int sig, struct target_sigaction *ka,
> -                        target_sigset_t *set, CPUARMState *env)
> -{
> -    target_setup_frame(sig, ka, 0, set, env);
> -}
> -
> -long do_rt_sigreturn(CPUARMState *env)
> -{
> -    struct target_rt_sigframe *frame =3D NULL;
> -    abi_ulong frame_addr =3D env->xregs[31];
> -
> -    trace_user_do_rt_sigreturn(env, frame_addr);
> -    if (frame_addr & 15) {
> -        goto badframe;
> -    }
> -
> -    if  (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
> -        goto badframe;
> -    }
> -
> -    if (target_restore_sigframe(env, frame)) {
> -        goto badframe;
> -    }
> -
> -    if (do_sigaltstack(frame_addr +
> -            offsetof(struct target_rt_sigframe, uc.tuc_stack),
> -            0, get_sp_from_cpustate(env)) =3D=3D -EFAULT) {
> -        goto badframe;
> -    }
> -
> -    unlock_user_struct(frame, frame_addr, 0);
> -    return -TARGET_QEMU_ESIGRETURN;
> -
> - badframe:
> -    unlock_user_struct(frame, frame_addr, 0);
> -    force_sig(TARGET_SIGSEGV);
> -    return -TARGET_QEMU_ESIGRETURN;
> -}
> -
> -long do_sigreturn(CPUARMState *env)
> -{
> -    return do_rt_sigreturn(env);
> -}
> -
> -#elif defined(TARGET_ARM)
> +#elif defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>
>  struct target_sigcontext {
>      abi_ulong trap_no;


--
Alex Benn=C3=A9e
