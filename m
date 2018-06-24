Received: from eggs.gnu.org ([2001:4830:134:3::10]:39490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fWvwr-0007A9-Pd
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fWvwq-0002AQ-Aj
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:44:21 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fWvwq-0002AC-3U
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:44:20 -0400
Received: by mail-vk0-x243.google.com with SMTP id o71-v6so6038373vke.7
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 20:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-14-richard.henderson@linaro.org>
From: Stafford Horne <shorne@gmail.com>
Date: Sun, 24 Jun 2018 12:44:08 +0900
Message-ID: <CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 13/22] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

On Tue, Jun 19, 2018 at 3:41 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The code in cpu_mmu_index does not properly honor SR_DME.
> This bug has workarounds elsewhere in that we flush the
> tlb more often than necessary, on the state changes that
> should be reflected in a change of mmu_index.
>
> Fixing this means that we can respect the mmu_index that
> is given to tlb_flush.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/openrisc/cpu.h              | 23 +++++++++++++--------
>  target/openrisc/interrupt.c        |  4 ----
>  target/openrisc/interrupt_helper.c | 15 +++-----------
>  target/openrisc/mmu.c              | 33 +++++++++++++++++++++++++++---
>  target/openrisc/sys_helper.c       |  4 ----
>  target/openrisc/translate.c        |  2 +-
>  6 files changed, 49 insertions(+), 32 deletions(-)


Hello,

I am trying to test these patches running a linux kernel.

For some reason this is causing a strange failure with SMP but not
single core, I see an OpenRISC target pointer is making its way into
the tb_jmp_cache.  I don't think this is right and I am trying to
figure out why this happens and why this patch triggers it.

When bisecting to this commit I get:

[New Thread 0x7fffe9f11700 (LWP 4210)]

[    0.000000] Compiled-in FDT at (ptrval)
[    0.000000] Linux version
4.18.0-rc1-simple-smp-00006-gd5d0782e3db9-dirty
(shorne@lianli.shorne-pla.net) (gcc version 9.0.0 20180426
(experimental) (GCC)) #1013 SMP Sat Jun 23 17:11:42 JST 2018
[    0.000000] CPU: OpenRISC-0 (revision 0) @20 MHz
[    0.000000] -- dcache disabled
[    0.000000] -- icache disabled
[    0.000000] -- dmmu:   64 entries, 1 way(s)
[    0.000000] -- immu:   64 entries, 1 way(s)
[    0.000000] -- additional features:
[    0.000000] -- power management
[    0.000000] -- PIC
[    0.000000] -- timer
[    0.000000] setup_memory: Memory: 0x0-0x2000000
[    0.000000] Setting up paging and PTEs.
[    0.000000] map_ram: Memory: 0x0-0x2000000
[    0.000000] itlb_miss_handler (ptrval)
[    0.000000] dtlb_miss_handler (ptrval)
[    0.000000] OpenRISC Linux -- http://openrisc.io
[    0.000000] percpu: Embedded 6 pages/cpu @(ptrval) s18880 r8192 d22080 u49152
[    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 4080
[    0.000000] Kernel command line: earlycon
[    0.000000] earlycon: ns16550a0 at MMIO 0x90000000 (options '115200')
[    0.000000] bootconsole [ns16550a0] enabled
[    0.000000] Dentry cache hash table entries: 4096 (order: 1, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 0, 8192 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 22336K/32768K available (3309K kernel code, 96K
rwdata, 736K rodata, 5898K init, 91K bss, 10432K reserved, 0K
cma-reserved)
[    0.000000] mem_init_done ...........................................
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 32, nr_irqs: 32, preallocated irqs: 0
[    0.000000] clocksource: openrisc_timer: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 95563022313 ns
[    0.000000] 40.00 BogoMIPS (lpj=200000)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Mount-cache hash table entries: 2048 (order: 0, 8192 bytes)
[    0.000000] Mountpoint-cache hash table entries: 2048 (order: 0, 8192 bytes)


(gdb) bt
#0  0x00005555556d3e59 in tb_lookup__cpu_state (cf_mask=0,
flags=<synthetic pointer>, cs_base=<synthetic pointer>, pc=<synthetic
pointer>, cpu=0x555555f81300)
    at /home/shorne/work/openrisc/qemu/include/exec/tb-lookup.h:31
#1  0x00005555556d3e59 in tb_find (cf_mask=0, tb_exit=0,
last_tb=0x7fffe223ff00 <code_gen_buffer+2358995>, cpu=0x555555f81300)
at /home/shorne/work/openrisc/qemu/accel/tcg/cpu-exec.c:390
#2  0x00005555556d3e59 in cpu_exec (cpu=cpu@entry=0x555555f81300) at
/home/shorne/work/openrisc/qemu/accel/tcg/cpu-exec.c:735
#3  0x00005555556a0d2b in tcg_cpu_exec (cpu=cpu@entry=0x555555f81300)
at /home/shorne/work/openrisc/qemu/cpus.c:1362
#4  0x00005555556a238e in qemu_tcg_rr_cpu_thread_fn (arg=<optimized
out>) at /home/shorne/work/openrisc/qemu/cpus.c:1461
#5  0x0000555555886005 in qemu_thread_start (args=0x555555f93ef0) at
/home/shorne/work/openrisc/qemu/util/qemu-thread-posix.c:507
#6  0x00007ffff2a18564 in start_thread () at /lib64/libpthread.so.0
#7  0x00007ffff274c31f in clone () at /lib64/libc.so.6
(gdb) l
26          uint32_t hash;
27
28          cpu_get_tb_cpu_state(env, pc, cs_base, flags);
29          hash = tb_jmp_cache_hash_func(*pc);
30          tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
31          if (likely(tb &&
32                     tb->pc == *pc &&
33                     tb->cs_base == *cs_base &&
34                     tb->flags == *flags &&
35                     tb->trace_vcpu_dstate == *cpu->trace_dstate &&
(gdb) p tb
$1 = (TranslationBlock *) 0xc03c90a8


To reproduce I am running qemu with:
  qemu-system-or1k -cpu or1200 -M or1k-sim -kernel
or1k-linux-4.18-rc1-smp -serial stdio -nographic -monitor none -smp
cpus=2 -m 128

Kernel (need to gunzip):
  SMP - http://shorne.noip.me/downloads/or1k-linux-4.18-rc1-smp.gz
  Single - http://shorne.noip.me/downloads/or1k-linux-4.18-rc1.gz

I will continue to investigate, I just figured out SMP triggers it so
maybe that will uncover something more.

Sorry, if this mail gets clobbered I am using the gmail web interface.

-Stafford
