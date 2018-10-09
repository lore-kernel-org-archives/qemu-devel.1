Received: from eggs.gnu.org ([2001:4830:134:3::10]:53084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tP6-0004MK-6w
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tP1-0001dK-RR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:54:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tP1-0001cE-8l
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:54:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 189-v6so2199220wmw.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:54:26 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-6-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008232756.30704-6-cota@braap.org>
Date: Tue, 09 Oct 2018 15:54:21 +0100
Message-ID: <87d0sjmaqq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 5/5] cputlb: dynamically resize TLBs based
 on use rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Perform the resizing only on flushes, otherwise we'd
> have to take a perf hit by either rehashing the array
> or unnecessarily flushing it.
>
> We grow the array aggressively, and reduce the size more
> slowly. This accommodates mixed workloads, where some
> processes might be memory-heavy while others are not.
>
> As the following experiments show, this a net perf gain,
> particularly for memory-heavy workloads. Experiments
> are run on an Intel i7-6700K CPU @ 4.00GHz.
>
> 1. System boot + shudown, debian aarch64:
>
> - Before (tb-lock-v3):
>  Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 r=
uns):
>
>        7469.363393      task-clock (msec)         #    0.998 CPUs utilize=
d            ( +-  0.07% )
>     31,507,707,190      cycles                    #    4.218 GHz         =
             ( +-  0.07% )
>     57,101,577,452      instructions              #    1.81  insns per cy=
cle          ( +-  0.08% )
>     10,265,531,804      branches                  # 1374.352 M/sec       =
             ( +-  0.07% )
>        173,020,681      branch-misses             #    1.69% of all branc=
hes          ( +-  0.10% )
>
>        7.483359063 seconds time elapsed                                  =
        ( +-  0.08% )
>
> - After:
>  Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 r=
uns):
>
>        7185.036730      task-clock (msec)         #    0.999 CPUs utilize=
d            ( +-  0.11% )
>     30,303,501,143      cycles                    #    4.218 GHz         =
             ( +-  0.11% )
>     54,198,386,487      instructions              #    1.79  insns per cy=
cle          ( +-  0.08% )
>      9,726,518,945      branches                  # 1353.719 M/sec       =
             ( +-  0.08% )
>        167,082,307      branch-misses             #    1.72% of all branc=
hes          ( +-  0.08% )
>
>        7.195597842 seconds time elapsed                                  =
        ( +-  0.11% )
>
> That is, a 3.8% improvement.
>
> 2. System boot + shutdown, ubuntu 18.04 x86_64:
>
> - Before (tb-lock-v3):
> Performance counter stats for 'taskset -c 0 ../img/x86_64/ubuntu-die.sh -=
nographic' (2 runs):
>
>       49971.036482      task-clock (msec)         #    0.999 CPUs utilize=
d            ( +-  1.62% )
>    210,766,077,140      cycles                    #    4.218 GHz         =
             ( +-  1.63% )
>    428,829,830,790      instructions              #    2.03  insns per cy=
cle          ( +-  0.75% )
>     77,313,384,038      branches                  # 1547.164 M/sec       =
             ( +-  0.54% )
>        835,610,706      branch-misses             #    1.08% of all branc=
hes          ( +-  2.97% )
>
>       50.003855102 seconds time elapsed                                  =
        ( +-  1.61% )
>
> - After:
>  Performance counter stats for 'taskset -c 0 ../img/x86_64/ubuntu-die.sh =
-nographic' (2 runs):
>
>       50118.124477      task-clock (msec)         #    0.999 CPUs utilize=
d            ( +-  4.30% )
>            132,396      context-switches          #    0.003 M/sec       =
             ( +-  1.20% )
>                  0      cpu-migrations            #    0.000 K/sec       =
             ( +-100.00% )
>            167,754      page-faults               #    0.003 M/sec       =
             ( +-  0.06% )
>    211,414,701,601      cycles                    #    4.218 GHz         =
             ( +-  4.30% )
>    <not supported>      stalled-cycles-frontend
>    <not supported>      stalled-cycles-backend
>    431,618,818,597      instructions              #    2.04  insns per cy=
cle          ( +-  6.40% )
>     80,197,256,524      branches                  # 1600.165 M/sec       =
             ( +-  8.59% )
>        794,830,352      branch-misses             #    0.99% of all branc=
hes          ( +-  2.05% )
>
>       50.177077175 seconds time elapsed                                  =
        ( +-  4.23% )
>
> No improvement (within noise range).
>
> 3. x86_64 SPEC06int:
>                               SPEC06int (test set)
>                          [ Y axis: speedup over master ]
>   8 +-+--+----+----+-----+----+----+----+----+----+----+-----+----+----+-=
-+-+
>     |                                                                    =
   |
>     |                                                   tlb-lock-v3      =
   |
>   7 +-+..................$$$...........................+indirection      =
 +-+
>     |                    $ $                              +resizing      =
   |
>     |                    $ $                                             =
   |
>   6 +-+..................$.$.............................................=
.+-+
>     |                    $ $                                             =
   |
>     |                    $ $                                             =
   |
>   5 +-+..................$.$.............................................=
.+-+
>     |                    $ $                                             =
   |
>     |                    $ $                                             =
   |
>   4 +-+..................$.$.............................................=
.+-+
>     |                    $ $                                             =
   |
>     |          +++       $ $                                             =
   |
>   3 +-+........$$+.......$.$.............................................=
.+-+
>     |          $$        $ $                                             =
   |
>     |          $$        $ $                                 $$$         =
   |
>   2 +-+........$$........$.$.................................$.$.........=
.+-+
>     |          $$        $ $                                 $ $       +$=
$  |
>     |          $$   $$+  $ $  $$$       +$$                  $ $  $$$   $=
$  |
>   1 +-+***#$***#$+**#$+**#+$**#+$**##$**##$***#$***#$+**#$+**#+$**#+$**##=
$+-+
>     |  * *#$* *#$ **#$ **# $**# $** #$** #$* *#$* *#$ **#$ **# $**# $** #=
$  |
>     |  * *#$* *#$ **#$ **# $**# $** #$** #$* *#$* *#$ **#$ **# $**# $** #=
$  |
>   0 +-+***#$***#$-**#$-**#$$**#$$**##$**##$***#$***#$-**#$-**#$$**#$$**##=
$+-+
>      401.bzi403.gc429445.g456.h462.libq464.h471.omne4483.xalancbgeomean
> png: https://imgur.com/a/b1wn3wc
>
> That is, a 1.53x average speedup over master, with a max speedup of 7.13x.
>
> Note that "indirection" (i.e. the first patch in this series) incurs
> no overhead, on average.
>
> To conclude, here is a different look at the SPEC06int results, using
> linux-user as the baseline and comparing master and this series ("tlb-dyn=
"):
>
>             Softmmu slowdown vs. linux-user for SPEC06int (test set)
>                     [ Y axis: slowdown over linux-user ]
>   14 +-+--+----+----+----+----+----+-----+----+----+----+----+----+----+-=
-+-+
>      |                                                                   =
   |
>      |                                                       master      =
   |
>   12 +-+...............+**..................................tlb-dyn......=
.+-+
>      |                  **                                               =
   |
>      |                  **                                               =
   |
>      |                  **                                               =
   |
>   10 +-+................**...............................................=
.+-+
>      |                  **                                               =
   |
>      |                  **                                               =
   |
>    8 +-+................**...............................................=
.+-+
>      |                  **                                               =
   |
>      |                  **                                               =
   |
>      |                  **                                               =
   |
>    6 +-+................**...............................................=
.+-+
>      |       ***        **                                               =
   |
>      |       * *        **                                               =
   |
>    4 +-+.....*.*........**.................................***...........=
.+-+
>      |       * *        **                                 * *           =
   |
>      |       * *  +++   **             ***            ***  * *  ***  *** =
   |
>      |       * *  +**++ **   **##      *+*#      ***  * *#+* *  * *##* * =
   |
>    2 +-+.....*.*##.**##.**##.**.#.**##.*+*#.***#.*+*#.*.*#.*.*#+*.*.#*.*#=
#+-+
>      |++***##*+*+#+**+#+**+#+**+#+**+#+*+*#+*+*#+*+*#+*+*#+*+*#+*+*+#*+*+=
#++|
>      |  * * #* * # ** # ** # ** # ** # * *# * *# * *# * *# * *# * * #* * =
#  |
>    0 +-+***##***##-**##-**##-**##-**##-***#-***#-***#-***#-***#-***##***#=
#+-+
>       401.bzi403.g429445.g456.hm462.libq464.h471.omn4483.xalancbgeomean
>
> png: https://imgur.com/a/eXkjMCE
>
> After this series, we bring down the average softmmu overhead
> from 2.77x to 1.80x, with a maximum slowdown of 2.48x (omnetpp).
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/cpu-defs.h | 39 +++++++++------------------------------
>  accel/tcg/cputlb.c      | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 31 deletions(-)
>
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 56f1887c7f..d4af0b2a2d 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -67,37 +67,15 @@ typedef uint64_t target_ulong;
>  #define CPU_TLB_ENTRY_BITS 5
>  #endif
>
> -/* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in CPU_TLB_BITS to ensure th=
at
> - * the TLB is not unnecessarily small, but still small enough for the
> - * TLB lookup instruction sequence used by the TCG target.
> - *
> - * TCG will have to generate an operand as large as the distance between
> - * env and the tlb_table[NB_MMU_MODES - 1][0].addend.  For simplicity,
> - * the TCG targets just round everything up to the next power of two, and
> - * count bits.  This works because: 1) the size of each TLB is a largish
> - * power of two, 2) and because the limit of the displacement is really =
close
> - * to a power of two, 3) the offset of tlb_table[0][0] inside env is sma=
ller
> - * than the size of a TLB.
> - *
> - * For example, the maximum displacement 0xFFF0 on PPC and MIPS, but TCG
> - * just says "the displacement is 16 bits".  TCG_TARGET_TLB_DISPLACEMENT=
_BITS
> - * then ensures that tlb_table at least 0x8000 bytes large ("not unneces=
sarily
> - * small": 2^15).  The operand then will come up smaller than 0xFFF0 wit=
hout
> - * any particular care, because the TLB for a single MMU mode is larger =
than
> - * 0x10000-0xFFF0=3D16 bytes.  In the end, the maximum value of the oper=
and
> - * could be something like 0xC000 (the offset of the last TLB table) plus
> - * 0x18 (the offset of the addend field in each TLB entry) plus the offs=
et
> - * of tlb_table inside env (which is non-trivial but not huge).
> +#define MIN_CPU_TLB_BITS 6
> +#define DEFAULT_CPU_TLB_BITS 8
> +/*
> + * Assuming TARGET_PAGE_BITS=3D=3D12, with 2**22 entries we can cover 2*=
*(22+12) =3D=3D
> + * 2**34 =3D=3D 16G of address space. This is roughly what one would exp=
ect a
> + * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
> + * Skylake's Level-2 STLB has 16 1G entries.
>   */
> -#define CPU_TLB_BITS                                             \
> -    MIN(8,                                                       \
> -        TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
> -        (NB_MMU_MODES <=3D 1 ? 0 :                                 \
> -         NB_MMU_MODES <=3D 2 ? 1 :                                 \
> -         NB_MMU_MODES <=3D 4 ? 2 :                                 \
> -         NB_MMU_MODES <=3D 8 ? 3 : 4))
> -
> -#define CPU_TLB_SIZE (1 << CPU_TLB_BITS)
> +#define MAX_CPU_TLB_BITS 22
>
>  typedef struct CPUTLBEntry {
>      /* bit TARGET_LONG_BITS to TARGET_PAGE_BITS : virtual address
> @@ -143,6 +121,7 @@ typedef struct CPUIOTLBEntry {
>
>  typedef struct CPUTLBDesc {
>      size_t n_used_entries;
> +    size_t n_flushes_low_rate;
>  } CPUTLBDesc;
>
>  #define CPU_COMMON_TLB  \
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 11d6060eb0..5ebfa4fbb5 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,9 +80,10 @@ void tlb_init(CPUState *cpu)
>
>      qemu_spin_init(&env->tlb_lock);
>      for (i =3D 0; i < NB_MMU_MODES; i++) {
> -        size_t n_entries =3D CPU_TLB_SIZE;
> +        size_t n_entries =3D 1 << DEFAULT_CPU_TLB_BITS;
>
>          env->tlb_desc[i].n_used_entries =3D 0;
> +        env->tlb_desc[i].n_flushes_low_rate =3D 0;
>          env->tlb_mask[i] =3D (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>          env->tlb_table[i] =3D g_new(CPUTLBEntry, n_entries);
>          env->iotlb[i] =3D g_new0(CPUIOTLBEntry, n_entries);
> @@ -121,6 +122,40 @@ size_t tlb_flush_count(void)
>      return count;
>  }
>
> +/* Call with tlb_lock held */
> +static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
> +{
> +    CPUTLBDesc *desc =3D &env->tlb_desc[mmu_idx];
> +    size_t old_size =3D tlb_n_entries(env, mmu_idx);
> +    size_t rate =3D desc->n_used_entries * 100 / old_size;
> +    size_t new_size =3D old_size;
> +
> +    if (rate =3D=3D 100) {
> +        new_size =3D MIN(old_size << 2, 1 << MAX_CPU_TLB_BITS);
> +    } else if (rate > 70) {
> +        new_size =3D MIN(old_size << 1, 1 << MAX_CPU_TLB_BITS);
> +    } else if (rate < 30) {
> +        desc->n_flushes_low_rate++;
> +        if (desc->n_flushes_low_rate =3D=3D 100) {
> +            new_size =3D MAX(old_size >> 1, 1 << MIN_CPU_TLB_BITS);
> +            desc->n_flushes_low_rate =3D 0;
> +        }
> +    }
> +
> +    if (new_size =3D=3D old_size) {
> +        return;
> +    }
> +
> +    g_free(env->tlb_table[mmu_idx]);
> +    g_free(env->iotlb[mmu_idx]);
> +
> +    /* desc->n_used_entries is cleared by the caller */
> +    desc->n_flushes_low_rate =3D 0;
> +    env->tlb_mask[mmu_idx] =3D (new_size - 1) << CPU_TLB_ENTRY_BITS;
> +    env->tlb_table[mmu_idx] =3D g_new(CPUTLBEntry, new_size);
> +    env->iotlb[mmu_idx] =3D g_new0(CPUIOTLBEntry, new_size);

I guess the allocation is a big enough stall there is no point either
pre-allocating or using RCU to clean-up the old data?

Given this is a new behaviour it would be nice to expose the occupancy
of the TLBs in "info jit" much like we do for TBs.

Nevertheless:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +}
> +
>  /* This is OK because CPU architectures generally permit an
>   * implementation to drop entries from the TLB at any time, so
>   * flushing more entries than required is only an efficiency issue,
> @@ -150,6 +185,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
>       */
>      qemu_spin_lock(&env->tlb_lock);
>      for (i =3D 0; i < NB_MMU_MODES; i++) {
> +        tlb_mmu_resize_locked(env, i);
>          memset(env->tlb_table[i], -1, sizeof_tlb(env, i));
>          env->tlb_desc[i].n_used_entries =3D 0;
>      }
> @@ -213,6 +249,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>          if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
>              tlb_debug("%d\n", mmu_idx);
>
> +            tlb_mmu_resize_locked(env, mmu_idx);
>              memset(env->tlb_table[mmu_idx], -1, sizeof_tlb(env, mmu_idx)=
);
>              memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_tabl=
e[0]));
>              env->tlb_desc[mmu_idx].n_used_entries =3D 0;


--
Alex Benn=C3=A9e
