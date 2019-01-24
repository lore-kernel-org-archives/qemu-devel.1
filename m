Received: from eggs.gnu.org ([209.51.188.92]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgAX-00059u-Q7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgAU-0006js-LJ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:39:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmgAU-0006da-5G
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:39:46 -0500
Received: by mail-wm1-x344.google.com with SMTP id y8so3285015wmi.4
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:39:46 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-16-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-16-cota@braap.org>
Date: Thu, 24 Jan 2019 14:39:43 +0000
Message-ID: <87tvhyyv9s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 15/38] tcg: let plugins instrument memory
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> XXX: store hostaddr from non-i386 TCG backends
> XXX: what hostaddr to return for I/O accesses?
> XXX: what hostaddr to return for cross-page accesses?

Just a heads up this patch now clashes with changes that have been made
to master.

>
> Here the trickiest feature is passing the host address to
> memory callbacks that request it. Perhaps it would be more
> appropriate to pass a "physical" address to plugins, but since
> in QEMU host addr ~=3D guest physical, I'm going with that for
> simplicity.
>
> To keep the implementation simple we piggy-back on the TLB fast path,
> and thus can only provide the host address _after_ memory accesses
> have occurred. For the slow path, it's a bit tedious because there
> are many places to update, but it's fairly simple.
>
> However, note that cross-page accesses are tricky, since the
> access might be to non-contiguous host addresses. So I'm punting
> on that and just passing NULL.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/atomic_template.h               |  5 +++
>  accel/tcg/softmmu_template.h              | 43 +++++++++++++++++-----
>  include/exec/cpu-defs.h                   |  9 +++++
>  include/exec/cpu_ldst.h                   |  9 +++++
>  include/exec/cpu_ldst_template.h          | 43 ++++++++++++++--------
>  include/exec/cpu_ldst_useronly_template.h | 42 +++++++++++++++-------
>  tcg/tcg.h                                 |  1 +
>  accel/tcg/cpu-exec.c                      |  2 ++
>  accel/tcg/cputlb.c                        |  9 +++++
>  tcg/i386/tcg-target.inc.c                 |  7 ++++
>  tcg/tcg-op.c                              | 44 ++++++++++++++++++-----
>  11 files changed, 169 insertions(+), 45 deletions(-)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index 2f7d5ee02a..5619c4b4b9 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -18,6 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>
> +#include "qemu/plugin.h"
>  #include "trace/mem.h"
>
>  #if DATA_SIZE =3D=3D 16
> @@ -73,6 +74,8 @@ void atomic_trace_rmw_pre(CPUArchState *env, target_ulo=
ng addr, uint8_t info)
>  static inline void atomic_trace_rmw_post(CPUArchState *env, target_ulong=
 addr,
>                                           void *haddr, uint8_t info)
>  {
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info);
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info | TRACE_=
MEM_ST);
>  }
>
>  static inline
> @@ -84,6 +87,7 @@ void atomic_trace_ld_pre(CPUArchState *env, target_ulon=
g addr, uint8_t info)
>  static inline void atomic_trace_ld_post(CPUArchState *env, target_ulong =
addr,
>                                          void *haddr, uint8_t info)
>  {
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info);
>  }
>
>  static inline
> @@ -95,6 +99,7 @@ void atomic_trace_st_pre(CPUArchState *env, target_ulon=
g addr, uint8_t info)
>  static inline void atomic_trace_st_post(CPUArchState *env, target_ulong =
addr,
>                                          void *haddr, uint8_t info)
>  {
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info);
>  }
>  #endif /* ATOMIC_TEMPLATE_COMMON */
>
> diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
> index b0adea045e..79109e25a1 100644
> --- a/accel/tcg/softmmu_template.h
> +++ b/accel/tcg/softmmu_template.h
> @@ -45,7 +45,6 @@
>  #error unsupported data size
>  #endif
>
> -
>  /* For the benefit of TCG generated code, we want to avoid the complicat=
ion
>     of ABI-specific return type promotion and always return a value exten=
ded
>     to the register size of the host.  This is tcg_target_long, except in=
 the
> @@ -99,10 +98,15 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArch=
State *env,
>                                                size_t mmu_idx, size_t ind=
ex,
>                                                target_ulong addr,
>                                                uintptr_t retaddr,
> +                                              TCGMemOp mo,
>                                                bool recheck,
>                                                MMUAccessType access_type)
>  {
>      CPUIOTLBEntry *iotlbentry =3D &env->iotlb[mmu_idx][index];
> +
> +    /* XXX Any sensible choice other than NULL? */
> +    set_hostaddr(env, mo, NULL);
> +
>      return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, recheck,
>                      access_type, DATA_SIZE);
>  }
> @@ -115,7 +119,8 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target=
_ulong addr,
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
>      CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>      target_ulong tlb_addr =3D entry->ADDR_READ;
> -    unsigned a_bits =3D get_alignment_bits(get_memop(oi));
> +    TCGMemOp mo =3D get_memop(oi);
> +    unsigned a_bits =3D get_alignment_bits(mo);
>      uintptr_t haddr;
>      DATA_TYPE res;
>
> @@ -141,7 +146,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target=
_ulong addr,
>
>          /* ??? Note that the io helpers always read data in the target
>             byte ordering.  We should push the LE/BE request down into io=
.  */
> -        res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
> +        res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr=
, mo,
>                                      tlb_addr & TLB_RECHECK,
>                                      READ_ACCESS_TYPE);
>          res =3D TGT_LE(res);
> @@ -162,12 +167,19 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, targ=
et_ulong addr,
>          res2 =3D helper_le_ld_name(env, addr2, oi, retaddr);
>          shift =3D (addr & (DATA_SIZE - 1)) * 8;
>
> +        /*
> +         * XXX cross-page accesses would have to be split into separate =
accesses
> +         * for the host address to make sense. For now, just return NULL.
> +         */
> +        set_hostaddr(env, mo, NULL);
> +
>          /* Little-endian combine.  */
>          res =3D (res1 >> shift) | (res2 << ((DATA_SIZE * 8) - shift));
>          return res;
>      }
>
>      haddr =3D addr + entry->addend;
> +    set_hostaddr(env, mo, (void *)haddr);
>  #if DATA_SIZE =3D=3D 1
>      res =3D glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
>  #else
> @@ -184,7 +196,8 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target=
_ulong addr,
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
>      CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>      target_ulong tlb_addr =3D entry->ADDR_READ;
> -    unsigned a_bits =3D get_alignment_bits(get_memop(oi));
> +    TCGMemOp mo =3D get_memop(oi);
> +    unsigned a_bits =3D get_alignment_bits(mo);
>      uintptr_t haddr;
>      DATA_TYPE res;
>
> @@ -210,7 +223,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target=
_ulong addr,
>
>          /* ??? Note that the io helpers always read data in the target
>             byte ordering.  We should push the LE/BE request down into io=
.  */
> -        res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
> +        res =3D glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr=
, mo,
>                                      tlb_addr & TLB_RECHECK,
>                                      READ_ACCESS_TYPE);
>          res =3D TGT_BE(res);
> @@ -231,12 +244,15 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, targ=
et_ulong addr,
>          res2 =3D helper_be_ld_name(env, addr2, oi, retaddr);
>          shift =3D (addr & (DATA_SIZE - 1)) * 8;
>
> +        set_hostaddr(env, mo, NULL);
> +
>          /* Big-endian combine.  */
>          res =3D (res1 << shift) | (res2 >> ((DATA_SIZE * 8) - shift));
>          return res;
>      }
>
>      haddr =3D addr + entry->addend;
> +    set_hostaddr(env, mo, (void *)haddr);
>      res =3D glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
>      return res;
>  }
> @@ -267,9 +283,12 @@ static inline void glue(io_write, SUFFIX)(CPUArchSta=
te *env,
>                                            DATA_TYPE val,
>                                            target_ulong addr,
>                                            uintptr_t retaddr,
> +                                          TCGMemOp mo,
>                                            bool recheck)
>  {
>      CPUIOTLBEntry *iotlbentry =3D &env->iotlb[mmu_idx][index];
> +
> +    set_hostaddr(env, mo, NULL);
>      return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
>                       recheck, DATA_SIZE);
>  }
> @@ -281,7 +300,8 @@ void helper_le_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
>      CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>      target_ulong tlb_addr =3D tlb_addr_write(entry);
> -    unsigned a_bits =3D get_alignment_bits(get_memop(oi));
> +    TCGMemOp mo =3D get_memop(oi);
> +    unsigned a_bits =3D get_alignment_bits(mo);
>      uintptr_t haddr;
>
>      if (addr & ((1 << a_bits) - 1)) {
> @@ -308,7 +328,7 @@ void helper_le_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>             byte ordering.  We should push the LE/BE request down into io=
.  */
>          val =3D TGT_LE(val);
>          glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr,
> -                               retaddr, tlb_addr & TLB_RECHECK);
> +                               retaddr, mo, tlb_addr & TLB_RECHECK);
>          return;
>      }
>
> @@ -340,10 +360,12 @@ void helper_le_st_name(CPUArchState *env, target_ul=
ong addr, DATA_TYPE val,
>              glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
>                                              oi, retaddr);
>          }
> +        set_hostaddr(env, mo, NULL);
>          return;
>      }
>
>      haddr =3D addr + entry->addend;
> +    set_hostaddr(env, mo, (void *)haddr);
>  #if DATA_SIZE =3D=3D 1
>      glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
>  #else
> @@ -359,7 +381,8 @@ void helper_be_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
>      CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>      target_ulong tlb_addr =3D tlb_addr_write(entry);
> -    unsigned a_bits =3D get_alignment_bits(get_memop(oi));
> +    TCGMemOp mo =3D get_memop(oi);
> +    unsigned a_bits =3D get_alignment_bits(mo);
>      uintptr_t haddr;
>
>      if (addr & ((1 << a_bits) - 1)) {
> @@ -385,7 +408,7 @@ void helper_be_st_name(CPUArchState *env, target_ulon=
g addr, DATA_TYPE val,
>          /* ??? Note that the io helpers always read data in the target
>             byte ordering.  We should push the LE/BE request down into io=
.  */
>          val =3D TGT_BE(val);
> -        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr,
> +        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr, =
mo,
>                                 tlb_addr & TLB_RECHECK);
>          return;
>      }
> @@ -418,10 +441,12 @@ void helper_be_st_name(CPUArchState *env, target_ul=
ong addr, DATA_TYPE val,
>              glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
>                                              oi, retaddr);
>          }
> +        set_hostaddr(env, mo, NULL);
>          return;
>      }
>
>      haddr =3D addr + entry->addend;
> +    set_hostaddr(env, mo, (void *)haddr);
>      glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
>  }
>  #endif /* DATA_SIZE > 1 */
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 40cd5d4774..f46bc0917d 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -178,6 +178,14 @@ typedef struct CPUTLBDesc {
>      CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];
>  #endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
>
> +#ifdef CONFIG_PLUGIN
> +# define CPU_PLUGIN_HOSTADDR                            \
> +    /* stores the host address of a guest access */     \
> +    void *hostaddr;
> +#else
> +# define CPU_PLUGIN_HOSTADDR
> +#endif
> +
>  #define CPU_COMMON_TLB                                                  \
>      /* The meaning of the MMU modes is defined in the target code. */   \
>      /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
> @@ -186,6 +194,7 @@ typedef struct CPUTLBDesc {
>      CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
>      CPU_IOTLB                                                           \
>      CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
> +    CPU_PLUGIN_HOSTADDR                                                 \
>      size_t tlb_flush_count;                                             \
>      target_ulong tlb_flush_addr;                                        \
>      target_ulong tlb_flush_mask;                                        \
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 83b2907d86..32dd8dd603 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -85,6 +85,15 @@ typedef target_ulong abi_ptr;
>  #define TARGET_ABI_FMT_ptr TARGET_ABI_FMT_lx
>  #endif
>
> +static inline void *read_hostaddr(CPUArchState *env)
> +{
> +#if defined(CONFIG_SOFTMMU) && defined(CONFIG_PLUGIN)
> +    return env->hostaddr;
> +#else
> +    return NULL;
> +#endif
> +}
> +
>  #if defined(CONFIG_USER_ONLY)
>
>  extern __thread uintptr_t helper_retaddr;
> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
> index 0f061d47ef..3493cb13bf 100644
> --- a/include/exec/cpu_ldst_template.h
> +++ b/include/exec/cpu_ldst_template.h
> @@ -28,6 +28,7 @@
>  #include "trace-root.h"
>  #endif
>
> +#include "qemu/plugin.h"
>  #include "trace/mem.h"
>
>  #if DATA_SIZE =3D=3D 8
> @@ -86,11 +87,11 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>      target_ulong addr;
>      int mmu_idx;
>      TCGMemOpIdx oi;
> -
> +    uintptr_t hostaddr;
>  #if !defined(SOFTMMU_CODE_ACCESS)
> -    trace_guest_mem_before_exec(
> -        ENV_GET_CPU(env), ptr,
> -        trace_mem_build_info(SHIFT, false, MO_TE, false));
> +    uint8_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false);
> +
> +    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
>  #endif
>
>      addr =3D ptr;
> @@ -101,10 +102,14 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>          oi =3D make_memop_idx(SHIFT, mmu_idx);
>          res =3D glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, ad=
dr,
>                                                              oi, retaddr);
> +        hostaddr =3D (uintptr_t)read_hostaddr(env);
>      } else {
> -        uintptr_t hostaddr =3D addr + entry->addend;
> +        hostaddr =3D addr + entry->addend;
>          res =3D glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
>      }
> +#ifndef SOFTMMU_CODE_ACCESS
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, (void *)hostaddr, mem=
info);
> +#endif
>      return res;
>  }
>
> @@ -125,11 +130,11 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>      target_ulong addr;
>      int mmu_idx;
>      TCGMemOpIdx oi;
> -
> +    uintptr_t hostaddr;
>  #if !defined(SOFTMMU_CODE_ACCESS)
> -    trace_guest_mem_before_exec(
> -        ENV_GET_CPU(env), ptr,
> -        trace_mem_build_info(SHIFT, true, MO_TE, false));
> +    uint8_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false);
> +
> +    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
>  #endif
>
>      addr =3D ptr;
> @@ -140,10 +145,14 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>          oi =3D make_memop_idx(SHIFT, mmu_idx);
>          res =3D (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
>                                 MMUSUFFIX)(env, addr, oi, retaddr);
> +        hostaddr =3D (uintptr_t)read_hostaddr(env);
>      } else {
> -        uintptr_t hostaddr =3D addr + entry->addend;
> +        hostaddr =3D addr + entry->addend;
>          res =3D glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
>      }
> +#ifndef SOFTMMU_CODE_ACCESS
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, (void *)hostaddr, mem=
info);
> +#endif
>      return res;
>  }
>
> @@ -167,11 +176,11 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CP=
UArchState *env,
>      target_ulong addr;
>      int mmu_idx;
>      TCGMemOpIdx oi;
> -
> +    uintptr_t hostaddr;
>  #if !defined(SOFTMMU_CODE_ACCESS)
> -    trace_guest_mem_before_exec(
> -        ENV_GET_CPU(env), ptr,
> -        trace_mem_build_info(SHIFT, false, MO_TE, true));
> +    uint8_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, true);
> +
> +    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
>  #endif
>
>      addr =3D ptr;
> @@ -182,10 +191,14 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CP=
UArchState *env,
>          oi =3D make_memop_idx(SHIFT, mmu_idx);
>          glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
>                                                       retaddr);
> +        hostaddr =3D (uintptr_t)read_hostaddr(env);
>      } else {
> -        uintptr_t hostaddr =3D addr + entry->addend;
> +        hostaddr =3D addr + entry->addend;
>          glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
>      }
> +#ifndef SOFTMMU_CODE_ACCESS
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, (void *)hostaddr, mem=
info);
> +#endif
>  }
>
>  static inline void
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
> index 0fd6019af0..e752e9c00e 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -64,12 +64,19 @@
>  static inline RES_TYPE
>  glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> +    RES_TYPE ret;
> +#if !defined(CODE_ACCESS)
> +    uint8_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false);
> +
> +    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
> +#endif
> +
> +    ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));
> +
>  #if !defined(CODE_ACCESS)
> -    trace_guest_mem_before_exec(
> -        ENV_GET_CPU(env), ptr,
> -        trace_mem_build_info(SHIFT, false, MO_TE, false));
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, NULL, meminfo);
>  #endif
> -    return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
> +    return ret;
>  }
>
>  static inline RES_TYPE
> @@ -88,12 +95,19 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>  static inline int
>  glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> +    int ret;
>  #if !defined(CODE_ACCESS)
> -    trace_guest_mem_before_exec(
> -        ENV_GET_CPU(env), ptr,
> -        trace_mem_build_info(SHIFT, true, MO_TE, false));
> +    uint8_t meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, false);
> +
> +    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
>  #endif
> -    return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
> +
> +    ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));
> +
> +#if !defined(CODE_ACCESS)
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, NULL, meminfo);
> +#endif
> +    return ret;
>  }
>
>  static inline int
> @@ -109,17 +123,21 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>  }
>  #endif
>
> -#ifndef CODE_ACCESS
> +#if !defined(CODE_ACCESS)
>  static inline void
>  glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
>                                        RES_TYPE v)
>  {
>  #if !defined(CODE_ACCESS)
> -    trace_guest_mem_before_exec(
> -        ENV_GET_CPU(env), ptr,
> -        trace_mem_build_info(SHIFT, false, MO_TE, true));
> +    uint8_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, true);
> +    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
>  #endif
> +
>      glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
> +
> +#if !defined(CODE_ACCESS)
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, NULL, meminfo);
> +#endif
>  }
>
>  static inline void
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index a376f83ab6..8938dcf52e 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -29,6 +29,7 @@
>  #include "cpu.h"
>  #include "exec/tb-context.h"
>  #include "qemu/bitops.h"
> +#include "qemu/plugin.h"
>  #include "qemu/queue.h"
>  #include "tcg-mo.h"
>  #include "tcg-target.h"
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d590f1f6c0..4c8265a908 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -267,6 +267,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
>          tcg_debug_assert(!have_mmap_lock());
>  #endif
>          assert_no_pages_locked();
> +        qemu_plugin_disable_mem_helpers(cpu);
>      }
>
>      if (in_exclusive_region) {
> @@ -716,6 +717,7 @@ int cpu_exec(CPUState *cpu)
>          if (qemu_mutex_iothread_locked()) {
>              qemu_mutex_unlock_iothread();
>          }
> +        qemu_plugin_disable_mem_helpers(cpu);
>      }
>
>      /* if an exception is pending, we execute it here */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5c61908084..3bdf98d2c3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1208,6 +1208,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, =
target_ulong addr,
>      cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
>  }
>
> +static inline void set_hostaddr(CPUArchState *env, TCGMemOp mo, void *ha=
ddr)
> +{
> +#ifdef CONFIG_PLUGIN
> +    if (mo & MO_HADDR) {
> +        env->hostaddr =3D haddr;
> +    }
> +#endif
> +}
> +
>  #ifdef TARGET_WORDS_BIGENDIAN
>  # define TGT_BE(X)  (X)
>  # define TGT_LE(X)  BSWAP(X)
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 5cbb07deab..eb3725f2e3 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1685,6 +1685,13 @@ static inline void tcg_out_tlb_load(TCGContext *s,=
 TCGReg addrlo, TCGReg addrhi,
>      /* add addend(r0), r1 */
>      tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
>                           offsetof(CPUTLBEntry, addend));
> +
> +#ifdef CONFIG_PLUGIN
> +    if (opc & MO_HADDR) {
> +        tcg_out_st(s, TCG_TYPE_PTR, r1, TCG_AREG0,
> +                   offsetof(CPUArchState, hostaddr));
> +    }
> +#endif
>  }
>
>  /*
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 7a8015c5a9..b30f0d4440 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -31,6 +31,7 @@
>  #include "tcg-mo.h"
>  #include "trace-tcg.h"
>  #include "trace/mem.h"
> +#include "exec/plugin-gen.h"
>
>  /* Reduce the number of ifdefs below.  This assumes that all uses of
>     TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
> @@ -2595,6 +2596,7 @@ void tcg_gen_exit_tb(TranslationBlock *tb, unsigned=
 idx)
>          tcg_debug_assert(idx =3D=3D TB_EXIT_REQUESTED);
>      }
>
> +    plugin_gen_disable_mem_helpers();
>      tcg_gen_op1i(INDEX_op_exit_tb, val);
>  }
>
> @@ -2607,6 +2609,7 @@ void tcg_gen_goto_tb(unsigned idx)
>      tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) =3D=3D 0=
);
>      tcg_ctx->goto_tb_issue_mask |=3D 1 << idx;
>  #endif
> +    plugin_gen_disable_mem_helpers();
>      /* When not chaining, we simply fall through to the "fallback" exit.=
  */
>      if (!qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
>          tcg_gen_op1i(INDEX_op_goto_tb, idx);
> @@ -2616,7 +2619,10 @@ void tcg_gen_goto_tb(unsigned idx)
>  void tcg_gen_lookup_and_goto_ptr(void)
>  {
>      if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAI=
N)) {
> -        TCGv_ptr ptr =3D tcg_temp_new_ptr();
> +        TCGv_ptr ptr;
> +
> +        plugin_gen_disable_mem_helpers();
> +        ptr =3D tcg_temp_new_ptr();
>          gen_helper_lookup_tb_ptr(ptr, cpu_env);
>          tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
>          tcg_temp_free_ptr(ptr);
> @@ -2699,26 +2705,42 @@ static void tcg_gen_req_mo(TCGBar type)
>      }
>  }
>
> +static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint8_t info)
> +{
> +#ifdef CONFIG_PLUGIN
> +    if (tcg_ctx->plugin_insn =3D=3D NULL) {
> +        return;
> +    }
> +    plugin_gen_empty_mem_callback(vaddr, info);
> +#endif
> +}
> +
>  void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
>  {
> +    uint8_t info =3D trace_mem_get_info(memop, 0);
> +
>      tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
>      memop =3D tcg_canonicalize_memop(memop, 0, 0);
> -    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
> -                               addr, trace_mem_get_info(memop, 0));
> +    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
>      gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
> +    plugin_gen_mem_callbacks(addr, info);
>  }
>
>  void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
>  {
> +    uint8_t info =3D trace_mem_get_info(memop, 1);
> +
>      tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
>      memop =3D tcg_canonicalize_memop(memop, 0, 1);
> -    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
> -                               addr, trace_mem_get_info(memop, 1));
> +    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
>      gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
> +    plugin_gen_mem_callbacks(addr, info);
>  }
>
>  void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
>  {
> +    uint8_t info;
> +
>      tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
>      if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
>          tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
> @@ -2731,13 +2753,16 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr,=
 TCGArg idx, TCGMemOp memop)
>      }
>
>      memop =3D tcg_canonicalize_memop(memop, 1, 0);
> -    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
> -                               addr, trace_mem_get_info(memop, 0));
> +    info =3D trace_mem_get_info(memop, 0);
> +    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
>      gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
> +    plugin_gen_mem_callbacks(addr, info);
>  }
>
>  void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
>  {
> +    uint8_t info;
> +
>      tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
>      if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
>          tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
> @@ -2745,9 +2770,10 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, =
TCGArg idx, TCGMemOp memop)
>      }
>
>      memop =3D tcg_canonicalize_memop(memop, 1, 1);
> -    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
> -                               addr, trace_mem_get_info(memop, 1));
> +    info =3D trace_mem_get_info(memop, 1);
> +    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
>      gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
> +    plugin_gen_mem_callbacks(addr, info);
>  }
>
>  static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)


--
Alex Benn=C3=A9e
