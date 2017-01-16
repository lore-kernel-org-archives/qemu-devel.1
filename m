Received: from eggs.gnu.org ([2001:4830:134:3::10]:56696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTCol-0001nx-20
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTCoh-0006hY-O8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:19:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTCoh-0006hS-Ea
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:19:43 -0500
Date: Mon, 16 Jan 2017 17:19:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170116191939.GA6657@thinpad.lan.raisama.net>
References: <20161224040042.12654-1-rth@twiddle.net>
	<20161224040042.12654-50-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161224040042.12654-50-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 49/65] tcg/i386: Rely on
 undefined/undocumented behaviour of BSF/BSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Fri, Dec 23, 2016 at 08:00:26PM -0800, Richard Henderson wrote:
> The ISA manual documents the output is undefined if the input was zero.
> 
> However, we document in target-i386 that the behavior of real silicon
> is to preserve the contents of the output register.  We also mention
> that there are real applications that depend on this.  That this is
> baked into silicon is mentioned as a potential cause for some false
> sharing behaviour wrt lzcnt/tzcnt.
> 
> Taking advantage of this allows us to save 2 insns in the normal case,
> and 4 insns for i686 emulating a 64-bit clz.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

I am unable to boot a Fedora image[1] with TCG using latest master,
and I have bisected the problem to this patch.

[1] http://download.fedoraproject.org/pub/fedora/linux/releases/25/CloudImages/x86_64/images/Fedora-Cloud-Base-25-1.3.x86_64.qcow2

$ qemu-system-x86_64 -machine accel=tcg -drive file=~/system/vmachines/Fedora-Cloud-Base-25-1.3.x86_64.qcow2,format=qcow2 -nographic
[    0.000000] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    0.000000] IP: [<          (null)>]           (null)
[    0.000000] PGD 0 
[    0.000000] Oops: 0010 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.6-300.fc25.x86_64 #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff9be0d500 task.stack: ffffffff9be00000
[    0.000000] RIP: 0010:[<0000000000000000>]  [<          (null)>]           (null)
[    0.000000] RSP: 0000:ffffa2c946c03ef0  EFLAGS: 00000202
[    0.000000] RAX: 0000000000000100 RBX: 000000000000002a RCX: 0000000000000000
[    0.000000] RDX: 00000000fffb6c22 RSI: ffffffff9be050d0 RDI: ffffffff9be05210
[    0.000000] RBP: ffffa2c946c03f58 R08: 0000000000000001 R09: 0000000000000100
[    0.000000] R10: ffffa2c946c10170 R11: 0000000000000000 R12: 000000000000002a
[    0.000000] R13: 0000000000000029 R14: ffffffff9be05210 R15: 000000000000002a
[    0.000000] FS:  0000000000000000(0000) GS:ffffa2c946c00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000000 CR3: 0000000005e06000 CR4: 00000000000006b0
[    0.000000] Stack:
[    0.000000]  ffffffff9b8052f2 002000009b02b204 ffffffff9be04000 00000000fffb6c23
[    0.000000]  0000000000000148 000001000000000a ffffffff9be050d0 0000000000000029
[    0.000000]  0000000000000030 ffffffff9be03db8 ffffa2c944c2ea00 0000000000000030
[    0.000000] Call Trace:
[    0.000000]  <IRQ> 
[    0.000000]  [<ffffffff9b8052f2>] ? __do_softirq+0x112/0x2ab
[    0.000000]  [<ffffffff9b0a6ad8>] irq_exit+0xe8/0xf0
[    0.000000]  [<ffffffff9b805034>] do_IRQ+0x54/0xd0
[    0.000000]  [<ffffffff9b802ecc>] common_interrupt+0x8c/0x8c
[    0.000000]  <EOI> 
[    0.000000]  [<ffffffff9b05d246>] ? native_restore_fl+0x6/0x10
[    0.000000]  [<ffffffff9b03014a>] native_calibrate_cpu+0x1fa/0x5e0
[    0.000000]  [<ffffffff9b3e5d09>] ? free_cpumask_var+0x9/0x10
[    0.000000]  [<ffffffff9b0ff6f1>] ? __setup_irq+0x311/0x630
[    0.000000]  [<ffffffff9bf8e15c>] tsc_init+0x2b/0x264
[    0.000000]  [<ffffffff9bf8a997>] x86_late_time_init+0xf/0x11
[    0.000000]  [<ffffffff9bf7ff3a>] start_kernel+0x3ae/0x480
[    0.000000]  [<ffffffff9bf7f120>] ? early_idt_handler_array+0x120/0x120
[    0.000000]  [<ffffffff9bf7f2ca>] x86_64_start_reservations+0x24/0x26
[    0.000000]  [<ffffffff9bf7f419>] x86_64_start_kernel+0x14d/0x170
[    0.000000] Code:  Bad RIP value.
[    0.000000] RIP  [<          (null)>]           (null)
[    0.000000]  RSP <ffffa2c946c03ef0>
[    0.000000] CR2: 0000000000000000
[    0.000000] ---[ end trace f68728a0d3053b52 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception in interrupt
[    0.000000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

Host CPU:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 69
model name      : Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping        : 1
microcode       : 0x1f
cpu MHz         : 2099.981
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs            :
bogomips        : 5387.48
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:


> ---
>  tcg/i386/tcg-target.inc.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 3ed8cd1..3650340 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1146,9 +1146,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
>          tcg_debug_assert(arg2 == (rexw ? 64 : 32));
>          tcg_out_modrm(s, OPC_TZCNT + rexw, dest, arg1);
>      } else {
> -        tcg_debug_assert(dest != arg2);
> +        /* ??? The manual says that the output is undefined when the
> +           input is zero, but real hardware leaves it unchanged.  As
> +           noted in target-i386/translate.c, real programs depend on
> +           this -- now we are one more of those.  */
> +        tcg_debug_assert(dest == arg2);
>          tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
> -        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
>      }
>  }
>  
> @@ -1161,20 +1164,26 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
>              tcg_debug_assert(arg2 == (rexw ? 64 : 32));
>          } else {
>              tcg_debug_assert(dest != arg2);
> +            /* LZCNT sets C if the input was zero.  */
>              tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
>          }
>      } else {
> -        tcg_debug_assert(!const_a2);
> -        tcg_debug_assert(dest != arg1);
> -        tcg_debug_assert(dest != arg2);
> +        TCGType type = rexw ? TCG_TYPE_I64: TCG_TYPE_I32;
> +        TCGArg rev = rexw ? 63 : 31;
>  
> -        /* Recall that the output of BSR is the index not the count.  */
> +        /* Recall that the output of BSR is the index not the count.
> +           Therefore we must adjust the result by ^ (SIZE-1).  In some
> +           cases below, we prefer an extra XOR to a JMP.  */
> +        /* ??? See the comment in tcg_out_ctz re BSF.  */
> +        if (const_a2) {
> +            tcg_debug_assert(dest != arg1);
> +            tcg_out_movi(s, type, dest, arg2 ^ rev);
> +        } else {
> +            tcg_debug_assert(dest == arg2);
> +            tgen_arithi(s, ARITH_XOR + rexw, dest, rev, 0);
> +        }
>          tcg_out_modrm(s, OPC_BSR + rexw, dest, arg1);
> -        tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
> -
> -        /* Since we have destroyed the flags from BSR, we have to re-test.  */
> -        tcg_out_cmp(s, arg1, 0, 1, rexw);
> -        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
> +        tgen_arithi(s, ARITH_XOR + rexw, dest, rev, 0);
>      }
>  }
>  
> @@ -2443,7 +2452,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_ctz_i64:
>          {
>              static const TCGTargetOpDef ctz[2] = {
> -                { .args_ct_str = { "&r", "r", "r" } },
> +                { .args_ct_str = { "r", "r", "0" } },
>                  { .args_ct_str = { "&r", "r", "rW" } },
>              };
>              return &ctz[have_bmi1];
> @@ -2452,7 +2461,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_clz_i64:
>          {
>              static const TCGTargetOpDef clz[2] = {
> -                { .args_ct_str = { "&r", "r", "r" } },
> +                { .args_ct_str = { "&r", "r", "0i" } },
>                  { .args_ct_str = { "&r", "r", "rW" } },
>              };
>              return &clz[have_lzcnt];
> -- 
> 2.9.3
> 
> 

-- 
Eduardo
