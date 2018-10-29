Received: from eggs.gnu.org ([2001:4830:134:3::10]:47406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9sI-0001JH-Or
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9sE-0001Cy-5H
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH9sC-000188-4x
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id 74-v6so1047986wrb.13
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:54:33 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-3-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-3-cota@braap.org>
Date: Mon, 29 Oct 2018 15:54:30 +0000
Message-ID: <8736soaguh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 03/71] cpu: introduce cpu_mutex_lock/unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> The few direct users of &cpu->lock will be converted soon.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h   | 33 +++++++++++++++++++++++++++++++
>  cpus.c              | 48 +++++++++++++++++++++++++++++++++++++++++++--
>  stubs/cpu-lock.c    | 20 +++++++++++++++++++
>  stubs/Makefile.objs |  1 +
>  4 files changed, 100 insertions(+), 2 deletions(-)
>  create mode 100644 stubs/cpu-lock.c
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index b813ca28fa..7fdb5a2be0 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -452,6 +452,39 @@ extern struct CPUTailQ cpus;
>
>  extern __thread CPUState *current_cpu;
>
> +/**
> + * cpu_mutex_lock - lock a CPU's mutex
> + * @cpu: the CPU whose mutex is to be locked
> + *
> + * To avoid deadlock, a CPU's mutex must be acquired after the BQL.
> + */
> +#define cpu_mutex_lock(cpu)                             \
> +    cpu_mutex_lock_impl(cpu, __FILE__, __LINE__)
> +void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line);
> +
> +/**
> + * cpu_mutex_unlock - unlock a CPU's mutex
> + * @cpu: the CPU whose mutex is to be unlocked
> + */
> +#define cpu_mutex_unlock(cpu)                           \
> +    cpu_mutex_unlock_impl(cpu, __FILE__, __LINE__)
> +void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line);
> +
> +/**
> + * cpu_mutex_locked - check whether a CPU's mutex is locked
> + * @cpu: the CPU of interest
> + *
> + * Returns true if the calling thread is currently holding the CPU's mut=
ex.
> + */
> +bool cpu_mutex_locked(const CPUState *cpu);
> +
> +/**
> + * no_cpu_mutex_locked - check whether any CPU mutex is held
> + *
> + * Returns true if the calling thread is not holding any CPU mutex.
> + */
> +bool no_cpu_mutex_locked(void);
> +
>  static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
>  {
>      unsigned int i;
> diff --git a/cpus.c b/cpus.c
> index b2a9698dc0..38cc9e1278 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -83,6 +83,47 @@ static unsigned int throttle_percentage;
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>
> +/* XXX: is this really the max number of CPUs? */
> +#define CPU_LOCK_BITMAP_SIZE 2048
> +
> +/*
> + * Note: we index the bitmap with cpu->cpu_index + 1 so that the logic
> + * also works during early CPU initialization, when cpu->cpu_index is se=
t to
> + * UNASSIGNED_CPU_INDEX =3D=3D -1.
> + */
> +static __thread DECLARE_BITMAP(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
> +
> +bool no_cpu_mutex_locked(void)
> +{
> +    return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
> +}
> +
> +void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
> +{
> +/* coverity gets confused by the indirect function call */
> +#ifdef __COVERITY__
> +    qemu_mutex_lock_impl(&cpu->lock, file, line);
> +#else
> +    QemuMutexLockFunc f =3D atomic_read(&qemu_mutex_lock_func);
> +
> +    g_assert(!cpu_mutex_locked(cpu));
> +    set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
> +    f(&cpu->lock, file, line);
> +#endif
> +}
> +
> +void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
> +{
> +    g_assert(cpu_mutex_locked(cpu));
> +    qemu_mutex_unlock_impl(&cpu->lock, file, line);
> +    clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
> +}
> +
> +bool cpu_mutex_locked(const CPUState *cpu)
> +{
> +    return test_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
> +}
> +
>  bool cpu_is_stopped(CPUState *cpu)
>  {
>      return cpu->stopped || !runstate_is_running();
> @@ -92,9 +133,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
>  {
>      bool ret;
>
> -    qemu_mutex_lock(&cpu->lock);
> +    cpu_mutex_lock(cpu);
>      ret =3D QSIMPLEQ_EMPTY(&cpu->work_list);
> -    qemu_mutex_unlock(&cpu->lock);
> +    cpu_mutex_unlock(cpu);
>      return ret;
>  }
>
> @@ -1843,6 +1884,9 @@ void qemu_mutex_lock_iothread_impl(const char *file=
, int line)
>  {
>      QemuMutexLockFunc bql_lock =3D atomic_read(&qemu_bql_mutex_lock_func=
);
>
> +    /* prevent deadlock with CPU mutex */
> +    g_assert(no_cpu_mutex_locked());
> +
>      g_assert(!qemu_mutex_iothread_locked());
>      bql_lock(&qemu_global_mutex, file, line);
>      iothread_locked =3D true;
> diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
> new file mode 100644
> index 0000000000..7c09af3768
> --- /dev/null
> +++ b/stubs/cpu-lock.c
> @@ -0,0 +1,20 @@
> +#include "qemu/osdep.h"
> +#include "qom/cpu.h"
> +
> +void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
> +{
> +}
> +
> +void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
> +{
> +}
> +
> +bool cpu_mutex_locked(const CPUState *cpu)
> +{
> +    return true;
> +}
> +
> +bool no_cpu_mutex_locked(void)
> +{
> +    return true;
> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 53d3f32cb2..fbcdc0256d 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -8,6 +8,7 @@ stub-obj-y +=3D blockdev-close-all-bdrv-states.o
>  stub-obj-y +=3D clock-warp.o
>  stub-obj-y +=3D cpu-get-clock.o
>  stub-obj-y +=3D cpu-get-icount.o
> +stub-obj-y +=3D cpu-lock.o

This is the wrong place because:

    c++  -I/usr/include/pixman-1  -Werror -pthread -I/usr/include/glib-2.0 =
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU=
_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -W=
redundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-str=
ict-aliasing -fno-common -fwrapv  -Wexpansion-to-defined -Wendif-labels -Wn=
o-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-exte=
rns -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-s=
tyle-declaration -Wold-style-definition -Wtype-limits
    -fstack-protector-strong  -I/usr/include/p11-kit-1    -I/usr/include/li=
bpng16 -I/usr/include/spice-server -I/usr/include/spice-1 -I/home/alex.benn=
ee/lsrc/qemu.git/capstone/include  -I../linux-headers -iquote .. -iquote /h=
ome/alex.bennee/lsrc/qemu.git/target/arm -DNEED_CPU_H -iquote /home/alex.be=
nnee/lsrc/qemu.git/include -I/home/alex.bennee/lsrc/qemu.git/linux-user/aar=
ch64 -I/home/alex.bennee/lsrc/qemu.git/linux-user/host/x86_64 -I/home/alex.=
bennee/lsrc/qemu.git/linux-user -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2=
 -g  -Wl,--warn-common -lxenctrl -lxenstore -lxenguest -lxenforeignmemory -=
lxengnttab -lxenevtchn -lxendevicemodel -Wl,-z,relro -Wl,-z,now -pie -m64 -=
g   -o qemu-aarch64 exec.o tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-=
op-gvec.o tcg/tcg-common.o tcg/optimize.o fpu/softfloat.o disas.o gdbstub-x=
ml.o gdbstub.o thunk.o accel/stubs/hax-stub.o accel/stubs/hvf-stub.o accel/=
stubs/whpx-stub.o accel/stubs/kvm-stub.o accel/tcg/tcg-runtime.o accel/tcg/=
tcg-runtime-gvec.o accel/tcg/cpu-exec.o accel/tcg/cpu-exec-common.o accel/t=
cg/translate-all.o accel/tcg/translator.o accel/tcg/user-exec.o accel/tcg/u=
ser-exec-stub.o linux-user/main.o linux-user/syscall.o linux-user/strace.o =
linux-user/mmap.o linux-user/signal.o linux-user/elfload.o linux-user/linux=
load.o linux-user/uaccess.o linux-user/uname.o linux-user/safe-syscall.o li=
nux-user/aarch64/signal.o linux-user/aarch64/cpu_loop.o linux-user/exit.o l=
inux-user/fd-trans.o linux-user/flatload.o target/arm/arm-semi.o target/arm=
/kvm-stub.o target/arm/translate.o target/arm/op_helper.o target/arm/helper=
.o target/arm/cpu.o target/arm/neon_helper.o target/arm/iwmmxt_helper.o tar=
get/arm/vec_helper.o target/arm/gdbstub.o target/arm/cpu64.o target/arm/tra=
nslate-a64.o target/arm/helper-a64.o target/arm/gdbstub64.o target/arm/cryp=
to_helper.o target/arm/translate-sve.o target/arm/sve_helper.o ../cpus-comm=
on.o ../disas/arm.o ../disas/arm-a64.o ../disas/i386.o ../disas/libvixl/vix=
l/utils.o ../disas/libvixl/vixl/compiler-intrinsics.o ../disas/libvixl/vixl=
/a64/instructions-a64.o ../disas/libvixl/vixl/a64/decoder-a64.o ../disas/li=
bvixl/vixl/a64/disasm-a64.o ../hw/core/qdev.o ../hw/core/qdev-properties.o =
../hw/core/bus.o ../hw/core/reset.o ../hw/core/irq.o ../hw/core/hotplug.o .=
./qom/cpu.o trace/generated-helpers.o trace/control-target.o ../qom/object.=
o ../qom/container.o ../qom/qom-qobject.o ../qom/object_interfaces.o ../cry=
pto/aes.o  ../libqemuutil.a   -L/home/alex.bennee/lsrc/qemu.git/capstone -l=
capstone -lm -lgthread-2.0 -pthread -lglib-2.0  -lz -lrt

  So we end up linking these stubs in linux-user mode - which I think is
  what breaks start_exclusive for the fork in linux-user:

  (gdb) l 232
  227         exclusive_work_ongoing =3D true;
  228         qemu_mutex_unlock(&qemu_cpu_list_lock);
  229
  230         /* Make all other cpus stop executing.  */
  231         CPU_FOREACH(other_cpu) {
  232             cpu_mutex_lock(other_cpu);
  233             if (other_cpu->running) {
  234                 g_assert(!other_cpu->exclusive_waiter);
  235                 other_cpu->exclusive_waiter =3D true;
  236                 qemu_cpu_kick(other_cpu);
  (gdb) info line 232
  Line 232 of "cpus-common.c" starts at address 0x5555556f4527 <start_exclu=
sive+151> and ends at 0x5555556f4540 <start_exclusive+176>.
  (gdb) x/10i 0x5555556f4527
     0x5555556f4527 <start_exclusive+151>:        lea    0xf0bba(%rip),%rbp=
        # 0x5555557e50e8
     0x5555556f452e <start_exclusive+158>:        xchg   %ax,%ax
     0x5555556f4530 <start_exclusive+160>:        mov    $0xe8,%edx
     0x5555556f4535 <start_exclusive+165>:        mov    %rbp,%rsi
     0x5555556f4538 <start_exclusive+168>:        mov    %rbx,%rdi
     0x5555556f453b <start_exclusive+171>:        callq  0x555555757b20 <cp=
u_mutex_lock_impl>
     0x5555556f4540 <start_exclusive+176>:        cmpb   $0x0,0x230(%rbx)
     0x5555556f4547 <start_exclusive+183>:        je     0x5555556f4587 <st=
art_exclusive+247>
     0x5555556f4549 <start_exclusive+185>:        cmpb   $0x0,0x231(%rbx)
     0x5555556f4550 <start_exclusive+192>:        je     0x5555556f4578 <st=
art_exclusive+232>
  (gdb) x/10i cpu_mutex_lock_impl
     0x555555757b20 <cpu_mutex_lock_impl>:        repz retq
     0x555555757b22:      nopl   0x0(%rax)
     0x555555757b26:      nopw   %cs:0x0(%rax,%rax,1)
     0x555555757b30 <cpu_mutex_unlock_impl>:      repz retq
     0x555555757b32:      nopl   0x0(%rax)
     0x555555757b36:      nopw   %cs:0x0(%rax,%rax,1)
     0x555555757b40 <cpu_mutex_locked>:   mov    $0x1,%eax
     0x555555757b45 <cpu_mutex_locked+5>: retq
     0x555555757b46:      nopw   %cs:0x0(%rax,%rax,1)
     0x555555757b50 <no_cpu_mutex_locked>:        mov    $0x1,%eax

--
Alex Benn=C3=A9e
