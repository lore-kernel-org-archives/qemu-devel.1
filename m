Received: from eggs.gnu.org ([2001:4830:134:3::10]:34679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etDYz-0006zE-B3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etDYs-0002m8-H5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:27:33 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etDYs-0002lO-7K
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:27:26 -0500
Received: by mail-wm0-x243.google.com with SMTP id h21so23119299wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:27:26 -0800 (PST)
References: <20180303143823.27055-1-richard.henderson@linaro.org>
	<20180303143823.27055-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180303143823.27055-6-richard.henderson@linaro.org>
Date: Tue, 06 Mar 2018 14:27:23 +0000
Message-ID: <871sgxth2s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 5/5] aarch64-linux-user: Add
 support for SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Depending on the currently selected size of the SVE vector registers,
> we can either store the data within the "standard" allocation, or we
> may beedn to allocate additional space with an EXTRA record.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/signal.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 192 insertions(+), 18 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index c31cf0601d..92513f655c 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1452,6 +1452,34 @@ struct target_extra_context {
>      uint32_t reserved[3];
>  };
>
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

Ahh there it is. I guess if we do a later clean-up we can use this

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


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
>  struct target_rt_sigframe {
>      struct target_siginfo info;
>      struct target_ucontext uc;
> @@ -1526,6 +1554,34 @@ static void target_setup_end_record(struct target_=
aarch64_ctx *end)
>      __put_user(0, &end->size);
>  }
>
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
>  static void target_restore_general_frame(CPUARMState *env,
>                                           struct target_rt_sigframe *sf)
>  {
> @@ -1569,14 +1625,45 @@ static void target_restore_fpsimd_record(CPUARMSt=
ate *env,
>      }
>  }
>
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
>  static int target_restore_sigframe(CPUARMState *env,
>                                     struct target_rt_sigframe *sf)
>  {
>      struct target_aarch64_ctx *ctx, *extra =3D NULL;
>      struct target_fpsimd_context *fpsimd =3D NULL;
> +    struct target_sve_context *sve =3D NULL;
>      uint64_t extra_datap =3D 0;
>      bool used_extra =3D false;
>      bool err =3D false;
> +    int vq =3D 0, sve_size =3D 0;
>
>      target_restore_general_frame(env, sf);
>
> @@ -1608,6 +1695,18 @@ static int target_restore_sigframe(CPUARMState *en=
v,
>              fpsimd =3D (struct target_fpsimd_context *)ctx;
>              break;
>
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
>          case TARGET_EXTRA_MAGIC:
>              if (extra || size !=3D sizeof(struct target_extra_context)) {
>                  err =3D true;
> @@ -1637,12 +1736,18 @@ static int target_restore_sigframe(CPUARMState *e=
nv,
>          err =3D true;
>      }
>
> +    /* SVE data, if present, overwrites FPSIMD data.  */
> +    if (sve) {
> +        target_restore_sve_record(env, sve, vq);
> +    }
> +
>   exit:
>      unlock_user(extra, extra_datap, 0);
>      return err;
>  }
>
> -static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *=
env)
> +static abi_ulong get_sigframe(struct target_sigaction *ka,
> +                              CPUARMState *env, int size)
>  {
>      abi_ulong sp;
>
> @@ -1655,30 +1760,97 @@ static abi_ulong get_sigframe(struct target_sigac=
tion *ka, CPUARMState *env)
>          sp =3D target_sigaltstack_used.ss_sp + target_sigaltstack_used.s=
s_size;
>      }
>
> -    sp =3D (sp - sizeof(struct target_rt_sigframe)) & ~15;
> +    sp =3D (sp - size) & ~15;
>
>      return sp;
>  }
>
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
>  static void target_setup_frame(int usig, struct target_sigaction *ka,
>                                 target_siginfo_t *info, target_sigset_t *=
set,
>                                 CPUARMState *env)
>  {
> -    int size =3D offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__r=
eserved);
> -    int fpsimd_ofs, end1_ofs, fr_ofs, end2_ofs =3D 0;
> -    int extra_ofs =3D 0, extra_base =3D 0, extra_size =3D 0;
> +    target_sigframe_layout layout =3D {
> +        /* Begin with the size pointing to the reserved space.  */
> +        .total_size =3D offsetof(struct target_rt_sigframe,
> +                               uc.tuc_mcontext.__reserved),
> +    };
> +    int fpsimd_ofs, fr_ofs, sve_ofs =3D 0, vq =3D 0, sve_size =3D 0;
>      struct target_rt_sigframe *frame;
>      struct target_rt_frame_record *fr;
>      abi_ulong frame_addr, return_addr;
>
> -    fpsimd_ofs =3D size;
> -    size +=3D sizeof(struct target_fpsimd_context);
> -    end1_ofs =3D size;
> -    size +=3D sizeof(struct target_aarch64_ctx);
> -    fr_ofs =3D size;
> -    size +=3D sizeof(struct target_rt_frame_record);
> +    /* FPSIMD record is always in the standard space.  */
> +    fpsimd_ofs =3D alloc_sigframe_space(sizeof(struct target_fpsimd_cont=
ext),
> +                                      &layout);
>
> -    frame_addr =3D get_sigframe(ka, env);
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
>      trace_user_setup_frame(env, frame_addr);
>      if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
>          goto give_sigsegv;
> @@ -1686,13 +1858,15 @@ static void target_setup_frame(int usig, struct t=
arget_sigaction *ka,
>
>      target_setup_general_frame(frame, env, set);
>      target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
> -    if (extra_ofs) {
> -        target_setup_extra_record((void *)frame + extra_ofs,
> -                                  frame_addr + extra_base, extra_size);
> +    target_setup_end_record((void *)frame + layout.std_end_ofs);
> +    if (layout.extra_ofs) {
> +        target_setup_extra_record((void *)frame + layout.extra_ofs,
> +                                  frame_addr + layout.extra_base,
> +                                  layout.extra_size);
> +        target_setup_end_record((void *)frame + layout.extra_end_ofs);
>      }
> -    target_setup_end_record((void *)frame + end1_ofs);
> -    if (end2_ofs) {
> -        target_setup_end_record((void *)frame + end2_ofs);
> +    if (sve_ofs) {
> +        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_si=
ze);
>      }
>
>      /* Set up the stack frame for unwinding.  */


--
Alex Benn=C3=A9e
