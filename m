Received: from eggs.gnu.org ([2001:4830:134:3::10]:39839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCB9-0001hQ-Uq
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCB8-0007rY-45
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:50:19 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:35066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPCB7-0007rN-T4
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:50:18 -0500
Received: by mail-ua0-x22d.google.com with SMTP id y9so54351236uae.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 09:50:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <83f1d283a895d22ee58d73d64e9c0ef328680cf7.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<83f1d283a895d22ee58d73d64e9c0ef328680cf7.1481121503.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 17:49:55 +0000
Message-ID: <CAFEAcA8Tu2UTbMuOOjEMMqZSjNumO6es6q8suABQN_M7CGS2EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ARM big-endian system-mode
 semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 14:48, Julian Brown <julian@codesourcery.com> wrote:
> This patch introduces an ARM-specific version of the memory read/write,
> etc. functions used for semihosting, in order to byte-swap (big-endian)
> target memory that is to be interpreted by the (little-endian) host.
> These functions also know about the byte-reversal used for BE32 system
> mode.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

This patch seems to have compile problems:

In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/arm-semi.c:117:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/softmmu-arm-semi.h=
:
In function =E2=80=98softmmu_unlock_user=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/softmmu-arm-semi.h=
:139:14:
error: unused variable =E2=80=98pc=E2=80=99 [-Werror=3Dunused-variable]
     uint8_t *pc =3D p;
              ^


/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/arm-semi.c: In
function =E2=80=98arm_semi_flen_cb=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/arm-semi.c:190:5:
error: implicit declaration of function =E2=80=98armsemi_memory_rw_debug=E2=
=80=99
[-Werror=3Dimplicit-function-declaration]
     armsemi_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t
*)&size, 4, 0);
     ^
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/arm-semi.c:190:5:
error: nested extern declaration of =E2=80=98armsemi_memory_rw_debug=E2=80=
=99
[-Werror=3Dnested-externs]

[there's no version of armsemi_memory_rw_debug() for CONFIG_USER_ONLY]




> ---
>  include/exec/softmmu-arm-semi.h | 148 ++++++++++++++++++++++++++++++++++=
++++++
>  target-arm/arm-semi.c           |   4 +-
>  target-arm/cpu.c                |  24 +++++++
>  target-arm/cpu.h                |   6 ++
>  4 files changed, 180 insertions(+), 2 deletions(-)
>  create mode 100644 include/exec/softmmu-arm-semi.h
>
> diff --git a/include/exec/softmmu-arm-semi.h b/include/exec/softmmu-arm-s=
emi.h
> new file mode 100644
> index 0000000..d97e017
> --- /dev/null
> +++ b/include/exec/softmmu-arm-semi.h
> @@ -0,0 +1,148 @@
> +/*
> + * Helper routines to provide target memory access for ARM semihosting
> + * syscalls in system emulation mode.
> + *
> + * Copyright (c) 2007 CodeSourcery, (c) 2016 Mentor Graphics
> + *
> + * This code is licensed under the GPL
> + */
> +
> +#ifndef SOFTMMU_ARM_SEMI_H
> +#define SOFTMMU_ARM_SEMI_H 1
> +
> +/* In BE32 system mode, the CPU-specific memory_rw_debug method will arr=
ange to
> + * perform byteswapping on the target memory, so that it appears to the =
host as
> + * it appears to the emulated CPU.  Memory is read verbatim in BE8 mode.=
  (In
> + * other words, this function arranges so that BUF has the same format i=
n both
> + * BE8 and BE32 system mode.)
> + */
> +
> +static inline int armsemi_memory_rw_debug(CPUState *cpu, target_ulong ad=
dr,
> +                                          uint8_t *buf, int len, bool is=
_write)
> +{
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +
> +    if (cc->memory_rw_debug) {
> +        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
> +    }
> +    return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
> +}

Nothing about this is arm-semihosting specific; in fact it's
identical to the existing target_memory_rw_debug() in gdbstub.c.

We have a few of these "invoke the class method if it exists, or
do this fallback" functions in include/qom/cpu.h, so that seems
like a good place for it.

(The logical name for the wrapper is "cpu_memory_rw_debug", except
that it's already taken.)

> +/* In big-endian mode (either BE8 or BE32), values larger than a byte wi=
ll be
> + * transferred to/from memory in big-endian format.  Assuming we're on a
> + * little-endian host machine, such values will need to be byteswapped b=
efore
> + * and after the host processes them.
> + *
> + * This means that byteswapping will occur *twice* in BE32 mode for
> + * halfword/word reads/writes.
> + */
> +
> +static inline bool arm_bswap_needed(CPUARMState *env)
> +{
> +#ifdef HOST_WORDS_BIGENDIAN
> +#error HOST_WORDS_BIGENDIAN is not supported for ARM semihosting at the =
moment.
> +#else
> +    return arm_sctlr_b(env) || arm_sctlr_ee(env);
> +#endif
> +}

This looks odd. SCTLR.EE is the exception endianness, not the
current endianness, so why is it involved in working out how to
interpret the semihosting arguments?

> +
> +static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong ad=
dr)
> +{
> +    uint64_t val;
> +
> +    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, =
0);
> +    if (arm_bswap_needed(env)) {
> +        return bswap64(val);
> +    } else {
> +        return val;
> +    }
> +}
> +
> +static inline uint32_t softmmu_tget32(CPUArchState *env, target_ulong ad=
dr)
> +{
> +    uint32_t val;
> +
> +    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, =
0);
> +    if (arm_bswap_needed(env)) {
> +        return bswap32(val);
> +    } else {
> +        return val;
> +    }
> +}
> +
> +static inline uint32_t softmmu_tget8(CPUArchState *env, target_ulong add=
r)
> +{
> +    uint8_t val;
> +    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, &val, 1, 0);
> +    return val;
> +}
> +
> +#define get_user_u64(arg, p) ({ arg =3D softmmu_tget64(env, p); 0; })
> +#define get_user_u32(arg, p) ({ arg =3D softmmu_tget32(env, p) ; 0; })
> +#define get_user_u8(arg, p) ({ arg =3D softmmu_tget8(env, p) ; 0; })
> +#define get_user_ual(arg, p) get_user_u32(arg, p)
> +
> +static inline void softmmu_tput64(CPUArchState *env,
> +                                  target_ulong addr, uint64_t val)
> +{
> +    if (arm_bswap_needed(env)) {
> +        val =3D bswap64(val);
> +    }
> +    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, 1);
> +}
> +
> +static inline void softmmu_tput32(CPUArchState *env,
> +                                  target_ulong addr, uint32_t val)
> +{
> +    if (arm_bswap_needed(env)) {
> +        val =3D bswap32(val);
> +    }
> +    armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, =
1);
> +}
> +#define put_user_u64(arg, p) ({ softmmu_tput64(env, p, arg) ; 0; })
> +#define put_user_u32(arg, p) ({ softmmu_tput32(env, p, arg) ; 0; })
> +#define put_user_ual(arg, p) put_user_u32(arg, p)
> +
> +static void *softmmu_lock_user(CPUArchState *env,
> +                               target_ulong addr, target_ulong len, int =
copy)
> +{
> +    uint8_t *p;
> +    /* TODO: Make this something that isn't fixed size.  */
> +    p =3D malloc(len);
> +    if (p && copy) {
> +        armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 0);
> +    }
> +    return p;
> +}
> +#define lock_user(type, p, len, copy) softmmu_lock_user(env, p, len, cop=
y)
> +static char *softmmu_lock_user_string(CPUArchState *env, target_ulong ad=
dr)
> +{
> +    char *p;
> +    char *s;
> +    uint8_t c;
> +    /* TODO: Make this something that isn't fixed size.  */
> +    s =3D p =3D malloc(1024);
> +    if (!s) {
> +        return NULL;
> +    }
> +    do {
> +        armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, &c, 1, 0);
> +        addr++;
> +        *(p++) =3D c;
> +    } while (c);
> +    return s;
> +}
> +#define lock_user_string(p) softmmu_lock_user_string(env, p)
> +static void softmmu_unlock_user(CPUArchState *env, void *p, target_ulong=
 addr,
> +                                target_ulong len)
> +{
> +    uint8_t *pc =3D p;
> +    if (len) {
> +        armsemi_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 1);
> +    }
> +    free(p);
> +}
> +
> +#define unlock_user(s, args, len) softmmu_unlock_user(env, s, args, len)
> +
> +#endif
> diff --git a/target-arm/arm-semi.c b/target-arm/arm-semi.c
> index 7cac873..1ad1e63 100644
> --- a/target-arm/arm-semi.c
> +++ b/target-arm/arm-semi.c
> @@ -114,7 +114,7 @@ static inline uint32_t set_swi_errno(CPUARMState *env=
, uint32_t code)
>      return code;
>  }
>
> -#include "exec/softmmu-semi.h"
> +#include "exec/softmmu-arm-semi.h"
>  #endif
>
>  static target_ulong arm_semi_syscall_len;
> @@ -187,7 +187,7 @@ static void arm_semi_flen_cb(CPUState *cs, target_ulo=
ng ret, target_ulong err)
>      /* The size is always stored in big-endian order, extract
>         the value. We assume the size always fit in 32 bits.  */
>      uint32_t size;
> -    cpu_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size, 4,=
 0);
> +    armsemi_memory_rw_debug(cs, arm_flen_buf(cpu) + 32, (uint8_t *)&size=
, 4, 0);
>      size =3D be32_to_cpu(size);
>      if (is_a64(env)) {
>          env->xregs[0] =3D size;
> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
> index 512964e..6afb0d9 100644
> --- a/target-arm/cpu.c
> +++ b/target-arm/cpu.c
> @@ -1556,6 +1556,27 @@ static gchar *arm_gdb_arch_name(CPUState *cs)
>      return g_strdup("arm");
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static int arm_cpu_memory_rw_debug(CPUState *cpu, vaddr address,
> +                                   uint8_t *buf, int len, bool is_write)
> +{
> +    target_ulong addr =3D address;
> +    ARMCPU *armcpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &armcpu->env;
> +
> +    if (arm_sctlr_b(env)) {
> +        target_ulong i;
> +        for (i =3D 0; i < len; i++) {
> +            cpu_memory_rw_debug(cpu, (addr + i) ^ 3, &buf[i], 1, is_writ=
e);
> +        }
> +    } else {
> +        cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
> +    }
> +
> +    return 0;
> +}
> +#endif
> +
>  static void arm_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
> @@ -1573,6 +1594,9 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
>      cc->has_work =3D arm_cpu_has_work;
>      cc->cpu_exec_interrupt =3D arm_cpu_exec_interrupt;
>      cc->dump_state =3D arm_cpu_dump_state;
> +#if !defined(CONFIG_USER_ONLY)
> +    cc->memory_rw_debug =3D arm_cpu_memory_rw_debug;
> +#endif
>      cc->set_pc =3D arm_cpu_set_pc;
>      cc->gdb_read_register =3D arm_cpu_gdb_read_register;
>      cc->gdb_write_register =3D arm_cpu_gdb_write_register;
> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
> index becbfce..087cf96 100644
> --- a/target-arm/cpu.h
> +++ b/target-arm/cpu.h
> @@ -2115,6 +2115,12 @@ static inline bool arm_sctlr_b(CPUARMState *env)
>          (env->cp15.sctlr_el[1] & SCTLR_B) !=3D 0;
>  }
>
> +static inline bool arm_sctlr_ee(CPUARMState *env)
> +{
> +    return arm_feature(env, ARM_FEATURE_V7) &&
> +           (env->cp15.sctlr_el[1] & SCTLR_EE) !=3D 0;
> +}
> +
>  /* Return true if the processor is in big-endian mode. */
>  static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>  {

thanks
-- PMM
